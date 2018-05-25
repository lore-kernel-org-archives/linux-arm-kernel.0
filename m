From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 May 2018 17:50:13 +0200
Subject: [PATCH 6/8] drm/exynos: fix scaler_task_done return type
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
Message-ID: <20180525155030.3667352-6-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern gcc versions warn about returning a ternary operator with an 'int'
type in a function returning type 'bool':

drivers/gpu/drm/exynos/exynos_drm_scaler.c: In function 'scaler_task_done':
drivers/gpu/drm/exynos/exynos_drm_scaler.c:402:47: error: ?: using integer constants in boolean context [-Werror=int-in-bool-context]
  return val & SCALER_INT_STATUS_FRAME_END ? 0 : -EINVAL;

>From context, it becomes clear that this should have been 'int',
so I'm fixing it, along with parenthesizing the expression to make
it clearer what is meant here (I got confused at first, after seeing
the warning).

Fixes: 01fb9185dc18 ("drm/exynos: Add driver for Exynos Scaler module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 63b05b7c846a..4ad49d7782cd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -397,9 +397,9 @@ static inline u32 scaler_get_int_status(struct scaler_context *scaler)
 	return scaler_read(SCALER_INT_STATUS);
 }
 
-static inline bool scaler_task_done(u32 val)
+static inline int scaler_task_done(u32 val)
 {
-	return val & SCALER_INT_STATUS_FRAME_END ? 0 : -EINVAL;
+	return (val & SCALER_INT_STATUS_FRAME_END) ? 0 : -EINVAL;
 }
 
 static irqreturn_t scaler_irq_handler(int irq, void *arg)
-- 
2.9.0
