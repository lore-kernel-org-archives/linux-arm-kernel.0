Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07162C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:12:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7F12184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nIN0dd7c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xX6lqGbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7F12184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KcrmwchcjQP2CVZOXutWmm2kw//L/vpmdGsqw68oKmw=; b=nIN0dd7cDmVqI43Ui9ZBwY/Bp
	JyErJj6c8JWgKVDddcWD+4GQaJJsS2o0GONJM/Zhk5aXVGUvPJolCTZfY7VaThXriCuRk7/NW2kH/
	+bzIQmIf2mzb3VafO3Sy7lrrmIhVe4pHp2b9TAcTEzv3kgB9rFp/fhkVAavvr00VgW9+3HF4t9irI
	JISkqMsLQ6SlgWi+zUrwhAlHUFpOgLpdI/C/lfEnQpSUZfxLMlK3ZAKDQfZicJTIsRRb6FwH1GOnB
	jfKsgP0EYZVU2EvcE9NEhUzhJ8GUl3VJDj8tob86YvlSIWc8Tx0Pphz3Dd7mOEfvH8SMP9r/pHGfV
	Ue9aWyB4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiXv-0006XT-To; Thu, 24 Jan 2019 17:12:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiXs-0006Wj-6H
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 17:12:05 +0000
Received: from earth.universe (tmo-116-177.customers.d1-online.com
 [80.187.116.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3AD702184C;
 Thu, 24 Jan 2019 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548349923;
 bh=5P98kFxsApaMTMrQLVTD4P/w5ZamWC+rXZU8wbFbCbg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xX6lqGbwK1LWd8uQtipMyFEOJeigu/FgL/tLZ3r+To7i4tWDKnJESc0i7FyDBm99a
 t/ruOe3k4BTF6SAA0Wpgj8+Qt3349fcWs0WVxVdiyvIqAbo5naF5/eBplGI/6t6Cjn
 qNZpZfM2Sc37YiOdB07vYGioPe4c3NoxSlE8vva0=
Received: by earth.universe (Postfix, from userid 1000)
 id 400CA3C08DF; Thu, 24 Jan 2019 18:11:58 +0100 (CET)
Date: Thu, 24 Jan 2019 18:11:58 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Nicolas.Ferre@microchip.com
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60 SoC
Message-ID: <20190124171158.bi74cnxngsjcawwn@earth.universe>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
 <20190123183443.ppxdfstmau2xtodi@earth.universe>
 <a74956fc-6085-eec2-c1b8-ed116b2297d8@microchip.com>
MIME-Version: 1.0
In-Reply-To: <a74956fc-6085-eec2-c1b8-ed116b2297d8@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_091204_270414_0328DA79 
X-CRM114-Status: GOOD (  20.01  )
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
Cc: devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 robh+dt@kernel.org, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8569034742079033561=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8569034742079033561==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hmt5rtfj35e5bjm"
Content-Disposition: inline


--3hmt5rtfj35e5bjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 24, 2019 at 10:34:50AM +0000, Nicolas.Ferre@microchip.com wrote:
> Hi Sebastian,
>=20
> On 23/01/2019 at 19:34, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Wed, Jan 16, 2019 at 10:57:42AM +0100, Nicolas Ferre wrote:
> >> Add support for additional reset causes and the proper compatibility
> >> string for sam9x60 SoC. The restart function is the same as the samx7.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   drivers/power/reset/at91-reset.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at=
91-reset.c
> >> index f44a9ffcc2ab..44ca983a49a1 100644
> >> --- a/drivers/power/reset/at91-reset.c
> >> +++ b/drivers/power/reset/at91-reset.c
> >> @@ -44,6 +44,9 @@ enum reset_type {
> >>   	RESET_TYPE_WATCHDOG	=3D 2,
> >>   	RESET_TYPE_SOFTWARE	=3D 3,
> >>   	RESET_TYPE_USER		=3D 4,
> >> +	RESET_TYPE_CPU_FAIL	=3D 6,
> >> +	RESET_TYPE_XTAL_FAIL	=3D 7,
> >> +	RESET_TYPE_ULP2		=3D 8,
> >=20
> > what happened to 5? :)
>=20
> That a good question ;-)
>=20
> It's marked as "Reserved"... which opens up a whole new field of=20
> speculation :-)

Ok :)

> [..]
>=20
> >>   	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
> >> +	{ .compatible =3D "microchip,sam9x60-rstc", .data =3D samx7_restart =
},
> >>   	{ /* sentinel */ }
> >>   };
> >>   MODULE_DEVICE_TABLE(of, at91_reset_of_match);
> >=20
> > Patch looks fine to me. But I will wait a bit with merging, so that
> > Alexandre or Ludovic have a chance to provide feedback.
>=20
> What about merging this patch with the whole series through the at91=20
> then arm-soc trees?

It seems to be possible to merge this standalone, but merging
through at91/arm-soc is also fine with me.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--3hmt5rtfj35e5bjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxJ8d4ACgkQ2O7X88g7
+prYRw//eRpCrw2o9rSRDF1wuaqVT8k3sgEoM3G9V+hWk243agZ5b+ahgAG70hrw
I9eV6psmHguTnxDgmCowpaKc0r+Ep/g3wOSOJCD7Qnp9dtlyVJyPPUYfaIULKasN
MlAJp7zHydM+7o7H9hHpVDmq+X7LLX6ZXye5hbCOFjzFwfq3CAehZknRHPnOTMtZ
Mym/E+sqKemS49cBUyGxK+WDe2zQ/ZjTldaVvJ72zzwJTCqSevPZHs687uNYa0YE
K7fH1y3AtO6IDQC63nL/aZd2z/r00/2/7u9QdkgdAHI35+LtKfscyuUUxE64AERB
XXAvksjAYbEsIyMcxsFSDTrGzqg6PVxSTbXgGt08vosBaOTOhSCmxbb3THvWHWmG
uZBTHr6TSyDdti/epp0+PYocWcn5CxY2HhwqJIxFYO75o8K3jFtYefuRP8KgTccX
uiSwxWovPWj8cs3m5o87QL1kVAtsCn+Rib5pyZf8vdbmun4B3Rb01iCS1aam03oH
jvb0PQedQ/PpO5RsBOZtxihWeXhVjDPzTp4JAc8e8TAaeVVwCvCDQOW2Kcy2q9IU
fjEbQE0tFSUE6JcWriI1ZEszCLOWUdbxXv/eaxMjmAwALGYHv54WJQUMo1rlMRsu
1UMuorDWmoN6PBTMmmJR4+yWI9VSAdO8TTApCYTafu/byJh/pig=
=OZfk
-----END PGP SIGNATURE-----

--3hmt5rtfj35e5bjm--


--===============8569034742079033561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8569034742079033561==--

