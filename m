From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 8 Sep 2016 15:02:56 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87d1keirlu.fsf@linux.intel.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <2733202.7lpFC7RnDm@wuerfel> <87lgz2iv6d.fsf@linux.intel.com>
 <4934737.egJZVdaLZs@wuerfel> <87d1keirlu.fsf@linux.intel.com>
Message-ID: <01a5728b-9ea7-3ccf-34e8-7602a654306b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2016 02:00 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
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
> oh, that makes things more interesting :-s
> 
>>>> That sounds a bit clumsy for the sake of consistency with PCI.
>>>> The advantage is that xhci can always use the grandparent device
>>>> as sysdev whenever it isn't probed through PCI or firmware
>>>> itself, but the purpose of the dwc3-glue is otherwise questionable.
>>>>
>>>> How about adding a 'compatible="snps,dwc3-pci"' property for the dwc3
>>>> device when that is created from the PCI driver and checking for that
>>>> with the device property interface instead? If it's "snps,dwc3"
>>>> we use the device itself while for "snps,dwc3-pci", we use the parent?
>>>
>>> Any reason why we wouldn't use e.g. dwc3-omap.dev as sysdev?
>>
>> That would be incompatible with the USB binding, as the sysdev
>> is assumed to be a USB host controller with #address-cells=<1>
>> and #size-cells=<0> in order to hold the child devices, for
>> example:
>>
>> / {
>>      omap_dwc3_1: omap_dwc3_1 at 48880000 {
>>         compatible = "ti,dwc3";
>>         #address-cells = <1>;
>>         #size-cells = <1>;
>>         ranges;
>>         usb1: usb at 48890000 {
>>                 compatible = "snps,dwc3";
>>                 reg = <0x48890000 0x17000>;
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>                 interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>>                              <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>>                              <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>                 interrupt-names = "peripheral",
>>                                   "host",
>>                                   "otg";
>>                 phys = <&usb2_phy1>, <&usb3_phy1>;
>>                 phy-names = "usb2-phy", "usb3-phy";
>>
>>                 hub at 1 {
>>                         compatible = "usb5e3,608";
>>                         reg = <1>;
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>
>>                         ethernet at 1 {
>>                                 compatible = "usb424,ec00";
>>                                 mac-address = [00 11 22 33 44 55];
>>                                 reg = <1>;
>>                         };
>>                 };
>>         };
>> };
>>
>> It's also the node that contains the "phys" properties and
>> presumably other properties like "otg-rev", "maximum-speed"
>> etc.
>>
>> If we make the sysdev point to the parent, then we can no longer
>> look up those properties and child devices from the USB core code
>> by looking at "sysdev->of_node".
> 
> this also makes things more interesting. I can't of anything other than
> having some type of flag passed via e.g. device_properties by dwc3-pci.c
> :-s
> 
> It's quite a hack, though. I still think that inheriting DMA (or
> manually initializing a child with parent's DMA bits and pieces) is the
> best way to go. So we're back to of_dma_configure() and
> acpi_dma_configure(), right?
> 
> But this needs to be done before dwc3_probe() executes. For dwc3-pci
> that's easy, but for DT devices, seems like it should be in of
> core. Below is, clearly, not enough but should show the idea:
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index fd5cfad7c403..a54610198946 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -94,8 +94,12 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>          * setup the correct supported mask.
>          */
> -       if (!dev->coherent_dma_mask)
> -               dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +       if (!dev->coherent_dma_mask) {
> +               if (!dev->parent->coherent_dma_mask)
> +                       dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +               else
> +                       dev->coherent_dma_mask = dev->parent->coherent_dma_mask;
> +       }
>  
>         /*
>          * Set it to coherent_dma_mask by default if the architecture
> 
> 

I'd like to clarify few points here:
- the default  dma_mask = DMA_BIT_MASK(32); assigned here to keep
 backward compatibility with existing DT files at the moment when 
of_dma_configure() has been introduced and it satisfies most of the cases
- if HW require specific DMA configuration then "dma-ranges" property have to be
defined and of_dma_configure() will take care of it just few lines down.
including parent-child case - as it will try to find "dma-ranes" prop in parent node
when called for child dev.

Personally, I think Arnd's approach should work, if the problem of selecting of proper 
sysdev/dma_dev device will be solved.

Wouldn't it work if is_device_dma_capable() will be used?

For DT-case, the device DMA properties have to be configured from DT. So, now
there are 2 cases for dwc3:
1) dwc3-glue (of_dma)
   |- dwc3 (of_dma)
      |- xhci-plat (manual)
 better to use dwc3-glue as sysdev, but can use dwc3 also

2) (arch/arm/boot/dts/ls1021a.dtsi)
  |- dwc3 (of_dma)
      |- xhci-plat (manual)
 need to use dwc3 as sysdev
  

dwc3: probe()
	if (!&pdev->dev->of_node)
		 legacy case - hard-code DMA props
		dwc->sysdev = &pdev->dev;
	else
		dev = &pdev->dev;
		do {
			if (is_device_dma_capable(dev)) {
				dwc->sysdev = dev;
				break;
			}
		   dev = dev->parent;
		while (dev);
		^this cycle can be limited in depth (2 for PCI)
	
	if (!dwc->sysdev)
		oops;

xhci_plat_probe:
	do the same

Wouldn't above work for other cases PCI/ACPI?

	


-- 
regards,
-grygorii
