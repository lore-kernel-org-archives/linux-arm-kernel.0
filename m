From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 6 Jan 2011 17:41:03 +0530
Subject: Current OMAP build failures
In-Reply-To: <20110106110336.GC31708@n2100.arm.linux.org.uk>
References: <20110106110336.GC31708@n2100.arm.linux.org.uk>
Message-ID: <3b65fe7bf98487ac1db721981f4c8bca@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Thursday, January 06, 2011 4:34 PM
> To: Tony Lindgren
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Current OMAP build failures
>

Have you used any custom build/ additional build flags
for omap2/3/4 reported issues ?
I just rebased Tony's 'omap-for-linus' branch with 2.6.37 and
it not seems to report below issues. May be it's getting
fixed as part of 2.6.38 omap queue or my build config is
not same as yours. I used omap2plus_defconfig.

> === omap2 ===
> arch/arm/plat-omap/devices.c:253: warning: ?omap_init_wdt? defined
> but not used
> arch/arm/mach-omap2/irq.c:64: warning: ?intc_context? defined but
> not used
> arch/arm/mach-omap2/prcm.c:122: warning: ?prcm_context? defined but
> not used
>
> Missing __maybe_unused or something else?
These seems to be fixed in omap queue.
>
> It also comes with three section mismatches:
>
> WARNING: vmlinux.o(.text+0x1f4c4): Section mismatch in reference
> from the function omap_early_device_register() to the function
> .init.text:early_platform_add_devices()
> The function omap_early_device_register() references
> the function __init early_platform_add_devices().
> This is often because omap_early_device_register lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> As early_platform_add_devices() is marked __init, so too should be
> omap_early_device_register().
I don't see this one. May be fixed
>
> WARNING: vmlinux.o(.text+0x1f6bc): Section mismatch in reference
> from the function omap_device_build_ss() to the function
> .init.text:early_platform_add_devices()
> The function omap_device_build_ss() references
> the function __init early_platform_add_devices().
> This is often because omap_device_build_ss lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> This looks like omap_early_device_register() has been inlined into
> omap_device_build_ss(), and it doesn't look like it can be marked
> __init.
>
> Rather than passing an 'is_early_device' into this function, split
> out the common code into a separate function which takes a function
> pointer to the registration function.  Then you can have two
> additional
> functions, one marked __init which uses omap_early_device_register()
> and one not marked __init using omap_device_register().
>
> This also means that we get the init-section type checking further
> up
> the chain.
This too
>
> WARNING: vmlinux.o(.data+0x6bd4): Section mismatch in reference from
> the variable h4_config to the (unknown reference)
> .init.data:(unknown)
> The variable h4_config references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the
> variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> Maybe it shouldn't be marked __initdata?
This too
>
> === omap3 ===
> WARNING: vmlinux.o(.text+0x1b780): Section mismatch in reference
> from the function sdp3430_twl_gpio_setup() to the function
> .init.text:omap2_hsmmc_init()
> The function sdp3430_twl_gpio_setup() references
> the function __init omap2_hsmmc_init().
> This is often because sdp3430_twl_gpio_setup lacks a __init
> annotation or the annotation of omap2_hsmmc_init is wrong.
>
> Missing __init on sdp3430_twl_gpio_setup ?
This too
>
> WARNING: vmlinux.o(.text+0x1f714): Section mismatch in reference
> from the function omap_early_device_register() to the function
> .init.text:early_platform_add_devices()
> The function omap_early_device_register() references
> the function __init early_platform_add_devices().
> This is often because omap_early_device_register lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> As before.
This too
>
> WARNING: vmlinux.o(.text+0x1f90c): Section mismatch in reference
> from the function omap_device_build_ss() to the function
> .init.text:early_platform_add_devices()
> The function omap_device_build_ss() references
> the function __init early_platform_add_devices().
> This is often because omap_device_build_ss lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> As before.
This too
>
> WARNING: vmlinux.o(.data+0x20670): Section mismatch in reference
> from the variable twl_driver to the function .init.text:twl_probe()
> The variable twl_driver references
> the function __init twl_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the
> variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> twl_probe shouldn't be __init ?
>
I only see the twl_probe section miss-match. Have attached full build
log for reference.

Regards,
Santosh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2.6.37_omap_for_linus.tar.bz2
Type: application/octet-stream
Size: 8378 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110106/5786427a/attachment.obj>
