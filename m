From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 17 Sep 2015 09:21:56 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150910104930.GI21084@n2100.arm.linux.org.uk>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
 <20150908125756.GY21084@n2100.arm.linux.org.uk>
 <m3a8su4llv.fsf@t19.piap.pl>
 <20150910104930.GI21084@n2100.arm.linux.org.uk>
Message-ID: <1442474516.6617.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 10.09.2015, 11:49 +0100 schrieb Russell King - ARM
Linux:
> On Thu, Sep 10, 2015 at 12:25:32PM +0200, Krzysztof Ha?asa wrote:
> > The Y plane is ok, but the Xv window is green, like on old monochrome
> > CRTs - what could that be? It looks like the UV planes are all wrong.
> 
> From a quick read of the imx-drm ipuv3-plane code, it looks like it
> doesn't bother with the U/V planes for planar images.  Nothing looks
> at fb->offsets[1,2] nor fb->pitches[1,2].  However, it claims to
> support DRM_FORMAT_YUV420 and DRM_FORMAT_YVU420 formats - which is
> wrong if it doesn't look at these other offsets and pitches.

The IDMAC has a few funny restrictions for multiplanar formats, and the
current code silently assumes that the U and V planes follow right after
Y.

I have a patch to enforce the same base address:
http://lists.freedesktop.org/archives/dri-devel/2015-August/089293.html
but it still doesn't check the offset/pitch limitations properly.

best regards
Philipp
