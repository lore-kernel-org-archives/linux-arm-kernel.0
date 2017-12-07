From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Dec 2017 16:58:50 +0100
Subject: [PATCH v4 05/15] drm/sun4i: Fix error path handling
In-Reply-To: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f83c1cebc731f0b4251f5ddd7b38c718cd79bb0b.1512662253.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 4c7f16d14a33 ("drm/sun4i: Fix TCON clock and regmap
initialization sequence") moved a bunch of logic around, but forgot to
update the gotos after the introduction of the err_free_dotclock label.

It means that if we fail later that the one introduced in that commit,
we'll just to the old label which isn't free the clock we created. This
will result in a breakage as soon as someone tries to do something with
that clock, since its resources will have been long reclaimed.

Cc: <stable@vger.kernel.org>
Fixes: 4c7f16d14a33 ("drm/sun4i: Fix TCON clock and regmap initialization sequence")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index a1ed462c2430..ea056a3d2131 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -724,12 +724,12 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	if (IS_ERR(tcon->crtc)) {
 		dev_err(dev, "Couldn't create our CRTC\n");
 		ret = PTR_ERR(tcon->crtc);
-		goto err_free_clocks;
+		goto err_free_dotclock;
 	}
 
 	ret = sun4i_rgb_init(drm, tcon);
 	if (ret < 0)
-		goto err_free_clocks;
+		goto err_free_dotclock;
 
 	if (tcon->quirks->needs_de_be_mux) {
 		/*
-- 
git-series 0.9.1
