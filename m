From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:06 +0100
Subject: [PATCH 04/14] [media] st_rc: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-4-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from reset_control_get_optional and to call
reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/rc/st_rc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/media/rc/st_rc.c b/drivers/media/rc/st_rc.c
index 1fa0c9d1c5083..04e694b707b45 100644
--- a/drivers/media/rc/st_rc.c
+++ b/drivers/media/rc/st_rc.c
@@ -165,8 +165,7 @@ static void st_rc_hardware_init(struct st_rc_device *dev)
 	unsigned int rx_sampling_freq_div;
 
 	/* Enable the IP */
-	if (dev->rstc)
-		reset_control_deassert(dev->rstc);
+	reset_control_deassert(dev->rstc);
 
 	clk_prepare_enable(dev->sys_clock);
 	baseclock = clk_get_rate(dev->sys_clock);
@@ -281,10 +280,11 @@ static int st_rc_probe(struct platform_device *pdev)
 	else
 		rc_dev->rx_base = rc_dev->base;
 
-
 	rc_dev->rstc = reset_control_get_optional(dev, NULL);
-	if (IS_ERR(rc_dev->rstc))
-		rc_dev->rstc = NULL;
+	if (IS_ERR(rc_dev->rstc)) {
+		ret = PTR_ERR(rc_dev->rstc);
+		goto err;
+	}
 
 	rc_dev->dev = dev;
 	platform_set_drvdata(pdev, rc_dev);
@@ -353,8 +353,7 @@ static int st_rc_suspend(struct device *dev)
 		writel(0x00, rc_dev->rx_base + IRB_RX_EN);
 		writel(0x00, rc_dev->rx_base + IRB_RX_INT_EN);
 		clk_disable_unprepare(rc_dev->sys_clock);
-		if (rc_dev->rstc)
-			reset_control_assert(rc_dev->rstc);
+		reset_control_assert(rc_dev->rstc);
 	}
 
 	return 0;
-- 
2.11.0
