From: dave@chronolytics.com (David F. Carlson)
Date: Fri, 25 Sep 2009 10:08:11 -0400 (EDT)
Subject: PATCH add MMIO interface to s3c-fb
Message-ID: <200909251408.n8PE8BxZ011775@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds the MMIO interface desired by XWindows fbdevHWMapMMIO() call.

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll

------------------------------------------------------------------------------
commit 92d6acaa6c50e642592be928c425f27b4bf1f8b0
Author: Dave Carlson <dave@chronolytics.com>
Date:   Mon Sep 14 18:45:14 2009 -0400

    Forward port from s3cfb driver from Mer 2.6.24.7.
    --dfc

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 5a72083..d8c1952 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -930,6 +930,15 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 				s3c_fb_release_win(sfb, sfb->windows[win]);
 			goto err_ioremap;
 		}
+		/* 
+		** The "correct" Xwindows way is for the fb driver to "own" the 
+		** fb register space.  If the ioctl FBIOGET_FSCREENINFO contains the 
+		** mmio physical address and extent, then the Xwindows fbdev call 
+		** fbdevHWMapMMIO() will allow Xwindows to canonically obtain 
+		** hw registers all using the defined framebuffer interfaces.
+		*/
+		sfb->windows[win].info.fix.mmio_start = res->start;
+		sfb->windows[win].info.fix.mmio_len = resource_size(res);
 	}
 
 	platform_set_drvdata(pdev, sfb);
