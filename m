From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue,  8 Aug 2017 16:58:30 +0530
Subject: [PATCH 1/3] drm/bridge: make drm_connector_funcs structures const
In-Reply-To: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
References: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502191712-11231-2-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only passed to the function
drm_connector_init and the corresponding argument is of type const.
Done using Coccinelle

@match disable optional_qualifier@
identifier s;
@@
static struct drm_connector_funcs s = {...};

@ref@
position p;
identifier match.s;
@@
s at p

@good1@
identifier match.s;
expression e1,e2;
position ref.p;
@@
drm_connector_init(e1,e2,&s at p,...)

@bad depends on  !good1@
position ref.p;
identifier match.s;
@@
s at p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct drm_connector_funcs s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index ff9792d..ee16635 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -785,7 +785,7 @@ static int adv7511_connector_get_modes(struct drm_connector *connector)
 	return adv7511_detect(adv, connector);
 }
 
-static struct drm_connector_funcs adv7511_connector_funcs = {
+static const struct drm_connector_funcs adv7511_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = adv7511_connector_detect,
-- 
1.9.1
