From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 01 Jun 2015 10:48:29 +0200
Subject: [PATCH v6 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1432928535-27522-2-git-send-email-eric@anholt.net>
References: <1432928535-27522-1-git-send-email-eric@anholt.net>
 <1432928535-27522-2-git-send-email-eric@anholt.net>
Message-ID: <1433148509.2361.35.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-05-29 at 12:42 -0700, Eric Anholt wrote:
> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.
> 
> v2: Drop power-domains stuff for now since we don't have the driver
>     core support to make it useful.  Move to drivers/firmware/.
>     Capitalize the enums.  De-global the firmware variable.  Use the
>     firmware device to allocate our DMA buffer, so that the dma-ranges
>     DT property gets respected.  Simplify the property tag transaction
>     interface even more, leaving a multi-tag interface still
>     available.  For conciseness, rename "raspberrypi" to "rpi" on all
>     functions/enums/structs, and the "firmware" variable to "fw".
>     Print when the driver is probed successfully, since debugging
>     -EPROBE_DEFER handling is such a big part of bcm2835 development.
>     Drop -EBUSY mailbox handling since the mailbox core has been fixed
>     to return -EPROBE_DEFER in -next.
> 
> v3: Use kernel-doc style for big comments (from Noralf), drop stale
>     comment, use "dev" when freeing DMA as well.
> 
> v4: Move description comment into copyright comment, drop a dead
>     initialization of "ret", and print the firmware revision at probe
>     time.
> 
> v5: Rename the compatible to "raspberrypi,bcm2835-firmware", move
>     include to not say "property", add functions to get struct
>     rpi_firmware from the device_node and put when done, make property
>     functions take the rpi_firmware instead and never return
>     -EPROBE_DEFER, put the driver under its own RASPBERRYPI_FIRMWARE
>     Kconfig.
> 
> v6: Drop the try_module_get/module_put stuff, since all clients will
>     be referencing our symbols in order to call those functions,
>     anyway.  Fix the kerneldoc comments for the changes in v5.

(This style of commit explanation is getting quite common. I must say I
rather dislike it. I think people should just update the entire commit
explanation when needed, and not simply paste any changes at the end of
it, thereby forcing the the reader to determine which older parts are
actually overruled by newer parts. Besides, many, or maybe even most, of
the changes are really not interesting enough to keep in the commit
explanation.)

> --- /dev/null
> +++ b/drivers/firmware/raspberrypi.c

> +EXPORT_SYMBOL_GPL(rpi_firmware_property_list);

> +EXPORT_SYMBOL_GPL(rpi_firmware_property);

A patch that uses these exports hit lkml recently:
https://lkml.org/lkml/2015/5/28/596 .

> +EXPORT_SYMBOL_GPL(rpi_firmware_get);

But I didn't spot a (recent) patch that uses this export. Is it queued
somewhere?

Thanks,


Paul Bolle
