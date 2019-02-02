Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7DBC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:40:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1FA2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jc+JxjpF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XWKRbUpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1FA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7L+uJoLubm6499jABPoBGAzpT6Visuajdt18jH8R33A=; b=Jc+JxjpFPl9qkhPLaOHIJjJgG
	OpK8jzbKpsL7eqB+HSSqxZSIwXZfsMOF4bWYDv+eRtiQlvcSrYzu41pkPe8kbYLcDn98WdmCdESwc
	RLSR8dPN4mbz1cbC7SCVnzNM5snrfv+W9ZprP9fMmi2XCeqZeG93tpXQGLl+WHgPW3mKMyBuLi+2G
	4Ijf5nFxcd5QwCX3YDsae0n77AmiIxxz5fkOLv9LRoVTfCMSMBxj6aAbtAyBzlBWi3aZzM3dbpg1x
	/DDuHELqdYLQUj/0tKx+pRPFoN4GbYB/DZJ720zZK3LrbGmOuku4jAfqI3B/niqWe/sUxItNhsMH8
	7SiW2aqtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpxOq-0002KY-8t; Sat, 02 Feb 2019 15:40:08 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpxOn-0001n3-FF
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 15:40:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jzdk4oao65b/O+KMYHai9nsFS6YtK201VAtnszIHEow=; b=XWKRbUpXXjhmtWK/ejEIAW05g
 e2sRH4oiT83alBdjfRfOcZqtBOYgyP8Q5d0sFTVesGuvxEwo78PFrjHOWb+zpzNrJP82eqgDPQfp8
 bV42Oyl1CyVLl9J7geyUmTESEwqI7aQpSt2LxDpflUSo0DaJU+MXJYDfKyilA9fN5cLr4=;
Received: from [2001:67c:1810:f055:877d:5801:eba7:24a1]
 (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gpxOd-0007Uc-01; Sat, 02 Feb 2019 15:39:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 5B0C0440082; Sat,  2 Feb 2019 15:39:54 +0000 (GMT)
Date: Sat, 2 Feb 2019 15:39:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Brian Masney <masneyb@onstation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: next-20190201 build: 2 failures 19 warnings (next-20190201)
Message-ID: <20190202153954.GK20797@sirena.org.uk>
References: <E1gpgTf-0002ZN-NF@optimist>
MIME-Version: 1.0
In-Reply-To: <E1gpgTf-0002ZN-NF@optimist>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_074005_677827_AFCC67B2 
X-CRM114-Status: UNSURE (   7.35  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2372484514746747843=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2372484514746747843==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 09:35:59PM +0000, Build bot for Mark Brown wrote:

Friday's -next fails to build an arm64 allmodconfig due to (among other
things):

> 	arm64-allmodconfig
> ERROR: "irq_chip_set_wake_parent" [drivers/pinctrl/qcom/pinctrl-spmi-gpio=
=2Eko] undefined!

due to ca69e2d165eb3d060cc9 (qcom: spmi-gpio: add support for
hierarchical IRQ chip) as the driver can be built as a module but the
above symbol is not exported. =20

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxVucYACgkQJNaLcl1U
h9Ap4Qf/Z35JMYW6BS61H0kHt826Qfnh7yMwv8szJtscn2QX/dM31wESH3VYpTNw
kn7lax8Vh+8I/A+1paCYhFen1M6nMHLdSBG0SRsNyjmTOg8T7tczrfvmONl5QBZ8
LgDbhA0xnTxAP9m6lAoSS8mrm2JJf1o3HnI4iS8FHW7ZlCQSKmZlR4GxdbTCAX+3
11BDRz3G+mQ3yv2haAfBPlXH5eXnQSOphqOD1ZHlRaOPppRMXigYAVIeNVN3axsP
9c3qbOOvM85OpO6o/OE7Kog5HVSqTK9+mYbdp9KVlIbnUByQlC81TVSSfyWZWYcY
bIHaYHfXVUdogmchPweF14hyuPFnvw==
=3yvP
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--


--===============2372484514746747843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2372484514746747843==--

