From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 20:41:57 +0200
Subject: [PATCH v2 3/3] arm: exynos5260: add support for S2R
In-Reply-To: <1395061795-17777-4-git-send-email-vikas.sajjan@samsung.com>
References: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
 <1395061795-17777-4-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <534D7D75.8080701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

On 17.03.2014 14:09, Vikas Sajjan wrote:
> Adds Suspend to RAM (S2R) support to exynos5260.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>   arch/arm/mach-exynos/pm.c       |   62 +++++++++++++++++++++++++++++++--------
>   arch/arm/mach-exynos/regs-pmu.h |   12 ++++++++
>   2 files changed, 61 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index dbe9670..12cc241 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -77,12 +77,20 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
>   	{ /* sentinel */ },
>   };
>
> +static const struct exynos_wkup_irq exynos5260_wkup_irq[] = {
> +	{ 105, BIT(1) }, /* RTC alarm */
> +	{ 106, BIT(2) }, /* RTC tick */
> +	{ /* sentinel */ },
> +};
> +
>   static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
>   {
>   	const struct exynos_wkup_irq *wkup_irq;
>
>   	if (soc_is_exynos5250())
>   		wkup_irq = exynos5250_wkup_irq;
> +	else if (soc_is_exynos5260())
> +		wkup_irq = exynos5260_wkup_irq;
>   	else
>   		wkup_irq = exynos4_wkup_irq;

This should probably be tied to some DT match table as match data for 
particular compatible strings. Also to eliminate the need to add such 
change for every new SoC, the mapping between wake-up sources and GIC 
interrupts should be probably parsed from DT.

Adding some people on CC for further comments.

>
> @@ -124,10 +132,20 @@ static void exynos_pm_prepare(void)
>   	unsigned int tmp;
>
>   	/* Set wake-up mask registers */
> -	__raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
> -	__raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
> +	if (soc_is_exynos5260()) {
> +		__raw_writel(exynos_get_eint_wake_mask(),
> +					EXYNOS5260_EINT_WAKEUP_MASK);
> +		__raw_writel(exynos_irqwake_intmask & ~(1 << 31),
> +					EXYNOS5260_WAKEUP_MASK);
> +	} else {
> +		__raw_writel(exynos_get_eint_wake_mask(),
> +					S5P_EINT_WAKEUP_MASK);
> +		__raw_writel(exynos_irqwake_intmask & ~(1 << 31),
> +					S5P_WAKEUP_MASK);
> +	}

Same here. I wonder what we could do to eliminate the need for such changes.

By the way, don't you need to handle here EXYNOS5260_WAKEUP_MASK2 and 
EXYNOS5260_WAKEUP_MASK3 as well?

>
> -	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
> +	if (!soc_is_exynos5260())
> +		s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));

Ugly.

>
>   	if (soc_is_exynos5250()) {
>   		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
> @@ -221,21 +239,39 @@ static void exynos_pm_resume(void)
>   			      : "cc");
>   	}
>
> -	/* For release retention */
> -
> -	__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
> -	__raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
> -	__raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
> -	__raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
> -	__raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
> -	__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
> -	__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
> +	if (soc_is_exynos5250()) {
> +		/* For release retention */
> +
> +		__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
> +		__raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
> +		__raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
> +		__raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
> +		__raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
> +		__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
> +		__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
> +	} else if (soc_is_exynos5260()) {
> +		/* For release retention */
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_LPDDR3_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RET_MAUDIO_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RET_JTAG_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MMC2_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_TOP_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_UART_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MMC0_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MMC1_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_SPI_OPTION);
> +		__raw_writel((1 << 28), EXYNOS5260_PAD_RETENTION_MIF_OPTION);
> +		__raw_writel((1 << 28),
> +				EXYNOS5260_PAD_RETENTION_BOOTLDO_OPTION);
> +	}
>

Ugly.

>   	if (soc_is_exynos5250())
>   		s3c_pm_do_restore(exynos5_sys_save,
>   			ARRAY_SIZE(exynos5_sys_save));
>
> -	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
> +	if (!soc_is_exynos5260())
> +		s3c_pm_do_restore_core(exynos_core_save,
> +				ARRAY_SIZE(exynos_core_save));

Ugly.

I believe that exactly the same comments apply to this file as mentioned 
in my review of patch 2/3 for pmu.c. The code needs to be reworked to 
let us remove soc_is_exynos*() macros.

Best regards,
Tomasz
