Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC67CC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:22:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E4B2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BokCSmMO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="exyFnKKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E4B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F5EPWfVEdhT+ynD4G/xZRZhGNLw3TUFg2mVbh24vBPk=; b=BokCSmMOokF/3NzjE3kqK5N9U
	k8YfWQFX1e1cu3h8X+9ElmSkeLd1QHzd7zIaXz9L1pMiF9aC9wEeg+GNZZQphhyYE8nVEIvYI4mj1
	QbnUQu62gLAWmDSQK/aXz/v0hkDeWq2G/uboJ09B5Pdg+3vS0i9qlbik8y/a/AyXeUWCZTT+2AExr
	nKjZbre1VHKy4y9tK5G/bm5EbpU2TaTPyTR1CccMMrF1YlnkyMC81Nb4d8WvfrgLTnTvyAqB73vzA
	Ad61to95EtCH6X6PMYFNqqgyi8SGEYRZ/FT4VXkApGzfdzThtTv91afiFXogbFYnh3LbGEkaS/m0k
	lmWdM0lQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXaJg-0006hA-Vj; Thu, 13 Dec 2018 23:22:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXaJV-0006YE-T9
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 23:22:43 +0000
Received: from earth.universe (unknown [185.216.33.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCA462080F;
 Thu, 13 Dec 2018 23:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544743351;
 bh=eRs0pdMWjc/5gZAEbYnVM8t7Rv8uaJ5X+t+ohf/onoI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=exyFnKKDOKp/hFZfypVsqn0x3OTlpK+5kLB1U1k4betT3C8dhB7AxuMHfVKZf5Fzx
 iKXflkArpPHzDny+hsoeMPvohREyxS7bjFSWDj27HT/pKZNk0+xqvwJN2rJJ1w+tpK
 4vmMg/SaIusuBSi/D6KYzrsP+iw0bRaqKh29GRyE=
Received: by earth.universe (Postfix, from userid 1000)
 id 6105D3C08A4; Fri, 14 Dec 2018 00:22:28 +0100 (CET)
Date: Fri, 14 Dec 2018 00:22:28 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: Configure wlcore wakeirq
Message-ID: <20181213232228.beiwpqeixfvadjjf@earth.universe>
References: <20181213230411.5009-1-tony@atomide.com>
 <20181213230411.5009-3-tony@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181213230411.5009-3-tony@atomide.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_152241_981540_CF7019C2 
X-CRM114-Status: GOOD (  16.70  )
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0786285351205322301=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0786285351205322301==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="avp7gkj5j2dtz5yr"
Content-Disposition: inline


--avp7gkj5j2dtz5yr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 13, 2018 at 03:04:11PM -0800, Tony Lindgren wrote:
> With wlcore supporting optional wakeirqs, we can configure it
> for pandaboard.

-ENOPANDA

-- Sebastian

> This makes ssh connection usable with the SoC
> entering deeper idle states.
>=20
> Let's configure a wakeirq both for the wlcore GPIO and the SDIO
> dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
> some point.
>=20
> And let's also add the missing keep-power-in-suspend while at it.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -359,20 +359,24 @@
> =20
>  &mmc3 {
>  	vmmc-supply =3D <&wl12xx_vmmc>;
> +	/* uart2_tx.sdmmc3_dat1 pad as wakeirq */
>  	interrupts-extended =3D <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
>  			       &omap4_pmx_core 0xde>;
> -
> +	interrupt-names =3D "irq", "wakeup";
>  	non-removable;
>  	bus-width =3D <4>;
>  	cap-power-off-card;
> +	keep-power-in-suspend;
> =20
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
>  	wlcore: wlcore@2 {
>  		compatible =3D "ti,wl1285", "ti,wl1283";
>  		reg =3D <2>;
> -		interrupt-parent =3D <&gpio4>;
> -		interrupts =3D <4 IRQ_TYPE_EDGE_RISING>; /* gpio100 */
> +		/* gpio_100 with gpmc_wait2 pad as wakeirq */
> +		interrupts-extended =3D <&gpio4 4 IRQ_TYPE_EDGE_RISING>,
> +				      <&omap4_pmx_core 0x4e>;
> +		interrupt-names =3D "irq", "wakeup";
>  		ref-clock-frequency =3D <26000000>;
>  		tcxo-clock-frequency =3D <26000000>;
>  	};
> --=20
> 2.19.2

--avp7gkj5j2dtz5yr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwS6bEACgkQ2O7X88g7
+prDPQ/+JSdbMwouHsYbluZAUpbH2LP66c0y+U7zxguTK56DvBTvB8DFzF2zBvqs
nf0DMCg0/Dxpt6PLgIlURLi38Ptr3RF5OweYS0o+GNuJreRsFwdWNAcFtDs8gHTV
mTvMoyhUGgHbzoUCRNtXnoca0zc6D0mY3jfLU6dFZz3rvdq+1b3d+ZFJknidERTe
Ejwx+TwTD8r0brGWUxxjmTGElhBxiIKOxOVeggQ+Zbdqo109f/QBDNAVgXGUBDNW
w2cK9C35xeULgDyMmxt1EPoon/tNSWl2pMYZHRe+qqcnIWvpS8WAZx+g32FvO79h
g+p1lzsiTn5/92qU7TpiuLBhSL5Ei45WqO2NZdSzlkW8j5DiRRcBe6vdegJNhdjz
Yp5POQIzPzP387cM2hWCSs1LfhG1Hm5dbkWgEARCgKRcE1F4loyBIdGgNwrpoCQx
JPCoEafxlBGbWjjEAaR+X+iIhSMgCTv83PkYsMnLtchugU2yYw9n8N3RA8Ggvg3Q
vjoqZvOCQ8XIbXO25UL99G5TGo98nUIZwSOvaQ7hMnG7SwQi0ux+KB7I/t0FRQxa
zWZk8uiNyr8LPozfH9Iuy/x3BtkmB+tmG58IN58J1NJxIzI4JdYpepx4U8J2/MR6
FYbducy7FG1mCoWizkIkHZ2Ujf+9ssR1iyegTM456DvQuPPUMkM=
=uzC4
-----END PGP SIGNATURE-----

--avp7gkj5j2dtz5yr--


--===============0786285351205322301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0786285351205322301==--

