Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:37:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1660620879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OjOrH0J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1660620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WFnORWebODfEdNMXDZudvrntXmoSJ14oEIom32joUMc=; b=OjOrH0J8gyD18nMZ4QxW+76eX
	jb5v9zZWtY4u0YM+LDLg663d7i92aASXQDKL4VDwP5wEYMGjgzT3C5Dp7XOlx8X2zJ+QvgtZ3ti6A
	d1PVST60uolR4wrnJzL01Sc7SyuYOTXloTqwTynKZuTZZiOGc8RsuMlacX97n+78I9J9kz1kvXqtm
	8p7egEbNZSS06CIYwgRozUxolSG0IGOzr+otVRrRQ8YaCWmAiiTA7Oa6zcVeW6NUX4cGR3tpzhIHq
	snWzXHVY478Yw7qw8AtluMCQ7DEAxcsFkSuaBMRYl8dAbXLwd86EHj52jCj6k4ybjFJVlXClkeidr
	1+8gSz1UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfnH-0002OW-6S; Wed, 05 Dec 2018 22:37:23 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfnD-0002Mk-Vz
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 22:37:21 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 63164267733
Received: by earth.universe (Postfix, from userid 1000)
 id D437D3C08D6; Wed,  5 Dec 2018 23:37:05 +0100 (CET)
Date: Wed, 5 Dec 2018 23:37:05 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 1/4] power: reset: at91-poweroff: use one poweroff
 function for at91-poweroff
Message-ID: <20181205223705.tg57jiqhq4u73gj3@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1541416443-4321-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_143720_291703_2DE10828 
X-CRM114-Status: GOOD (  19.24  )
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
Content-Type: multipart/mixed; boundary="===============7811432959896996977=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7811432959896996977==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eivayloweo7yle4y"
Content-Disposition: inline


--eivayloweo7yle4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2018 at 11:14:23AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Use only one poweroff function and adapt it to work for both scenarios
> (with LPDDR or not). The assignement of pm_power_off was moved at the
> end of probe after all initializations are OK. This patch adapt the idea
> from commit 4e018c1e9b05 ("power: reset: at91-poweroff: use only one
> poweroff function").
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 49 ++++++++++++++++++++-----------=
------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index fb2fc8f741a1..82533f4c72fc 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -76,11 +76,6 @@ static void __init at91_wakeup_status(struct platform_=
device *pdev)
> =20
>  static void at91_poweroff(void)
>  {
> -	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
> -}
> -
> -static void at91_lpddr_poweroff(void)
> -{
>  	asm volatile(
>  		/* Align to cache lines */
>  		".balign 32\n\t"
> @@ -89,9 +84,11 @@ static void at91_lpddr_poweroff(void)
>  		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
> =20
>  		/* Power down SDRAM0 */
> +		"	tst	%0, #0\n\t"
> +		"	beq	1f\n\t"
>  		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
>  		/* Shutdown CPU */
> -		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
> +		"1:	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
> =20
>  		"	b	.\n\t"
>  		:
> @@ -177,34 +174,42 @@ static int __init at91_poweroff_probe(struct platfo=
rm_device *pdev)
>  	if (pdev->dev.of_node)
>  		at91_poweroff_dt_set_wakeup_mode(pdev);
> =20
> -	pm_power_off =3D at91_poweroff;
> -
>  	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
> -	if (!np)
> -		return 0;
> +	if (np) {
> +		mpddrc_base =3D of_iomap(np, 0);
> +		of_node_put(np);
> =20
> -	mpddrc_base =3D of_iomap(np, 0);
> -	of_node_put(np);
> +		if (!mpddrc_base) {
> +			ret =3D -ENOMEM;
> +			goto clk_disable;
> +		}
> =20
> -	if (!mpddrc_base)
> -		return 0;
> +		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
> +				 AT91_DDRSDRC_MD;
> +		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
> +		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
> +			iounmap(mpddrc_base);
> +			mpddrc_base =3D NULL;
> +		}
> +	}
> =20
> -	ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
> -	if ((ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR2) ||
> -	    (ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR3))
> -		pm_power_off =3D at91_lpddr_poweroff;
> -	else
> -		iounmap(mpddrc_base);
> +	pm_power_off =3D at91_poweroff;
> =20
>  	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(sclk);
> +	return ret;
>  }
> =20
>  static int __exit at91_poweroff_remove(struct platform_device *pdev)
>  {
> -	if (pm_power_off =3D=3D at91_poweroff ||
> -	    pm_power_off =3D=3D at91_lpddr_poweroff)
> +	if (pm_power_off =3D=3D at91_poweroff)
>  		pm_power_off =3D NULL;
> =20
> +	if (mpddrc_base)
> +		iounmap(mpddrc_base);
> +
>  	clk_disable_unprepare(sclk);
> =20
>  	return 0;
> --=20
> 2.7.4
>=20

--eivayloweo7yle4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIUwsACgkQ2O7X88g7
+prnlBAAiSmmPBfEk851yikNkNZCeUSuK7YMLJXw26Q/hzUxp+1ljI08ZXd/ZcCN
859sN7oDE7874mxcQaS0nfixyktSm87p/aIMpk6IkOyPlNs0LPrp7xpxYbR3ebHC
0TnU6dThx0CHsB4XjN3HQSNpei0lnIXwmF/7xQ2KE+kzfNdQ7tfulsHAnKrzZOAu
tLHWCK34qCj0NLiNmdFXoJWOkxeW/WNMGzLspHGGpPgC7JsG8JlWa3hBHV/LWiI2
UkMIQKin2f69WuiM4YcBurTs9zjM9TJabN7E8NWE5wV/W19jij9q1weGomI5sONC
2tPWAyTWpx9eNEAyB/u/3drZosP5Spx823TTx+ZIPHyknN57g7FXz1jBvimS9QRj
xfR1PTU9mV7RuzomE2xyv9ZiEAz/inHmTz6NdRyGTDUjps9JoPC99g3gXW1ixdva
bE8P+0XL760UUBflHihuSoFhxaHpESnlFDWNc2/QA5s1JflKEIpvjzEvQF5mpWF/
c0ny2nNWB/7sLFkNL0abTLhOkiVfZnQlWtlVh4h2DU9uclKnnGwp+YdsKeDkpmcB
7jkdkDfh9ZLZ5bhqg+qcBHFBkH7h9rcy0kORZ6IUeixfob9AzO67UFvv59JJDSji
YI9Nh2+sPIG3b6MG/2vbF4hlYq/oMZxgC5zHkSFxUUC3j9EFnus=
=dx8U
-----END PGP SIGNATURE-----

--eivayloweo7yle4y--


--===============7811432959896996977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7811432959896996977==--

