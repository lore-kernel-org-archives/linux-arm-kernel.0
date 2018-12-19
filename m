Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA68FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:50:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D4020449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4Pqe7RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D4020449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vMDlqVh7ztyerYQEnsETpJJhh0tQITMD8JE2AncB8ck=; b=U4Pqe7RCEU16hoeFJcIzJyHrt
	pKqOwcUvaLc7qseICdCDZLH275l8gQL2WZ4JaUJW0CMu8dD8axqepSECUH8tMzQh8kwL86EIiq4Tv
	GeI/KRSou6EN/+/LcI3zDRPb/WqlE9MITj9Z4+ToaP+NUJI8apfebvOiI6pokDzQU+LQxHuLiLku3
	Z3CzyXg3KDdqxzIJTJCEtVqw2lfCnraDvxb0iGkFlt+luozpYfLAzfZblv3gN4TfLyAAl5ETVwvla
	5+zer9fsgqOwElw1zKjc5EezcuRRp7VG1TWJoDzCh59gShLaYSnhpEsuOnx1yOZv60VCzncst+rB+
	ZaYALh5bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZe7Y-00034v-DC; Wed, 19 Dec 2018 15:50:52 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZe7U-00034C-8X
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:50:50 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1B82020A82; Wed, 19 Dec 2018 16:50:36 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id CD38F2037D;
 Wed, 19 Dec 2018 16:50:25 +0100 (CET)
Date: Wed, 19 Dec 2018 16:50:26 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20181219155026.2mpnmdibs3i6ianh@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZBzOyAGwgOZwArbvnqtcvwMkJrqwGQ-q7+XFX-BVs34RQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBzOyAGwgOZwArbvnqtcvwMkJrqwGQ-q7+XFX-BVs34RQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_075048_587827_14F39554 
X-CRM114-Status: GOOD (  21.08  )
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
Content-Type: multipart/mixed; boundary="===============0945485541682835382=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0945485541682835382==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pabpp542fin7m244"
Content-Disposition: inline


--pabpp542fin7m244
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:30:08PM +0530, Jagan Teki wrote:
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
> >
> > So, just like I asked in your v4, twice,
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/615=
339.html
>=20
> I don't know how can I comment here. Not quite clearly understand your
> setup, because I have verified 3 different panels from different
> vendors one with 2-lane, another with 4-lane and one with video format
> and another one is burstmode format. I even verified with the clock
> rate and register details.
>
> Please suggest me, what can look further on this.

You had a reason to do these patches in the first place, yet you never
mention it anywhere in your commit logs. it would address the first
part of my comment.

And I can help you nail down whatever is going on here, but I would
need the panel datasheet for that. It is my second point.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pabpp542fin7m244
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBpowgAKCRDj7w1vZxhR
xS5mAPkBvCnKEMqNBzx1jl/H57Y26OfbClwFS5eU5c1rFTUIIwEA6cxvVrxQQtiz
TkacBASu5Zw9+olpuqa2tKq8tAcJdw4=
=GMM5
-----END PGP SIGNATURE-----

--pabpp542fin7m244--


--===============0945485541682835382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0945485541682835382==--

