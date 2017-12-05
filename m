From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:17 +0100
Subject: [PATCH v3 05/15] drm/sun4i: Fix error path handling
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1f2443c41082fc6e086570da38d20744c52fe636.1512486553.git-series.maxime.ripard@free-electrons.com>
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
