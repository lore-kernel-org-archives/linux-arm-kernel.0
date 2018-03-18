From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 18 Mar 2018 23:48:10 +0100
Subject: [PATCH 2/2] drm/sun4i: hdmi: Fix another error handling path in
 'sun4i_hdmi_bind()'
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
Message-ID: <5e0084af4ad57e9eea3bca5bd8e2e95970cd6714.1521413031.git.christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we can not get the HDMI DDC clock, we still need to free some
resources before returning.

Fixes: 939d749ad664 ("drm/sun4i: hdmi: Add support for controller hardware variants")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index d2839727bb0b..fa4bcd092eaf 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -552,7 +552,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		hdmi->ddc_parent_clk = devm_clk_get(dev, "ddc");
 		if (IS_ERR(hdmi->ddc_parent_clk)) {
 			dev_err(dev, "Couldn't get the HDMI DDC clock\n");
-			return PTR_ERR(hdmi->ddc_parent_clk);
+			ret = PTR_ERR(hdmi->ddc_parent_clk);
+			goto err_disable_mod_clk;
 		}
 	} else {
 		hdmi->ddc_parent_clk = hdmi->tmds_clk;
-- 
2.14.1
