Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C95AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:39:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2205B20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmTpKrTd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iKSePolp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2205B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e2wr9ZgQccAgbVIZATRF8cuAaSjsQg31nAu24a5Tpvs=; b=rmTpKrTd4ctctHL8Wq1UvRfnE
	QdJTiUAH8PcUwMwphFZZ+Zx4esPK7wSsCOsXEmY6vb3fBFIawwL6gKS1gzyLk4BnT9InGAA5RKhgE
	hpdYgYulxxujNhtUNPYMH+DtuQ3xIATsSZ8cVkKBpSRdaa5v3Ix2KXzZpA2HPPOMxcdH5zXWqbwTO
	qND25dp2yhJFZZs3n5oFHlLtXcHBJL97Z5HpL3VdXMNlfey5odkrm8wdF5y6FVzqtGfYUZx0ouFlj
	3YVjah64dvliQT+A0uYGI7xH5B7UDPOctiG/S+aU9qmu4GeZ55CdrKp+fSV3/YiKRQLve6st7XW7u
	NWVaXsahQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghw63-0006qQ-4a; Fri, 11 Jan 2019 12:39:35 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghw5y-0006pK-3a
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D/NfYiAP7tuTDrJC/6QMQEqWJDLLQHwMQdWAk2dYgnE=; b=iKSePolpHb2ceciufTWQ05pEe
 myZymPxBk+i7dMsmq/+qf0vZ+Ifm9jH/bTI4b8ZljB58HQWrgQ0nfSrc+9KyMtcwST9DN3GJNSgEr
 cLQHS1SK6hflB3bskcgSi/fI/qLau8QQQHkTcqfJrmeUN70KOV/v+H9EViAHt7upoJ5r4=;
Received: from 94.197.121.207.threembb.co.uk ([94.197.121.207]
 helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ghw5j-0008Fy-88; Fri, 11 Jan 2019 12:39:15 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id D3E8F440082; Fri, 11 Jan 2019 12:39:13 +0000 (GMT)
Date: Fri, 11 Jan 2019 12:39:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Message-ID: <20190111123913.GA2804@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
MIME-Version: 1.0
In-Reply-To: <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_043930_458050_2844627F 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: len.brown@intel.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, pavel@ucw.cz,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0935192176051191898=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0935192176051191898==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 10:24:26AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 09.01.2019 18:57, Mark Brown wrote:

> > regulator state which feels fragile.  But based on the cover letter
> > that's kind of like what the initial proposal about target states was so
> > perhaps this is the way we end up going...=20

> Are you talking about [1] ?

I can't follow that link right now, I'm working offline.

> I can get rid of this patch, take advantage of [3] and [4] and introduce
> also the regulator standby states. In this case, no matter the mapping b/w
> Linux power saving modes and AT91 SoC's power saving modes, we will be
> covered on misconfiguration (at least on SAMA5D2 Xplained board).

> And in patch 3/3 I could get rid of regulator checks and rely on DT (bad
> thing would be that in case of no input for regulator's state in
> mem/standby the board could not properly suspended/resumed), if any.

> What do you think about this?

Like I say I'm working offline so I can't check the links but it sounds
like you're saying that the existing suspend mode configuration features
are enough for your systems?  If so that's great - certainly what you're
saying above sounds sensible to me but it's possible I misunderstood
something based on not having the links.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw4jm4ACgkQJNaLcl1U
h9Ccswf+NULiFYb7x7jPouVeC7CIJLiKxHhaBH5KaCJsAITd15esv74wkfRHqf+A
sI52Sg6uJA4Cxt68zZz9EAMslHECb1wdMcgLfj1C1GKP0mjiF2IQmbG0jlAwbjLX
gt69eODFF9sWJs7FyCQsH605yavOv1jVYEPblgT9efgmJYZEm2FkVLDwUrGbI9rU
ARsLuXTfJ0t0RWOvYr/H81P76EJgE95+x0tD9KygwNWENzx/u5nRBpZJmSbB9x3h
C8HkW3ftkWZWU2KmgySOw0t+k7UM6/H8WmA0sUi/gHEocPtqIgPiu6BMOVqNwLuA
Yf+vPlQk2zChUP2bfLqcxwdtmXCkfg==
=uQKs
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


--===============0935192176051191898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0935192176051191898==--

