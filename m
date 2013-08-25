From: cjb@laptop.org (Chris Ball)
Date: Sat, 24 Aug 2013 22:11:46 -0400
Subject: [PATCH] mmc: sdhci: request irq after sdhci_init() is called
In-Reply-To: <1373006335-31239-1-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Fri, 5 Jul 2013 14:38:55 +0800")
References: <1373006335-31239-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <87mwo6tt7h.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Jul 05 2013, Shawn Guo wrote:
> Generally request_irq() should be called after hardware has been
> initialized into a sane state.  However, sdhci driver currently calls
> request_irq() before sdhci_init().  At least, the following kernel panic
> seen on i.MX6 is caused by that.  The sdhci controller on i.MX6 may have
> noisy glitch on DAT1 line, which will trigger SDIO interrupt handling
> once request_irq() is called.  But at this point, the SDIO interrupt
> handler host->sdio_irq_thread has not been registered yet.  Thus, we
> see the NULL pointer access with wake_up_process(host->sdio_irq_thread)
> in mmc_signal_sdio_irq().

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
