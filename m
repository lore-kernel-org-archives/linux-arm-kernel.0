Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D45C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:41:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FB721473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LOv7BGBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FB721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9hTZMtmzAD9czBVAgXgh6nozV0LStdMmzdRzuWZARgs=; b=LOv7BGBDYq0lP3
	GnZSMUgjfwl30SNXpTXHlMTulNGZjvK2Bh3Uj7oZTdgHgSF8GlSo8yb84DlsL55jFXJiBQXM79ys5
	HSk0y+oBpi4LGMA6PMBMyadD9n59muLp/JwVcSI5DltnEobk6FQL1ikUJTP9tfGh6Rr1hcCH6KXZL
	0jVcXOyiPcFpGPh+9gx3tiUatha51ehaLo4/zESE3gwNanJPk2Rqte5ljtb4cYwXbM4IqWNrIhwYE
	YgYo+nlePdB1k9dc+hGaz40maMEQbPyEwfHS+guqNgRKUgC1cNIpSdrA4Hg+weAcMoLl1Iw1UNeE0
	Mdq03RAun9eDzQr1Wxjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVVU-0006SG-Hz; Tue, 29 Jan 2019 15:41:00 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVVR-0006Rp-17
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:40:58 +0000
Received: from aptenodytes (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 75A45200014;
 Tue, 29 Jan 2019 15:40:53 +0000 (UTC)
Message-ID: <c207065fea6b565c497685ce82ab3f3c696b5df4.camel@bootlin.com>
Subject: Re: [PATCH 2/4] drm/sun4i: dsi: Change the start delay calculation
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Tue, 29 Jan 2019 16:40:52 +0100
In-Reply-To: <624512bb9665e0b15244c2bdf230bcfada3a3b98.1548236066.git-series.maxime.ripard@bootlin.com>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <624512bb9665e0b15244c2bdf230bcfada3a3b98.1548236066.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_074057_220077_70351BA5 
X-CRM114-Status: GOOD (  20.21  )
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

On Wed, 2019-01-23 at 16:54 +0100, Maxime Ripard wrote:
> The current calculation for the video start delay in the current DSI driver
> is that it is the total vertical size, minus the backporch and sync length,
> plus 1.
> 
> However, the Allwinner code has it as the active vertical size, plus the
> back porch and the sync length. This doesn't make any difference on the
> only panel it has been tested with so far, since in that particular case
> the front porch is equal to the sum of the back porch and sync length.
> 
> This is not the case for all panels, obviously, so we need to fix it. Since
> the Allwinner code has a bunch of extra code to deal with out of bounds
> values, so let's add them as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 380fc527a707..e3e4ba90c059 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -357,7 +357,12 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>  					   struct drm_display_mode *mode)
>  {
> -	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> +	u16 delay = (mode->vsync_end + 1) % mode->vtotal;
> +
> +	if (!delay)
> +		delay = 1;

For increased clarity, you might want to change this last block to:

delay = max(delay, 1);

Cheers,

Paul

> +	return delay;
>  }
>  
>  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
