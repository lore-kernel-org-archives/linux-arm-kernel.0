From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Apr 2011 22:48:27 -0600
Subject: [PATCH v2] arm/dt: Add a make rule to build dtb for enabled boards
In-Reply-To: <1301929307-1838-1-git-send-email-shawn.guo@linaro.org>
References: <1301929307-1838-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110405044827.GA28817@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 11:01:47PM +0800, Shawn Guo wrote:
> With 'make ARCH=arm dtb', it builds Device Tree Blobs for those boards
> enabled by build CONFIG.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> It's based on commit fe8e6d0b0e601ca0a63fe768d4b812d5a45a9da7
> "arm/dt: Add dtb make rule" from Rob Herring.  And it works against
> Linaro kernel tree.  But it needs to go through mainline review
> before it gets applied.
> 
> Changes since v1:
> * Take suggestion from Rob Herring to move .dts dection into machine
>   sepcific Makefile.boot, so that arch/arm/boot/Makefile can be as
>   clean as it is.

Looks good, some minor comments below, but I've picked it up and asked
Nicolas to merge it.

Cheers,
g.

> 
>  arch/arm/Makefile                     |    3 +++
>  arch/arm/boot/Makefile                |    2 ++
>  arch/arm/mach-exynos4/Makefile.boot   |    2 ++
>  arch/arm/mach-mx5/Makefile.boot       |    5 +++++
>  arch/arm/mach-omap2/Makefile.boot     |    4 ++++
>  arch/arm/mach-tegra/Makefile.boot     |    2 ++
>  arch/arm/mach-versatile/Makefile.boot |    2 ++
>  7 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index d51ab6c..7fd2af9 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -292,6 +292,9 @@ zinstall uinstall install: vmlinux
>  %.dtb:
>  	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
>  
> +dtb:
> +	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
> +

Since the target is the same, I've merged this rule with the %.dtb
rule.  I also renamed the target 'dtbs' because it will build more
than one .dtb file.

>  # We use MRPROPER_FILES and CLEAN_FILES now
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 08fc37f..ce39850 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -63,6 +63,8 @@ endif
>  $(obj)/%.dtb: $(src)/dts/%.dts
>  	$(call cmd,dtc)
>  
> +$(obj)/dtb: $(addprefix $(obj)/, $(dtb-y))
> +
>  quiet_cmd_uimage = UIMAGE  $@
>        cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
>  		   -C none -a $(LOADADDR) -e $(STARTADDR) \
> diff --git a/arch/arm/mach-exynos4/Makefile.boot b/arch/arm/mach-exynos4/Makefile.boot
> index d65956f..fcee6b5 100644
> --- a/arch/arm/mach-exynos4/Makefile.boot
> +++ b/arch/arm/mach-exynos4/Makefile.boot
> @@ -1,2 +1,4 @@
>     zreladdr-y	:= 0x40008000
>  params_phys-y	:= 0x40000100
> +
> +dtb-$(CONFIG_MACH_SMDKV310) += exynos4-smdkv310.dtb
> diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> index e928be1..4111462 100644
> --- a/arch/arm/mach-mx5/Makefile.boot
> +++ b/arch/arm/mach-mx5/Makefile.boot
> @@ -7,3 +7,8 @@ initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
>     zreladdr-$(CONFIG_ARCH_MX53)	:= 0x70008000
>  params_phys-$(CONFIG_ARCH_MX53)	:= 0x70000100
>  initrd_phys-$(CONFIG_ARCH_MX53)	:= 0x70800000
> +
> +dtb-$(CONFIG_MACH_MX51_BABBAGE) += mx51-babbage.dtb
> +dtb-$(CONFIG_MACH_MX51_EFIKAMX) += genesi-efikamx.dtb
> +dtb-$(CONFIG_MACH_MX51_EFIKASB) += genesi-efikasb.dtb
> +dtb-$(CONFIG_MACH_MX53_LOCO) += mx53-loco.dtb
> diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
> index 565aff7..0f54901 100644
> --- a/arch/arm/mach-omap2/Makefile.boot
> +++ b/arch/arm/mach-omap2/Makefile.boot
> @@ -1,3 +1,7 @@
>    zreladdr-y		:= 0x80008000
>  params_phys-y		:= 0x80000100
>  initrd_phys-y		:= 0x80800000
> +
> +dtb-$(CONFIG_MACH_OMAP3_BEAGLE) += omap3-beagle.dtb
> +dtb-$(CONFIG_MACH_OMAP4_PANDA) += omap4-panda.dtb
> +dtb-$(CONFIG_MACH_OVERO) += omap3-overo.dtb
> diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
> index db52d61..c98addf 100644
> --- a/arch/arm/mach-tegra/Makefile.boot
> +++ b/arch/arm/mach-tegra/Makefile.boot
> @@ -1,3 +1,5 @@
>  zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00008000
>  params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
>  initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
> +
> +dtb-$(CONFIG_MACH_HARMONY) += tegra-harmony.dtb
> diff --git a/arch/arm/mach-versatile/Makefile.boot b/arch/arm/mach-versatile/Makefile.boot
> index c7e75ac..e2227d3 100644
> --- a/arch/arm/mach-versatile/Makefile.boot
> +++ b/arch/arm/mach-versatile/Makefile.boot
> @@ -2,3 +2,5 @@
>  params_phys-y	:= 0x00000100
>  initrd_phys-y	:= 0x00800000
>  
> +dtb-$(CONFIG_ARCH_VERSATILE_PB) += versatile-pb.dtb
> +dtb-$(CONFIG_MACH_VERSATILE_AB) += versatile-ab.dtb
> -- 
> 1.7.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
