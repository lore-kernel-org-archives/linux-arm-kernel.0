From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  2 Apr 2012 15:14:43 +0800
Subject: [PATCH v2] ARM: amba: adapt to regulator probe deferral change
Message-ID: <1333350883-6373-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 04bf301 (regulator: Support driver probe deferral) changes
regulator_get() and regulator_register() to return -EPROBE_DEFER
instead of -ENODEV.  Adapt amba bus driver to the change, otherwise
amba_probe() will fail on the platforms that do not have "vcore"
regulator device.

It fixes the boot failure on i.mx28 which uses amba-pl011 as serial
console.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Changes since v1:
 * Revert the comment change

 drivers/amba/bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 01c2cf4..380995e 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -363,7 +363,7 @@ static int amba_get_enable_vcore(struct amba_device *pcdev)
 
 	if (IS_ERR(vcore)) {
 		/* It is OK not to supply a vcore regulator */
-		if (PTR_ERR(vcore) == -ENODEV)
+		if (PTR_ERR(vcore) == -EPROBE_DEFER)
 			return 0;
 		return PTR_ERR(vcore);
 	}
-- 
1.7.5.4
