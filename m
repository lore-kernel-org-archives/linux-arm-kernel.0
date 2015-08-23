From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Aug 2015 02:11:19 +0200
Subject: [PATCH 08/11] drm/exynos: mic: fix error return code
In-Reply-To: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1440288682-12732-9-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Propagate error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpu/drm/exynos/exynos_drm_mic.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 8994eab..ddf0b6c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -432,6 +432,7 @@ int exynos_mic_probe(struct platform_device *pdev)
 							"samsung,disp-syscon");
 	if (IS_ERR(mic->sysreg)) {
 		DRM_ERROR("mic: Failed to get system register.\n");
+		ret = PTR_ERR(mic->sysreg);
 		goto err;
 	}
 
