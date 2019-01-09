Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5839E20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFhV+7Iv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVjKborK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5839E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WqPiDtwke9kCSfCnZyupEF8pXO+IgwGbH0l5E9wJeno=; b=CFhV+7IvIUj2XF
	5S9U3fJJuu7XGADGEXg1xF5NAu1omQhp7cvibr74vKgYgOixRQ1j6/36/rExc4FwQqfZUPNXf5i/p
	G2Gc2pVbvznF8wxOW+UMNxRbxaygfMXK3Ux8I5mO1yNhBKPvbFZCUwJRK1/ZIp5Iht43NffUARdib
	J5AmjLgDCI3HXO5rpCcaDROYyDYuN3jrLV4jJmZ+UksG/gnw63FbN0OEeFb2fVtRmITblJVKeAGjF
	UuVbIPMafe7SGWIeTOEyBaejLxDioW+eI4KRijpFrjkoenZHyn9OZxj7rwWUOfx4vBrP8i97CxqOm
	4Hmm8BIjb391rQOCv3WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghCB4-0001D9-Tp; Wed, 09 Jan 2019 11:37:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCAx-00014j-8h
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:37:40 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 93C9120652;
 Wed,  9 Jan 2019 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547033854;
 bh=FF2vd1Obk2LeuFU+5+bxuooqtBDJR4hsSNBOpm7rfoY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KVjKborKe/gIozUUHRef5iPMjxgX58tnVh3S0ysqkrsVZ75juHeFYuG8fYsWFK/uI
 7EjqXaXHAgoyiqwJq9JoTDxbE3UfmAGxS6BchIPSxOwMC9zbJ3lbCqRbzs10t6mTp6
 bgChlnIcn9CYqDsWvHpsWs2iBOtrlZG8i0UqPj1A=
Date: Wed, 9 Jan 2019 12:37:24 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Message-ID: <20190109123449.65742b99@bbrezillon>
In-Reply-To: <20190109101224.GT21184@phenom.ffwll.local>
References: <20190108123129.20031-1-peda@axentia.se>
 <20190109101224.GT21184@phenom.ffwll.local>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_033735_771077_59229771 
X-CRM114-Status: GOOD (  16.32  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Peter Rosin <peda@axentia.se>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 9 Jan 2019 11:12:24 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Tue, Jan 08, 2019 at 12:31:36PM +0000, Peter Rosin wrote:
> > While trying to temporarily hide a plane, one thing that was attempted
> > was to call (from libdrm)
> > 
> > 	drmModeSetPlane(fd, plane_id, crtc_id, fb_id, 0,
> > 			0, 0, 0, 0, 0, 0, 0, 0);
> > 
> > This call causes a pair of "Division by zero in kernel." messages. Kill
> > those messages, but preserve the current behaviour that also happen to
> > make the plane disappear with the above call.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > Side note, when comparing with drm_atomic_helper_check_plane_state(), I get
> > the feeling that the src rect should be clipped together with the crtc rect
> > if/when clipping is needed. That function calls drm_rect_clip_scaled(), and
> > the equivalent does not seem to happen here. Should clipping be performed
> > on the src rect?  
> 
> Any reasons atmel can't switch over to that helper? Would compute a nice
> ->visible state variable for you ...  

We should definitely use drm_atomic_helper_check_plane_state().

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
