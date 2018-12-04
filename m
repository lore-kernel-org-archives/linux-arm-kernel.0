Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51013C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:29:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191AF2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gr5SSYge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191AF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f99X3Pd/cnz+mX7xRPDCOjsCJhLCf6b0lglZKWNym9c=; b=gr5SSYgeq/anV/GKPPPaRmAHb
	JgB6bipS7RlSi4qgk52lY0qFpnknW9g74kS1rrFTceI5vR6qxmyYh+Cyr8CA7OUxBrGdFArV78elV
	JjQtW0yCLnVXm+6sUa6mAW2wXdlcQ5FXFti4s4TfftunMVC4ztFDLZ4eP1O5zJQPdeWCU/jqD0prm
	C11CoSb17XDjDF7XDWUlUMl89n1sfjOvOZJCxVB+LH0ACdbaNPDfcm0EWqgzA5fJbQOuKKCRGFA6H
	Cagu/8aTPzopCgC0DXkC+zk4Puc5BTE2gPt3f76VWwYapFjzrDb3M96ZdzrlDnflW/91zCkcaUCak
	4bmBXGpDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCe1-000050-1N; Tue, 04 Dec 2018 15:29:53 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCdx-0008Vg-Qq
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:29:51 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 97B0320711; Tue,  4 Dec 2018 16:29:38 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 509E5206D8;
 Tue,  4 Dec 2018 16:29:28 +0100 (CET)
Date: Tue, 4 Dec 2018 16:29:28 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 06/21] drm/sun4i: frontend: Configure and enable YUV
 to RGB CSC when needed
Message-ID: <20181204152928.ola6ggxbatre54nd@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181204142218.16284-7-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_072950_137204_4AC1BDD9 
X-CRM114-Status: GOOD (  19.91  )
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
Content-Type: multipart/mixed; boundary="===============5211186757256425188=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5211186757256425188==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jx5x6yurcrnphq3c"
Content-Disposition: inline


--jx5x6yurcrnphq3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:03PM +0100, Paul Kocialkowski wrote:
> In prevision of adding support for YUV formats, set the YUV to RGB
> colorspace conversion coefficients if required and don't bypass the
> CSC engine when converting.
>=20
> The BT601 coefficients from the A33 BSP are copied over from the backend
> code. Because of module inter-dependency, we can't have the frontend use
> these coefficients from the backend directly.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 45 ++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
>  2 files changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index d0eca4b8784d..1737a4394401 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -48,6 +48,28 @@ static const u32 sun4i_frontend_horz_coef[64] =3D {
>  	0x03ff0000, 0x0000fd41, 0x01ff0000, 0x0000fe42,
>  };
> =20
> +/*
> + * These coefficients are taken from the A33 BSP from Allwinner.
> + *
> + * The first three values of each row are coded as 13-bit signed fixed-p=
oint
> + * numbers, with 10 bits for the fractional part. The fourth value is a
> + * constant coded as a 14-bit signed fixed-point number with 4 bits for =
the
> + * fractional part.
> + *
> + * The values in table order give the following colorspace translation:
> + * G =3D 1.164 * Y - 0.391 * U - 0.813 * V + 135
> + * R =3D 1.164 * Y + 1.596 * V - 222
> + * B =3D 1.164 * Y + 2.018 * U + 276
> + *
> + * This seems to be a conversion from Y[16:235] UV[16:240] to RGB[0:255],
> + * following the BT601 spec.
> + */
> +static const u32 sunxi_bt601_yuv2rgb_coef[12] =3D {
> +	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
> +	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
> +	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
> +};
> +

I'd really prefer not to duplicate that structure. IIRC, we already
have a dependency between the frontend and the backend (or the other
way around), maybe we should just move that structure to either so
that we don't have a circular dependency?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jx5x6yurcrnphq3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAadWAAKCRDj7w1vZxhR
xS9nAQD6l90xa8MmqOS2zOe6JbkarFaS3gzmacnmtgHCyUoq4AD/X2gxTruUk0Yd
NyOG3OHfNgQhfG/GiqLyDJMOVW+VvA8=
=1hp2
-----END PGP SIGNATURE-----

--jx5x6yurcrnphq3c--


--===============5211186757256425188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5211186757256425188==--

