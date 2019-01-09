Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B18020661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HRKWOciD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="D0lRYUSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B18020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VkRbPNW9FJYYi1X0w7CfnNtyyUnR8Rkr1Up9qQ9fdt4=; b=HRKWOciDd7CN1kvyTBONpeKUH
	WGtFMsdm1kmQ4265i8DGOQiURYBm6vkFbLm2GJZ6b9EiZ7Xg4A9wt4XUatWPa0m7gyKk8efKF6xU9
	MOcYUIA10UJlfc4PJO1pqe9j008/a46oTh4r85amxcpww/FuDpDMSrnGFKZOo/Ef1rUA5BENYtVXJ
	btjqhnOCboEzFzdYy2KnW4AFTXafEgIYZHieKfh/CeyxQPEygLAandAcz3N8duXfyRmjk2hnn2mG1
	k+IsNp12hhbsuLhhBVG2CoVwIRwYYzm2/KCDjfkHwBs0HqjtsJXBcQQQVYR/AZ80/VV+4D9zCjv0S
	TbmeHubsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIrm-0000C3-Sc; Wed, 09 Jan 2019 18:46:14 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIrj-0000Bi-P8
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:46:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HoUUAmONh6tfxEaWm8k8WBpdpdPeuNV9ZIsTcKwd+uE=; b=D0lRYUSttmiOmBj2aHK6X4kKe
 0Kd+C2Fr/6p6P7fVYg3Si2H26D0ufOSShgZ3dziQqWt51SszEjzfk4TGVc8+gTZw+SLL6/Mv3KFjy
 FTRd3QigPvQzLlx0+9XCmPwnpCwbAKWNGUC53VOeWeqX7he2uzCTje9UXn88aHfh43nV8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ghIrc-0000k9-Qu; Wed, 09 Jan 2019 18:46:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 55EFB1127528; Wed,  9 Jan 2019 18:46:04 +0000 (GMT)
Date: Wed, 9 Jan 2019 18:46:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap settings
Message-ID: <20190109184604.GJ10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_104611_966163_8A0EABC9 
X-CRM114-Status: GOOD (  17.17  )
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
Content-Type: multipart/mixed; boundary="===============4577713820405447056=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4577713820405447056==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 22, 2018 at 12:44:07AM +0800, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:

> > +       regcache_cache_bypass(i2s->regmap, true);
> >         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> > +       regcache_cache_bypass(i2s->regmap, false);

> IIRC the flush cache bit is self-clearing. So you likely want to mark
> this register as volatile. If it is marked as volatile, then all access
> to that register bypasses the cache, so the regcache_cache_bypass calls
> are unneeded.

Yes, that should be the case.

> However, looking at the code, the write would seem to be ignored if the
> regmap is in the cache_only state. We only set this when the bus clock
> is disabled. Under such a condition, bypassing the cache and forcing a
> write would be unwise, as the system either drops the write, or stalls
> altogether.

Right, access to a cache only register while the device is in cache only
mode is not a great idea - the usual reason we're in cache only mode is
that the device is in a state where I/O isn't going to work.  One thing
that can work for this if you need the register to be cached (but is a
bit gross) is to do a write setting the self clearing bit then another
immediately after resetting it back to the cleared state.  That works OK
for cases where the bit is a strobe and never retains state, though if
the device isn't operational then needing to write to the register might
indicate a bigger picture logic error (or it could be that the register
map mixes random things into one register).

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QWsACgkQJNaLcl1U
h9Czcgf/WEsr/xgxGR1vWUvTZ6HNUj2DdVfl5O8Fqvyh5XNwHUGt4I8gueUJSoRL
lRSRA1NqnXYhd1S27qKSWtJA4VgRg7bDT/SoD7PFAspmc4R8fZ9yPdKBqqTZB+yv
KCwF2H/u/8LIhGVJtqTpEpmwkmQh+H3he6HLSnDaVRtaqiEQKzD/1gP5NGW5AJdL
SgZsfpsGlefkKglwLqw62e2lnjjqShydhd5p9ciEO51Hc4rJzQgxYQYWTJwZ9jNK
XjGkwyVghD8WtKoEAnwrd7l1JR//Hapv52wmq4oSZ83in8TNXracdM1djPxxizjW
q6G62CFmh8On1d62dbYKwhdZxpQlvg==
=Yhg0
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--


--===============4577713820405447056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4577713820405447056==--

