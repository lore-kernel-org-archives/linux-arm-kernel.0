From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 May 2010 12:19:46 +0200
Subject: [PATCH v6] ARM: S5PV210: Add Ext interrupt support.
In-Reply-To: <1274082986-24250-1-git-send-email-kgene.kim@samsung.com>
References: <1274082986-24250-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <00c601caf5aa$7c5aeea0$7510cbe0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, May 17, 2010 9:56 AM Kukjin Kim wrote:

> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> Add support for external interrupts on S5PV210.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig                  |    1 +
>  arch/arm/mach-s5pv210/include/mach/irqs.h      |   31 ++---
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   44 +++++
>  arch/arm/plat-s5p/Kconfig                      |    5 +
>  arch/arm/plat-s5p/Makefile                     |    1 +
>  arch/arm/plat-s5p/irq-eint.c                   |  213
> ++++++++++++++++++++++++
>  6 files changed, 275 insertions(+), 20 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h
>  create mode 100644 arch/arm/plat-s5p/irq-eint.c
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index af33a1a..c4c2a7f 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -12,6 +12,7 @@ if ARCH_S5PV210
>  config CPU_S5PV210
>  	bool
>  	select PLAT_S5P
> +	select S5P_EXT_INT
>  	help
>  	  Enable S5PV210 CPU support
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
> s5pv210/include/mach/irqs.h
> index 62c5175..3a9e42e 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -17,22 +17,6 @@
> 
>  /* VIC0: System, DMA, Timer */
> 
> -#define IRQ_EINT0		S5P_IRQ_VIC0(0)
> -#define IRQ_EINT1		S5P_IRQ_VIC0(1)
> -#define IRQ_EINT2		S5P_IRQ_VIC0(2)
> -#define IRQ_EINT3		S5P_IRQ_VIC0(3)
> -#define IRQ_EINT4		S5P_IRQ_VIC0(4)
> -#define IRQ_EINT5		S5P_IRQ_VIC0(5)
> -#define IRQ_EINT6		S5P_IRQ_VIC0(6)
> -#define IRQ_EINT7		S5P_IRQ_VIC0(7)
> -#define IRQ_EINT8		S5P_IRQ_VIC0(8)
> -#define IRQ_EINT9		S5P_IRQ_VIC0(9)
> -#define IRQ_EINT10		S5P_IRQ_VIC0(10)
> -#define IRQ_EINT11		S5P_IRQ_VIC0(11)
> -#define IRQ_EINT12		S5P_IRQ_VIC0(12)
> -#define IRQ_EINT13		S5P_IRQ_VIC0(13)
> -#define IRQ_EINT14		S5P_IRQ_VIC0(14)
> -#define IRQ_EINT15		S5P_IRQ_VIC0(15)
>  #define IRQ_EINT16_31		S5P_IRQ_VIC0(16)
>  #define IRQ_BATF		S5P_IRQ_VIC0(17)
>  #define IRQ_MDMA		S5P_IRQ_VIC0(18)
> @@ -134,13 +118,20 @@
>  #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
>  #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
> 
> -#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
> +#define S5P_EINT_16_31_BASE	(IRQ_VIC_END + 1)
> 
> -#define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
> -#define IRQ_EINT(x)		S5P_EINT(x)

ok

> +#define EINT_MODE		S3C_GPIO_SFN(0xf)

IMHO the irq.h is not the right place for this define

> +
> +#define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_IRQ_VIC0(0)) \
> +					: ((x) + S5P_EINT_16_31_BASE))
> 
>  /* Set the default NR_IRQS */
> 
> -#define NR_IRQS 		(IRQ_EINT(31) + 1)
> +#define NR_IRQS			(IRQ_EINT(31) + 1)
> +

ok

> +#define EINT_GPIO_0(x)		S5PV210_GPH0(x)
> +#define EINT_GPIO_1(x)		S5PV210_GPH1(x)
> +#define EINT_GPIO_2(x)		S5PV210_GPH2(x)
> +#define EINT_GPIO_3(x)		S5PV210_GPH3(x)

Again, gpio.h would be much better for these.

> ...

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
