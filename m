From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Fri, 05 Nov 2010 16:05:16 +0200
Subject: [PATCH 2/7] ARM i.MX irq: Compile avic irq code only on SoCs
	that need it
In-Reply-To: <1288950371-1552-3-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
	<1288950371-1552-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4CD40F1C.3020005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2010 11:46 AM, Sascha Hauer wrote:
> This patch adds a Kconfig option for the avic irq controller
> and lets the SoCs that need it select this option.
> Also, as we have two irq controllers for i.MX, irq.c is not
> appropriate anymore, so rename it to avic.c
>
> Signed-off-by: Sascha Hauer<s.hauer@pengutronix.de>
> ---
>   arch/arm/mach-imx/Kconfig           |    3 +++
>   arch/arm/mach-mx3/Kconfig           |    2 ++
>   arch/arm/plat-mxc/Kconfig           |    4 ++++
>   arch/arm/plat-mxc/Makefile          |    3 ++-
>   arch/arm/plat-mxc/{irq.c =>  avic.c} |    0
>   5 files changed, 11 insertions(+), 1 deletions(-)
>   rename arch/arm/plat-mxc/{irq.c =>  avic.c} (100%)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 197f9e2..58b6114 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -7,6 +7,7 @@ config SOC_IMX1
>   	select CPU_ARM920T
>   	select IMX_HAVE_DMA_V1
>   	select IMX_HAVE_IOMUX_V1
> +	select MXC_AVIC
>   	bool
>
>   comment "MX1 platforms:"
> @@ -36,6 +37,7 @@ config SOC_IMX21
>   	select ARCH_MXC_AUDMUX_V1
>   	select IMX_HAVE_DMA_V1
>   	select IMX_HAVE_IOMUX_V1
> +	select MXC_AVIC
>   	bool
>
>   config SOC_IMX27
> @@ -43,6 +45,7 @@ config SOC_IMX27
>   	select ARCH_MXC_AUDMUX_V1
>   	select IMX_HAVE_DMA_V1
>   	select IMX_HAVE_IOMUX_V1
> +	select MXC_AVIC
>   	bool
>
>   choice
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 5000ac1..7863199 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -3,6 +3,7 @@ if ARCH_MX3
>   config ARCH_MX31
>   	select ARCH_HAS_RNGA
>   	select ARCH_MXC_AUDMUX_V2
> +	select MXC_AVIC
>   	bool
>
>   config ARCH_MX35
> @@ -10,6 +11,7 @@ config ARCH_MX35
>   	select ARCH_MXC_IOMUX_V3
>   	select ARCH_MXC_AUDMUX_V2
>   	select HAVE_EPIT
> +	select MXC_AVIC
>
>   comment "MX3 platforms:"
>
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index 64e3a64..31d07c0 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -25,6 +25,7 @@ config ARCH_MX25
>   	select ARCH_MXC_IOMUX_V3
>   	select HAVE_FB_IMX
>   	select ARCH_MXC_AUDMUX_V2
> +	select MXC_AVIC
>   	help
>   	  This enables support for systems based on the Freescale i.MX25 family
>
> @@ -75,6 +76,9 @@ config MXC_TZIC
>   	  containing this interrupt controller.
>   	  Say N here only if you are really sure.
>
> +config MXC_AVIC
> +	bool
> +
>   config MXC_PWM
>   	tristate "Enable PWM driver"
>   	select HAVE_PWM
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index 3726709..0e12591 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -3,10 +3,11 @@
>   #
>
>   # Common support
> -obj-y := irq.o clock.o gpio.o time.o devices.o cpu.o system.o
> +obj-y := clock.o gpio.o time.o devices.o cpu.o system.o
>
>   # MX51 uses the TZIC interrupt controller, older platforms use AVIC (irq.o)

it is not irq.o anymore as stated in the comment

>   obj-$(CONFIG_MXC_TZIC) += tzic.o
> +obj-$(CONFIG_MXC_AVIC) += avic.o
>
>   obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
>   obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
> diff --git a/arch/arm/plat-mxc/irq.c b/arch/arm/plat-mxc/avic.c
> similarity index 100%
> rename from arch/arm/plat-mxc/irq.c
> rename to arch/arm/plat-mxc/avic.c
