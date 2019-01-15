Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C881BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:47:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92165214AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xq6sGFOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92165214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+i6ISzOsC3DeFp7lj/G328VNcfuYZoWGJjyhr5ntyOE=; b=Xq6sGFOPfntlS6d9iGweik0T7
	9AY4KewN9Hz+VzrwB7DzlY+z0GmUYDyeExomCtwYKHK75y4IZBZc13vAwpZAvpMKWvID4Hm8ILxb0
	TdACugawFtpa7AX10Unpi0f8TDs9GeHF8OZSlGdjz2pSZeSfEbz9lYjGnPFM++5gGE458lwJ1xsC/
	y5Aarw3HwhkpRqTGlO2bs2CBSPxmB+E47d1DRm2Qfuhbuh+YpfzQ5HKRDBu5HdhlHK89C5Zdd86ew
	CmKNMlEiDZS5+w+FB+i2pTzC5ak+CpqgzI297xD4nAp2nzZgWEaam7ds/r2SiSNNhtY9YuQ4E3fdQ
	SEWzamBmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXUM-0006Hc-B5; Tue, 15 Jan 2019 22:47:18 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXUJ-0006HD-1O
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 22:47:16 +0000
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
 by pokefinder.org (Postfix) with ESMTPSA id 129512C9D2D;
 Tue, 15 Jan 2019 23:47:14 +0100 (CET)
Date: Tue, 15 Jan 2019 23:47:13 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c-next v9 0/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
Message-ID: <20190115224713.duoha332mjlrmwji@ninjato>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_144715_229897_C840C39E 
X-CRM114-Status: GOOD (  12.58  )
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
 linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============8231274973844659825=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8231274973844659825==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xwuf2wduqyb2yvvn"
Content-Disposition: inline


--xwuf2wduqyb2yvvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 02:09:11PM -0700, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so a
> case can be happened that this master tries to send data through
> the master_xfer function but slave data from peer master is still
> being processed by this driver. To prevent state corruption in the
> case, this patch adds checking code if any slave operation is
> ongoing and it waits up to the bus timeout duration before starting
> a master_xfer operation.
>=20
> To support this change, it introduces changes on i2c-core-base to
> make that able to read the bus timeout and master transfer retries
> count values from device tree properties.
>=20
> Please review this patch set.

Marking this as "Changes requested". I think if the mutex approach
works, these patches become obsolete then.


--xwuf2wduqyb2yvvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+YvEACgkQFA3kzBSg
Kbb02Q/9G2qC89KWcdgTbnn6LJRKpfD/+wioyzPtJdq3Vy0UHGJJZ0DvcZbLBkbt
Mc5ToZFckDRdznQCBm4vZG6r+9HqKRK58i+EJXzg/iomWYTWi+WScUb0uo5PNpy3
UX5ZxtOkw0JBpBPRtjxp3pH88/KGv/9ROOUbpToh1BzF2ZLWEjAf0BFK0snNbdEZ
A2BNFIntvm14mk5TskacVvbJS/61W8LDoZSU/PTTp3XpaQVq+GYvPw23Dw/h+L0U
xNCa2WEHly8p79Ol4cSzb5U7Y+SEVmaSSGx1y/mRkcxh4vEywzlxVOg01OueAv+S
ZrdtWSruFEaZ5MzJgA7zSpX4Ox6xzw5grLF7AxiJ3cNnBSQEithH5qm9+9PxvjeB
wrKrtz37ZqyeYeNOxT1gZIBXPvx/PTanD7X87quyks1rbIlsSimUEqllpgqZlJrP
5pxdzpuJcgdRnx+WPJme5V4M+uLvoi79kJMIYKaabCDC9HG1EiFHw2HQn9K32UUp
kj9myrPOF7rUfZZTGrUHyGBy9/EHnU9Wl3QaUSTN1Q0Moo+QE/0sqeK4MsAYnoBO
JxebYGo8XO++FtvFHI3BlhQ8/yVQ3HsxISMtiwr1TsJDY7LNKA+fKJCMIAyBI99T
jQ8aRWsMrbnFdYxXApxkmkVwHgCFRARZ0ushrdIT/RWr87yXiUI=
=krzm
-----END PGP SIGNATURE-----

--xwuf2wduqyb2yvvn--


--===============8231274973844659825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8231274973844659825==--

