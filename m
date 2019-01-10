Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F1C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:28:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B8320685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nNcVzObN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B8320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HUV5rBLIxeuKSDjUe0OBQGyYA5zDw8npMo74C7xRANw=; b=nNcVzObNVTzV9Lso0wcaOEZkz
	hyBYLj0+MrQZ0cfY40loRZCN+5tlahiJojoprhu5cbI2K+t24/2gRVmZnHdgOD9iBACEBLAvIHX6r
	LtY1xw2sworIGqqAi0vNyDCFf6c0iLUjKbH+QRU0ySh8KBoTJOMK+4HN/pnfzKgARxgqNzMyyrQSy
	r+1KjHVAFQzXBPpv9Fw3eU3dnQUWfptKCAQFQlI89Stgl2Xv2lIE1ex1XvQ6KmMz5PPe0PoJYoXBs
	Q/Jm4auXUBoYMreWo37r0GdsWU0/dycTXvhfNe3bfSNIskowHqqRX9/+KYiLy3clKLyx2WlWgSTQR
	UFClP+vcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghcGO-0007kG-9p; Thu, 10 Jan 2019 15:28:56 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghcGK-0007jp-N9
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:28:54 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 849A3209C2; Thu, 10 Jan 2019 16:28:51 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 50116209BC;
 Thu, 10 Jan 2019 16:28:51 +0100 (CET)
Date: Thu, 10 Jan 2019 16:28:51 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] pinctrl: sunxi: Fix and simplify pin bank regulator
 handling
Message-ID: <20190110152851.g33mgpfgzeatj332@flea>
References: <20190110082633.6321-1-wens@csie.org>
 <20190110082633.6321-2-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190110082633.6321-2-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_072852_887025_82DDCA5C 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0166975202361701248=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0166975202361701248==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2pnopejneh27lbcz"
Content-Disposition: inline


--2pnopejneh27lbcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 04:26:33PM +0800, Chen-Yu Tsai wrote:
> The new per-pin-bank regulator handling code in the sunxi pinctrl driver
> has mismatched conditions for enabling and disabling the regulator: it
> is enabled each time a pin is requested, but only disabled when the
> pin-bank's reference count reaches zero.
>=20
> Since we are doing reference counting already, there's no need to enable
> the regulator each time a pin is requested. Instead we can just do it
> for the first requested pin of each pin-bank. Thus we can reverse the
> test and bail out early if it's not the first occurrence.
>=20
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> I'm getting the feeling that the current code is prone to race
> conditions when pinctrl sets are actively switched during runtime, or
> gpios are requested and freed from userspace.
>=20
> Any ideas?

IIRC, I've looked into it when writing that patch and there's an upper
mutex that prevents request from being called multiple times at
once. Linus might prove me wrong though.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2pnopejneh27lbcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDdkswAKCRDj7w1vZxhR
xT4RAQDm0VrViQOqnAb+y4lxm/C2Kk6e0f9nii3jW/wt7IavcgEA2l2fHktJKyQS
bjMr8bur8Y3On3zKYvDRU+a+LHjdEAc=
=+NHo
-----END PGP SIGNATURE-----

--2pnopejneh27lbcz--


--===============0166975202361701248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0166975202361701248==--

