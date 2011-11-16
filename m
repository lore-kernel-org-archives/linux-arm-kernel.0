From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Nov 2011 15:36:56 +0000
Subject: [PATCH 5/5] ARM: vexpress: DT-based support for CoreTiles
 Express A5x2 and A9x4
In-Reply-To: <1321036026-23411-6-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-6-git-send-email-pawel.moll@arm.com>
Message-ID: <20111116153656.GC2073@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 06:27:06PM +0000, Pawel Moll wrote:
> This patch adds Device Trees for ARM Ltd. CoreTile Express A5x2
> and CoreTile Express A9x4 used with V2M motherboard and an initial
> implementation of the DT machine support (this code is separate
> from the current core tile code).
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/boot/dts/vexpress-v2p-ca5s.dts |  132 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts  |  146 +++++++++++++++++++++++++++++++
>  arch/arm/mach-vexpress/Kconfig          |   15 +++
>  arch/arm/mach-vexpress/Makefile         |    1 +
>  arch/arm/mach-vexpress/v2p-ca5s_ca9.c   |  103 ++++++++++++++++++++++
>  5 files changed, 397 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
>  create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
>  create mode 100644 arch/arm/mach-vexpress/v2p-ca5s_ca9.c
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts

[...]

> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "V2P-CA5s";
> +	arm,hbi = <0x225>;

Are these part numbers formally hex numbers?  Is so, fine.  Otherwise
maybe it would me safer to make properties of this kind strings.

[...]

> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index d1b0f35..6b79400 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -22,4 +22,19 @@ config ARCH_VEXPRESS_DT
>  	bool
>  	select OF
>  
> +config ARCH_VEXPRESS_V2P_CA5S_CA9
> +	bool "DT: CoreTiles Express A5x2 and A9x4"

This "DT" stuff is a bit cryptic -- also it's an implementation feature
rather than part of the core nature of this config option.

Also, pedaitically, the product name is "CoreTile Express".

Finally, this option does not support those core tiles, as such; rather
it supports particular whole-platform configurations involving those
core tiles.

How about "CoreTile Express A5x2 and A9x4 based platform support"

> +	select ARCH_VEXPRESS_RS1
> +	select ARCH_VEXPRESS_DT
> +	select ARM_ERRATA_720789
> +	select ARM_ERRATA_751472
> +	select ARM_ERRATA_753970
> +	help
> +	  This option enabled Device Tree based support for
> +	  CoreTile Express A5x2 (V2P-CA5s) and
> +	  CoreTile Express A9x4 (V2P-CA9).
> +
> +	  Note that you must provide kernel with a valid DTB
> +	  for the board if you want to use this option.

For the above reasons, the following alternative text might be a bit
more user-friendly:

	help
	  This option enables support for systems using any of the the following
	  ARM core tiles on the Versatile Express motherboard:

	      CoreTile Express A5x2 (V2P-CA5s)
	      CoreTile Express A9x4 (V2P-CA9)

	  You must boot using a Flattened Device Tree in order to use these
	  platforms.  The traditional (ATAGs) boot method is not usable on
	  these boards with this option.

	  If you want your kernel to run on one of these platforms and your
	  bootloader supports Flattened Device Tree based booting, say Y.

Do we still support the "old style" V2P-CA9x4 support?  If so, we could
add a comment explaining that is available as an alternative, for now.

> +
>  endmenu
> diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> index 90551b9..06e3687 100644
> --- a/arch/arm/mach-vexpress/Makefile
> +++ b/arch/arm/mach-vexpress/Makefile
> @@ -4,5 +4,6 @@
>  
>  obj-y					:= v2m.o
>  obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
> +obj-$(CONFIG_ARCH_VEXPRESS_V2P_CA5S_CA9) += v2p-ca5s_ca9.o
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> diff --git a/arch/arm/mach-vexpress/v2p-ca5s_ca9.c b/arch/arm/mach-vexpress/v2p-ca5s_ca9.c

[...]

> +DT_MACHINE_START(VEXPRESS_V2P_CA5S_CA9, "ARM Versatile Express")

We could try to name the platform fully here, but these strings would
get very long -- so I agree it best to leave that to be specified in
the device tree.

Cheers
---Dave
