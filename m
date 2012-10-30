From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 20:31:27 -0600
Subject: [PATCH 1/2] arm: bcm2835: move to the multiplatform support
In-Reply-To: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508F3BFF.6010305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 04:24 AM, Thomas Petazzoni wrote:
> This commit integrates the bcm2835 into the list of platforms
> supported by the multiplatform mechanism, which makes it possible to
> build a single kernel binary image that boots on various SoCs.
...
> Note that if you have CONFIG_VFP enabled, you need "[PATCH v3] ARM:
> vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3
> set" to be applied in order to avoid a VFP-related kernel panic when
> starting the first userspace application. Thanks to Albin Tonnerre for
> pointing me to the right fix for this problem!

Since CONFIG_VFP is enabled in bcm2835_defconfig (or in general, could
be enabled in anyone's .config), I guess that means I can't apply the
patch yet, because the VFP fix you mention above doesn't seem to have
been applied anywhere, so applying it would cause bcm2835_defconfig to
be unbootable. To apply this, I'd need to merge in a branch containing
the VFP fix first.

What branch is this patch series based on? Neither "git am" not "git am
-3" will apply the series; apparently my repo doesn't have the blobs to
perform the 3-way merge -3 invokes even though I have a remote for
linux-next which should pick up most blob sources.

A couple minor comments on the code itself:

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug

> +	config DEBUG_BCM2835_UART
> +		bool "Kernel low-level debugging messages via BCM2835 UART"
> +		depends on ARCH_BCM2835
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on BCM2835 based platforms.
> +

Since the SoC has multiple UARTs, does it make sense to rename that
something like DEBUG_BM2835_PL011_UART?

> diff --git a/arch/arm/mach-bcm2835/include/mach/debug-macro.S b/arch/arm/include/debug/bcm2835.S

> -#include <mach/bcm2835_soc.h>
> +#define BCM2835_DEBUG_PHYS	0x20201000
> +#define BCM2835_DEBUG_VIRT	0xf0201000

Especially since I have to wait to apply this anyway, I'd prefer to
avoid that part of this patch, by calling debug_ll_io_init() from
bcm2835_map_io(). That patch unfortunately also isn't checked in yet,
but I'll try to chase it down.
