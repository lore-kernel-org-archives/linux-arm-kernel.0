Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265BDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69D420879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTsEmrid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69D420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f6RK35HwQMh4AKpcDd2AKFi4ozmZ4W7vyvp8FVBdgu0=; b=hTsEmridKqzNb4qaI+EmdArrf
	eOLoICd/5vNFiAEIoXmdydDVslCFE1p0F21x4rigbm3AYRXEvjLtRLXOWOXVaug32j5V/Cz64DoaS
	/eaC1m93YPa5Tu20UlQEH88enq5re5hY/LIe4rOXzIa5rs1suKS06MKk9zdFBfaT06b0B5ht6Cdfq
	xajs6pabxT2JVchl2MpsuWDlBvlDW5cpxnLP5zEuaIqetKWvWdkgwGLTaGLMGmIPn5atRlGFL3xq2
	ILJIaegRAVZvl7R4MairIXjSLRutQ+b9qQwJbwth5ZTtvHqJAEmTQtTkZN6OxXaLDpDivY3RliLHS
	S9Min7azQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfqv-0005L4-IE; Wed, 05 Dec 2018 22:41:09 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfqr-0005JT-SR
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 22:41:07 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 7BE59267733
Received: by earth.universe (Postfix, from userid 1000)
 id 395113C08D6; Wed,  5 Dec 2018 23:40:52 +0100 (CET)
Date: Wed, 5 Dec 2018 23:40:52 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Message-ID: <20181205224052.34o3cmh3y3htchcj@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
 <20181106210933.GU24212@piout.net>
 <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
 <20181107172340.GF21694@piout.net>
MIME-Version: 1.0
In-Reply-To: <20181107172340.GF21694@piout.net>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_144106_180503_C544367F 
X-CRM114-Status: GOOD (  22.04  )
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
Cc: linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============5008850726950985730=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5008850726950985730==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7jup4dhfa2jvl5qs"
Content-Disposition: inline


--7jup4dhfa2jvl5qs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 07, 2018 at 06:23:40PM +0100, Alexandre Belloni wrote:
> On 07/11/2018 14:54:17+0000, Claudiu.Beznea@microchip.com wrote:
> > Hi Alexandre,
> >=20
> > On 06.11.2018 23:09, Alexandre Belloni wrote:
> > > Hi Claudiu,
> > >=20
> > > On 05/11/2018 11:14:26+0000, Claudiu.Beznea@microchip.com wrote:
> > >>  static int __init at91_poweroff_probe(struct platform_device *pdev)
> > >> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct p=
latform_device *pdev)
> > >>  	u32 ddr_type;
> > >>  	int ret;
> > >> =20
> > >> +	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_K=
ERNEL);
> > >> +	if (!at91_shdwc)
> > >> +		return -ENOMEM;
> > >> +
> > >=20
> > > Is there any real benefit that will offset the time lost for that
> > > allocation at boot time?
> >=20
> > No, I haven't run benchmarks on this. I only wanted to have them groupe=
d in
> > one structure. Please let me know if you have some tests in mind.
> >=20
>=20
> Well, it is probably not much but small things adds up. Having it as a
> global structure is probably good enough.

I suppose I will get a new patch with this change?

-- Sebastian

>=20
> > >=20
> > > I understand you are then testing at91_shdwc to know whether the driv=
er
> > > already probed once. But, the driver will never probe twice as there =
is
> > > only one shutdown controller on the SoC and anyway, If it was to probe
> > > twice, it will still work as expected.
> >=20
> > I had in mind the scenario where the driver would be compiled as module=
=2E I
> > know insmod already does this checking. I'm ok to remove this checking.=
 I
> > will do it in next version. With this I will also remove devm_kzalloc()=
 of
> > at91_shdwc.
> >=20
>=20
> Thanks,
>=20
> --=20
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--7jup4dhfa2jvl5qs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIU/QACgkQ2O7X88g7
+prpcBAApVtD/m59e95DIdgGh2IqxIfqkmorBI4Yy/SQD7QokwmVns/8AUPhwxDO
SdulNqMPGCkm7QvUODDMJ91VSUwv6nnBY7ABu0R6eBi188c0V1g0qukrX4j0fbQh
7q+HxhcmWJddtkSE3QSYzsVb9+hrtwaYy47zehqzDNiloxJj0P6iFQbZmXJwIr2/
rVRLnMk99Aj+fUGcpu1Far2ojzftVFvsUGm80kYS8iMi6kS3zhxzXweo9QZr0wNb
O9trFVRGI7Y/jxdQGNevc8zJGMmfLXRpN7JZ4Mwyidckc2OWwMNXe+3TBmOZy/Wi
Fckz5OKKymitxe3d41XLwnsxNglAmDwz7HLTLdpszabYH89FnkgXFvh5csHZq9E4
NMapiMD8uhZevVF2b5Gkk0PQGnijV+OZNsM0AzyJIWj41rq2+OfJgaJ3vMNDeMGn
mbzUYjCxw0FfKlwvigTRYq/4c/NdS5vdmfnNsyshg70/ctCcXyHBPPR6GAWTX4tG
XEdIoGfexgIFT8lvspSEucRtsS2e25bvBCDB8gvstvXBllrt8FJqhZ78dnxFzr1Z
Bn+KlwCoatA7Y4w7A0zPrHIY93m9zyuBXhkAsSkKmXh0YN4nPtGyAmRcT78f985s
2TiN3zGNwG6o5g0dHF8k6NlzhoNnI6mvgZYMlNwCtUUTBt0SC0c=
=YuLw
-----END PGP SIGNATURE-----

--7jup4dhfa2jvl5qs--


--===============5008850726950985730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5008850726950985730==--

