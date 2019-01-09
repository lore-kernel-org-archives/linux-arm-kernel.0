Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3812AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:49:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0617520661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QipoK8uB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DM3P26aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0617520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XCNfxtK9PDQheoTPjiLmOphdfbOt3Yj3nf7ALZkA+p0=; b=QipoK8uB7Q/XhmKg1xuPD1hbd
	JVxCYBysy4zJSeoGQMVqgibYBru8OVgtfWw6IzV4mki8Ld4YRRD1A0EOCMkQ0jX3OiADOzU+VEMzy
	Fe4IgyNenNx8kpPh+eprCuaFBfs88WzJyu598QDvA7ds39aT31GxzZVhMZVL9+xEbtfJjvUB4LZe2
	cSx0e91WdDrugSFk5aSepd9yzhVzKbynvyfzUFmrPGheu2RFBQ1T7UjGROs4LCs3n9RhJQHCRFL2Q
	UFbvuMG/ADhRLAnPnQUtYgyvkAg+Q2EM72ogWSkFsHjtGFBIitPGv90OwygPTAnU4Qsq0qneC3Y/9
	5KN0j1CQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIv7-00010o-DA; Wed, 09 Jan 2019 18:49:41 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIv3-0000xa-G3
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:49:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VMBXxHQtIn2rIyl7ckaX9SE9gtbIaHhcAOyg8NP+D8Q=; b=DM3P26aJJVS2KzaDNza1SrCSG
 7ncG4FjDkULJs/3Qmmxjfb7rP3OKkX5eUBtIWyPZT3CjgSli8u02OdsnUpJNggypYD1XLiA54TlqF
 asByfV3xZrT5Nh5Oyl3+mMJJLZmOaY253H3pkc2bi5ZYrs4PPw7Vggt2h3KLKXMivk/vU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ghIuy-0000kX-4A; Wed, 09 Jan 2019 18:49:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id B071B1127528; Wed,  9 Jan 2019 18:49:31 +0000 (GMT)
Date: Wed, 9 Jan 2019 18:49:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [alsa-devel] [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap
 settings
Message-ID: <20190109184931.GK10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
 <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
 <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_104937_750180_1DE64883 
X-CRM114-Status: GOOD (  13.94  )
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
 Jonas Karlman <jonas@kwiboo.se>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Code Kipper <codekipper@gmail.com>, linux-sunxi <linux-sunxi@googlegroups.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8764379230976429329=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8764379230976429329==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23, 2018 at 11:16:31AM +0800, Chen-Yu Tsai wrote:

> This sounds like the flush is happening after DMA transfers and/or I2S
> operations have started, disrupting the order of the audio samples. I
> think that might be the case since the regcache is synced sequentially,
> and the FIFO control register is after the enable bits. That would imply
> that the device is taken out of runtime suspend after the .start_capture
> or .start_playback callbacks. Not sure if that's the case, but that would
> mean the bus clocks are still off at this point, and bypassing the cache
> and updating the bits is basically moot.

I would expect that the device needs to be resumed from suspend before
we start actually trying to transfer audio - there is stuff in the ASoC
core which is supposed to have appropriate gets but it's possible
something is going wrong there.

> I think there's something else happening here, but we need to figure it
> out instead of papering over it with something that "just works" but
> we don't know why it works.

I agree.

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QjoACgkQJNaLcl1U
h9CYkQf+LxpY1u9lPMC6ld9Jxf0JNyammIoqScIdns2JZ8ZH4M6rpKWUsUyETdVg
14bCT1yi7D5ZH9Ekcw/6yXB0FBQX0rqP2W9X7PODZTgWEVBwF6wrp9jIe5YlYsM5
47wuQFzRquRKmhaBwvuwdOM0+l2T8cRd7ZnOVmVNDJxb3oD8/0fR3LKCd8e8sQ9v
vqJTljjBtGlvwwWbWLeMLkXbvlesGpc7heRgrdHFXgxf46BMpN0rZuUWZU/5XwF6
zqSDZaXBPAgm1CFJ06FQdo8VeAmXT+mD0X0tJgZKG2FxJBAKEp5Ss9+sgSCMsbVr
Qo/rQCkOQYPKtuPsNLeHCFJEaBNy0g==
=m/5F
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--


--===============8764379230976429329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8764379230976429329==--

