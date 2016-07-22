From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 22 Jul 2016 08:22:54 +0100
Subject: [PATCH 1/1] drm/sti: use new Reset API
Message-ID: <20160722072254.20397-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 0b52297f228 ("reset: Add support for shared reset controls") the
new Reset API now demands consumers choose either an *_exclusive or
a *_shared line when requesting reset lines.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_compositor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/sti/sti_compositor.c
index 3d2fa3a..c2ace02 100644
--- a/drivers/gpu/drm/sti/sti_compositor.c
+++ b/drivers/gpu/drm/sti/sti_compositor.c
@@ -234,12 +234,12 @@ static int sti_compositor_probe(struct platform_device *pdev)
 	}
 
 	/* Get reset resources */
-	compo->rst_main = devm_reset_control_get(dev, "compo-main");
+	compo->rst_main = devm_reset_control_get_shared(dev, "compo-main");
 	/* Take compo main out of reset */
 	if (!IS_ERR(compo->rst_main))
 		reset_control_deassert(compo->rst_main);
 
-	compo->rst_aux = devm_reset_control_get(dev, "compo-aux");
+	compo->rst_aux = devm_reset_control_get_shared(dev, "compo-aux");
 	/* Take compo aux out of reset */
 	if (!IS_ERR(compo->rst_aux))
 		reset_control_deassert(compo->rst_aux);
-- 
2.9.0
