From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 17 Jul 2012 20:40:34 +0800
Subject: mmc: mxs: DEADLOCK
In-Reply-To: <5004F00F.5000800@bluegiga.com>
References: <4FFC367A.8020100@bluegiga.com>
 <20120711060607.GE14060@S2101-09.ap.freescale.net>
 <20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
 <5003AD52.7070304@bluegiga.com> <5004F00F.5000800@bluegiga.com>
Message-ID: <20120717124033.GB3109@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 07:54:39AM +0300, Lauri Hintsala wrote:
> Shawn,
> 
> Could you review this patch? Attila reported it fixes his SDIO
> initialization issue.
> 
Thanks for fixing it.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Lauri
> 
> 
> On 07/16/2012 08:57 AM, Lauri Hintsala wrote:
> >>Any hints how to work around or fix this, would be appreciated
> >
> >
> >Does this patch fix your issue?
> >
> > >>>>>>>
> >--- a/drivers/mmc/host/mxs-mmc.c
> >+++ b/drivers/mmc/host/mxs-mmc.c
> >@@ -637,11 +637,6 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host
> >*mmc, int enable)
> >                 host->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> >          writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
> >                 host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_SET);
> >-
> >-        if (readl(host->base + HW_SSP_STATUS(host)) &
> >-                BM_SSP_STATUS_SDIO_IRQ)
> >-            mmc_signal_sdio_irq(host->mmc);
> >-
> >      } else {
> >          writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
> >                 host->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> >@@ -650,6 +645,11 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host
> >*mmc, int enable)
> >      }
> >
> >      spin_unlock_irqrestore(&host->lock, flags);
> >+
> >+    if (enable && readl(host->base + HW_SSP_STATUS(host)) &
> >+            BM_SSP_STATUS_SDIO_IRQ)
> >+        mmc_signal_sdio_irq(host->mmc);
> >+
> >  }
> >
> >  static const struct mmc_host_ops mxs_mmc_ops = {
> ><<<<<<<
> >
> >mxs_mmc_enable_sdio_irq was called by mmc_signal_sdio_irq.
> >mmc_signal_sdio_irq was called inside spin lock. So the lock was tried
> >to acquire before it was released.
> >
> >
> >Best regards,
> >Lauri Hintsala
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >the body of a message to majordomo at vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
