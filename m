Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFBAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB5920866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SuDoqKD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB5920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GJeBWrYXgDTfC4scrlx3v9x0WL+xXLTSftfuoCFoGoU=; b=SuDoqKD/lXHDrCgvXR1wE2QWc
	CXKibjaesTHYS8ZsRuOvS1pB4nAZfFGoNo6fghd3BLUwuAQfvW2kmDGaNDwoNXVstdkTHkwfZR+mH
	1ccISzqO7wpwdrZwwsoLUlJH3w/S2IBNzBmwDZQObXlfVbOQSqek3mBSQKpxih2Fub4NntrB8zwrV
	UHrKQSPn5p3M/qjqZvgaMY/gudzkKsfDEvWZeR6W/pcfYUgHGVoF9s4CpPTLjEIOpeLjzlRs3nA21
	peuxgcInVRFmJ0jnwQGnudEtob+Ljglu1PUgqRGv/n56cEqSYmCrSTkB7uT2ym4Rqin6iIccFui7V
	cjkQHJ/cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjqhg-0005CW-VM; Wed, 16 Jan 2019 19:18:20 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjqhX-00050E-NW
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 19:18:17 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 69B98209BC; Wed, 16 Jan 2019 20:18:08 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
 by mail.bootlin.com (Postfix) with ESMTPSA id 072E6207B0;
 Wed, 16 Jan 2019 20:17:57 +0100 (CET)
Date: Wed, 16 Jan 2019 12:11:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
Message-ID: <20190116111109.dkc4zgsz6lcjlzs5@flea>
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
 <20181220125438.11700-3-jagan@amarulasolutions.com>
 <20181221130025.lbvw7yvy74brf3jn@flea>
 <CAMty3ZCG5cF3tP2mid5xyS=yhtxkY+TOcGkwRkv+vrZt1=0iQg@mail.gmail.com>
 <20190107132929.ksyajmzn2gzr6oep@flea>
 <CAMty3ZAx9MthB0M-eFmsZv9CxF3Z1BkFTU6Hw=ZT5wu6aJwjGQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZAx9MthB0M-eFmsZv9CxF3Z1BkFTU6Hw=ZT5wu6aJwjGQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_111812_526655_CB3E7203 
X-CRM114-Status: GOOD (  23.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============6120329650346537982=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6120329650346537982==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tme5liorzp5mnfdf"
Content-Disposition: inline


--tme5liorzp5mnfdf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 11:54:12AM +0530, Jagan Teki wrote:
> On Mon, Jan 7, 2019 at 6:59 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> > On Mon, Dec 24, 2018 at 08:57:48PM +0530, Jagan Teki wrote:
> > > On Fri, Dec 21, 2018 at 6:30 PM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > On Thu, Dec 20, 2018 at 06:24:34PM +0530, Jagan Teki wrote:
> > > > > Unfortunately default CSI_SCLK rate cannot work properly to
> > > > > drive the connected sensor interface, particularly on few
> > > > > Allwinner SoC's like A64.
> > > > >
> > > > > So, add mod_rate quirk via driver data so-that the respective
> > > > > SoC's which require to alter the default mod clock rate can assign
> > > > > the operating clock rate.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++=
++----
> > > > >  1 file changed, 28 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b=
/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > index ee882b66a5ea..fe002beae09c 100644
> > > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > @@ -15,6 +15,7 @@
> > > > >  #include <linux/ioctl.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/of.h>
> > > > > +#include <linux/of_device.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/pm_runtime.h>
> > > > >  #include <linux/regmap.h>
> > > > > @@ -28,8 +29,13 @@
> > > > >
> > > > >  #define MODULE_NAME  "sun6i-csi"
> > > > >
> > > > > +struct sun6i_csi_variant {
> > > > > +     unsigned long                   mod_rate;
> > > > > +};
> > > > > +
> > > > >  struct sun6i_csi_dev {
> > > > >       struct sun6i_csi                csi;
> > > > > +     const struct sun6i_csi_variant  *variant;
> > > > >       struct device                   *dev;
> > > > >
> > > > >       struct regmap                   *regmap;
> > > > > @@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struc=
t sun6i_csi_dev *sdev,
> > > > >               return PTR_ERR(sdev->clk_mod);
> > > > >       }
> > > > >
> > > > > +     if (sdev->variant->mod_rate)
> > > > > +             clk_set_rate_exclusive(sdev->clk_mod, sdev->variant=
->mod_rate);
> > > > > +
> > > >
> > > > It still doesn't make any sense to do it in the probe function...
> > >
> > > I'm not sure we discussed about the context wrt probe, we discussed
> > > about exclusive put clock.
> >
> > https://lkml.org/lkml/2018/12/18/584
> >
> > "Doing it here is not really optimal either, since you'll put a
> > constraint on the system (maintaining that clock at 300MHz), while
> > it's not in use."
>=20
> But this constraint is only set, for SoC's who need mod_rate change
> not for whole SoCs.

Still, that constraint is there for the whole system on affected
SoCs. Whether it applies to one SoC or not is not really relevant.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tme5liorzp5mnfdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXD8RTQAKCRDj7w1vZxhR
xT6tAP9ZNf6d/5D7t2bcICJ3jps6qwA+vv4bM33AM2BI06aZLAD+KZ2PMgd+ZQfT
8/d8btb5HBoo3QhQK+Rj9Zp4LlU5fQc=
=xBGo
-----END PGP SIGNATURE-----

--tme5liorzp5mnfdf--


--===============6120329650346537982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6120329650346537982==--

