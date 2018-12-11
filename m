Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE91C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BA020811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ASOFh3+I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MQ53xJQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BA020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vst2JV233xc650neD6Q4fe9wjdYCDC4I30SO45YWgFo=; b=ASOFh3+I9Z7C1RQFy0S5sjdtL
	jZI/lY7PzfQM7QRceXEI7uyWyhBp7A4q52ogrjsA7LVdNvwt4tgKRvjLsUrgNNUnwU4Ef8QUQzeCW
	MjwFpZQTqwRtHKJBGdUqCJJ4VOAVLy+mJn5N7g/TTJaZ/b1QPII0U43IkcidoatYlgbAphGhWAKGw
	ltjVjOZFwIkwoNA+T4FuYMPlyO5BZdTlOeE5YhFRVtnNHDsh28k2HQaJGDYehgwgjcPWzxyK3vg75
	IxYN+qpWrNdTdUOQku1YlbMPkzS9KFZGrm5l3DBTKozaBXcpIH0Xzq1uvqwl6S4T+cChffZH8w2LV
	Y9yf5LHmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWgeG-0006JK-DK; Tue, 11 Dec 2018 11:56:24 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWge8-0006GW-LW
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 11:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YWRSg4yTXWadcO4EAMVM142R2J3Ai55hF3y+pazCfvc=; b=MQ53xJQ9hQrtiojQvwSqGvyAG
 LayLBr/d/S0KrTr13lQJJca1PiwaamH4F/vI4NUDE0FnCvhML/iHfyduHXQFTkVn44FENHQU+55ll
 DKciJDYhA5mhC8j9UzSYy9XV7dokSdbfrfTRvmHx58w9uW+DQMyykOcGY5H3V0Hesb/Ao=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWgdu-0000zT-8j; Tue, 11 Dec 2018 11:56:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id B7FD2112540C; Tue, 11 Dec 2018 11:56:01 +0000 (GMT)
Date: Tue, 11 Dec 2018 11:56:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Message-ID: <20181211115601.GB6686@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
 <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_035616_860374_96FD121A 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7694963425899343601=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7694963425899343601==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:13:00AM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Dec 11, 2018 at 01:14:28AM +0000, Mark Brown wrote:

> > It looked like there was an unanswered question about if patch 2 was
> > needed or not?  Marek?

> I cannot find an unanswered question. There is a workaround that Marek
> introduced in 6fd8b8503a0dcf66510314dc054745087ae89f94 that might not be
> needed any more with my patch 2. So it's the other way round: If Marek's
> problem is fixed by patch 2, my patch is the better one. I have problems
> with SCK changing polarity when CS is already asserted in the presence
> of Marek's change. After my change they are gone. Even if this
> workaround is superflous now, it doesn't hurt and IMHO the question if
> it is needed or not should not delay my fix.

That was the unanswered question.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPpdAACgkQJNaLcl1U
h9AW2wf/epfY5+fNfX7inQ4diih/d8xpOviNzpNb71+mgdpdynVe0TmXF6Lcn3me
sw4EI2zIxKds7J1Of2r3US7XO3J9kt+DqJ3uT5tlvUuFJVqk/MnMfVbZWG2OeccX
MRm5Ovg+0tE00wmHNiP6lNWJuMK9VBGyjkznwzjttaKqzfGOCqIGR5+paFD0JX20
Z1ikU9kgdFdk8E/K1WzAvy9okixqJke4BsPzAKwT5qWDuF2H6+TeTMdOA/LDds8r
PyshDXwDDtfL2clIW3z0lvkGJXCsHOHESW+2/2/N+5OGWm89JdNR0gO1Buvw3H/U
scoD/2+21EZQoYwFyAxDmfPYEFiR8Q==
=cae1
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--


--===============7694963425899343601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7694963425899343601==--

