From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Feb 2015 22:53:33 +0800
Subject: [PATCH 3/8] drm: armada: fix struct clk pointer comparing
In-Reply-To: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1424876018-17852-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
instances"), clk API users can no longer check if two struct clk
pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
simply comparing two pointers.  That's because with the per-user clk
change, a brand new struct clk is created whenever clients try to look
up the clock by calling clk_get() or sister functions like clk_get_sys()
and of_clk_get().  This changes the original behavior where the struct
clk is only created for once when clock driver registers the clock to
CCF in the first place.  The net change here is before commit
035a61c314eb the struct clk pointer is unique for given hardware
clock, while after the commit the pointers returned by clk lookup calls
become different for the same hardware clock.

That said, the struct clk pointer comparing in the code doesn't work any
more.  Call helper function clk_is_match() instead to fix the problem.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpu/drm/armada/armada_510.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
index ad3d2ebf95c9..862deafe8b24 100644
--- a/drivers/gpu/drm/armada/armada_510.c
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -53,7 +53,7 @@ static int armada510_crtc_compute_clock(struct armada_crtc *dcrtc,
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	if (dcrtc->clk != clk) {
+	if (!clk_is_match(dcrtc->clk, clk)) {
 		ret = clk_prepare_enable(clk);
 		if (ret)
 			return ret;
-- 
1.9.1
