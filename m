From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 16 Feb 2018 23:30:41 +0100
Subject: Nokia N900 camera in v4.16-rc1: ready for testing?
Message-ID: <20180216223041.GA16010@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Camera should work on N900, with v4.16-rc1. Autofocus should work;
flash is in the queue.

This patch is needed for non-square image. Patched v4l-utils is very
much recommened for taking photos.

Sakari: any ideas about this one? This is the bug I showed you in
Prague...

Best regards,
								Pavel

commit b685b7b98fc50149779416b33d234e4f9ff6ad0e
Author: Pavel <pavel@ucw.cz>
Date:   Mon Feb 13 21:26:51 2017 +0100

    omap3isp: fix VP2SDR bit so capture (not preview) works
    
    This is neccessary for capture (not preview) to work properly on
    N900. Why is unknown.

diff --git a/drivers/media/platform/omap3isp/ispccdc.c b/drivers/media/platform/omap3isp/ispccdc.c
index b66276a..6435857 100644
--- a/drivers/media/platform/omap3isp/ispccdc.c
+++ b/drivers/media/platform/omap3isp/ispccdc.c
@@ -1182,7 +1182,8 @@ static void ccdc_configure(struct isp_ccdc_device *ccdc)
 	/* Use the raw, unprocessed data when writing to memory. The H3A and
 	 * histogram modules are still fed with lens shading corrected data.
 	 */
-	syn_mode &= ~ISPCCDC_SYN_MODE_VP2SDR;
+//	syn_mode &= ~ISPCCDC_SYN_MODE_VP2SDR;
+	syn_mode |= ISPCCDC_SYN_MODE_VP2SDR;
 
 	if (ccdc->output & CCDC_OUTPUT_MEMORY)
 		syn_mode |= ISPCCDC_SYN_MODE_WEN;
@@ -1249,6 +1250,8 @@ static void ccdc_configure(struct isp_ccdc_device *ccdc)
 			<< ISPCCDC_VERT_LINES_NLV_SHIFT,
 		       OMAP3_ISP_IOMEM_CCDC, ISPCCDC_VERT_LINES);
 
+	printk("configuring for %d(%d)x%d\n", crop->width, ccdc->video_out.bpl_value, crop->height);
+
 	ccdc_config_outlineoffset(ccdc, ccdc->video_out.bpl_value,
 				  format->field);
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180216/5e4daab2/attachment.sig>
