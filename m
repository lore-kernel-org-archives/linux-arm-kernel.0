Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:18:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB43F21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q+/xYOwW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSKEFHJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB43F21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3pE9H6FmZ5PklGjsEXMgE1Zt+RIktnlKDrjDFpZhTmg=; b=q+/xYOwWInC8MAwsZXSp12KeC
	2Wi+KUYzHBdpc4XmVC3fueCr4HR5BRyYdUeqQJ2lvTAOsk9aGpnTn6IEYUVkW/SuGN/UKczJNrfoP
	KVFIBxNoMkUVpH5ThcMlsbAZNyIhMuWEZQ0emBupTF2pFXPlxGEUGQPwKG4kX5ZZf3syl0uptl6du
	nBJtZsbFGtvebI2VH/x22p0kPJ5T37LmR9w6L79tVV/9zbBvcIUiM1Ka07wZmHCqR80XMSyA+qavJ
	jT+bjyyMCdT6WkK++1nrp5u+iSoSpPKT3boSLBxjFLdzc/Moc+1EJAl7Y2nDTwsZMf8fiokO+dhhG
	x0ivX4YAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwEeC-0008Ij-ON; Tue, 19 Feb 2019 23:17:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEe8-0008Ht-FX
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:17:54 +0000
Received: from earth.universe (unknown [185.216.33.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C94F21736;
 Tue, 19 Feb 2019 23:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550618271;
 bh=HGDjECPqOHQfdK/O95bynrS6k4scHZCSI0MZsf9j5xQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uSKEFHJJE/cbOWEm2wLdEeLwQ51b2uOp50zdlTQwFRAq8cT1BYc7DXyJrBkm6vgmO
 OGOwq+yLwbVoP4MJ8uiHVLbPeZ0cBdO6qns5Y0hzOHMdv525PDXPCw63PM5Jh7VGkc
 2V2B++VLtFDS0rh4pEIJdHJJxiEftwP9qig9CWfk=
Received: by earth.universe (Postfix, from userid 1000)
 id 4C10D3C08DD; Wed, 20 Feb 2019 00:17:49 +0100 (CET)
Date: Wed, 20 Feb 2019 00:17:49 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v5 08/10] power: supply: olpc_battery: Allow building the
 driver on non-x86
Message-ID: <20190219231749.b6ydhiq2now3z5fr@earth.universe>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-9-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20190110175845.1203986-9-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_151752_587327_9CBAD4FE 
X-CRM114-Status: GOOD (  19.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Content-Type: multipart/mixed; boundary="===============0871965217809549940=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0871965217809549940==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byb526xt5hk5xygm"
Content-Disposition: inline


--byb526xt5hk5xygm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:58:43PM +0100, Lubomir Rintel wrote:
> With the recent changes to the driver and addition of OLPC XO-1.75 EC
> driver it is possible to use this driver on ARM-based XO laptops as
> well.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

This looks simple enough to not cause a big mess when merged
through x86 platform tree:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/supply/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..66e4d1958de3 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -151,7 +151,7 @@ config BATTERY_PMU
> =20
>  config BATTERY_OLPC
>  	tristate "One Laptop Per Child battery"
> -	depends on X86_32 && OLPC
> +	depends on OLPC_EC
>  	help
>  	  Say Y to enable support for the battery on the OLPC laptop.
> =20
> --=20
> 2.20.1
>=20

--byb526xt5hk5xygm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxsjpwACgkQ2O7X88g7
+pr83Q/8Ca1j0ayvype2fj2zz7DiMEXkdtft6NqEhS/u3xrNP6fSaZqMHhMqWbbs
aYzJqKykpIrTvKpF7pvLGNYwV6yQVdVxcemy1AThPrRYenNQCrKErPz/YAsYsxst
G1OEiTM34HG9pdjwQgDACDLrd6y0cUmi/fq6TJJOKIaiM4FEaK5UUg7Yva526uzS
d4snhlUTTDPjMYkvvNPNzMa1idpEoH2J8SI7ZRGRicbklbNNsehPkve3MG5u81MI
v2QAr5v2HnW+R0CmghycE0mrDO3CkFGWOsutytvwxIFEnOcAwyYrIeFnFQFjG7ll
KegWRWOtCRYk9iPqIA8DK7ZFg+ef3APt71fCG7Fb+2GoUduhsokllSF24Q+tygMh
yBgJ98xVkBQAYxlWGNxH370+PaHvcl1ShQ1yMZOVVogtdvqdlCH+7how0XsPIV/b
udGnxBnvUJ+ZWq9ax2bqxGttR53bJlSXGH5uVaRTYl0ElMpfZkvgJehL3TWG4uE6
T2+Km2SDuGLaF+TgxR4IEJ39zquT5lHdlQPyo3obYMy3mFP1XTiMiiw0LfZ90UVk
yqWhFUxyc2hy2WZJbEKsvyEOWASH5LfwDUzhnbE583GWll2aQceQXXQ3w3YTLPAB
MhEsVEUPfEmahjxRFRpZ1Zulvto2r2lCp9sSB7c1+Vhllx/9/l4=
=a6QF
-----END PGP SIGNATURE-----

--byb526xt5hk5xygm--


--===============0871965217809549940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0871965217809549940==--

