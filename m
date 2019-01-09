Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B3FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:51:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824A720661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gPBIm2jV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LkkGaiVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824A720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bz2/DXVQEgrJomfKlYgv5nMsS8ApaCDKRbRznO3sVeo=; b=gPBIm2jVXzQGvQBD28Spm5b8M
	WTVoGWMuFPrDa4Cd6jixDPtJOh3xDgi0/5JPWrh17wmrxUn2yegyonpI7M5zqdA+qMU7tScCJzGb1
	uNmacCTsjtGNkoxfrcADeIJOr9EoDYXUDZGiAvsGW2P9eFoAqbU171j9CMZjiApOiqfhRusbWG/dI
	RoD9XnHQsI8d5P4/3mmmGvT5BBilSYQEY4Cp2/y2XVjsjVPl4iOtSHNPRAaQiJjcqTSSey8PiNYcm
	sgChuEhxX8gwH4cW4m2tknbRRMSCBmLkbfOaZrfU6WvSrzpqCIbLMkQarw2KMMPDvR8rcKr3utk6y
	3RewSMClg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIwW-0003EO-QY; Wed, 09 Jan 2019 18:51:08 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIwQ-0003E1-UU
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:51:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hKyL4CfL7YSUjp0Dl0YOxZy+BWcnp2DvLGJ9XkgMYR4=; b=LkkGaiVCgD13wGa0Otq7kEuJP
 yTBDaI36Go73N4kwiEPCiVI35F9fF83OEewahVfGQOJa3ckr0NKPpmzB97kfr8JbFBtkQGbThsVe9
 vbewzbS2q/LU9OMCa+TAruCFWT//eyk6dVHj7kAv83mNutYQiqgcZEDUWSXd6jL61us0M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ghIwM-0000ks-Mg; Wed, 09 Jan 2019 18:50:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 542661127528; Wed,  9 Jan 2019 18:50:58 +0000 (GMT)
Date: Wed, 9 Jan 2019 18:50:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
Message-ID: <20190109185058.GL10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-5-codekipper@gmail.com>
 <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_105106_519717_9F554CE8 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 "Andrea Venturi \(pers\)" <be17068@iperbole.bo.it>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============7882919299183058301=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7882919299183058301==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 22, 2018 at 12:54:48AM +0800, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:

> > Also add offset to RX channel select

> Commit log seems a bit lacking. You could probably explain how you
> found this, either when comparing datasheet macros, or some actual
> error manifested and you "heard" it. You could also state what the
> fixed outcome should be.

> Also please add a fixes tag.

Plus send this at the start of the series so it can be applied as a fix
and sent to Linus during the development cycle.

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QpEACgkQJNaLcl1U
h9A/2Qf+MpKvC1sDIcOBBmk7hZNPdkcZE5wlhCQAmahqcAdv8UeXEo+DGX8UwwtV
4DI7HFayI95aRYebTz5VK/W1noETZaQMciZ8eeqELS95MInDMhauwlioR0QlN90L
re/xxB9i+h/rGYomJenLE4UblW9FQ9D92bIudL7aSW+ysnEJFvptf3e6IVYwWGBH
Oh3H2N35iCCVsO45ex6Ra2k4h5/zDqz8jqM3MrlDN0AAb5OmT76HHWfiCNPTNZyU
hty4A7sssYji0nqfs3gB6UqJwK4eAxjGak6tmh5yHu02WXh+4HQjMMpnQfvYVdX3
RUFMDvm2f2KaEaljyksXH4Wml+pKAw==
=REGU
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--


--===============7882919299183058301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7882919299183058301==--

