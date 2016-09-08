From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 8 Sep 2016 15:59:19 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160908122810.GA14132@b29397-desktop>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <2733202.7lpFC7RnDm@wuerfel> <87lgz2iv6d.fsf@linux.intel.com>
 <4934737.egJZVdaLZs@wuerfel> <20160908122810.GA14132@b29397-desktop>
Message-ID: <72263b67-6b33-de44-d568-a967ee3503ae@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2016 03:28 PM, Peter Chen wrote:
> On Thu, Sep 08, 2016 at 12:17:21PM +0200, Arnd Bergmann wrote:
>> On Thursday, September 8, 2016 12:43:06 PM CEST Felipe Balbi wrote:
>>> Arnd Bergmann <arnd@arndb.de> writes:
>>>> On Thursday, September 8, 2016 11:29:04 AM CEST Felipe Balbi wrote:
>>>>>> If we do that, we have to put child devices of the dwc3 devices into
>>>>>> the platform glue, and it also breaks those dwc3 devices that don't
>>>>>> have a parent driver.
>>>>>
>>>>> Well, this is easy to fix:
>>>>>
>>>>>         if (dwc->dev->parent) {
>>>>>                 dwc->sysdev = dwc->dev->parent;
>>>>>         } else {
>>>>>                 dev_info(dwc->dev, "Please provide a glue layer!\n");
>>>>>                 dwc->sysdev = dwc->dev;
>>>>>         }
>>>>
>>>> I don't understand. Do you mean we should have an extra level of
>>>> stacking and splitting "static struct platform_driver dwc3_driver"
>>>> in two so instead of
>>>>
>>>>       "qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "xhci" (usb_bus.dev)
>>>>
>>>> we do this?
>>>>
>>>>       "qcom,dwc3" -> "snps,dwc3" (usb_bus.sysdev) -> "dwc3-glue" -> "xhci" (usb_bus.dev)
>>>
>>> no 
>>>
>>> If we have a parent device, use that as sysdev, otherwise use self as
>>> sysdev.
>>
>> But there is often a parent device in DT, as the xhci device is
>> attached to some internal bus that gets turned into a platform_device
>> as well, so checking whether there is a parent will get the wrong
>> device node.
> 
> From my point, all platform and firmware information at dwc3 are
> correct, so we don't need to change dwc3/core.c, only changing for
> xhci-plat.c is ok.
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index ed56bf9..fd57c0d 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -145,6 +145,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	struct clk              *clk;
>  	int			ret;
>  	int			irq;
> +	struct device *dev = &pdev->dev, *sysdev;
>  
>  	if (usb_disabled())
>  		return -ENODEV;
> @@ -155,6 +156,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return -ENODEV;
>  
> +	if (dev->parent) {
> +		sysdev = dev->parent;
> +	} else {
> +        	sysdev = dev;
> +	}
> +

Shouldn't we be more careful with that?

armada-375.dtsi

	soc {
		compatible = "marvell,armada375-mbus", "simple-bus";

		internal-regs {
			compatible = "simple-bus";

			usb3 at 58000 {
				compatible = "marvell,armada-375-xhci";
				reg = <0x58000 0x20000>,<0x5b880 0x80>;
				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
				clocks = <&gateclk 16>;
				phys = <&usbcluster PHY_TYPE_USB3>;
				phy-names = "usb";
				status = "disabled";
			};


What will be the parent dev in above case?

-- 
regards,
-grygorii
