From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 14 Sep 2015 10:39:15 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1441709778.13536.8.camel@pengutronix.de> (Lucas Stach's message
 of "Tue, 08 Sep 2015 12:56:18 +0200")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
Message-ID: <m3bnd52y4s.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another round of tests, I noticed the new git versions :-)
Testing Linux v4.2 + PLL5 DTS patch (for HDMI output with enabled LVDS).
Using mplayer with YUV420 (DRM Xvideo would probably work with packed
UYVY-alike formats but I need YUV420 because H.264 decoder produces it).
The driver is git://ftp.arm.linux.org.uk/~rmk/xf86-video-armada.git,
branch unstable-devel, and it uses
git://ftp.arm.linux.org.uk/~rmk/libdrm-armada.git/.

	IMX DRM Xvideo output:

Only unscaled video: no color (luminance is good but the color
components are green). The driver doesn't use color information.
I hope this is easily fixable.


	rmk/drm-etnaviv-devel:

With unscaled video, the only visible problem is tearing in the middle
of the screen (unability to sync with screen refresh).

With scaling, I'm getting horizontal lines (mostly visible when the
scene changes) and some sort of stalls - sometimes two frames are
alternating for few seconds then it goes forward.


	pengutronix/etnaviv-for-upstream:
No etnaviv Xvideo:
(==) armada(0): Backing store enabled
(==) armada(0): Silken mouse enabled
(EE) armada(0): etnaviv: unable to open: Not a directory
(WW) armada(0): [drm] Vivante initialization failed, running unaccelerated

I assume I need a newer something.


	pengutronix/v4.2/topic/etnaviv-for-rmk:
It requires:
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -216,6 +216,7 @@ phys_addr_t dma_get_contiguous_base(struct device *dev)
 {
 	return cma_get_base(dev_get_cma_area(dev));
 }
+EXPORT_SYMBOL(dma_get_contiguous_base);
 
 /*
  * Support for reserved memory regions defined in device tree


Likewise, no etnaviv XVideo:
(--) armada(0): Vivante GC320 GPU revision 5007 (etnaviv) 2d PE2.0
(EE) armada(0): etnaviv: unable to create context: (null)
(WW) armada(0): [drm] Vivante initialization failed, running unaccelerated


Comments?
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
