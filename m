Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:12:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EF72070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BSN7xRdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EF72070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tt6xzQMZEbpq3uNOm1/K8C5IrJWFipCk81shnwmOEO0=; b=BSN7xRdvP1tvkMrgyHYraATDt
	7M1/pIh7y8QG+reaYvi37Z/om4t5zTiyvVJbLCxSAzCiF8ATxu8ij1A00Lmw4tY/F7r6Hfh/rJUUP
	OwXeafDarNkbi8bAZ2pt5E1NKzy7PbsVRyAdLQouwDX97jJOS3iEahcG863sTnZmb4QXxfKmsYq+b
	Pwjral+4V2ojiLNo+SzC2Jhv2mdtZsXN7MfR5MA88fdJ/g4zZ1Ijj2xBalDJWBo1VIjnxfDG6HJS7
	mRJLidCvM/o7vFhQnwmsgmQMrZkpt9nqvaP2Yl+e5Y6ConzQv105M+yUVDBPmIuxxIdXqj12JW/TZ
	m3hpCZdeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggVdV-0000a7-6J; Mon, 07 Jan 2019 14:12:13 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggVdR-0000Zd-DZ
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 14:12:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 113CE209D7; Mon,  7 Jan 2019 15:12:08 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr
 [90.88.149.148])
 by mail.bootlin.com (Postfix) with ESMTPSA id D715420802;
 Mon,  7 Jan 2019 15:11:57 +0100 (CET)
Date: Mon, 7 Jan 2019 15:11:58 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190107141158.zaimizk4rlqa6xli@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_061209_730009_C2F1961C 
X-CRM114-Status: GOOD (  18.46  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============7499854363094866080=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7499854363094866080==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2f4sgk2x6n64h3fz"
Content-Disposition: inline


--2f4sgk2x6n64h3fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 02:26:11AM +0530, Jagan Teki wrote:
> On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > Video start delay can be computed by subtracting total vertical
> > > timing with front porch timing and with adding 1 delay line for TCON.
> > >
> > > BSP code form BPI-M64-bsp is computing video start delay as
> > > (from linux-sunxi/
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > =3D> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > =3D> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > >    - panel->lcd_y - (panel->lcd_vbp)
> > > =3D> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > >                            - panel->lcd_y - panel->lcd_vbp
> > > =3D> timmings->ver_front_porch
> > >
> > > So, update the start delay computation accordingly.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Even though it's a bit better now on my A33 board and I don't have the
> > white stripes on the bottom of the display, there's still some
> > flickering with your patches applied.
> >
> > Bisecting it seems to point at that patch, but reverting it doesn't
> > make the issue go away, so it's not really clear which one exactly is
> > at fault.
>=20
> Is reverting this patch, work fine or not?

As I was saying, it doesn't.

> This patch is trying to make use of front porch instead of existing
> back porch to compute the delay. Since we revert the VBP fix patch[1]
> to assume VBP as VFP value look like your setup would also require to
> revert this change. But as per BSP or drm_mode details all of my
> displays even work with and w/o reverting these two.

Again, I cannot help you without the datasheet for the panels you're
trying to submit.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2f4sgk2x6n64h3fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDNeLgAKCRDj7w1vZxhR
xZcmAQD+Vb+9GVQqhaYBdMGINgctl0C0OJbmlIIp5NIuvS7qTQEA5RSgws23ZINC
hEiM5577HRtlW0Q8p0cQaAY4ZIT0hA0=
=l3Hj
-----END PGP SIGNATURE-----

--2f4sgk2x6n64h3fz--


--===============7499854363094866080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7499854363094866080==--

