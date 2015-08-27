From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Thu, 27 Aug 2015 14:18:43 +0530
Subject: [LINUX RFC v2 0/4] spi: add dual parallel mode support in Zynq
 MPSoC GQSPI controller
In-Reply-To: <CAD6G_RTCQ5Fzjgxz+-3oMDAyUTg6UFAqvpEPQzJ9maSTZ3Nc_g@mail.gmail.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <CAD6G_RQhWBsUTZNBB44W98Fjzw82H_D_E9nY0aDWezj729mkoA@mail.gmail.com>
 <CAGnW=BZtsVtT+Z7gTq5jybXsHWp+RNpjc6ckk6-MXWxAS7u8Mw@mail.gmail.com>
 <CAD6G_RTCQ5Fzjgxz+-3oMDAyUTg6UFAqvpEPQzJ9maSTZ3Nc_g@mail.gmail.com>
Message-ID: <CAGnW=BZ80B_2kzZVULhZvEXFs+_GXkGbu8mii1eFp3MySvA8aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 11:53 AM, Jagan Teki <jteki@openedev.com> wrote:
> On 26 August 2015 at 21:02, punnaiah choudary kalluri
> <punnaia@xilinx.com> wrote:
>> On Wed, Aug 26, 2015 at 5:49 PM, Jagan Teki <jteki@openedev.com> wrote:
>>> On 26 August 2015 at 11:56, Ranjit Waghmode <ranjit.waghmode@xilinx.com> wrote:
>>>> This series adds dual parallel mode support for Zynq Ultrascale+
>>>> MPSoC GQSPI controller driver.
>>>>
>>>> What is dual parallel mode?
>>>> ---------------------------
>>>> ZynqMP GQSPI controller supports Dual Parallel mode with following functionalities:
>>>> 1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
>>>> 2) Chip selects and clock are shared to both the flash devices
>>>> 3) This mode is targeted for faster read/write speed and also doubles the size
>>>> 4) Commands/data can be transmitted/received from both the devices(mirror),
>>>>    or only upper or only lower flash memory devices.
>>>> 5) Data arrangement:
>>>>    With stripe enabled,
>>>>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>>>>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.
<snip>
>>> I don't find any previous discussion about way to inform flash
>>> dual-ness into spi-nor
>>> from spi drivers.
>>>
>>> Here is my idea, probably others may think same.
>>> Informing dual_flash from drivers/spi through flags or any other mode
>>> bits is not a better approach as dual flash feature is specific to
>>> spi-nor flash controller (controller specially designed for spi-nor
>>> flash not the generic spi controller).  So if the driver sits on
>>> drivers/mtd/spi-nor/ (ex: fsl-quadspi.c), may be we can inform flash
>>> specific things to spi-nor as it's not touching generic spi stack in
>>> Linux. But there is a defined-drawback if the driver is moved to
>>> drivers/mtd/spi-nor ie it can't use spi core API's at-all.
>>
>> Xilinx GQSPI is a generic quad spi controller. The primary goal is to support
>> Generic/Future command sequences and Future NOR/NAND flash devices.
>> This core can also be used for legacy SPI devices. Due to the generic nature
>> of the core, software can generate any command sequence. It also has additional
>> features like parallel and stacked configurations to double the data
>> rate and size.
>> Accessing spi-nor flash device is one particular use case and like
>> that there will be
>> many. So, we decided to keep this driver in generic spi framework and
>> that is the ideal
>> thing to do for the GQSPI controller.
>
> Yes, I understand the generic nature of the GQSPI and it's good to
> have all-in-one like generic spi, spi-nor and spi-nand and more
> together, but Linux stacks were implemented in such a way to support
> the each type of controller with connected slaves separably for better
> handling.

True and this is the reason we have controller drivers and protocol drivers.
GQSPI is the controller driver and spi-nor and spi-nand are the
protocol drivers.

>
> Currently GQSPI driver is added in drivers/spi as it supports generic
> spi nature and now it enhanced more through flags for supporting
> spi-nor, what if we add spi-nand support for the same controller? do
> we add one more driver in spi-nand framework (drivers/mtd/spi-nand -
> an on going implementation)? My only observation here is even if the
> controller is more generic to support more number of device classes,
> and adding same driver and populate the slave stuff through flags or
> different kind of mechanism to different driver stack, this is not a
> better approach I thought.

Just to clear, dual parallel( 2 CS and 8 IO lines) is not only specific
to flash parts, one can use for any other custom streaming protocols
I would say exporting dual parallel connection to protocol drivers is
something like depicting the spi bus topology to the protocol layer.

AFAIK, spi-nor and spi-nand are protocol drivers for accessing the
nor and nand flash devices sitting on the spi bus using the spi
controller driver.

Regards,
Punnaiah

>
> Based on the above comments, there is an approach to handle this
> support and I'm not 100% sure whether this fits or not but we
> implemented the same -  this is "probing child devices from parent"
> (there was a discussion with Arnd earlier wrt this, but I'm unable to
> get the mailing thread)
>
> Added Arnd (probably will give more inputs or corrections)
>
> Let me explain how we implemented on our design.
> We have PCIe controller that support basic root complex handling, dma
> and controller hotplug (not in-build pcie hp) and ideally we need to
> write driver for handling root complex on drivers/pci/host and one
> hotplug driver in drivers/pci and one more driver in drivers/dma for
> handling pcie dma stuff. And some pcie calls need to navigate from
> root complex driver to dma and hotplug driver that means there is call
> transition from driver/pci to driver/dma which is absolutely not a
> good approach (spi to spi-nor and spi-nand transition - in GQSPI case)
>
> So the implementation we follow is like there is a pcie root complex
> driver(probably generic spi driver in drivers/spi/*) and inside probe
> we have register platform_device for hotplug (spi-nor) and dma
> (spi-nand) and the dma driver in drivers/dma and hotplug driver in
> driver/pci/ are platform drivers which is of legacy binding (not with
> dts) so there should be a common dts for root complex driver
> (drivers/spi/*) and individual child driver need to take those while
> registering platform_device.
>
> example pseudo:
>
> drivers/dma/dma-child2.c
>
> Legacy platform_driver binding and handling dma future as normal dma
> driver, spi-nand in your case
>
> drivers/pci/hotplug/hp-child1.c
>
> Legacy platform_driver binding and handling hotplug future as normal
> hotplug driver, spi-nor in your case.
>
> drivers/pci/host/rc-parent-pci.c
>
> static int rc_parent_pcie_probe_bridge(struct platform_device *pdev)
> {
>    // Generic rc handling (genric spi stuff)
>
>    // Hotplug handling (spi-nor)
>    - platform_device_alloc
>    - assign need resources
>    - register pdev using platform_device_add
>
>     // DMA handling (spi-nand)
>    - same as above
> }
>
> static const struct of_device_id rc_parent_pcie_match_table[] = {
>         {.compatible = "abc,rc-parent",},
>         {},
> };
>
> static struct platform_driver rc_parent_pcie_driver = {
>         .driver = {
>                    .name = "rc-parent",
>                    .of_match_table = of_match_ptr(rc_parent_pcie_match_table),
>         },
>         .probe = rc_parent_pcie_probe_bridge,
> };
> module_platform_driver(rc_parent_pcie_driver);
>
> I couldn't find any driver mainlined wrt this design, think more on
> GQSPI front, whether this design fits well or not.
>
> thanks!
> --
> Jagan | openedev.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
