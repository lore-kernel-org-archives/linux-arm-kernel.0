Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B84C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:34:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32322081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h0Vefh8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32322081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J4WHChrigOCzPvRYcNh1j13Z/zh4/6eFZaDOgpEuNyU=; b=h0Vefh8ZnrrJQox9MJZl9Gars
	0mRLv3OSUSEEr9EHrNmvlHD4HFS87kIRdnXpWFcGs1BrMndTNgRQLTS3n60a2XBbK1Srlv4IN/HY1
	NaCAO3Fl/3cuQRM5QqpKpvxCGci67dp8xpWcGhei3deR9yVhCkL7itQZ0+z5WHfjQ2AQD8SlPEDMx
	u96o3Qex765BjA6/G8Kt8VssAgsMJRqnKorbTLjyiaVh+tCog+HRuT9xT8cJz5Z5+xILEU5rFXXIO
	aJMixybdkLkN6nLHUtt7pAY4dPuYBQX4QGSODGBZ8xRB+TJ89SdNkZy7Fe+dXNtYkCOiLFklRX9/2
	DNpSDHZNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCiU-0003ub-K3; Tue, 04 Dec 2018 15:34:30 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCiQ-0003u1-V2
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:34:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A46DE2071D; Tue,  4 Dec 2018 16:34:15 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5EC3D20701;
 Tue,  4 Dec 2018 16:34:05 +0100 (CET)
Date: Tue, 4 Dec 2018 16:34:05 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 12/21] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
Message-ID: <20181204153405.n5qvznkcrh7n3xej@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-13-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181204142218.16284-13-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_073427_137203_D417C843 
X-CRM114-Status: GOOD (  19.26  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 linux-sunxi@googlegroups.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4872111997996360860=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4872111997996360860==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="idpip5xwsigx4kmw"
Content-Disposition: inline


--idpip5xwsigx4kmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:09PM +0100, Paul Kocialkowski wrote:
> This introduces stride and offset configuration for the VPU tiling mode.
> Stride is calculated differently than it is for linear formats and an
> offset is calculated, for which new register definitions are introduced.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 60 ++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  8 ++++
>  2 files changed, 65 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index 3dcb05147e41..151b78d3c02e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -125,21 +125,75 @@ void sun4i_frontend_update_buffer(struct sun4i_fron=
tend *frontend,
>  {
>  	struct drm_plane_state *state =3D plane->state;
>  	struct drm_framebuffer *fb =3D state->fb;
> +	unsigned int strides[3] =3D {};
> +
>  	dma_addr_t paddr;
>  	bool swap;
> =20
> +	if (fb->modifier =3D=3D DRM_FORMAT_MOD_ALLWINNER_TILED) {
> +		unsigned int width =3D state->src_w >> 16;
> +		unsigned int offset;
> +
> +		/*
> +		 * In MB32 tiled mode, the stride is defined as the distance
> +		 * between the start of the end line of the current tile and
> +		 * the start of the first line in the next vertical tile.
> +		 *
> +		 * Tiles are represented in row-major order, thus the end line
> +		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
> +		 * the next vertical tile starts at: 32-bit-aligned-width * 32
> +		 * and the distance is: 32 * (32-bit-aligned-width - 31).
> +		 */

It'd be better if that comment was next to the macro definition where
the code is.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--idpip5xwsigx4kmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAaebQAKCRDj7w1vZxhR
xdVyAQDVOCk1gnFQ9fahKa2wpltM2OL7Uhyxyb6anXKqdxBUDAD+PDFjkVj+Tl4l
y/4+AA3NQBPX5VWUKBA4R8DAhLyWkAQ=
=nuNs
-----END PGP SIGNATURE-----

--idpip5xwsigx4kmw--


--===============4872111997996360860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4872111997996360860==--

