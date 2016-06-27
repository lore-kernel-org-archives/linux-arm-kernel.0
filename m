From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Jun 2016 13:37:23 +0200
Subject: next build: 142 builds: 6 failed, 136 passed, 17 errors,
 111 warnings (next-20160624)
In-Reply-To: <576da61b.4d9a1c0a.d5671.1807@mx.google.com>
References: <576da61b.4d9a1c0a.d5671.1807@mx.google.com>
Message-ID: <6046594.ORRxUGPcVO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 24, 2016 2:28:59 PM CEST kernelci. org bot wrote:
> 
> Errors summary:
> 
>       3  arch/arm/include/asm/jump_label.h:13:7: error: impossible constraint in 'asm'
>      66  arch/arm/include/asm/jump_label.h:13:7: warning: asm operand 0 probably doesn't match constraints

I've just sent a patch for this, hopefully it works again soon.

>       1  fs/fat/dir.c:758:424: internal compiler error: Segmentation fault

I'm pretty sure this is fixed with gcc-6.1.1, but I cannot reproduce the problem
here. I've tried various compilers.

>       2  drivers/char/mwave/smapi.h:53:0: warning: "FALSE" redefined [enabled by default]
>       2  drivers/char/mwave/smapi.h:52:0: warning: "TRUE" redefined [enabled by default]

This should be fixed in tomorrow's linux-next, I did two different patches for it,
and the other one should get merged as well.

>       1  arch/arm/configs/mps2_defconfig:102:warning: symbol value 'y' invalid for PRINTK_TIME

I should do a patch for this.

>       1  .config:972:warning: override: NOHIGHMEM changes choice state
>       1  .config:971:warning: override: SLOB changes choice state
>       1  .config:969:warning: override: KERNEL_XZ changes choice state
>       1  .config:968:warning: override: CC_OPTIMIZE_FOR_SIZE changes choice state
>       1  .config:944:warning: override: SLOB changes choice state
>       1  .config:941:warning: override: CC_OPTIMIZE_FOR_SIZE changes choice state
>       1  .config:877:warning: override: SLOB changes choice state
>       1  .config:875:warning: override: KERNEL_XZ changes choice state
>       1  .config:874:warning: override: CC_OPTIMIZE_FOR_SIZE changes choice state

The tinyconfig warnings are really annoying :(

> --------------------------------------------------------------------------------
> allmodconfig (arm64) ? FAIL, 2 errors, 3 warnings, 0 section mismatches
> 
> Errors:
>     binder.c:(.text+0x294f54): undefined reference to `usb_ep_set_maxpacket_limit'
>     binder.c:(.text+0x295030): undefined reference to `usb_ep_set_maxpacket_limit'

I sent a fix.

>     net/rxrpc/peer_object.c:57:15: warning: 'p' may be used uninitialized in this function [-Wmaybe-uninitialized]

My fix was merged, should be good today.

>     drivers/media/dvb-frontends/cxd2841er.c:3217:552: warning: 'carrier_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]

I don't see this one. It's a false positive.

> --------------------------------------------------------------------------------
> allmodconfig (x86) ? PASS, 0 errors, 14 warnings, 0 section mismatches
> 
> Warnings:
>     net/bluetooth/6lowpan.c:608:570: warning: 'addr_type' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     lib/test_hash.c:224:7: warning: "HAVE_ARCH__HASH_32" is not defined [-Wundef]
>     lib/test_hash.c:229:7: warning: "HAVE_ARCH_HASH_32" is not defined [-Wundef]
>     lib/test_hash.c:234:7: warning: "HAVE_ARCH_HASH_64" is not defined [-Wundef]
>     lib/test_hash.c:146:2: warning: missing braces around initializer [-Wmissing-braces]
>     lib/test_hash.c:146:2: warning: (near initialization for 'hash_or[0]') [-Wmissing-braces]

The problem only exists with gcc-4.9 or earlier. Geert has sent a patch a month
ago but nothing happened.

>     drivers/extcon/extcon.c:435:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c:89:90: warning: 'type' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/media/usb/dvb-usb/dvb-usb-dvb.c:323:5: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/media/dvb-frontends/cxd2841er.c:3217:569: warning: 'carrier_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/net/xen-netback/hash.c:127:6: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

I think these are all the result of using a pre-4.9 gcc and they are
all false positives. Maybe we can just call those older versions with
-Wno-maybe-uninitialized in the kernelci infrastructure?

> --------------------------------------------------------------------------------
> allmodconfig+CONFIG_OF=n (x86) ? FAIL, 4 errors, 14 warnings, 0 section mismatches
> 
> Errors:

>     drivers/pinctrl/bcm/pinctrl-iproc-gpio.c:381:20: error: 'pinconf_generic_dt_node_to_map_pin' undeclared here (not in a function)
>     drivers/pinctrl/bcm/pinctrl-cygnus-mux.c:739:20: error: 'pinconf_generic_dt_node_to_map_group' undeclared here (not in a function)
>     drivers/pinctrl/bcm/pinctrl-nsp-gpio.c:365:20: error: 'pinconf_generic_dt_node_to_map_pin' undeclared here (not in a function)

Haven't looked at the x86 specific problem yet, and I don't immediately see
what's wrong here. We appear to always set GENERIC_PINCONF from the driver.

> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_SMP=n (arm) ? FAIL, 4 errors, 0 warnings, 0 section mismatches
> 
> Errors:
>     dss-common.c:(.text+0x52bc): undefined reference to `secondary_startup'
>     dss-common.c:(.text+0x52e8): undefined reference to `secondary_startup'
>     dss-common.c:(.text+0x530c): undefined reference to `secondary_startup'
>     dss-common.c:(.text+0x5340): undefined reference to `secondary_startup'

I reported the problem, but don't have an idea for a good fix. This broke
with 0573b957fc21 ("ARM: OMAP4+: Prevent CPU1 related hang with kexec").

> --------------------------------------------------------------------------------
> pxa_defconfig (arm) ? FAIL, 3 errors, 0 warnings, 0 section mismatches
> 
> Errors:
>     /home/buildslave/workspace/khilman-kbuilder/next/build/../drivers/of/of_mdio.c:435: undefined reference to `fixed_phy_register'
>     /home/buildslave/workspace/khilman-kbuilder/next/build/../drivers/of/of_mdio.c:413: undefined reference to `fixed_phy_register'
>     /home/buildslave/workspace/khilman-kbuilder/next/build/../drivers/of/of_mdio.c:447: undefined reference to `fixed_phy_register'

I sent a patch for this.

	Arnd
