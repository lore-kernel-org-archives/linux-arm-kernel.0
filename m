From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 11 Apr 2017 18:20:55 +0800
Subject: [PATCH 1/2] mmc: slot-gpio: check cd_gpio before setting up
 cd_gpio_isr
In-Reply-To: <20170411102056.2869-1-jszhang@marvell.com>
References: <20170411102056.2869-1-jszhang@marvell.com>
Message-ID: <20170411102056.2869-2-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

slot-gpio knows more information than its user, such as whether there
is cd gpio_desc or not. While one of its user -- the common sdhci
driver doesn't know it. To prepare for next patch which will setup
sdhci's own isr for card-detect interrupts, we add the check before
setting up cd_gpio_isr.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/core/slot-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index a8450a8701e4..42b260593955 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -162,6 +162,9 @@ void mmc_gpio_set_cd_isr(struct mmc_host *host,
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
+	if (!ctx->cd_gpio)
+		return;
+
 	WARN_ON(ctx->cd_gpio_isr);
 	ctx->cd_gpio_isr = isr;
 }
-- 
2.11.0
