From: andy@warmcat.com (Andy Green)
Date: Thu, 03 Mar 2011 13:50:30 +0000
Subject: [PATCH 2/4] OMAP3 I2C document why cpu type and not peripheral unit
	ID used to probe
In-Reply-To: <20110303134744.30648.91218.stgit@otae.warmcat.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com>
Message-ID: <20110303135030.30648.14923.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe why we can't simply probe the peripheral unit ID
to make the decision about what register map to use

Cc: patches at linaro.org
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b605ff3..d6500ec 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1032,6 +1032,17 @@ omap_i2c_probe(struct platform_device *pdev)
 	else
 		dev->reg_shift = 2;
 
+	dev->regs = (u8 *)reg_map;
+
+	/*
+	 * this is a bit tricky, implementation on 4430 has the active
+	 * part of its ID register moved to +4 instead of +0 as
+	 * previously.  So, we can't probe just using the ID register
+	 * Complicating matters the older implementation using the
+	 * simpler register set on 3530 also reports its revision as
+	 * 0x40, same as the 4430 newer implementation.
+	 */
+
 	if (cpu_is_omap44xx())
 		dev->regs = (u8 *) omap4_reg_map;
 	else
