Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C76C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:48:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6544721908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXorB7YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6544721908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cuCekHNkF3nHs2ffeId4/hu2lW2BQRIQLUp8GY7iEyU=; b=kXorB7YBjSOxlODhzCCdhG1g8
	bUY/WElltEeroIkgdLPWK6jpBIz2crTO+5bj0UbSjwl0Kw62/LsnFNnE6wYe3Z0jqmdHmL0XJ/hhZ
	rBabdBWtQsd1QoQOViD5Up0DVYfZL464UctOL+fEQY43H5aKaXj6zz83PUcd0zSjuZvyO0w+HoxO6
	OVC7Hoq5gxRNkSXZCfoC78E+PJfeWUgW8SqX7Z49N8PccU4IQTanPRU3MAr3yr+/1r9dyvbUXW+YQ
	yYWKRdApbSsHsQob/9oxF/I31ijOfqUynidrl+YlbjWf4T40lpfpSD6qoB5JXJQ9peEVYyFdVsJ3K
	yrTCFco4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsE13-0006MH-K7; Fri, 08 Feb 2019 21:48:57 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsE0z-0006L7-RW
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 21:48:56 +0000
Received: from localhost (p54B331AB.dip0.t-ipconnect.de [84.179.49.171])
 by pokefinder.org (Postfix) with ESMTPSA id 3DB5B2C282F;
 Fri,  8 Feb 2019 22:48:50 +0100 (CET)
Date: Fri, 8 Feb 2019 22:48:49 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Add multi-master use case support
Message-ID: <20190208214849.GH12451@kunai>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_134854_038246_0281F883 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6543578638201901127=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6543578638201901127==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 11:39:58AM -0800, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
>=20
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Hmmm, the #ifdeffery quite increases with this patch. Maybe it is easier
to select I2C_SLAVE in Kconfig? I'll let you decide.

My code checkers found this:

    CPPCHECK
drivers/i2c/busses/i2c-aspeed.c:694:10: warning: Variable 'ret' is assigned=
 a value that is never used. [unreadVariable]


--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxd+T0ACgkQFA3kzBSg
KbYPvg/8CQ+tXkRGz8HmQGO9FCYbOYEFSlIz26yIOPrldRkZGuG+Kb+Fp+ges97e
hx0VXsi7KmaQZwQl3GI9sttzjbINY11XCpERgpEdPumbQD/q2aEeyl1n7HlJ3la+
Dpl5mzTO4Hma/PACdNoYY2PTYBrDz7GfrfiT5seRGr18Uc6LGlNMKGJnbPYrT5J8
ZZthhAmN0EB2HCSQ0KF4OGZX6QUV1TjX2mka0qvP/TzL0RwhVE/xhLXNGf6TUcBp
M7P7Was7AzUFETJdpELqSbL79tQH/2/1b2dGcG0ZRIXfo8DC4zekSlG5tprkA678
uh8INIeg1nPxjj2S4aoOvR28XuUnOhWD/idAWu2ZwzcPj1ntZy0NZqQAbJ3+FZAu
D9v7G8KZRbtMf6CGyBhZ2sVikTDwUkfErafXImXI0OesiBpB2c3m3ETS25bhiiHc
yOMKWLauSuyYf4sKqTcHobJtd1MV4kSn37opY/ugvknEEsqAJT6Z2uGNF5/LXgDO
ckyWHgFVkIZsDPkgeg+sCJZo+cLzaOMnPdUtNm0t+K7T4DaUL+tZxo+n3Hm8Qwvq
zgdgFxQCtk2Cq8flR9F9TD/AkCxFllMEUzDSavqm7ndxscaONWLvEddf6qxFrZT6
K8fymQrltfxpKmGc8r7LRnlhI728qamrLx/MKr/w96ByuPsdUgA=
=6dhw
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--


--===============6543578638201901127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6543578638201901127==--

