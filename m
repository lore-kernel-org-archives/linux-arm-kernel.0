Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19882C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:28:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D657820870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VoQf1aI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D657820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QZaCgCYePELIR7V/v8VmQzDceS8gPfM7qYPySKrT+I0=; b=VoQf1aI2eEU+JFc5XPl8sKjx1
	A5oFxRLotN0+oplbLWuGPXZCxzYlM7HV92vl3p2V9ITo5CghR+8+rM9MpH96D+Tv+1uaQoZRgjhXR
	JBjJWKgaTi0Ibo3bGaysb7zRPrNUtOgnakJEkd+eDk0dZDnZhLAWrEaoQDWO6NngqEL330uyL1imu
	NxXTKa+GJA+KX741vSBVHdjhxCszLC9NDfhKBuwFhaW1p5F8tDpdbDKLVbiyZSsNUyHt4jGiGPWzD
	+drxBKENS8GIUpa99FuWI0i0nhxne4CdvyGLGKamS8bGYUk5BYu2MK/crVohrGRKlK4/Z4iqUnOoC
	m1iEc7A9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDu3-0001ZG-NZ; Wed, 23 Jan 2019 08:28:55 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDtz-0001Yy-Qq
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:28:53 +0000
Received: from localhost (p54B3320B.dip0.t-ipconnect.de [84.179.50.11])
 by pokefinder.org (Postfix) with ESMTPSA id 5B2F72C54BC;
 Wed, 23 Jan 2019 09:28:50 +0100 (CET)
Date: Wed, 23 Jan 2019 09:28:49 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] i2c: imx: fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20190123082849.GA1129@kunai>
References: <20190123003741.GA12068@embeddedor>
MIME-Version: 1.0
In-Reply-To: <20190123003741.GA12068@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_002852_016872_B515559F 
X-CRM114-Status: UNSURE (   8.75  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============2007268471723374176=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2007268471723374176==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 06:37:41PM -0600, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in i2c_imx_dma_request.
>=20
> The proper pointer to be passed as argument is dma->chan_tx.
>=20
> This bug was detected with the help of Coccinelle.
>=20
> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_d=
ma_request")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I pushed a similar fix to linux-next yesterday.


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxIJcEACgkQFA3kzBSg
KbbPdA/+LdO8wwH7iCh/9IZ4wC1rMppcRk1eXJf3wcUgYi0wCrAF/yiFO4GAvHXN
1OH0daG1Q22hapc6B7aRfWtkpi6zf1b1w6/L/EFYi/2ykgV2TVqIKNiEhyvHLgBR
sVOTYtYVZe4j3afB49nMcf7S3oSBPob7K+l59vmCXS1uNNhPbV4wlI3r7J6Rkw1Z
37DKkPH3JvRLA07FjqlyM7D8NkRcQxchwQDmshVRaJ4RoMZ5QsonzZXTk1LWSDn/
nZul0iV0G2PvgvU+GBTWdwLLBnq4b2W2S8ITtr52msthPuAt0AkotbCOc0EF2dLV
zR/wbjpo6EwN9ImcyboL5/ybWW3swHmCxXLsqLw05lvSfYlIRg1kkrYOwMRvD/59
KS9YbJeD5z8BDfVYXwGFCoDIIs44RrK9npBFmyn/aV2nI1TBXRtQbYxdyuHsEdKL
GwBtjVityTWZYMIeT9RLQ8+4p6UvSx1Tsi9SgBojgpD2NER4Jcr5jFTJ4bBjgor5
IV01oH4uaRhMk3sxeVtreNuZEHFxK2o/XU0YyUb78ov3sNA2L7APDYFkOjysVV8P
ITFv6eniEogVQ+nuWJtcc5LFOOqloxSQXsQiZNodIYSHtOXmZHoCTWi3wEIEoBek
DnZyF2MF4VSbxwAGCvQe40GFgNKBLcH8vj6x6gVYbR+g6RT3wp0=
=hJl/
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


--===============2007268471723374176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2007268471723374176==--

