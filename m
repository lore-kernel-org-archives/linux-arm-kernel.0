From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 13:42:55 +0200
Subject: [PATCH] [v3] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
In-Reply-To: <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com>
References: <20180711144403.1022829-1-arnd@arndb.de>
 <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
 <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com>
Message-ID: <20180907114255.7j7r6wzolnz5qkk7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 01:26:30PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 7, 2018 at 11:41 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> >
> > On 11/07/18 15:43, Arnd Bergmann wrote:
> > > Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
> > > a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
> > >
> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> > >
> > > This solves the problem by adding a silent symbol for the tcon_top module,
> > > building it as a separate module in exactly the cases that we need it,
> > > but in a way that it is reachable by the other modules.
> > >
> > > Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
> > > Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > I am seeing the following on today's -next (20180907) as well the last
> > few -next versions for that matter ...
> >
> > ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> > ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
> >
> > Seems like this issue has cropped up again as Arnd's fix is present. I
> > am seeing this on ARM64 builds.
> 
> I have not started build testing on linux-next since the merge window, but
> looking at the changes that got queued up, I find commits cf77d79b4e29
> ("drm/sun4i: tcon: Add another way for matching mixers with tcon") and
> 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON") that both
> introduced a reference to the tcon_top file from sun4i_tcon.c.
> 
> More IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) checks in
> the caller like I did in my patch would help, or alternatively one could
> decide to give up and just always include the TCON_TOP.

Sorry for the breakage.

Can you test:

----8<----
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 4834c90b4912..c78cd35a1294 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -974,7 +974,8 @@ static bool sun4i_tcon_connected_to_tcon_top(struct device_node *node)
 
 	remote = of_graph_get_remote_node(node, 0, -1);
 	if (remote) {
-		ret = !!of_match_node(sun8i_tcon_top_of_table, remote);
+		ret = !!(IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+			 of_match_node(sun8i_tcon_top_of_table, remote));
 		of_node_put(remote);
 	}
 
@@ -1402,13 +1403,20 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
 	if (!pdev)
 		return -EINVAL;
 
-	if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
+	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+	    encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
 		ret = sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
 		if (ret)
 			return ret;
 	}
 
-	return sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
+	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP)) {
+		ret = sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
----8<----

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/f78dfb80/attachment.sig>
