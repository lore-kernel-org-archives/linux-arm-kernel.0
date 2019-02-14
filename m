Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4946A222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uTSsqeEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4946A222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0+6bZo3ILpqftAMeM8bz4WCsnzVpb3Ou3+gn4QBLtAE=; b=uTSsqeEiHC6wdQY3TXYoKEiuK
	sf4a9NaC0Wc1s10f0MRMbgf6aT6nohpa7fNC2n1M4om50vGLOrP/o+HyJm2bObtJfLZJTiMeDyK6P
	1EiBirSzQrY4piB1kgQj+lTyyS51qsJzOlC4yUvGGvnPewAQF3JfldX4zGQrysPJvxn8S9saaNjj3
	eE/1ssU4HwEWF80r6KJdCW/xP2dFiqtt56gSaPWw3QatHQzBppa8FukoD9rKssVo8B5u8EQAP0c5g
	mS0gU9G5CZdVbIlQSQaXNHW9AueL4XL4OBxgbnyqQkzX/AmKFr1BqLzcnisOjVQlzkbLE4J1HPkMN
	DYz/92NAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDDf-0007Mr-Jw; Thu, 14 Feb 2019 09:22:11 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDDX-0007Db-LD
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:22:05 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3EB39E0010;
 Thu, 14 Feb 2019 09:21:49 +0000 (UTC)
Date: Thu, 14 Feb 2019 10:21:48 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 3/8] drm/sun4i: dsi: Enforce boundaries on the start
 delay
Message-ID: <20190214092148.3jhtp5i5crl632wd@flea>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <c9889cf5f7a3d101ef380905900b45a182596f56.1549896081.git-series.maxime.ripard@bootlin.com>
 <bf6176bef13d471a1fb829f918dbbe38de909e21.camel@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <bf6176bef13d471a1fb829f918dbbe38de909e21.camel@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_012203_953652_D7B7E51E 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5922336248753042845=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5922336248753042845==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="moug3onooorq2334"
Content-Disposition: inline


--moug3onooorq2334
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Tue, Feb 12, 2019 at 04:30:33PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Mon, 2019-02-11 at 15:41 +0100, Maxime Ripard wrote:
> > The Allwinner BSP makes sure that we don't end up with a null start del=
ay
> > or with a delay larger than vtotal.
> >=20
> > The former condition is likely to happen now with the reworked start de=
lay,
> > so make sure we enforce the same boundaries.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks!

> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/s=
un4i/sun6i_mipi_dsi.c
> > index 9471fa695ec7..506f2e8cf454 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -358,8 +358,12 @@ static u16 sun6i_dsi_get_video_start_delay(struct =
sun6i_dsi *dsi,
> >  					   struct drm_display_mode *mode)
> >  {
> >  	u16 start =3D clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> > +	u16 delay =3D mode->vtotal - (mode->vsync_end - mode->vdisplay) + sta=
rt;
> > =20
> > -	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
> > +	if (delay > mode->vtotal)
> > +		delay =3D delay % mode->vtotal;
>=20
> I wonder whether delay =3D=3D mode->vtotal would make sense at all. If no=
t,
> then we can just apply the modulo unconditionally. But in doubt, let's
> keep things this way.

I guess that situation can happen, especially with the start clamping.

But even without it, it can happen when mode->vtotal - mode->vsync_end
(so the backporch) is equal to 10.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--moug3onooorq2334
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGUzLAAKCRDj7w1vZxhR
xeD/AP93+BXVH4dU5N7/el2SXR6+kHkHrCiBSeZBXFrUoa2/kwEAwiZD6fnQ8wXk
KJ+w7dROnazKTKsmZS2b4x+l951qZgc=
=Oqs4
-----END PGP SIGNATURE-----

--moug3onooorq2334--


--===============5922336248753042845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5922336248753042845==--

