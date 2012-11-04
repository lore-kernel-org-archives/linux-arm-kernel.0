From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 4 Nov 2012 19:04:16 +0530
Subject: [PATCH v3 06/11] clk: davinci - add build infrastructure for
 DaVinci clock drivers
In-Reply-To: <1351181518-11882-7-git-send-email-m-karicheri2@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-7-git-send-email-m-karicheri2@ti.com>
Message-ID: <50966ED8.6070404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 9:41 PM, Murali Karicheri wrote:
> This updates clk Makefile and Kconfig to integrate the DaVinci specific
> clock drivers. Also add new Kconfig and Makefile for these drivers.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

As mentioned before, this should be folded into previous patches which
actually add the particular functionality.

> ---
>  drivers/clk/Kconfig          |    2 ++
>  drivers/clk/Makefile         |    1 +
>  drivers/clk/davinci/Kconfig  |   44 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/davinci/Makefile |    5 +++++
>  4 files changed, 52 insertions(+)
>  create mode 100644 drivers/clk/davinci/Kconfig
>  create mode 100644 drivers/clk/davinci/Makefile
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 7f0b5ca..1ad2ab0 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -33,6 +33,8 @@ config COMMON_CLK_DEBUG
>  	  clk_flags, clk_prepare_count, clk_enable_count &
>  	  clk_notifier_count.
>  
> +source "drivers/clk/davinci/Kconfig"
> +
>  config COMMON_CLK_WM831X
>  	tristate "Clock driver for WM831x/2x PMICs"
>  	depends on MFD_WM831X
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 5869ea3..b127b6f 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
>  obj-$(CONFIG_PLAT_SPEAR)	+= spear/
>  obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
>  obj-$(CONFIG_ARCH_INTEGRATOR)	+= versatile/
> +obj-$(CONFIG_DAVINCI_CLKS)	+= davinci/
>  
>  # Chip specific
>  obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
> diff --git a/drivers/clk/davinci/Kconfig b/drivers/clk/davinci/Kconfig
> new file mode 100644
> index 0000000..e53bbc3
> --- /dev/null
> +++ b/drivers/clk/davinci/Kconfig
> @@ -0,0 +1,44 @@
> +menu "TI DaVinci Clock drivers"
> +	depends on COMMON_CLK
> +
> +config  CLK_DAVINCI_PSC
> +	bool "TI DaVici PSC clock driver"
> +	default n
> +	---help---
> +	  Selects clock driver for DaVinci PSC clocks. This clock
> +	  hardware is found on TI DaVinci SoCs and other SoCs that
> +	  uses this hardware IP. This hardware has a local power
> +	  sleep control module that gate the clock to the IP.
> +
> +config  CLK_DAVINCI_PLL
> +	bool "DaVici main PLL clock"
> +	---help---
> +	  Selects clock driver for DaVinci main PLL. This clock
> +	  hardware is found on TI DaVinci SoCs. This typically has
> +	  a multiplier, a pre divider and post driver. Some of the
> +	  SoCs has the the dividers fixed, and others have it
> +	  programmable
> +
> +config  CLK_DAVINCI_PLLDIV
> +	bool "DaVici PLL divider clock"
> +	---help---
> +	  Selects clock driver for DaVinci PLL divider. This clock
> +	  hardware is found on TI DaVinci SoCs. This typically has
> +	  a divider and an enable bit to bypass or enable the
> +	  divider.
> +
> +config DAVINCI_CLKS
> +	bool "TI DaVinci common clocks"
> +	default n
> +	select CLK_DAVINCI_PSC
> +	select CLK_DAVINCI_PLLDIV
> +	---help---
> +	  Selects common clock drivers for DaVinci. These clocks
> +	  are re-used across many TI SoCs that are based on DaVinci and
> +	  Keystone (c6x) families. This config option is used to select
> +	  the common clock driver for DaVinci based SoCs. SoCs specific
> +	  Kconfig option needs to select the driver for clocks specific
> +	  to the SoC.
> +
> +endmenu

I wonder if all these configurations are really required. For complete
clock functionality you anyway require all this functionality so I
wonder why anyone would not select any of these. And to differentiate
between architecture changes, conditional build based on architecture
can be used:

obj-$(CONFIG_ARCH_DAVINCI)	+= clk-pll.o
obj-$(CONFIG_ARCH_KEYSTONE)	+= clk-pll-keystone.o

Thanks,
Sekhar
