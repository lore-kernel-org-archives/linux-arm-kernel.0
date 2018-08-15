From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 15 Aug 2018 20:21:50 +0200
Subject: serdev: How to attach serdev devices to USB based tty devices?
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Message-ID: <20180815182150.wsd5oxlucsox2qig@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

+cc Johan Hovold <johan@kernel.org>

Johan told me, that he is working on this at ELCE 2017. Also he is
the subsystem maintainer of the USB serial subsystem.

-- Sebastian

On Tue, Aug 14, 2018 at 04:28:20AM +0200, Andreas F?rber wrote:
> Hi Rob et al.,
> 
> For my LoRa network driver project [1] I have found your serdev
> framework to be a valuable help for dealing with hardware modules
> exposing some textual or binary UART interface.
> 
> In particular on arm(64) and mips this allows to define an unlimited
> number of serdev drivers [2] that are associated via their Device Tree
> compatible string and can optionally be configured via DT properties.
> 
> And in theory it seems serdev has also grown support for ACPI.
> 
> Now, a growing number of vendors are placing such modules on a USB stick
> for easy evaluation on x86_64 PC hardware, or are designing mPCIe or M.2
> cards using their USB pins. While I do not yet have access to such a
> device myself, it is my understanding that devices with USB-UART bridge
> chipsets (e.g., FTDI) will show up as /dev/ttyUSBx and devices with an
> MCU implementing the CDC USB protocol (e.g., Pico-cell gateway = picoGW)
> will show up as /dev/ttyACMx.
> On the Raspberry Pi I've seen that Device Tree nodes can be used to pass
> information to on-board devices such as MAC address to Ethernet chipset,
> but that does not seem all that useful for passing a serdev child node
> to hot-plugged devices at unpredictable hub/port location (where it
> should not interfere with regular USB-UART cables for debugging), nor
> would it help ACPI based platforms such as x86_64.
> 
> My idea then was that if we had some unique criteria like vendor and
> product IDs (or whatever is supported in usb_device_id), we could write
> a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
> could call into the existing tty driver's probe function and afterwards
> try creating and attaching the appropriate serdev device, i.e. a fixed
> USB-to-serdev driver mapping. Problem is that most devices don't seem to
> implement any unique identifier I could make this depend on - either by
> using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
> virtual com port identifiers in CDC firmware and only differing in the
> textual description [3] the usb_device_id does not seem to match on.
> 
> The obvious solution would of course be if hardware vendors could revise
> their designs to configure FTDI/etc. chips uniquely. I hear that that
> may involve exchanging the chipset, increasing costs, and may impact
> existing drivers. Wouldn't help for devices out there today either.
> 
> For the picoGW CDC firmware, Semtech does appear to own a USB vendor ID,
> so it would seem possible to allocate their own product IDs for SX1301
> and SX1308 respectively to replace the generic STMicroelectronics IDs,
> which the various vendors could offer as firmware updates.
> 
> All outside my control though.
> 
> Oliver therefore suggested to not mess with USB drivers and instead use
> a line discipline (ldisc). It seems that for example the userspace tool
> slattach takes a tty device and performs an ioctl to switch the generic
> tty device into a special N_SLIP protocol mode, implemented in [4].
> 
> However, the existing number of such ldisc modes appears to be below 30,
> with hardly any vendor-specific implementation, so polluting its number
> space seems undesirable? And in some cases I would like to use the same
> protocol implementation over direct UART and over USB, so would like to
> avoid duplicate serdev_device_driver and tty_ldisc_ops implementations.
> 
> Long story short, has there been any thinking about a userspace
> interface to attach a given serdev driver to a tty device?
> 
> Or is there, on OF_DYNAMIC platforms, a way from userspace to associate
> a DT fragment (!= DT Overlay) with a given USB device dynamically, to
> attach a serdev node with sub-nodes?
> 
> Any other ideas how to cleanly solve this?
> 
> In some cases we're talking about a "simple" AT-like command interface;
> the picoGW implements a semi-generic USB-SPI bridge that may host a
> choice of 2+ chipsets, which in turn has two further sub-devices with 3+
> chipset choices (theoretically clk output and rx/tx options etc.) each.
> (For the latter I'm thinking we'll need a serdev driver exposing a
> regmap_bus and then implement regmap_bus based versions of the SPI
> drivers like Ben and I refactored SX1257 in [2] last weekend.)
> 
> Thanks,
> Andreas
> 
> [1] https://patchwork.ozlabs.org/cover/937545/
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/drivers/net/lora?h=lora-next
> [3]
> https://github.com/Lora-net/picoGW_mcu/blob/master/src/usb_cdc/Src/usbd_desc.cpp#L59
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/slip/slip.c#n1281
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180815/bad148ee/attachment.sig>
