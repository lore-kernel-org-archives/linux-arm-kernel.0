From: s-anna@ti.com (Suman Anna)
Date: Thu, 18 May 2017 17:09:01 -0500
Subject: [PATCH 3/4] remoteproc/davinci: fix unbalanced reset between start
 and stop ops
In-Reply-To: <20170518220902.2846-1-s-anna@ti.com>
References: <20170518220902.2846-1-s-anna@ti.com>
Message-ID: <20170518220902.2846-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci remoteproc driver is currently de-asserting the reset in
its rproc .start() ops, but is not asserting the reset in its .stop()
ops. This leaves the remote processor to not boot properly when using
the sysfs 'state' variable between multiple start and stop operations.
On the other hand, a reset is being asserted unconditionally in the
driver remove function to alleviate some of these issues.

Move this reset assertion logic into the .stop() ops implementation
to fix the sysfs state-machine and the unbalanced reset. The logic
from remove is still effective since .stop() ops will be invoked
during the remove due to the enabled 'auto-boot' support. The probe
already has support for asserting the reset in case the DSP is not
in reset for some reason.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index fcd3cecb4967..99539cec1329 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -137,6 +137,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
 {
 	struct da8xx_rproc *drproc = rproc->priv;
 
+	davinci_clk_reset_assert(drproc->dsp_clk);
 	clk_disable(drproc->dsp_clk);
 
 	return 0;
@@ -256,16 +257,6 @@ static int da8xx_rproc_remove(struct platform_device *pdev)
 	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
 
 	/*
-	 * It's important to place the DSP in reset before going away,
-	 * since a subsequent insmod of this module may enable the DSP's
-	 * clock before its program/boot-address has been loaded and
-	 * before this module's probe has had a chance to reset the DSP.
-	 * Without the reset, the DSP can lockup permanently when it
-	 * begins executing garbage.
-	 */
-	davinci_clk_reset_assert(drproc->dsp_clk);
-
-	/*
 	 * The devm subsystem might end up releasing things before
 	 * freeing the irq, thus allowing an interrupt to sneak in while
 	 * the device is being removed.  This should prevent that.
-- 
2.12.0
