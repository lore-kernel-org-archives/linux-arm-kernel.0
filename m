From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 18 Mar 2018 23:48:09 +0100
Subject: [PATCH 1/2] drm/sun4i: hdmi: Fix an error handling path in
 'sun4i_hdmi_bind()'
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
Message-ID: <14c42391e1b562c7495bda6ad6fa1d24ec8dc052.1521413031.git.christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we can not allocate the HDMI encoder regmap, we still need to free some
resources before returning.

Fixes: 4b1c924b1fc1 ("drm/sun4i: hdmi: create a regmap for later use")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 500b6fb3e028..d2839727bb0b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -538,7 +538,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 					     &sun4i_hdmi_regmap_config);
 	if (IS_ERR(hdmi->regmap)) {
 		dev_err(dev, "Couldn't create HDMI encoder regmap\n");
-		return PTR_ERR(hdmi->regmap);
+		ret = PTR_ERR(hdmi->regmap);
+		goto err_disable_mod_clk;
 	}
 
 	ret = sun4i_tmds_create(hdmi);
-- 
2.14.1
