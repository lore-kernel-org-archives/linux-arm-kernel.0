From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Feb 2017 19:38:50 +0000
Subject: [PATCH v2 1/4] [media] exynos-gsc: Use 576p instead 720p as a
 threshold for colorspaces
In-Reply-To: <20170209200420.3046-2-thibault.saunier@osg.samsung.com>
References: <20170209200420.3046-1-thibault.saunier@osg.samsung.com>
 <20170209200420.3046-2-thibault.saunier@osg.samsung.com>
Message-ID: <20170210193850.GN27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 05:04:17PM -0300, Thibault Saunier wrote:
> From: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> The media documentation says that the V4L2_COLORSPACE_SMPTE170M colorspace
> should be used for SDTV and V4L2_COLORSPACE_REC709 for HDTV. But drivers
> don't agree on the display resolution that should be used as a threshold.
> 
> Some drivers set V4L2_COLORSPACE_REC709 for 720p and higher while others
> set V4L2_COLORSPACE_REC709 for anything higher than 576p. Newers drivers
> use the latter and that also matches what user-space multimedia programs
> do (i.e: GStreamer), so change the driver logic to be aligned with this.
> 
> Also, check for the resolution in G_FMT instead unconditionally setting
> the V4L2_COLORSPACE_REC709 colorspace.

It would be nice to refer to some specification to justify the change,
rather than "let's follow what <random-piece-of-software> does".

EIA CEA 861B talks about colorimetry for various resolutions:

5.1 480p, 480i, 576p, 576i, 240p, and 288p
The color space used by the 480-line, 576-line, 240-line, and 288-line
formats will likely be based on SMPTE 170M [1].

5.2 1080i, 1080p, and 720p
The color space used by the high definition formats will likely be based
on ITU-R BT.709-4 [6].

Notice, however, that it says "will likely be" - it's not a requirement,
as it's expected that the colorspace will be part of the media metadata
(eg, contained in the transport stream.)  In other words, it should be
configurable or ultimately provided by the ultimate source of the image.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
