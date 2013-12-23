From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Dec 2013 20:47:01 +0800
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: fix access hardirq-unsafe lock
 in atomic context
In-Reply-To: <1387796544-18209-1-git-send-email-b29396@freescale.com>
References: <1387796544-18209-1-git-send-email-b29396@freescale.com>
Message-ID: <20131223124659.GK26070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 07:02:23PM +0800, Dong Aisheng wrote:
> Sometimes we may meet the following lockdep issue.
> The root cause is .set_clock callback is executed with spin_lock_irqsave
> in sdhci_do_set_ios. However, the IMX set_clock callback will try to access
> clk_get_rate which is using a mutex lock.
> 
> The fix avoids access mutex in .set_clock callback by initializing the
> pltfm_host->clock at probe time and use it later instead of calling
> clk_get_rate again in atomic context.

While I agree this is the way less intrusive, I'm also wondering why
sdhci_do_set_ios() needs a spinlock at all, or at least it's
questionable if the lock should necessarily be held for such a long
running section.

Nevertheless, as long as we can guarantee that the rate of
pltfm_host->clk does not change after the driver is probed, I'm fine
with the patch.

Shawn
