From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Mar 2018 11:58:50 +0100
Subject: [PATCH 2/2] usb: host: xhci-plat: Fix clock resource by adding a
 register clock
In-Reply-To: <0643f36a-cee7-8e4a-77c3-c60672ca385f@intel.com> (Mathias Nyman's
 message of "Wed, 28 Feb 2018 18:05:20 +0200")
References: <20180214161620.4401-1-gregory.clement@bootlin.com>
 <20180214161620.4401-3-gregory.clement@bootlin.com>
 <0643f36a-cee7-8e4a-77c3-c60672ca385f@intel.com>
Message-ID: <87fu541bth.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On mer., f?vr. 28 2018, Mathias Nyman <mathias.nyman@intel.com> wrote:

> On 14.02.2018 18:16, Gregory CLEMENT wrote:
>> On Armada 7K/8K we need to explicitly enable the register clock. This
>> clock is optional because not all the SoCs using this IP need it but at
>> least for Armada 7K/8K it is actually mandatory.
>>
>> The change was done at xhci-plat level and not at a xhci-mvebu.c because,
>> it is expected that other SoC would have this kind of constraint.
>>
>> The binding documentation is updating accordingly.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>   Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 +++-
>>   drivers/usb/host/xhci-plat.c                       | 33 ++++++++++++++++++----
>>   drivers/usb/host/xhci.h                            |  3 +-
>>   3 files changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> index e2ea59bbca93..e4b14511f4f8 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> @@ -27,7 +27,10 @@ Required properties:
>>     - interrupts: one XHCI interrupt should be described here.
>>     Optional properties:
>> -  - clocks: reference to a clock
>> +  - clocks: reference to the clocks
>> +  - clock-names: mandatory if there is a second clock, in this case
>> +    the name must be "core" for the first clock and "reg" for the
>> +    second one
>>     - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
>>     - usb3-lpm-capable: determines if platform is USB3 LPM capable
>>     - quirk-broken-port-ped: set if the controller has broken port disable mechanism
>
> Would be good to get a Ack or review by Rob Herring for the above

Would you mind to have a look on this binding update ?

Initially I didn't copy you trying to not overflow you because this
change is only about adding a new clock, which is pretty common. But I
think Mathias would be more confident with a Ack or review by you.

Thanks,

Gregory

>
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index 79afaac57ef6..fd0c399013a2 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -157,6 +157,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>   	struct resource         *res;
>>   	struct usb_hcd		*hcd;
>>   	struct clk              *clk;
>> +	struct clk              *reg_clk;
>>   	int			ret;
>>   	int			irq;
>>   @@ -226,17 +227,27 @@ static int xhci_plat_probe(struct
>> platform_device *pdev)
>>   	hcd->rsrc_len = resource_size(res);
>>     	/*
>> -	 * Not all platforms have a clk so it is not an error if the
>> -	 * clock does not exists.
>> +	 * Not all platforms have clks so it is not an error if the
>> +	 * clock do not exist.
>>   	 */
>> +	reg_clk = devm_clk_get(&pdev->dev, "reg");
>> +	if (!IS_ERR(reg_clk)) {
>> +		ret = clk_prepare_enable(reg_clk);
>> +		if (ret)
>> +			goto put_hcd;
>> +	} else if (PTR_ERR(reg_clk) == -EPROBE_DEFER) {
>> +		ret = -EPROBE_DEFER;
>> +		goto put_hcd;
>> +	}
>> +
>>   	clk = devm_clk_get(&pdev->dev, NULL);
>>   	if (!IS_ERR(clk)) {
>>   		ret = clk_prepare_enable(clk);
>>   		if (ret)
>> -			goto put_hcd;
>> +			goto disable_reg_clk;
>>   	} else if (PTR_ERR(clk) == -EPROBE_DEFER) {
>>   		ret = -EPROBE_DEFER;
>> -		goto put_hcd;
>> +		goto disable_reg_clk;
>>   	}
>>     	xhci = hcd_to_xhci(hcd);
>> @@ -252,6 +263,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>   	device_wakeup_enable(hcd->self.controller);
>>     	xhci->clk = clk;
>> +	xhci->reg_clk = reg_clk;
>>   	xhci->main_hcd = hcd;
>>   	xhci->shared_hcd = __usb_create_
>
> hcd(driver, sysdev, &pdev->dev,
>>   			dev_name(&pdev->dev), hcd);
>> @@ -321,6 +333,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>   disable_clk:
>>   	clk_disable_unprepare(clk);
>>   +disable_reg_clk:
>> +	clk_disable_unprepare(reg_clk);
>> +
>>   put_hcd:
>>   	usb_put_hcd(hcd);
>>   @@ -336,6 +351,7 @@ static int xhci_plat_remove(struct
>> platform_device *dev)
>>   	struct usb_hcd	*hcd = platform_get_drvdata(dev);
>>   	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>>   	struct clk *clk = xhci->clk;
>> +	struct clk *reg_clk = xhci->reg_clk;
>>     	xhci->xhc_state |= XHCI_STATE_REMOVING;
>>   @@ -346,6 +362,7 @@ static int xhci_plat_remove(struct
>> platform_device *dev)
>>   	usb_put_hcd(xhci->shared_hcd);
>>     	clk_disable_unprepare(clk);
>> +	clk_disable_unprepare(reg_clk);
>>   	usb_put_hcd(hcd);
>>     	pm_runtime_set_suspended(&dev->dev);
>> @@ -370,8 +387,10 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
>>   	 */
>>   	ret = xhci_suspend(xhci, device_may_wakeup(dev));
>>   -	if (!device_may_wakeup(dev) && !IS_ERR(xhci->clk))
>> +	if (!device_may_wakeup(dev) && !IS_ERR(xhci->clk)) {
>>   		clk_disable_unprepare(xhci->clk);
>> +		clk_disable_unprepare(xhci->reg_clk);
>> +	}
>>     	return ret;
>>   }
>> @@ -382,8 +401,10 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
>>   	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>>   	int ret;
>>   -	if (!device_may_wakeup(dev) && !IS_ERR(xhci->clk))
>> +	if (!device_may_wakeup(dev) && !IS_ERR(xhci->clk)) {
>> +		clk_prepare_enable(xhci->reg_clk);
>>   		clk_prepare_enable(xhci->clk);
>> +	}
>>     	ret = xhci_priv_resume_quirk(hcd);
>>   	if (ret)
>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index 96099a245c69..9884aaba1b40 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1726,8 +1726,9 @@ struct xhci_hcd {
>>   	int		page_shift;
>>   	/* msi-x vectors */
>>   	int		msix_count;
>> -	/* optional clock */
>> +	/* optional clocks */
>>   	struct clk		*clk;
>> +	struct clk		*reg_clk;
>>   	/* data structures */
>>   	struct xhci_device_context_array *dcbaa;
>>   	struct xhci_ring	*cmd_ring;
>>
>
> Looks good to me, I'll queue it up if the devicetree bindings looks ok for Rob Herring
>
> -Mathias
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
