From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 13 Jun 2017 10:19:47 +0200
Subject: [PATCH V2 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <1497340725-26594-3-git-send-email-aisheng.dong@nxp.com>
References: <1497340725-26594-1-git-send-email-aisheng.dong@nxp.com>
 <1497340725-26594-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <2318694.E4xdUbedMD@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 June 2017 15:58:45, Dong Aisheng wrote:
> diff --git a/drivers/clocksource/timer-imx-tpm.c
> b/drivers/clocksource/timer-imx-tpm.c new file mode 100644
> index 0000000..940a4f75
> --- /dev/null
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -0,0 +1,227 @@
> [...]
> +static int tpm_set_next_event(unsigned long delta,
> +				struct clock_event_device *evt)
> +{
> +	unsigned long next, now;
> +
> +	next = readl(timer_base + TPM_CNT) + delta;
> +	writel(next, timer_base + TPM_C0V);
> +	now = readl(timer_base + TPM_CNT);

What about:
> now = readl(timer_base + TPM_CNT);
> next = now + delta;
> writel(next, timer_base + TPM_C0V);
> return 0;

> +	return (int)((next - now) <= 0) ? -ETIME : 0;

Can this error actually happen, even with your implementation?

Best regards,
Alexander
