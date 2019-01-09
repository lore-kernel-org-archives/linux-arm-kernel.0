Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E172FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:42:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1699206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aj9UdYFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1699206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rZwQ7nA4fZ9FdR/uwB5uAcQ82Ei9sL15qJ29Ur9re/g=; b=aj9UdYFLvbbEoC
	FbsuDnJR/SKSmj104icGcuhCI5IDnPZoM+5Yqrbh80YzEZJHmg2RjHnhXsY+kSQ84x2CAMIt+Qq77
	Oh7Oeo2hHtCq0L4NlFkLdAdkPQHiu0m+5PJarY1T7kzu9Cap6tVo1K5vw+CYJo3+Wi8bmyX/Szftw
	2NAkd1LYkQN4sLtVlFMc/HHJ/j0yIabBnxFADW+wssKdG7nfiJWNxpEWh1MKb69j5XUFxWhZITtfh
	gZNdvPcJP8GvibXQ7Zvq4dIY4TAKL5njMwG6b9/zxrIb9ivz5kJQpZwJfgpM37lYtc7NFklwPue2v
	lmBihe0hE0Gv1Y/1/nSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghF49-00013H-AH; Wed, 09 Jan 2019 14:42:45 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghF45-00012t-W0
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:42:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2057D2078E; Wed,  9 Jan 2019 15:42:40 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id ACCA1206A7;
 Wed,  9 Jan 2019 15:42:29 +0100 (CET)
Message-ID: <9b8098a9fde4f7645ffe2da263cee038dd823e69.camel@bootlin.com>
Subject: Re: [PATCH 2/2] media: cedrus: Allow using the current dst buffer
 as reference
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Date: Wed, 09 Jan 2019 15:42:29 +0100
In-Reply-To: <9a624f6a-0c38-f2c9-3f2d-2758f9a19299@xs4all.nl>
References: <20190109141920.12677-1-paul.kocialkowski@bootlin.com>
 <20190109141920.12677-2-paul.kocialkowski@bootlin.com>
 <9a624f6a-0c38-f2c9-3f2d-2758f9a19299@xs4all.nl>
Organization: Bootlin
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_064242_302636_ABEF02DC 
X-CRM114-Status: GOOD (  28.51  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Li <ayaka@soulik.info>,
 Tomasz Figa <tfiga@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, 2019-01-09 at 15:29 +0100, Hans Verkuil wrote:
> On 01/09/19 15:19, Paul Kocialkowski wrote:
> > It was reported that some cases of interleaved video decoding require
> > using the current destination buffer as a reference. However, this is
> > no longer possible after the move to vb2_find_timestamp because only
> > dequeued and done buffers are considered.
> > 
> > Add a helper in our driver that also considers the current destination
> > buffer before resorting to vb2_find_timestamp and use it in MPEG-2.
> 
> This patch looks good, but can you also add checks to handle the case
> when no buffer with the given timestamp was found? Probably should be done
> in a third patch.
> 
> I suspect the driver will crash if an unknown timestamp is passed on to the
> driver. I would really like to see that corner case fixed.

You're totally right and I think that more generarlly, the current code
flow is rather fragile whenever something wrong happens in our setup()
codec op. I think we should at least have that op return an error code
and properly deal with it when that occurs.

I am planning on making a cleanup series to fix that.

Before using timestamps, reference buffer index validation was done in
std_validate and now it's fully up to the driver. I wonder if it would
be feasible to bring something back in there since all stateless
drivers will face the same issue. The conditions set in
cedrus_reference_index_find seem generic enough for that, but we should
check that std_validate is not called too early, when the queue is in a
different state (and the buffer might not be dequeud or done yet).

What do you think?

Cheers,

Paul

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/staging/media/sunxi/cedrus/cedrus_dec.c   | 13 +++++++++++++
> >  drivers/staging/media/sunxi/cedrus/cedrus_dec.h   |  2 ++
> >  drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c | 10 ++++++----
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > index 443fb037e1cf..2c295286766c 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > @@ -22,6 +22,19 @@
> >  #include "cedrus_dec.h"
> >  #include "cedrus_hw.h"
> >  
> > +int cedrus_reference_index_find(struct vb2_queue *queue,
> > +				struct vb2_buffer *vb2_buf, u64 timestamp)
> > +{
> > +	/*
> > +	 * Allow using the current capture buffer as reference, which can occur
> > +	 * for field-coded pictures.
> > +	 */
> > +	if (vb2_buf->timestamp == timestamp)
> > +		return vb2_buf->index;
> > +	else
> > +		return vb2_find_timestamp(queue, timestamp, 0);
> > +}
> > +
> >  void cedrus_device_run(void *priv)
> >  {
> >  	struct cedrus_ctx *ctx = priv;
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
> > index d1ae7903677b..8d0fc248220f 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
> > @@ -16,6 +16,8 @@
> >  #ifndef _CEDRUS_DEC_H_
> >  #define _CEDRUS_DEC_H_
> >  
> > +int cedrus_reference_index_find(struct vb2_queue *queue,
> > +				struct vb2_buffer *vb2_buf, u64 timestamp);
> >  void cedrus_device_run(void *priv);
> >  
> >  #endif
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > index cb45fda9aaeb..81c66a8aa1ac 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
> > @@ -10,6 +10,7 @@
> >  #include <media/videobuf2-dma-contig.h>
> >  
> >  #include "cedrus.h"
> > +#include "cedrus_dec.h"
> >  #include "cedrus_hw.h"
> >  #include "cedrus_regs.h"
> >  
> > @@ -159,8 +160,8 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
> >  	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> >  
> >  	/* Forward and backward prediction reference buffers. */
> > -	forward_idx = vb2_find_timestamp(cap_q,
> > -					 slice_params->forward_ref_ts, 0);
> > +	forward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
> > +						  slice_params->forward_ref_ts);
> >  
> >  	fwd_luma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 0);
> >  	fwd_chroma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 1);
> > @@ -168,8 +169,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
> >  	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
> >  	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
> >  
> > -	backward_idx = vb2_find_timestamp(cap_q,
> > -					  slice_params->backward_ref_ts, 0);
> > +	backward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
> > +						   slice_params->backward_ref_ts);
> > +
> >  	bwd_luma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 0);
> >  	bwd_chroma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 1);
> >  
> > 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
