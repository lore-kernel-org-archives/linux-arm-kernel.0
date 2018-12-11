Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D940C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:06:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9E020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hzJIK0Tk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kz1a0G0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9E020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HFiULWCO5Aun6ByYVpot839yLQ44lr4HwSRCZCbsaaM=; b=hzJIK0Tkw5QSrQ9VAtpuVrl56
	aYrFpd+1wGO6fuouCNeWuWAE0I2a2ziHqPFmOjqnlRVZ5QapAF/l4wUQdqfwK6+/Pk0R4Q7A+fkKI
	jEQNCl2jV7GkIwD3Daftx+uZeOXz4YOWYpU2DkzPO5ovzy0m5cyoWqCbV5DEibUWVzJkb1LpwTHTR
	BKLSDmABTsL9Ts457iVZSXQq1/IbjXnYd6iCQIzs3chi5d0Xx12bGQFS5Zmc/dDb+9qFGG5g9gslH
	X3a0FWjm0kD6SpbewsnnRqExI1El/+RdZHzW1UZynRijpq5CvhB36xuu+Ps6R75aXA/si4W0sBSA4
	Ts5q2EaQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqAq-00088L-2P; Tue, 11 Dec 2018 22:06:40 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqAm-00087s-Q7
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 22:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1a5LI433qsniaJpxptBQzNkDdDlyUwQqgrCDn64a2cg=; b=kz1a0G0aS4wx7eoG6EdVxTJcF
 RSvPEETn96WASQltJzCBkelQGfHH2YmT6DfAs7xmnFdykze1cFIrdXUzX5JZkDr/ykEPMKyIHilS7
 XtSL17ZqR7OyiIWRLEEfL54LylwelkVjP1uZWM7QO8D+FwW4dwEWEnLXHT1WCz7U5Lz+8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWqAX-0001kk-3I; Tue, 11 Dec 2018 22:06:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 81847112540E; Tue, 11 Dec 2018 22:06:20 +0000 (GMT)
Date: Tue, 11 Dec 2018 22:06:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Daniel Scheller <d.scheller@gmx.net>
Subject: Re: next-20181211 build: 1 failures 32 warnings (next-20181211)
Message-ID: <20181211220620.GS6686@sirena.org.uk>
References: <E1gWnrV-00086U-3m@optimist>
MIME-Version: 1.0
In-Reply-To: <E1gWnrV-00086U-3m@optimist>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_140637_003655_90C4C754 
X-CRM114-Status: UNSURE (   7.81  )
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
 Russell King <linux@armlinux.org.uk>, linux-next@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============5161394574824488240=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5161394574824488240==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="daC8KDjlMyCcZyAo"
Content-Disposition: inline


--daC8KDjlMyCcZyAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 07:38:33PM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig due to:

> 	arm-allmodconfig
> ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'
> ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'
> ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'
> ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'

in ddbridge-ci.c and some other media files.  This is because
ddbridge.h includes asm/irq.h but that does not directly include headers
which define the above types and it appears some header changes have
removed an implicit inclusion of those.  Moving the asm includes after
the linux ones in ddbridge.h fixes this though this appears to be
against the coding style for media.

--daC8KDjlMyCcZyAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwQNNsACgkQJNaLcl1U
h9BIhAf/QxLriJgoTE64TXKs4ezWsRnAcKuzXFd4w9zMxqvclE6DzD4fm+SWAq5G
tt93m2jwK8z2TPI1CswtNqTJJB0x3gEwoj9LRnxA0z8W+1PuzS9urBgkxDUdJWQN
9/1v3c0sTzCgBKHcALmQTZdOEQroYfo6YLRDqmWY6W2sPciAlHOBtZePsScCYJZs
dc7bQQiC7G+9WhYqAB6AVjDT/gJy/X9Qz02BkKswOrmmi75r2eICVkYH64QZiCni
hTSMu7ucS8EDBWUE5Mqma9Hpv5Uii35Ts8r15V0mtj3XopczqDrIikauAC0jcCFu
ju9LRTsWKyf8vQU1Lae9yH0afyzBVA==
=kNcS
-----END PGP SIGNATURE-----

--daC8KDjlMyCcZyAo--


--===============5161394574824488240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5161394574824488240==--

