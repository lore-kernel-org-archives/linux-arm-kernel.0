From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 24 Dec 2013 10:13:56 +0800
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: fix access hardirq-unsafe
 lock in atomic context
In-Reply-To: <20131223124659.GK26070@S2101-09.ap.freescale.net>
References: <1387796544-18209-1-git-send-email-b29396@freescale.com>
 <20131223124659.GK26070@S2101-09.ap.freescale.net>
Message-ID: <20131224021355.GB23230@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 08:47:01PM +0800, Shawn Guo wrote:
> On Mon, Dec 23, 2013 at 07:02:23PM +0800, Dong Aisheng wrote:
> > Sometimes we may meet the following lockdep issue.
> > The root cause is .set_clock callback is executed with spin_lock_irqsave
> > in sdhci_do_set_ios. However, the IMX set_clock callback will try to access
> > clk_get_rate which is using a mutex lock.
> > 
> > The fix avoids access mutex in .set_clock callback by initializing the
> > pltfm_host->clock at probe time and use it later instead of calling
> > clk_get_rate again in atomic context.
> 
> While I agree this is the way less intrusive, I'm also wondering why
> sdhci_do_set_ios() needs a spinlock at all, or at least it's
> questionable if the lock should necessarily be held for such a long
> running section.

Per my understanding, it's for protecting the host structure including
register r/w where can also be accessed from ISR, so we need it.

> 
> Nevertheless, as long as we can guarantee that the rate of
> pltfm_host->clk does not change after the driver is probed, I'm fine
> with the patch.
> 

We does not change the host parent clock always currently.

Regards
Dong Aisheng
> Shawn
> 
