From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 2 Aug 2013 13:11:17 +0300
Subject: [FAILURE] drivers/video/omap2/displays-new/connector-analog-tv.c
In-Reply-To: <20130801191903.GC23006@n2100.arm.linux.org.uk>
References: <20130801191903.GC23006@n2100.arm.linux.org.uk>
Message-ID: <51FB85C5.8020707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/13 22:19, Russell King - ARM Linux wrote:
> Last couple of 4430SDP randconfig build attempts had this error in
> common:
> 
> drivers/video/omap2/displays-new/connector-analog-tv.c: In function 'tvc_probe':
> drivers/video/omap2/displays-new/connector-analog-tv.c:215:19: error: 'omap_dss_pal_timings' undeclared (first use in this function)
> 
> #ifdef CONFIG_OMAP2_DSS_VENC
> /* Hardcoded timings for tv modes. Venc only uses these to
>  * identify the mode, and does not actually use the configs
>  * itself. However, the configs should be something that
>  * a normal monitor can also show */
> extern const struct omap_video_timings omap_dss_pal_timings;
> extern const struct omap_video_timings omap_dss_ntsc_timings;
> #endif
> 
> # CONFIG_OMAP2_DSS_VENC is not set
> 
> Maybe some required dependencies are missing?

Thanks, I've made a fix (below). Instead of adding a build dependency, I've
removed the dependency as there shouldn't be one in the first place.

I'll add the patch to fbdev fixes branch.

 Tomi


commit 005358c8c05998bef5e136ca7e7d6b1dc5326b49 (HEAD, 3.11-fixes/fbdev)
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Fri Aug 2 10:15:01 2013 +0300

    OMAPDSS: analog-tv-connector: compile fix
    
    connector-analog-tv.c uses omap_dss_pal_timings, defined in omapdss's
    venc.c, for default timings. omap_dss_pal_timings only exists when VENC
    is enabled in the kernel config, so disabling VENC breaks
    omap_dss_pal_timings connector-analog-tv compilation.
    
    Instead of adding dependency to VENC, add internal default timings to
    the connector driver, because the connector driver should not depend on
    VENC, and it can be used with any other analog TV encoder.
    
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c b/drivers/video/omap2/displays-new/connector-analog-tv.c
index 5338f36..1b60698 100644
--- a/drivers/video/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
@@ -28,6 +28,20 @@ struct panel_drv_data {
 	bool invert_polarity;
 };
 
+static const struct omap_video_timings tvc_pal_timings = {
+	.x_res		= 720,
+	.y_res		= 574,
+	.pixel_clock	= 13500,
+	.hsw		= 64,
+	.hfp		= 12,
+	.hbp		= 68,
+	.vsw		= 5,
+	.vfp		= 5,
+	.vbp		= 41,
+
+	.interlace	= true,
+};
+
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
 
 static int tvc_connect(struct omap_dss_device *dssdev)
@@ -212,14 +226,14 @@ static int tvc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ddata->timings = omap_dss_pal_timings;
+	ddata->timings = tvc_pal_timings;
 
 	dssdev = &ddata->dssdev;
 	dssdev->driver = &tvc_driver;
 	dssdev->dev = &pdev->dev;
 	dssdev->type = OMAP_DISPLAY_TYPE_VENC;
 	dssdev->owner = THIS_MODULE;
-	dssdev->panel.timings = omap_dss_pal_timings;
+	dssdev->panel.timings = tvc_pal_timings;
 
 	r = omapdss_register_display(dssdev);
 	if (r) {


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/12a3ed71/attachment.sig>
