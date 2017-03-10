From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:22 -0500
Subject: [PATCH 07/41] drm/rockchip: Don't use atomic constructs for psr
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-8-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using timer and spinlocks, use delayed_work and
mutexes for rockchip psr. This allows us to make blocking
calls when enabling/disabling psr (which is sort of important
given we're talking over dpcd to the display).

Cc: Caesar Wang <wxt@rock-chips.com>
Cc: ?? ? <wzz@rock-chips.com>
Cc: St?phane Marchesin <marcheu@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 14 +++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c     | 68 +++++++++++--------------
 4 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 28c0d4406454..90eb7908e2e5 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -72,7 +72,7 @@ struct rockchip_dp_device {
 	struct reset_control     *rst;
 
 	struct work_struct	 psr_work;
-	spinlock_t		 psr_lock;
+	struct mutex		 psr_lock;
 	unsigned int             psr_state;
 
 	const struct rockchip_dp_chip_data *data;
@@ -83,21 +83,20 @@ struct rockchip_dp_device {
 static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 {
 	struct rockchip_dp_device *dp = to_dp(encoder);
-	unsigned long flags;
 
 	if (!analogix_dp_psr_supported(dp->dev))
 		return;
 
 	dev_dbg(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
 
-	spin_lock_irqsave(&dp->psr_lock, flags);
+	mutex_lock(&dp->psr_lock);
 	if (enabled)
 		dp->psr_state = EDP_VSC_PSR_STATE_ACTIVE;
 	else
 		dp->psr_state = ~EDP_VSC_PSR_STATE_ACTIVE;
 
 	schedule_work(&dp->psr_work);
-	spin_unlock_irqrestore(&dp->psr_lock, flags);
+	mutex_unlock(&dp->psr_lock);
 }
 
 static void analogix_dp_psr_work(struct work_struct *work)
@@ -108,7 +107,6 @@ static void analogix_dp_psr_work(struct work_struct *work)
 	int psr_state = dp->psr_state;
 	int vact_end;
 	int ret;
-	unsigned long flags;
 
 	if (!crtc)
 		return;
@@ -122,12 +120,12 @@ static void analogix_dp_psr_work(struct work_struct *work)
 		return;
 	}
 
-	spin_lock_irqsave(&dp->psr_lock, flags);
+	mutex_lock(&dp->psr_lock);
 	if (psr_state == EDP_VSC_PSR_STATE_ACTIVE)
 		analogix_dp_enable_psr(dp->dev);
 	else
 		analogix_dp_disable_psr(dp->dev);
-	spin_unlock_irqrestore(&dp->psr_lock, flags);
+	mutex_unlock(&dp->psr_lock);
 }
 
 static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
@@ -406,7 +404,7 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	dp->plat_data.power_off = rockchip_dp_powerdown;
 	dp->plat_data.get_modes = rockchip_dp_get_modes;
 
-	spin_lock_init(&dp->psr_lock);
+	mutex_init(&dp->psr_lock);
 	dp->psr_state = ~EDP_VSC_PSR_STATE_ACTIVE;
 	INIT_WORK(&dp->psr_work, analogix_dp_psr_work);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 1e371b7a1506..6b767b8dabd5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -134,7 +134,7 @@ static int rockchip_drm_bind(struct device *dev)
 	drm_dev->dev_private = private;
 
 	INIT_LIST_HEAD(&private->psr_list);
-	spin_lock_init(&private->psr_list_lock);
+	mutex_init(&private->psr_list_lock);
 
 	drm_mode_config_init(drm_dev);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 8aca219ec4c8..1844951118da 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -55,7 +55,7 @@ struct rockchip_drm_private {
 	struct mutex mm_lock;
 	struct drm_mm mm;
 	struct list_head psr_list;
-	spinlock_t psr_list_lock;
+	struct mutex psr_list_lock;
 };
 
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 4c379e90b178..b339ca943139 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -18,7 +18,7 @@
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_psr.h"
 
-#define PSR_FLUSH_TIMEOUT	msecs_to_jiffies(100)
+#define PSR_FLUSH_TIMEOUT_MS	100
 
 enum psr_state {
 	PSR_FLUSH,
@@ -30,11 +30,11 @@ struct psr_drv {
 	struct list_head	list;
 	struct drm_encoder	*encoder;
 
-	spinlock_t		lock;
+	struct mutex		lock;
 	bool			active;
 	enum psr_state		state;
 
-	struct timer_list	flush_timer;
+	struct delayed_work	flush_work;
 
 	void (*set)(struct drm_encoder *encoder, bool enable);
 };
@@ -43,9 +43,8 @@ static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
 {
 	struct rockchip_drm_private *drm_drv = crtc->dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry(psr, &drm_drv->psr_list, list) {
 		if (psr->encoder->crtc == crtc)
 			goto out;
@@ -53,7 +52,7 @@ static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
 	psr = ERR_PTR(-ENODEV);
 
 out:
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 	return psr;
 }
 
@@ -61,9 +60,8 @@ static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry(psr, &drm_drv->psr_list, list) {
 		if (psr->encoder == encoder)
 			goto out;
@@ -71,7 +69,7 @@ static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
 	psr = ERR_PTR(-ENODEV);
 
 out:
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 	return psr;
 }
 
@@ -112,23 +110,21 @@ static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
 
 static void psr_set_state(struct psr_drv *psr, enum psr_state state)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	psr_set_state_locked(psr, state);
-	spin_unlock_irqrestore(&psr->lock, flags);
+	mutex_unlock(&psr->lock);
 }
 
-static void psr_flush_handler(unsigned long data)
+static void psr_flush_handler(struct work_struct *work)
 {
-	struct psr_drv *psr = (struct psr_drv *)data;
-	unsigned long flags;
+	struct psr_drv *psr = container_of(to_delayed_work(work),
+					   struct psr_drv, flush_work);
 
 	/* If the state has changed since we initiated the flush, do nothing */
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	if (psr->state == PSR_FLUSH)
 		psr_set_state_locked(psr, PSR_ENABLE);
-	spin_unlock_irqrestore(&psr->lock, flags);
+	mutex_unlock(&psr->lock);
 }
 
 /**
@@ -141,14 +137,13 @@ static void psr_flush_handler(unsigned long data)
 int rockchip_drm_psr_activate(struct drm_encoder *encoder)
 {
 	struct psr_drv *psr = find_psr_by_encoder(encoder);
-	unsigned long flags;
 
 	if (IS_ERR(psr))
 		return PTR_ERR(psr);
 
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	psr->active = true;
-	spin_unlock_irqrestore(&psr->lock, flags);
+	mutex_unlock(&psr->lock);
 
 	return 0;
 }
@@ -164,15 +159,14 @@ EXPORT_SYMBOL(rockchip_drm_psr_activate);
 int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 {
 	struct psr_drv *psr = find_psr_by_encoder(encoder);
-	unsigned long flags;
 
 	if (IS_ERR(psr))
 		return PTR_ERR(psr);
 
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	psr->active = false;
-	spin_unlock_irqrestore(&psr->lock, flags);
-	del_timer_sync(&psr->flush_timer);
+	mutex_unlock(&psr->lock);
+	cancel_delayed_work_sync(&psr->flush_work);
 
 	return 0;
 }
@@ -180,9 +174,8 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
 
 static void rockchip_drm_do_flush(struct psr_drv *psr)
 {
-	mod_timer(&psr->flush_timer,
-		  round_jiffies_up(jiffies + PSR_FLUSH_TIMEOUT));
 	psr_set_state(psr, PSR_FLUSH);
+	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
 }
 
 /**
@@ -219,12 +212,11 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev)
 {
 	struct rockchip_drm_private *drm_drv = dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry(psr, &drm_drv->psr_list, list)
 		rockchip_drm_do_flush(psr);
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 }
 EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
 
@@ -241,7 +233,6 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
 	if (!encoder || !psr_set)
 		return -EINVAL;
@@ -250,17 +241,17 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 	if (!psr)
 		return -ENOMEM;
 
-	setup_timer(&psr->flush_timer, psr_flush_handler, (unsigned long)psr);
-	spin_lock_init(&psr->lock);
+	INIT_DELAYED_WORK(&psr->flush_work, psr_flush_handler);
+	mutex_init(&psr->lock);
 
 	psr->active = true;
 	psr->state = PSR_DISABLE;
 	psr->encoder = encoder;
 	psr->set = psr_set;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_add_tail(&psr->list, &drm_drv->psr_list);
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 
 	return 0;
 }
@@ -278,16 +269,15 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr, *n;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry_safe(psr, n, &drm_drv->psr_list, list) {
 		if (psr->encoder == encoder) {
-			del_timer(&psr->flush_timer);
+			cancel_delayed_work_sync(&psr->flush_work);
 			list_del(&psr->list);
 			kfree(psr);
 		}
 	}
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 }
 EXPORT_SYMBOL(rockchip_drm_psr_unregister);
-- 
2.12.0.246.ga2ecc84866-goog
