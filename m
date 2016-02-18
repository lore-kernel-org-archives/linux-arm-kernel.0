From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2016 23:41:44 +0000
Subject: [PATCH] ARM: virt: fix hyp-stub build for pre-ARMv7 CPUs
In-Reply-To: <1455799309-21300-1-git-send-email-jean-philippe.brucker@arm.com>
References: <20160217212551.GJ19428@n2100.arm.linux.org.uk>
 <1455799309-21300-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <20160218234144.GU19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 12:41:49PM +0000, Jean-Philippe Brucker wrote:
> ARMv6 CPUs do not have virtualisation extensions, but hyp-stub.S is
> still included into the image to keep it generic. In order to use ARMv7
> instructions during HYP initialisation, add -march=armv7-a flag to
> hyp-stub's build.
> 
> On an ARMv6 CPU, __hyp_stub_install returns as soon as it detects that
> the mode isn't HYP, so we will never reach those instructions.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Please drop this in the patch system, thanks.

> ---
>  arch/arm/boot/compressed/Makefile |    2 ++
>  arch/arm/kernel/Makefile          |    1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 7a6a58e..43788b1 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -195,5 +195,7 @@ CFLAGS_font.o := -Dstatic=
>  $(obj)/font.c: $(FONTC)
>  	$(call cmd,shipped)
>  
> +AFLAGS_hyp-stub.o := -Wa,-march=armv7-a
> +
>  $(obj)/hyp-stub.S: $(srctree)/arch/$(SRCARCH)/kernel/hyp-stub.S
>  	$(call cmd,shipped)
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 2c5f160..ad325a8 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_DEBUG_LL)	+= debug.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  
>  obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
> +AFLAGS_hyp-stub.o		:=-Wa,-march=armv7-a
>  ifeq ($(CONFIG_ARM_PSCI),y)
>  obj-$(CONFIG_SMP)		+= psci_smp.o
>  endif
> -- 
> 1.7.9.5
> 

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
