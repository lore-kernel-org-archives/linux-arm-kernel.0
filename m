Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F35C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:50:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674A920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ljHGESNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674A920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VsGqSy48ekd5+weQMWvM5vdor41jFon3Z0V8CZAmA54=; b=ljHGESNodZu47NsAiRWAG9t1W
	f0W9TJtmIrEZTLpnPh88Jiwc8aOJovGB39m6Q99xqiyqJo9fD2fPlARTvHwGlQfxMpVgdJyv+F4un
	HLTsggLs8ZriK5Lnlq8VwxsSP3YmDvUExLsfStYNDEQRj+NJCa0gfgtcyQiX3JVIl93V6FwiaxrXd
	aueXSGjU2mWZbkkDSdBpmu0vgtiKul98/Va/WLf/pLNsS/ltwpAEI8+NMMT46/olssTrLc2BcjO0N
	luQUv4SIatkcUAYnFDk1ArTNFj+JWdfC08rsfhTjomPTWQboXugVPO6QilescXHakLeP+iE3z1h5Q
	OvkxODPDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm4s1-0003SM-8a; Tue, 22 Jan 2019 22:50:13 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm4rw-0002Er-3d
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 22:50:10 +0000
Received: from localhost (p54B333AA.dip0.t-ipconnect.de [84.179.51.170])
 by pokefinder.org (Postfix) with ESMTPSA id E800B2C78FF;
 Tue, 22 Jan 2019 23:50:01 +0100 (CET)
Date: Tue, 22 Jan 2019 23:49:58 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Message-ID: <20190122224958.fhui4wsbxkwlyq3v@ninjato>
References: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_145008_304437_56DA164F 
X-CRM114-Status: UNSURE (   6.88  )
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
Cc: eha@deif.com, s.hauer@pengutronix.de, kernel-janitors@vger.kernel.org,
 linux@rempel-privat.de, linux-i2c@vger.kernel.org,
 wsa+renesas@sang-engineering.com, linux-imx@nxp.com, kernel@pengutronix.de,
 u.kleine-koenig@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 peda@axentia.se, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: multipart/mixed; boundary="===============2945236924282958945=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2945236924282958945==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vaiyalpw7x7el7e5"
Content-Disposition: inline


--vaiyalpw7x7el7e5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 03:14:54AM +0000, YueHaibing wrote:
> Change the call to PTR_ERR to access the value just tested by IS_ERR.
>=20
> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_d=
ma_request")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to for-next, thanks!


--vaiyalpw7x7el7e5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHnhIACgkQFA3kzBSg
Kba3ig//USjhYGdbn997HGFCPU0owSFvWUiISdShBXFggJlrezFhcdHVv9YuunYJ
lB+DGLl/khc+mqy6I0F5nlWClgsoOgdx3OUVjLZYSN7D9MYtSSAsJjhbvXzYpXxV
xd8aIIpl5VVqZgUxH1O9yFiBfGXRLRsb5xrcN4gdcqk+f52+LLgrmaXmXWIX/6mB
KIHVJdH0Ux0xyRvFNuVZphWLbEu27GYg/g54nEDaa4wN3h7nngjdXVXUSMQ0aNUQ
OcNZC9KJl0gCo5GZUciJlWa+Hvw2GYXa+7Q2tmC+4d2rIEnwStkeB6IbX+XOgGTR
rtmQK5RpzeUFoIrN359t4rxMPbJhUAeOIqtr2XhNR8Y9SoaxP3qZEjO+DhneeTiC
A6pg4uIiyDS56Yz3hHX9P7jHxlox3d8C8hylu83ZYoUS2tSmQzfeHB6XT9HEtS6S
K9kQ/jbvBrjn8wMnYEQwXdas2BTBX56i4k4odVbyFjOzeC66msJjP9p6rJe45H94
y75RdycNL+rs2bmAzSXUsWpHnwJ9v5/rcII7lEffJpz83BqQKYZbk39p4BM5u/q7
Gn48ttNYe4gIb929l7kY1PRB0J8YJhfjbc/EdQjtTQiIzWOj8PGjK3P5pDoZPUfS
lO5Iuzg8ksPCLtAsGa6YeAO3RzGJNd8gBxs54DOnOYb4+xodJCQ=
=UEXE
-----END PGP SIGNATURE-----

--vaiyalpw7x7el7e5--


--===============2945236924282958945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2945236924282958945==--

