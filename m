From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 21:55:37 +0800
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
Message-ID: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
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
---
 drivers/amba/bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 01c2cf4..aafee73 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -362,8 +362,8 @@ static int amba_get_enable_vcore(struct amba_device *pcdev)
 	pcdev->vcore = vcore;
 
 	if (IS_ERR(vcore)) {
-		/* It is OK not to supply a vcore regulator */
-		if (PTR_ERR(vcore) == -ENODEV)
+		/* It should not fail in case of -EPROBE_DEFER */
+		if (PTR_ERR(vcore) == -EPROBE_DEFER)
 			return 0;
 		return PTR_ERR(vcore);
 	}
-- 
1.7.5.4
