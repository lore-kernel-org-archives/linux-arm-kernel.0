From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 13 Sep 2011 18:32:53 +0530
Subject: [PATCH v7 20/26] gpio/omap: skip operations in runtime callbacks
In-Reply-To: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1315918979-26173-21-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The *_runtime_suspend/resume() callbacks perform basic operations
necessary before/after turning off/on clocks using *_runtime_put/get*().
This happens when modules are fully initialized and functional.
They don't have to be called during initialization. As we need the clocks
to be turned on/off using *_runtime_get/put*() in *_probe() make sure
we return from these callbacks during this time.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8ec9f68..628e42f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1122,6 +1122,9 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	int j;
 	unsigned long flags;
 
+	if (!bank->mod_usage)
+		return 0;
+
 	spin_lock_irqsave(&bank->lock, flags);
 	/*
 	 * If going to OFF, remove triggering for all
@@ -1166,6 +1169,9 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	int j;
 	unsigned long flags;
 
+	if (!bank->mod_usage)
+		return 0;
+
 	spin_lock_irqsave(&bank->lock, flags);
 	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 		clk_enable(bank->dbck);
-- 
1.7.0.4
