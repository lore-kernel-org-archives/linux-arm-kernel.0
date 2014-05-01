From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 01 May 2014 11:55:40 -0700
Subject: [PATCH 05/10] clk: versatile: Split config options for sp810 and
 vexpress_osc
In-Reply-To: <1398707877-22596-6-git-send-email-pawel.moll@arm.com>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-6-git-send-email-pawel.moll@arm.com>
Message-ID: <20140501185540.4919.29582@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pawel Moll (2014-04-28 10:57:52)
> Move the Kconfig entry for Versatile (& Express) clock drivers
> into a separate file and add individual options for sp810
> and vexpress_osc drivers, as they are optional in some
> configurations and may have separate dependencies.
> 
> Cc: Mike Turquette <mturquette@linaro.org> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/Kconfig            |  9 +--------
>  drivers/clk/versatile/Kconfig  | 26 ++++++++++++++++++++++++++
>  drivers/clk/versatile/Makefile |  5 +++--
>  3 files changed, 30 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/clk/versatile/Kconfig
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 6f56d3a..4fdfd6c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -30,14 +30,7 @@ config COMMON_CLK_WM831X
>            Supports the clocking subsystem of the WM831x/2x series of
>           PMICs from Wolfson Microlectronics.
>  
> -config COMMON_CLK_VERSATILE
> -       bool "Clock driver for ARM Reference designs"
> -       depends on ARCH_INTEGRATOR || ARCH_REALVIEW || ARCH_VEXPRESS || ARM64
> -       ---help---
> -          Supports clocking on ARM Reference designs:
> -         - Integrator/AP and Integrator/CP
> -         - RealView PB1176, EB, PB11MP and PBX
> -         - Versatile Express
> +source "drivers/clk/versatile/Kconfig"
>  
>  config COMMON_CLK_MAX77686
>         tristate "Clock driver for Maxim 77686 MFD"
> diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> new file mode 100644
> index 0000000..1530c93
> --- /dev/null
> +++ b/drivers/clk/versatile/Kconfig
> @@ -0,0 +1,26 @@
> +config COMMON_CLK_VERSATILE
> +       bool "Clock driver for ARM Reference designs"
> +       depends on ARCH_INTEGRATOR || ARCH_REALVIEW || ARCH_VEXPRESS || ARM64
> +       ---help---
> +          Supports clocking on ARM Reference designs:
> +         - Integrator/AP and Integrator/CP
> +         - RealView PB1176, EB, PB11MP and PBX
> +         - Versatile Express
> +
> +config CLK_SP810
> +       bool "Clock driver for ARM SP810 System Controller"
> +       depends on COMMON_CLK_VERSATILE
> +       default y if ARCH_VEXPRESS
> +       ---help---
> +         Supports clock muxing (REFCLK/TIMCLK to TIMERCLKEN0-3) capabilities
> +         of the ARM SP810 System Controller cell.
> +
> +config CLK_VEXPRESS_OSC
> +       bool "Clock driver for Versatile Express OSC clock generators"
> +       depends on COMMON_CLK_VERSATILE
> +       depends on VEXPRESS_CONFIG
> +       default y if ARCH_VEXPRESS
> +       ---help---
> +         Simple regmap-based driver driving clock generators on Versatile
> +         Express platforms hidden behind its configuration infrastructure,
> +         commonly known as OSCs.
> diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
> index c16ca78..fd449f9 100644
> --- a/drivers/clk/versatile/Makefile
> +++ b/drivers/clk/versatile/Makefile
> @@ -3,5 +3,6 @@ obj-$(CONFIG_ICST)              += clk-icst.o
>  obj-$(CONFIG_ARCH_INTEGRATOR)  += clk-integrator.o
>  obj-$(CONFIG_INTEGRATOR_IMPD1) += clk-impd1.o
>  obj-$(CONFIG_ARCH_REALVIEW)    += clk-realview.o
> -obj-$(CONFIG_ARCH_VEXPRESS)    += clk-vexpress.o clk-sp810.o
> -obj-$(CONFIG_VEXPRESS_CONFIG)  += clk-vexpress-osc.o
> +obj-$(CONFIG_ARCH_VEXPRESS)    += clk-vexpress.o
> +obj-$(CONFIG_CLK_SP810)                += clk-sp810.o
> +obj-$(CONFIG_CLK_VEXPRESS_OSC) += clk-vexpress-osc.o
> -- 
> 1.9.1
> 
