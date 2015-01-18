From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 18 Jan 2015 10:47:41 +0100
Subject: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54BB795C.6040402@broadcom.com>
References: <rjui@broadcom.com>
 <1421451737-7107-1-git-send-email-rjui@broadcom.com>
 <1421451737-7107-3-git-send-email-rjui@broadcom.com>
 <54BB795C.6040402@broadcom.com>
Message-ID: <20150118094741.GE22880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote:
> On 01/17/15 00:42, Ray Jui wrote:
> 
> [...]
> 
> >+/*
> >+ * Can be expanded in the future if more interrupt status bits are utilized
> >+ */
> >+#define ISR_MASK (1<<  IS_M_START_BUSY_SHIFT)
> >+
> >+static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
> >+{
> >+	struct bcm_iproc_i2c_dev *iproc_i2c = data;
> >+	u32 status = readl(iproc_i2c->base + IS_OFFSET);
> >+
> >+	status&= ISR_MASK;
> >+
> >+	if (!status)
> >+		return IRQ_NONE;
> >+
> >+	writel(status, iproc_i2c->base + IS_OFFSET);
> >+	complete_all(&iproc_i2c->done);
> 
> Looking over this code it seems to me there is always a single
> process waiting for iproc_i2c->done to complete. So using complete()
> here would suffice.
Yeah, there is always only a single thread waiting. That means both
complete and complete_all are suitable. AFAIK there is no reason to pick
one over the other in this case.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
