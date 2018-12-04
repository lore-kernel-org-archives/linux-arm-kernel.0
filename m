Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF6AC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:10:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D362082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KKYowh5G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="P0CNRjdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D362082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8oqM8w+u0g/OGZHNvvUzfklLnbW2ZK7TVLtr5T72SGA=; b=KKYowh5GCMgf1JaNGDkHqCXi7
	0DbJ7kxJbfaIO0MOkrnkPV7pn6nJ3bz3Rk09hj8aGgiNd7wFf172CXlG9L+1wrJWZXs9m5CnNfVS8
	FWRCkeeBfwodXvR7CW8Oo16ON/leKV0JCFXD2Xwkm2mebnEq90vpldnjIGnR7r4bNbnSaAJsBjQhT
	JcYHuZqZXlRjTwBQkRK+I1cjrWgCro7xdW8FYysl4N9W5xgzvfOgtolMcGPnBaSNi6+rawUvF4jUx
	PSwXRyg+ldr7bHfWO2fEitH8M25f9ZSvLH1wT4D+FEeZRvsB7sQqggRKIjpIzAaOZi3xRWussi/QS
	s0H/ZYkXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCLC-0008V3-0I; Tue, 04 Dec 2018 15:10:26 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCL8-0008Lh-GW
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:10:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1x+InGfy+R+JKyg18Jez/GqAMNx8TbwgBoRZ07sXDXY=; b=P0CNRjdX02l/PUg/RZeaCIkUI
 UrOexDN/m4FYbmWt9Nsa8DrBsxy3YlxPkXi3ZuxtJHuMT37f6xTtg8APpVtmYUVO28V/LsEzx3baT
 bWEJfNP+vO7DLU/wFvfGe3L4cFjm2U59/rtmiAoxw1pIBQOoTW6CNsO7fluaKUnYKOHI8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gUCKh-0007XZ-8E; Tue, 04 Dec 2018 15:09:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id B144111251E3; Tue,  4 Dec 2018 15:09:54 +0000 (GMT)
Date: Tue, 4 Dec 2018 15:09:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH 06/14] regulator: axp20x: add software based soft_start
 for AXP209 LDO3
Message-ID: <20181204150954.GC6809@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <41cb1b4dac3a15595c89fa962b78d3f68f370021.1543245984.git-series.plaes@plaes.org>
 <20181127093619.72ensythkx2mhdf5@flea>
 <20181204133144.eqd3dk3jgqm4fbk4@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20181204133144.eqd3dk3jgqm4fbk4@plaes.org>
X-Cookie: The sum of the Universe is zero.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_071022_727245_EA34B9B0 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Lee Jones <lee.jones@linaro.org>, Olliver Schinagl <oliver@schinagl.nl>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5896667224702434424=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5896667224702434424==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 01:31:44PM +0000, Priit Laes wrote:

> Yes, makes sense. Although, should we then also distinguish between
> regulators which support soft-start in hardware and devices which emulate
> it by delay, like in this case?

Drivers should not be emulating soft start, if they need a ramp delay
they should set that in their descriptor and let the framework do it.

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwGmMEACgkQJNaLcl1U
h9CpFQf/SOm+w6bfzdiV1mRAj1uTKpc8/3V/4pVfrGTWO1zcbprN9Bhwx/eucEeR
hNTs3C6ApYsMW3cYqgbc/FhcNvsTCF4dLs73wkRpTOYV011dtkvJfnyFJZ0gD1ko
R+G/vg+PO7DAogzZVPbU2/LezobGagpma578ucZVUdesyv4PVOx6RB4Llg07sfIn
NFGEMfRjjOziJpg24raKgigiZBx54Cz9q7e0b19pJAeYl+Xb1I05QNN2C66Vf853
ZdLfvbyC+4ucB02jZmydtJqf1YYG58KwcI+2wcx4CCYxzbC7pP3yVGfUxlzLxZjR
0+ZWUI+2xKFwR1VBuHpWQJ9whgroQg==
=cKg0
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--


--===============5896667224702434424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5896667224702434424==--

