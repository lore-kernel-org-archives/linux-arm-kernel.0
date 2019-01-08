Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA3C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:58:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BBF2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="euBUbmsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BBF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s8gK7hYmoMPC6ehhRSl66mHJtN4DepAMm0ShbSPn3Jg=; b=euBUbmsy1zK1Z02aWzkP/4kL1
	AYqE6azNhCxSQpKpc1JEjZGZ8pSS2YjVe4UqdqNPNpk8QmlzKxQvl4Lm2FmXRdCZRkQCjgkJGMbsD
	A79EH1BXJhn4xQpHElimI8O4GhScXa4q93eMRzVki/xn+HgBAl04suUgQpoTaJnpL6gb4TAg9PX+T
	x9Xwc83h2qaXHd48XddPY4AOlHTxmrpfSRtkgYFz8n84Zt+rp04Fx03vGEzEN0LBzKfuTDoKcn1aG
	212+LlsaSqdI8W6j9ei/nQgZfS3jeDBfbKQFTLMeiHT7sFH18MmZAryOTEtzpuqLhNifuHb2NZY1z
	fsrTBFifQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnDh-0008JW-Cu; Tue, 08 Jan 2019 08:58:45 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnDd-0008J5-4A
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 08:58:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E9312209BC; Tue,  8 Jan 2019 09:58:39 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr
 [90.88.149.148])
 by mail.bootlin.com (Postfix) with ESMTPSA id B7085206DC;
 Tue,  8 Jan 2019 09:58:29 +0100 (CET)
Date: Tue, 8 Jan 2019 09:58:29 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190108085829.clianbtjovu3oieq@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
 <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_005841_447167_9BCFF61B 
X-CRM114-Status: GOOD (  21.06  )
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
Content-Type: multipart/mixed; boundary="===============4188629785869552821=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4188629785869552821==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m3ctiswi7poqkfry"
Content-Disposition: inline


--m3ctiswi7poqkfry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 08:48:21PM +0530, Jagan Teki wrote:
> On Mon, Jan 7, 2019 at 7:42 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Fri, Dec 21, 2018 at 02:26:11AM +0530, Jagan Teki wrote:
> > > On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > > > Video start delay can be computed by subtracting total vertical
> > > > > timing with front porch timing and with adding 1 delay line for T=
CON.
> > > > >
> > > > > BSP code form BPI-M64-bsp is computing video start delay as
> > > > > (from linux-sunxi/
> > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > >
> > > > > u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > > =3D> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > > =3D> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > > =3D> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > > =3D> timmings->ver_front_porch
> > > > >
> > > > > So, update the start delay computation accordingly.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > >
> > > > Even though it's a bit better now on my A33 board and I don't have =
the
> > > > white stripes on the bottom of the display, there's still some
> > > > flickering with your patches applied.
> > > >
> > > > Bisecting it seems to point at that patch, but reverting it doesn't
> > > > make the issue go away, so it's not really clear which one exactly =
is
> > > > at fault.
> > >
> > > Is reverting this patch, work fine or not?
> >
> > As I was saying, it doesn't.
> >
> > > This patch is trying to make use of front porch instead of existing
> > > back porch to compute the delay. Since we revert the VBP fix patch[1]
> > > to assume VBP as VFP value look like your setup would also require to
> > > revert this change. But as per BSP or drm_mode details all of my
> > > displays even work with and w/o reverting these two.
> >
> > Again, I cannot help you without the datasheet for the panels you're
> > trying to submit.
>=20
> The panel bound with Sitronix ST7701 IC
> http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.=
pdf

It's the controller, not the panel

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m3ctiswi7poqkfry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDRmNQAKCRDj7w1vZxhR
xX0hAQD/08EfBi/WV1bd+mCQeFb+ux+liOt8kbGwfwOdJWle2wEAxsZnPybyH+5c
Q7Xrz0RlIUvqu9Sy6WXGgZ9aLOn+lwQ=
=zTbv
-----END PGP SIGNATURE-----

--m3ctiswi7poqkfry--


--===============4188629785869552821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4188629785869552821==--

