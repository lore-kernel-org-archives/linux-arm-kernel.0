From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue,  8 Aug 2017 16:58:31 +0530
Subject: [PATCH 2/3] drm/sun4i: make drm_connector_funcs structures const
In-Reply-To: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
References: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502191712-11231-3-git-send-email-bhumirks@gmail.com>
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
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 76362c0..4a456de 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -119,7 +119,7 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 	drm_connector_cleanup(connector);
 }
 
-static struct drm_connector_funcs sun4i_rgb_con_funcs = {
+static const struct drm_connector_funcs sun4i_rgb_con_funcs = {
 	.dpms			= drm_atomic_helper_connector_dpms,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= sun4i_rgb_connector_destroy,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 73bfe7b..d246794 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -537,7 +537,7 @@ static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,
 	drm_connector_cleanup(connector);
 }
 
-static struct drm_connector_funcs sun4i_tv_comp_connector_funcs = {
+static const struct drm_connector_funcs sun4i_tv_comp_connector_funcs = {
 	.dpms			= drm_atomic_helper_connector_dpms,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= sun4i_tv_comp_connector_destroy,
-- 
1.9.1
