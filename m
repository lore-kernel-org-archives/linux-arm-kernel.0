From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 17:24:12 +0100
Subject: [PATCH 2/2] usb: host: xhci-plat: Fix clock resource by adding a
 register clock
In-Reply-To: <da059a0e-d6f3-73e4-b58d-b3db074c0601@codeaurora.org> (Manu
 Gautam's message of "Wed, 28 Feb 2018 21:39:05 +0530")
References: <20180214161620.4401-1-gregory.clement@bootlin.com>
 <20180214161620.4401-3-gregory.clement@bootlin.com>
 <da059a0e-d6f3-73e4-b58d-b3db074c0601@codeaurora.org>
Message-ID: <87zi3tdqvn.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manu,
 
 On mer., f?vr. 28 2018, Manu Gautam <mgautam@codeaurora.org> wrote:

> Hi,
>
>
> On 2/14/2018 9:46 PM, Gregory CLEMENT wrote:
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
>>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 +++-
>>  drivers/usb/host/xhci-plat.c                       | 33 ++++++++++++++++++----
>>  drivers/usb/host/xhci.h                            |  3 +-
>>  3 files changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> index e2ea59bbca93..e4b14511f4f8 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> @@ -27,7 +27,10 @@ Required properties:
>>    - interrupts: one XHCI interrupt should be described here.
>>  
>>  Optional properties:
>> -  - clocks: reference to a clock
>> +  - clocks: reference to the clocks
>> +  - clock-names: mandatory if there is a second clock, in this case
>> +    the name must be "core" for the first clock and "reg" for the
>> +    second one
>>    - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
>>    - usb3-lpm-capable: determines if platform is USB3 LPM capable
>>    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index 79afaac57ef6..fd0c399013a2 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -157,6 +157,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>  	struct resource         *res;
>>  	struct usb_hcd		*hcd;
>>  	struct clk              *clk;
>> +	struct clk              *reg_clk;
>>  	int			ret;
>>  	int			irq;
>>  
>> @@ -226,17 +227,27 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>  	hcd->rsrc_len = resource_size(res);
>>  
>>  	/*
>> -	 * Not all platforms have a clk so it is not an error if the
>> -	 * clock does not exists.
>> +	 * Not all platforms have clks so it is not an error if the
>> +	 * clock do not exist.
>>  	 */
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
>
> How about using clk_bulk_ APIs?

I didn't know this API, but after having a look on it, it didn't match
what I need. Indeed the second clock is "optional" to handle the
backward compatibility. With the clk_bulk_ APIS all the clocks are
mandatory.

Thanks,

Gregory

>
>>  	clk = devm_clk_get(&pdev->dev, NULL);
>>  	if (!IS_ERR(clk)) {
>>  		ret = clk_prepare_enable(clk);
>>
>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
