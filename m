From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2016 17:25:39 +0200
Subject: [PATCH 3/6] Clocksource: add nuc970 clocksource driver
In-Reply-To: <1466851042-22239-4-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-4-git-send-email-vw@iommu.org>
Message-ID: <4184925.Jh1dkPbmzX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 25, 2016 6:37:19 PM CEST Wan Zongshun wrote:
> This patch is to add nuc970 clocksource driver support.
> 
> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
>  .../mach-w90x900/include/mach/nuc970-regs-timer.h  |  44 +++++
>  drivers/clocksource/Kconfig                        |   8 +
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/timer-nuc900.c                 | 207 +++++++++++++++++++++
>  4 files changed, 260 insertions(+)
>  create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
>  create mode 100644 drivers/clocksource/timer-nuc900.c
> 
> diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h b/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
> new file mode 100644
> index 0000000..43d7e8b
> --- /dev/null
> +++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h

Please move the contents of the header file into the driver. We try to not
have any new mach/*.h headers.

> +
> +static unsigned int timer0_load;
> +static void __iomem *tmr_base;
> +
> +static int nuc970_clockevent_set_oneshot(struct clock_event_device *evt)
> +{
> +	unsigned int val;
> +
> +	val = __raw_readl(tmr_base + REG_TMR_TCSR0);
> +	val &= ~(0x03 << 27);
> +
> +	val |= (ONESHOT | COUNTEN | INTEN | PRESCALE);
> +
> +	__raw_writel(val, tmr_base + REG_TMR_TCSR0);
> +	return 0;
> +}
> +

writel() instead of __raw_writel()

	Arnd
