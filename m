From: chris@printf.net (Chris Ball)
Date: Mon, 13 Jan 2014 18:41:59 +0000
Subject: [PATCH V2 1/2] mmc: sdhci-esdhc-imx: fix access hardirq-unsafe
 lock in atomic context
In-Reply-To: <1388042634-17281-1-git-send-email-b29396@freescale.com> (Dong
 Aisheng's message of "Thu, 26 Dec 2013 15:23:53 +0800")
References: <1388042634-17281-1-git-send-email-b29396@freescale.com>
Message-ID: <86k3e3afm0.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 26 2013, Dong Aisheng wrote:
> Sometimes we may meet the following lockdep issue.
> The root cause is .set_clock callback is executed with spin_lock_irqsave
> in sdhci_do_set_ios. However, the IMX set_clock callback will try to access
> clk_get_rate which is using a mutex lock.
>
> The fix avoids access mutex in .set_clock callback by initializing the
> pltfm_host->clock at probe time and use it later instead of calling
> clk_get_rate again in atomic context.
>
> [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]

Thanks, pushed to mmc-next.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
