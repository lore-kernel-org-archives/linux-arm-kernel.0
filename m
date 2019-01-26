Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AACC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:41:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB172184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JlJIgYZV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gztZkI2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB172184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FBJdY+zAJuOT49v0l9d0bJZTUa3QT5YsLqTqmHO8V9M=; b=JlJIgYZVfWHfr56qQOn/PBrqE
	xNum4VH0STCs06cgA+YME5t6HL69OaaXb2tnVq6WO8OYvEP9Z81ClWwH/VhlHA+vpo6C7R05J22no
	n5OSQpxtwcDiH3/Awc5WyCVGxQxL2LPtTe8SWFIU5taRpADkNTNOPZ3CEVpeO4/EizouRcmUsX+1p
	38O9mH4Jf8Z3Dwoxu7H/BQj0GSn+aZRUY7WiZkSLkj+HII0NOa8/MQswFWMYhRxoG/IYB3fy8jiTy
	q5ynpLP0zk5XCsR/Ip0BSX4VAXcW/4s0DXYH9e652One71aJV+KTO37FaK5vqytWK8Df7Ply9kzV6
	QH/bPdTSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnSt4-0007W0-MA; Sat, 26 Jan 2019 18:41:02 +0000
Received: from mail.andi.de1.cc ([2a01:238:43f3:0:615b:ee97:1f81:cbf2]
 helo=h2641619.stratoserver.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnSt0-0007VX-In
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 18:41:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mp65YKRqiZLYb7rn16aDP6BkwG4Y9/EmU7kqVpFnUr0=; b=gztZkI2MK7n/IT7Ut/yGA0FG0
 jw3ql+cGgjZUcE+QLDrDD0mG5EPy57JzFcsQ9wBlAzaOZJZ7t7M0PmoFBAKeXZ828vp0ERH7QGa3F
 E68l3nCkqtZsdrP2OiNTo7LH7hplZyl+H87EL+6o/yq1jzbX+gg0RdpLp7Ksrya+y3MpY=;
Received: from p5dc58b75.dip0.t-ipconnect.de ([93.197.139.117] helo=aktux)
 by h2641619.stratoserver.net with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1gnSsq-00005z-D6; Sat, 26 Jan 2019 19:40:48 +0100
Date: Sat, 26 Jan 2019 19:40:44 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of
 fck reparenting
Message-ID: <20190126194044.2fad4427@aktux>
In-Reply-To: <20190122175717.13428-2-tony@atomide.com>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-2-tony@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_104058_916848_E2BBDC26 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>, "H
 . Nikolaus Schaller" <hns@goldelico.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2678235839763053915=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============2678235839763053915==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5AbSC/DfyOdNO2cukCydAeE"; protocol="application/pgp-signature"

--Sig_/5AbSC/DfyOdNO2cukCydAeE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jan 2019 09:57:15 -0800
Tony Lindgren <tony@atomide.com> wrote:

> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc") moved some omap4 timers to probe with ti-sysc
> interconnect target module. Turns out this broke pwm-omap-dmtimer
> where we now try to reparent the clock to itself with the following:
>=20
> omap_dm_timer_of_set_source: failed to set parent
>=20
> With ti-sysc, we can now configure the clock sources in the dts
> with assigned-clocks and assigned-clock-parents. So we should be able
> to remove omap_dm_timer_of_set_source with clean-up patches later on.
> But for now, let's just fix it first by checking if parent and fck
> are the same and bail out of so.
>=20
together with 2/3 it fixes things on pyra

Tested-By: Andreas Kemnade <andreas@kemnade.info>

--Sig_/5AbSC/DfyOdNO2cukCydAeE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxMqawACgkQfb1qx03i
kyT5yw//ZSntlnj30pDgOix+cgXsXwIjRu8Q4saMMzN18kLHRZv5bdjACIFRbGdl
H8i4SvDjILrspfjRpH8e4TJcVqETdO3WO9SiulldBnU0nOYFcMBEPlqVKh2KZnwV
GCJkHntwIwb+1HvoqYnteeBRQNhozFC+oDFv2XT/kAtCImgyc9LqUdw4fBKK9Smv
+8AS83jBLcOix2okDitGoZ/R2bz+Z9G1XwbrH2/3ovh5APa4taHkrGnhqtnX/npW
C4FlrOCJhOCpRk7JCY/gxdWBXUFhEHPUBIgV4UaS1A12nQXQnpUzKpFFJcBx1CFI
zSmE/ph7sutbg5rM8jGwy6PYeEBBwp0G+WkG6zKoyr2nVQQ0CpjsXW8wak8f7QZ7
lqEe0iEfEkBdN0BMy+gNXbJhKf53b2WrTeKx2c8N4UWj/n16ETMNB24pZEJyC6z1
eHp60FABXxSluyBTAGdNBgM9rqVQTQRWG/Pelgi2i0yovnFWhrKZJLcung+GuFUR
YCqAbDtKtRHd+Nt8bKdc6VbsUVNhZArFm3op8uszQsAG43XYDjsCT+Yf3ikjL0Wo
dDf4txq4V19WC4Kutvk23M65SbeWlVK5H5fx1NhIsnO2owZsJ+R+slLeZQ4/qiS5
vIkmaDch2gZXtA41bVpEl2bV8xOPkGbwvUlA02iRY93bYtnTKZU=
=YJJJ
-----END PGP SIGNATURE-----

--Sig_/5AbSC/DfyOdNO2cukCydAeE--


--===============2678235839763053915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2678235839763053915==--

