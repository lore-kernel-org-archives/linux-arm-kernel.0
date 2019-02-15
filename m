Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06339C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:53:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07FD204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HW8/c6YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07FD204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VYrZFdDJrof9W0qRcSgDo6fvYqJLx/s6rndPnqTG6ao=; b=HW8/c6YK+omZxRlsc+kL2+vUJ
	5IPTacamScvQzYeb+V0XKxWI4Mr3yxqD0j86HQIm+WM60ym6pd1Sdua6XOH0vi+bBLzypDbl8AKNM
	DVah23rRRrcs4sW+WwatOu8geB74dL1HuxvHzSfMQhzIpo0K6B01GT+fJdCiuWhv3lvwh/e0pQf+V
	hMOjop2+tp46vPAdmVbE767+W7p+Vi76jrbU8f7yNd1erXViVOBzde36epZL4Ucf5ZMu+nnZAt6AM
	bxdm+nqTqb5jSjocIseSkk2YU2OheAPxRlFEw1xL9SmtIx0Nke2L8XsY9T7e27AiD+z9ohgJccNGS
	gxNlUGjAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZEi-0006Rp-89; Fri, 15 Feb 2019 08:52:44 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZEe-0006RV-GI
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:52:41 +0000
Received: from localhost (unknown [83.221.228.209])
 by pokefinder.org (Postfix) with ESMTPSA id AF80A2E3551;
 Fri, 15 Feb 2019 09:52:39 +0100 (CET)
Date: Fri, 15 Feb 2019 09:52:39 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH v2] i2c: aspeed: Add multi-master use case support
Message-ID: <20190215085239.v5cjmcef2q62xiyl@ninjato>
References: <20190211185444.4965-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190211185444.4965-1-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_005240_690297_4F7BDF5E 
X-CRM114-Status: GOOD (  10.57  )
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
Content-Type: multipart/mixed; boundary="===============1048174329060260669=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1048174329060260669==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ybsnxjjqnbgxua7z"
Content-Disposition: inline


--ybsnxjjqnbgxua7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:54:44AM -0800, Jae Hyun Yoo wrote:
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
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks!


--ybsnxjjqnbgxua7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmfdcACgkQFA3kzBSg
KbYJEw//dnf7zJDVpII7ZpsgPtNZerCcz/+RipuuRefqyn6ol/03zMNMDsTsqWTZ
WB9tWi0dBE0uC50iOyLKS0M9I5b1xVqKasEl2Z/r8J9IvGuakbIfGfhiYJ9oJgdH
zJBxkc5W2Or1FJ9AUIxpKWeaUSeE6J2/wv5168RfjLQAb+Sr9jVCrCon1ZsTo/7B
9lBwoYMAXTonbf615WTcU+fnRHDyIbjboL0OB1W2Iv8ksmTPvETviuqfSk4PyiSJ
RLcQUWrw44sUu9sSUzQNZ97g6l20R/LnFtXdQYIDrXNTmP+tXlAfxqdt6ghVumwa
toW9MZX/JkYc0xrBIOQPpEL61yqLyoQdChhv9ahUAKUiKTIkz0Io9S5PobOMvIbd
sGyJ+abYVA9Qvg8CH+ZKQGZwm/SgIGfKtkIgbh+3Q6ATChB5dDfytJw4N2OoVu0T
5DgPrkmpIaVF9JTOnhvzQZYswpBZuDk11yC2Tea2s9Djp1fN3ettw+uYLbcnLmo1
GNLWOtLTkT0gr/krY8xy006jaMOa4tjlLLKlB9AzUNB4APidP2UDKE68wrxlo7SD
+5nQ+CZn9CJUBdXR5hQeDrzpoTdRBgNlUPUaB0TOK3Sbz962vu1I4019xG1ITLwf
OEUWzonl3lABGqbew7I3lyn5Py9nEcWVfW+6Ks74i5vvRBcIAOQ=
=dfmE
-----END PGP SIGNATURE-----

--ybsnxjjqnbgxua7z--


--===============1048174329060260669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1048174329060260669==--

