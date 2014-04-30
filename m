From: robherring2@gmail.com (Rob Herring)
Date: Wed, 30 Apr 2014 01:34:05 -0500
Subject: Fwd: [PATCH v4 02/14] ARM: append ARCH_MULTI_V7_LPAE
In-Reply-To: <1398668032-8335-3-git-send-email-haojian.zhuang@linaro.org>
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAL_Jsq+PGPTYBNu2rnD56ko3E0LNryNK8e0ZsR+pU=U1q-vZ9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 1:53 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> Add new ARCH_MULTI_V7_LPAE config. It will select ARM_LPAE only both
> ARCH_MULTI_V6 & ARCH_MULTI_V7 is disabled.
>
> ARCH_MULTI_V7 means non-LPAE platform.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig               | 10 +++++++++-
>  arch/arm/mach-berlin/Kconfig   |  2 +-
>  arch/arm/mach-highbank/Kconfig |  2 +-
>  arch/arm/mach-mvebu/Kconfig    |  4 ++--
>  arch/arm/mach-omap2/Kconfig    |  4 ++--
>  arch/arm/mach-qcom/Kconfig     |  2 +-
>  arch/arm/mach-shmobile/Kconfig |  2 +-
>  arch/arm/mach-tegra/Kconfig    |  2 +-
>  arch/arm/mach-vexpress/Kconfig |  2 +-
>  9 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ab438cb..5ef96ea 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -918,12 +918,20 @@ config ARCH_MULTI_V6
>         select CPU_V6K
>
>  config ARCH_MULTI_V7
> -       bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
> +       bool "ARMv7 non-LPAE based platforms (Cortex-A5/A8/A9, PJ4, PJ4B, Scorpion)"
>         default y
>         select ARCH_MULTI_V6_V7
> +       select ARCH_MULTI_V7_LPAE

This doesn't seem right.

>         select CPU_V7
>         select HAVE_SMP
>
> +config ARCH_MULTI_V7_LPAE
> +       bool "ARMv7 LPAE based platforms (Cortex-A7/A12/A15/A17, Brahma-B15, PJ4B-MP, Krait)"
> +       select ARCH_MULTI_V6_V7
> +       select CPU_V7
> +       select HAVE_SMP
> +       select ARM_LPAE if !(ARCH_MULTI_V6 || ARCH_MULTI_V7)

This logic doesn't really seem right either.

Most of the rest of the changes can be avoided if you rename
ARCH_MULTI_V7 to ARCH_MULTI_V7_NONLPAE and then add:

config ARCH_MULTI_V7
    def_bool y if (ARCH_MULTI_V7_NONLPAE || ARCH_MULTI_V7_LPAE)

> +
>  config ARCH_MULTI_V6_V7
>         bool
>         select MIGHT_HAVE_CACHE_L2X0
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index b0cb072..be0512d 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_BERLIN
> -       bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
> +       bool "Marvell Berlin SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V7_LPAE)
>         select ARM_GIC
>         select GENERIC_IRQ_CHIP
>         select DW_APB_ICTL
> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index 830b76e..9b6b3f8 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_HIGHBANK
> -       bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7
> +       bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7_LPAE

Highbank is not LPAE. Midway is LPAE (and can run non-LPAE kernels).

>         select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>         select ARCH_HAS_CPUFREQ
>         select ARCH_HAS_HOLES_MEMORYMODEL
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 3f73eec..0d54d1a 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_MVEBU
> -       bool "Marvell Engineering Business Unit (MVEBU) SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V5)
> +       bool "Marvell Engineering Business Unit (MVEBU) SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V7_LPAE || ARCH_MULTI_V5)
>         select ARCH_SUPPORTS_BIG_ENDIAN
>         select CLKSRC_MMIO
>         select GENERIC_IRQ_CHIP
> @@ -59,7 +59,7 @@ config MACH_ARMADA_38X
>           on the Marvell Armada 380/385 SoC with device tree.
>
>  config MACH_ARMADA_XP
> -       bool "Marvell Armada XP boards" if ARCH_MULTI_V7
> +       bool "Marvell Armada XP boards" if ARCH_MULTI_V7_LPAE
>         select ARMADA_XP_CLK
>         select CPU_PJ4B
>         select MACH_MVEBU_V7
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index cb31d43..1958791 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -41,7 +41,7 @@ config ARCH_OMAP4
>
>  config SOC_OMAP5
>         bool "TI OMAP5"
> -       depends on ARCH_MULTI_V7
> +       depends on ARCH_MULTI_V7_LPAE

Can't OMAP5 run a non-LPAE enabled kernel?

Rob
