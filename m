From: tiffany.lin@mediatek.com (tiffany lin)
Date: Tue, 19 Apr 2016 14:46:17 +0800
Subject: [PATCH 3/7] [Media] vcodec: mediatek: Add Mediatek V4L2 Video
 Decoder Driver
In-Reply-To: <1461001697.2719.7.camel@gmail.com>
References: <1460548915-17536-1-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-2-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-3-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-4-git-send-email-tiffany.lin@mediatek.com>
 <5710FA3A.2030603@xs4all.nl> <1460958046.7861.48.camel@mtksdaap41>
 <57148D8E.9060601@xs4all.nl> <1460967754.7861.61.camel@mtksdaap41>
 <1461001697.2719.7.camel@gmail.com>
Message-ID: <1461048377.32652.19.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Mon, 2016-04-18 at 13:48 -0400, Nicolas Dufresne wrote:
> Le lundi 18 avril 2016 ? 16:22 +0800, tiffany lin a ?crit :
> > > > We are plaining to remove m2m framework in th feature, although
> > we think
> > > 
> > > Remove it for just the decoder driver or both encoder and decoder?
> > > 
> > Remove it from decoder driver.
> 
> Did you look at how CODA handle it (drivers/media/platform/coda/coda-
> common.c) ? I don't know any detail, but they do have the same issue
> and use both v4l2_m2m_fop_poll and v4l2_m2m_fop_mmap.
> 
I check coda-common.c, it use v4l2_m2m_set_src_buffered to allow
device_run be triggered without OUTPUT buffer.

Double check the patch "[media] mem2mem: add support for hardware
buffered queue".
This patch make m2m framework could support that
1. out-of-order frames, causing a few mem2mem device runs in the
beginning, that don't produce any decompressed buffer at the v4l2
capture side.
2. the last few frames can be decoded from the bitstream with mem2mem
device runs that don't need a new input buffer at the v4l2 output side.

This is similar our requirement that we want start decode without
CAPTURE buffer.
Is there any restriction that when v4l2_m2m_set_src_buffered can be
used?



best regards,
Tiffany

> cheers,
> Nicolas
