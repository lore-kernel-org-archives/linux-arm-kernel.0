Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A8C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BC4218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NU5p7R6Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlU33iy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BC4218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qGUxBoowvucOVzz+557/4ehWIpw34rTR/eS6vJAY64g=; b=NU5p7R6ZZKnfGNE46FJeu5j0k
	qj0kP1zAJ+6DhcGVdA9ax0IPvMQISWS+s+bsVypIDudSpPrGoJ19nqT6tZBSEoQErcRibj39DIBNB
	DVA1anbSJWMq8iBYsqY1A0KUCj4ETIhfL22sh4ceMJL66K0mtPJvUS+Wa+oTbN96d0PbibZVXRGy2
	BXFfu1GE49YcSuXiDta0yHrfN5UrN6MOi8uF33mdq8grzx/qUiTAfiCuj+eBPxXrV1tu2iYzoptYb
	kzEO6zntKkAFn2rUSZYFRpbPtyp9Ni33MGjRzvapvjgZ6dH2FqwHieeKBhFn/mGjYvJdTsS+5KFkU
	R8CYeljqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbm4-0004Jn-1C; Thu, 24 Jan 2019 09:58:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbm1-0004J4-C0
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:58:14 +0000
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de
 [37.138.185.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A107218D3;
 Thu, 24 Jan 2019 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548323892;
 bh=7UoZMWPWUFjPrC0HC3cAbcVTPiRgwsz8XqaaMGPBb24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VlU33iy4qjjSiO7QoZv7jJBLBWO8EBjUld5NdokukyaZja4+29bMaWPCeqXp5WFqn
 S/ubuDhgxhX79JzA2Gq5v00FqTuUT2o7pSMmD04zVNF39ZUpm5WTVu+pj3ktfvDpjB
 oDGZ/0jy+cpY0Mvr1HatbGjsbD6l+z1JkPg8vB+w=
Received: by earth.universe (Postfix, from userid 1000)
 id 02F9C3C08E2; Wed, 23 Jan 2019 19:34:43 +0100 (CET)
Date: Wed, 23 Jan 2019 19:34:43 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60 SoC
Message-ID: <20190123183443.ppxdfstmau2xtodi@earth.universe>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
In-Reply-To: <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_015813_443316_2F0E2133 
X-CRM114-Status: GOOD (  16.63  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2081345286039022973=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2081345286039022973==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fsyxtax7c7p3uw4j"
Content-Disposition: inline


--fsyxtax7c7p3uw4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 16, 2019 at 10:57:42AM +0100, Nicolas Ferre wrote:
> Add support for additional reset causes and the proper compatibility
> string for sam9x60 SoC. The restart function is the same as the samx7.
>=20
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/power/reset/at91-reset.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index f44a9ffcc2ab..44ca983a49a1 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -44,6 +44,9 @@ enum reset_type {
>  	RESET_TYPE_WATCHDOG	=3D 2,
>  	RESET_TYPE_SOFTWARE	=3D 3,
>  	RESET_TYPE_USER		=3D 4,
> +	RESET_TYPE_CPU_FAIL	=3D 6,
> +	RESET_TYPE_XTAL_FAIL	=3D 7,
> +	RESET_TYPE_ULP2		=3D 8,

what happened to 5? :)

>  };
> =20
>  static void __iomem *at91_ramc_base[2], *at91_rstc_base;
> @@ -164,6 +167,15 @@ static void __init at91_reset_status(struct platform=
_device *pdev)
>  	case RESET_TYPE_USER:
>  		reason =3D "user reset";
>  		break;
> +	case RESET_TYPE_CPU_FAIL:
> +		reason =3D "CPU clock failure detection";
> +		break;
> +	case RESET_TYPE_XTAL_FAIL:
> +		reason =3D "32.768 kHz crystal failure detection";
> +		break;
> +	case RESET_TYPE_ULP2:
> +		reason =3D "ULP2 reset";
> +		break;
>  	default:
>  		reason =3D "unknown reset";
>  		break;
> @@ -183,6 +195,7 @@ static const struct of_device_id at91_reset_of_match[=
] =3D {
>  	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_resta=
rt },
>  	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart },
>  	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
> +	{ .compatible =3D "microchip,sam9x60-rstc", .data =3D samx7_restart },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, at91_reset_of_match);

Patch looks fine to me. But I will wait a bit with merging, so that
Alexandre or Ludovic have a chance to provide feedback.

-- Sebastian

--fsyxtax7c7p3uw4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIs8MACgkQ2O7X88g7
+ppfqg//W5G0xWAA5Nh0Nt4eBrn2o6Gnz1Uqb7Wcx4MXDnz7P7J6AFci+0gzhcXh
KEdebzlE/w4uJK2qQc0DKDZ3I0DCUL97dzQM3zkzkBokaRkj+WkrsIzc3JUxB60d
gPva6cyCWAM6Hq+FvrTlueofDTbKfrLmBEnMv1Is6MXElfzmVUmaa/AG4gqfEbwM
8n44j068IKrfLTxzwCFGzLrS6O8+LWDb8bo1PjfU8JBXYBHKIOBSyXpePFyqQ5/3
lTVDhTl4ApueS/qwX5KeLsT75ryZb0zNomYt2LZx11DI6T/8SnoJDkcgh8HS+E8q
W+7Ea5ZW1Xi8VaWl4kjfFCgPZfzIug63WqVf8I2cWgBlyT7PbTAsrd3WLVSaGZYK
te6mkVNrQSvOBwrt+jhqI66QEB58AJkO+P4BHWhtFWL2+BUGu/ATPEd1de58a+qc
0dKUTBBF2Yy1cWd/CfvBsBH8zzS5vcOuMx0BVzOaOodQK4PJ3BzcvyV5PbNPQ5OO
l+YwoJ/UhKH/Sfvc/PNvBIYCf0Rz1YnsHQGKINMLrY6qh7d2BzYTZKlMamen7e6R
ysvOG2jM4fkuJbGoqfUp3mPKlwvRPJH0drJdkYP8zb1LOhKbKt3JOFBnbwwDN7Xi
Xwrv8ggoRFAUH9bYF5Dv3+aiYr1ApP/9d18+3wYeQnX4roUkhH8=
=AsFe
-----END PGP SIGNATURE-----

--fsyxtax7c7p3uw4j--


--===============2081345286039022973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2081345286039022973==--

