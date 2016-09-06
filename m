From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 06 Sep 2016 09:40:19 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160906063529.GA22312@b29397-desktop>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <6414695.LEIYfGPUEg@wuerfel>
 <CADRPPNR1_6fbaHLvbmNZW+r7YWW=vOZ+wGCS-MAcNPi9gB3eOw@mail.gmail.com>
 <4865343.bOXkeC8XtQ@wuerfel> <20160906063529.GA22312@b29397-desktop>
Message-ID: <87bn01o7jg.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Peter Chen <hzpeterchen@gmail.com> writes:
> On Mon, Sep 05, 2016 at 05:39:27PM +0200, Arnd Bergmann wrote:
>> On Friday, September 2, 2016 5:16:31 PM CEST Leo Li wrote:
>> > 
>> > Can we use the firmware or bootloader information to provide the
>> > default dma-mapping attributes for devices that doesn't have an
>> > of_node pointer or ACPI data?  This will at least restore what we had
>> > previously provided .  I'm concerned that changing all the drivers
>> > that are creating child device will be a big effort.  Like I mentioned
>> > in another thread, there are many instances of platform_device_add()
>> > under the drivers/ directory.
>> 
>> Fortunately, there are not too many drivers that call platform_device_add
>> *and* try to set up a dma mask for the child device:
>> 
>> git grep -wl dma_mask drivers | xargs grep -wl 'platform_device_\(add\|register\)'
>> 
>> drivers/base/platform.c
>> drivers/bcma/main.c
>> drivers/eisa/virtual_root.c
>> drivers/mfd/mfd-core.c
>> drivers/mfd/omap-usb-host.c
>> drivers/misc/mic/card/mic_x100.c
>> drivers/platform/goldfish/pdev_bus.c
>> drivers/ssb/main.c
>> drivers/usb/chipidea/core.c
>> drivers/usb/dwc3/dwc3-exynos.c
>> drivers/usb/dwc3/host.c
>> drivers/usb/gadget/udc/bdc/bdc_pci.c
>> drivers/usb/host/bcma-hcd.c
>> drivers/usb/host/fsl-mph-dr-of.c
>> drivers/usb/host/ssb-hcd.c
>> drivers/usb/misc/ftdi-elan.c
>> drivers/usb/musb/blackfin.c
>> drivers/usb/musb/musb_dsps.c
>> drivers/usb/musb/omap2430.c
>> drivers/usb/musb/ux500.c
>> 
>> Most of these are probably never used with any nonstandard
>> DMA settings (IOMMU, cache coherency, offset, ...).
>> 
>> One thing we could possibly do is to go through these and
>> replace the hardcoded dma mask setup with of_dma_configure()
>> in all cases in which we actually use DT for probing, which
>> should cover the interesting cases.
>> 
>
> One case I am going to work is to let USB chipidea driver support iommu,
> the chipidea core device is no of_node, and created by
> platform_add_device on the runtime. Using of_dma_configure with parent
> of_node is a solution from my point, like [1].
>
> https://lkml.org/lkml/2016/2/22/7

this only solves the problem for DT devices. Legacy devices and
PCI-based systems will still suffer from the same problem. At least for
dwc3, I will only be taking patches that solve the problem for all
users, not a subset of them.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/ccfce4b7/attachment.sig>
