From: kim.phillips@freescale.com (Kim Phillips)
Date: Mon, 16 Apr 2012 18:08:34 -0500
Subject: [PATCH v2] rtc: add support for Freescale SNVS RTC
In-Reply-To: <1334387237-23519-1-git-send-email-paul.liu@linaro.org>
References: <1334387237-23519-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120416180834.a4578493ab1f747a1b3c2dd0@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 14 Apr 2012 15:07:17 +0800
"Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org> wrote:

> +++ b/Documentation/devicetree/bindings/rtc/snvs-rtc.txt

this conflicts with the "Secure Non-Volatile Storage (SNVS) Node"
section published in:

Documentation/devicetree/bindings/crypto/fsl-sec4.txt

please use that instead.

> +config RTC_DRV_SNVS
> +	tristate "Freescale SNVS Real Time Clock"
> +	depends on ARCH_MXC

|| FSL_SOC

since this h/w also exists in other, non-ARM based, SoCs.

> +struct rtc_drv_data {
> +	struct rtc_device *rtc;
> +	void __iomem *ioaddr;
> +	int irq;
> +	bool irq_enable;
> +};
> +
> +static DEFINE_SPINLOCK(rtc_lock);

the lock belongs in struct rtc_drv_data.

> +static int64_t time_diff;

time_diff is only being written; it isn't being used.

> +	return IRQ_HANDLED;

return IRQ_NONE if !(lp_status & SNVS_LPSR_LPTA)

> +	alrm->pending =
> +	    ((readl(ioaddr + SNVS_LPSR) & SNVS_LPSR_LPTA) != 0) ? 1 : 0;

alrm->pending = !!readl(ioaddr + SNVS_LPSR) & SNVS_LPSR_LPTA;

> +	/* initialize glitch detect */
> +	writel(SNVS_LPPGDR_INIT, ioaddr + SNVS_LPPGDR);
> +	udelay(100);
> +
> +	/* clear lp interrupt status */
> +	writel(0xFFFFFFFF, ioaddr + SNVS_LPSR);
> +
> +	/* Enable RTC */
> +	lp_cr = readl(ioaddr + SNVS_LPCR);
> +	if ((lp_cr & SNVS_LPCR_SRTC_ENV) == 0)
> +		writel(lp_cr | SNVS_LPCR_SRTC_ENV, ioaddr + SNVS_LPCR);
> +	udelay(100);
> +
> +	writel(0xFFFFFFFF, ioaddr + SNVS_LPSR);
> +	udelay(100);

the manual doesn't state that delays are required after writing
these registers; it should be safe to remove them.

> +	/* By default, devices should wakeup if they can */
> +	/* So snvs is set as "should wakeup" as it can */

/*
 * multi-line
 * comment format
 */

Kim
