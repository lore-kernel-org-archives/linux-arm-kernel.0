From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 21:33:36 +0200
Subject: [PATCH 1/2] regulator: imx-anatop: Set default voltage selector for
 vddpu
Message-ID: <1412624017-28673-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code reads the default voltage selector from its register. If the
bootloader disables the regulator, the default voltage selector will be
0 which results in faulty behaviour of this regulator driver.

This patch sets a default voltage selector for vddpu if it is not set in
the register.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/anatop-regulator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 4f730af70e7c..30e8d7ad5813 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -283,6 +283,14 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 			sreg->sel = 0;
 			sreg->bypass = true;
 		}
+
+		/*
+		 * In case vddpu was disabled by the bootloader, we need to set
+		 * a sane default until imx6-cpufreq was probed and changes the
+		 * voltage to the correct value. In this case we set 1.25V.
+		 */
+		if (!sreg->sel && !strcmp(sreg->name, "vddpu"))
+			sreg->sel = 22;
 	} else {
 		rdesc->ops = &anatop_rops;
 	}
-- 
2.1.0
