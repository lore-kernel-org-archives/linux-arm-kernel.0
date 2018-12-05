Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76FFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983AE20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m+V69qR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983AE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l01pgxGMh18jAYP6pazdCPlrF+sIjMmB6mioRTmnO3E=; b=m+V69qR+I35GtdUnd10tETb7+
	z8to/b48QmXX+14SPNu7xKG1CLyTEzUs8WxRrLbLKQ0RaRvzk+IQwIjXTQbwflJlpPxxFDupuGTBu
	3Iw9kl54vez1y770vTdV5H4cPDNTBtHipKGqXFaeQ6MRG+OpU6EcjDU4pfbUyTgH4TO6pWvm0X699
	5+IV454cYqsQwUt3HpH4E7yJdrTyXpZwXFth+TJomAgzJeWVUBiSlPX/tmuGI8DWPMn8I8BumE8Bx
	fz4CeWIqrDR0q5uVhb3TGs8V/t7g+YKcPIQXd8740CXoXS27ASWe/Dgk5YLW+IAeJwE5JfO8AmiVt
	VzbuIBGYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfoY-0002zW-LP; Wed, 05 Dec 2018 22:38:42 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfoV-0002yB-EO
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 22:38:40 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 51D11267733
Received: by earth.universe (Postfix, from userid 1000)
 id AC0163C08D6; Wed,  5 Dec 2018 23:38:25 +0100 (CET)
Date: Wed, 5 Dec 2018 23:38:25 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 3/4] power: reset: at91-poweroff: check shdwc data
 structure at the beginning of probe
Message-ID: <20181205223825.vkye6tgvan2laxlu@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_143839_611659_3993BE23 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============1697527266963532369=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1697527266963532369==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="molrisa3iqg5uhvw"
Content-Disposition: inline


--molrisa3iqg5uhvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2018 at 11:14:28AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Check at91_shdwc before continuing with probe since we want only one inst=
ance of
> this driver. Inspired from commit 9f1e44774be5 ("power: reset: at91-power=
off:
> do not procede if at91_shdwc is allocated").
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

This depends on patch 2, so I skipped this one.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index 48661e04a3de..e75d8f0f0526 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -160,6 +160,9 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
>  	u32 ddr_type;
>  	int ret;
> =20
> +	if (at91_shdwc)
> +		return -EBUSY;
> +
>  	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL=
);
>  	if (!at91_shdwc)
>  		return -ENOMEM;
> --=20
> 2.7.4
>=20

--molrisa3iqg5uhvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIU2EACgkQ2O7X88g7
+prIDA//U8cbco0f57BpAw5fvYKg3OUiZ+k8pD1BhqrSsM/VfXF9PZm4uDQAP0EU
jcNmwCYrjV8jX0a9RA/ub29pj4Bl53608IN1cb9h4mnDuuyjVoX/T92gI6gbk+MT
dQow9HmkDB4ICCwefrthCd7IIwSXDlxf/COyMj8wZoSIih1/BtKnzjvnnw7ahPQX
btK/HrbGU/RLe1QgXq7X0VTnr6PPFB8XVbkoHr94yVO2jwKclbkB69wUK7NkHq5S
ahU/X3NPaFAEgH8xfZyw+jFMdxK8HVux5RsKOidIPJab9PE3sFb2VCgwIpMkNHQz
fIJiG9rL0JxUXKEa9mNl9pnGKG3LO0FmqGZqX9tuqs8EfvqmL9sI2B0+TKkqj41S
lm7N7O8gO4yRBCR8NmVDrCL+ZOxwqchKN0C4+RMBtiOxumtIyfX82h6RGI3vZW2n
n7QpoRPYeIlFByTd6yYGZPnsvDxs5thwpG0Wn4VmKlbGYO1ZzQjjK9aFuPSmRuGk
IqIsFH6TszJfQ00quVcxMBwrq9GxmJCXzwGeCLWq5ZRUm7iKLgf5R3664tdgLlnh
OddntHIGRcWF1q+/p2gAu1TSlB2vJZldgX/kHvHN8ARA3+i6ZMYeKYcobGOJP4yS
P0UR7v2GYyPT40XVNmpdycCrHxUsClOt862xMxbVBiBoTI7Babc=
=chEH
-----END PGP SIGNATURE-----

--molrisa3iqg5uhvw--


--===============1697527266963532369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1697527266963532369==--

