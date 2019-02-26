Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8784EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:37:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510272173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="plF808eJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DliGZre3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510272173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wxkmkzOvK3K2teJHFQlrW5KMXp8Kc5SAd4vztiPmXaY=; b=plF808eJ6oZKCD83ER/VksQ/7
	TmHenpF6AaGEg6+AQnbx76eEs0bp9EizEvOZLCQ+4Um3Mgnwr/tjmD0dqKXYUFLOGikZcf7oW/BSm
	FYtrYzsFmVpSAtACMyRG63tdXs3xKH+5xk8D5fm7RpKeEHyLIBXeQQQ+xYlxd60OeeMQ4UgYxbKsf
	pi/twfD4UpL/z2XMAy9YihME1PwAqcfSkEo5vmDqhAfgweVkaEwx6MF63VAVPIoZcHNRMtmpeE0e5
	BxzljCOyumehlvJKwCGMRl9VbxSWKkAULPbI9ALe6q4hVsIMrejcUAz7/rXhAmUEJFeRzGoGWuxGm
	8hCmV7kAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyb3A-00024i-SF; Tue, 26 Feb 2019 11:37:28 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyb37-00023i-L3; Tue, 26 Feb 2019 11:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d++7WAmEGJUbaZmfgDebiYoN+itkoqdBd5iVBGodf3w=; b=DliGZre3VcEHLs+bkH+vGaHXA
 VRgleyZkO11ndOdjv+Orp9ufLHBdYtg0fIB3fpb5UyH/X61StpcHzO6tKmDuTBr0kYuvJV5hewmxS
 sjnElCu09NCPh1tpIIXSsJZQ5v4wOf2zEAX2polElwUUkWLNTyfPXzajuYlWgJy2byCqk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gyb33-0007fQ-DW; Tue, 26 Feb 2019 11:37:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 874CA11284F0; Tue, 26 Feb 2019 11:37:20 +0000 (GMT)
Date: Tue, 26 Feb 2019 11:37:20 +0000
From: Mark Brown <broonie@kernel.org>
To: kernel@martin.sperl.org
Subject: Re: [PATCH 3/5] spi: core: allow defining time that cs is deasserted
 as a multiple of SCK
Message-ID: <20190226113720.GB7082@sirena.org.uk>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-4-kernel@martin.sperl.org>
 <20190223124010.y7lsncknnxoblvgz@wunner.de>
 <CCC6392E-3189-49BE-B04D-3997434184D0@martin.sperl.org>
 <20190224103913.bjw7g6ievr75iawz@wunner.de>
 <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org>
MIME-Version: 1.0
In-Reply-To: <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org>
X-Cookie: Driver does not carry cash.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_033725_839151_EDA2E854 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 linux-spi <linux-spi@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 Lukas Wunner <lukas@wunner.de>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4951245521128774269=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4951245521128774269==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2019 at 12:03:33PM +0100, kernel@martin.sperl.org wrote:

> Some devices - like the mcp2517fd -  have for example an internal PLL
> based on an external clock. So during setup you have to use speed_hz=20
> of <clock_hz> / 2 (or 4MHz at most) and only when PLL is in sync we=20
> may be using speed_hz from the dt (or less if a module parameter is
> used to limit ourselves further)

> So the initial setup would not be able to help here - and every
> bus controller would now be required to implement setup.

> It also means open coding the calculations in each driver that=20
> needs something like this.

> Thus it is - imo - in the right location to support it in spi core.

I agree, this feature makes sense to me.

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx1JO8ACgkQJNaLcl1U
h9DqiQf/VIQKFSWAfGMPLHiXyFgCxDWSMEJBXx+qqHGX4tavUNpc/O5N4MNu52M7
/OUmB5qjgGIDXgUwVVL3ePo6qE76yqvvbXBO/XPGjoFxJMVKs/mX4jFC6gUiDU7S
ZV4xEya2ro12xZZSvAd5GoGq6OClBhSjpj18pudOh4DoqasYVYNaJUWKQW+r++zu
wsYvaUNnpRn3FmzsT/+Ptp+tB3Q8psXMRtM7fCOyhAcXY2yfVi8WTjplvjWoUlAU
oxfMql51xNPPUYMwtEEWeqGDhJMP6i6nAAChPeTE4Pjp7HZQxLj0+MioeSSicd8b
68XET/UO9eO9OR9WmFmhyGKkUJH8nw==
=wUxh
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--


--===============4951245521128774269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4951245521128774269==--

