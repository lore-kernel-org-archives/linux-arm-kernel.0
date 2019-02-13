Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C96FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:33:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E024F222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f8F4/p1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E024F222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U719t4jmbW0dGG6oDiVOFCQi4x7rfVtPbxZfc4UJnSI=; b=f8F4/p1QVQLw2k
	TGxieHidFCTUMFy7ub/pKqs6SMJn7+3cghz6r29WCa4PFIy4mmggns8G6g8dsj73xIXjtwMqun4n1
	waCf5sopLhKkXvuf9fgWt03MakYrRuC8CKM5vRitz0Fp90jEWoJEAOmJwwiQn8UDIymz7X3Xbf4RD
	B8JacPjOQfyB2AVIGJwz2pM54pF/htkqNS40dAV/NcYGvzCMT7mpgV+5Lt6P1+dXW4akH/SwtMFrY
	yaH0ihkMwYhDBrUhxq/jTKOlcwyEtlkkVJ5I/mw9dghYpmcHP/Yvh5vU2FblLe/7m9+96wLqQDOYr
	X7zqsi1mP3R/vK1yv2qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvbe-0006T6-V0; Wed, 13 Feb 2019 14:33:46 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvbb-0006Sf-2R
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:33:44 +0000
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 39D7C240025;
 Wed, 13 Feb 2019 14:33:39 +0000 (UTC)
Message-ID: <a170e16bed016b0ba79b4f0a1181639598c7b205.camel@bootlin.com>
Subject: Re: [PATCH v3 5/8] drm/sun4i: dsi: Fix DRQ calculation
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Wed, 13 Feb 2019 15:33:38 +0100
In-Reply-To: <e858ff6509e0d3f657fd9229b28f4ac177a04a76.1549896081.git-series.maxime.ripard@bootlin.com>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <e858ff6509e0d3f657fd9229b28f4ac177a04a76.1549896081.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_063343_260871_04C3B38B 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, 2019-02-11 at 15:41 +0100, Maxime Ripard wrote:
> The DRQ calculation code in the Allwinner BSP uses the vertical front
> porch value as the condition, but we're using the video back porch.
> 
> Since I always confuse the two, and I'm the original author of that code, I
> guess I deserved a brown paper bag.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Assuming that the BSP's hbp is referring to the back porch only, then
calculating ht - x - hbp does give us the front porch + hsync length.

Well, let's guess that this about the front porch only until we know
better. It's certainly better than using the back porch anyway :)

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 2518a0d7567c..8e6392831e9d 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -372,9 +372,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>  	struct mipi_dsi_device *device = dsi->device;
>  	u32 val = 0;
>  
> -	if ((mode->hsync_end - mode->hdisplay) > 20) {
> +	if ((mode->hsync_start - mode->hdisplay) > 20) {
>  		/* Maaaaaagic */
> -		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
> +		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
>  
>  		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
>  		drq /= 32;
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
