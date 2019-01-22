Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF2AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:18:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B83F20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gTW9rynO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B83F20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xKU08C5oKVic3+lLcJY7QS6nXOhDoviG1MAxyp/Ga/4=; b=gTW9rynOIcJU0X+CXMi6ex7kL
	Z00tFwLRgYc+ylkvgIEPyUShzfbyOy3SkHvzIyttoIQ52VZFcBUvyBSN7cIOCAJpSwPKSJOZ+Xhud
	W3FDo2gmFQ6IlsydZ3qBfh/6/ze0M2cAdAEUzRFb/Ui1E2ICgIHca5MbKorD/vDZNFm4J0kqkXQw1
	f4fAjJJ6BTuseoqfIloIs56unu2PR+8nv1cmGny99lYY8B1mfkWwm+KVn8gnW40Px/PfGUPTXhDjb
	CtW8R7bcX/7Jrtg2TCsfhG/2f65kh9qFbbwuZliREq24Tyg0LgqQNdJu+1Tc2o3jiYCbSyNZXOrtQ
	LuGCop1pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glsC1-00084f-1D; Tue, 22 Jan 2019 09:18:01 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glsBU-0007gK-RK
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 09:17:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1E1AE20898; Tue, 22 Jan 2019 10:17:27 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id E4E512078C;
 Tue, 22 Jan 2019 10:17:26 +0100 (CET)
Date: Tue, 22 Jan 2019 10:17:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH] drm/sun4i: hdmi: Fix usage of TMDS clock
Message-ID: <20190122091727.fksox7poqxvt5umu@flea>
References: <20190122073232.7240-1-plaes@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20190122073232.7240-1-plaes@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_011730_336645_F15E1292 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Daniel Vetter <daniel@ffwll.ch>, Priit Laes <priit.laes@paf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0291246111631749881=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0291246111631749881==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lbdnwpdvvhkcqe7e"
Content-Disposition: inline


--lbdnwpdvvhkcqe7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 09:32:32AM +0200, Priit Laes wrote:
> From: Priit Laes <priit.laes@paf.com>
>=20
> Although TMDS clock is required for HDMI to properly function,
> nobody called clk_prepare_enable(). This fixes reference counting
> issues and makes sure clock is running when it needs to be running.
>=20
> Due to TDMS clock being parent clock for DDC clock, TDMS clock
> was turned on/off for each EDID probe, causing spurious failures
> for certain HDMI/DVI screens.
>=20
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
>=20
> Signed-off-by: Priit Laes <priit.laes@paf.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index 061d2e0d9011..25f4d676fd82 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -92,6 +92,8 @@ static void sun4i_hdmi_disable(struct drm_encoder *enco=
der)
>  	val =3D readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>  	val &=3D ~SUN4I_HDMI_VID_CTRL_ENABLE;
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> +
> +	clk_disable_unprepare(hdmi->tmds_clk);
>  }
> =20
>  static void sun4i_hdmi_enable(struct drm_encoder *encoder)
> @@ -112,6 +114,8 @@ static void sun4i_hdmi_enable(struct drm_encoder *enc=
oder)
>  		val |=3D SUN4I_HDMI_VID_CTRL_HDMI_MODE;
> =20
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> +
> +	clk_prepare_enable(hdmi->tmds_clk);

We'll probably need to enable that clock to send the infoframes as
well. I moved it earlier (and that allows the enable and disable
function to be symetric as well).

Thanks for figuring this out!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lbdnwpdvvhkcqe7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEbfpwAKCRDj7w1vZxhR
xVD8AP4r8ZYtfTpNba2DWGmqkcY/4eSPc/nhzr/mi+rgHBBzxgD/bXaa18v4nZPA
1QuP3vO5DoJrfjiguCxTX+NGJJUvCw8=
=NJQt
-----END PGP SIGNATURE-----

--lbdnwpdvvhkcqe7e--


--===============0291246111631749881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0291246111631749881==--

