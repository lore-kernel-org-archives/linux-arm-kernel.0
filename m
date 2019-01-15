Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9403C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83B720866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tPGQQAOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83B720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LsCBNPxxU+Ask9jzsjj8VZw9A72y1sp9rh5mxxnmCwE=; b=tPGQQAOFPwuAyG4yLAiCfxs4J
	vEI0eJ9/XMMu+LcEKwaKCJBEl/ZGwkRBNAxMDdBaUcaBdu7yiIZRoK5RgYl8PGADNSRJ4DxVJ6H01
	cKkZ+PpFyrSuT3nMtbowrJ12ltPmcQUEHwB6CIKKFeNsGlICtYDRPoo7CTbltKc31sI5hGDhgL2ig
	PXAV7Q5p7C6xB3R7QAzkYB2rF3VlRBkgmKcnYtQKHinpQ7UHtKDJEKQo1HG1nX3elySlOUUjZAo9w
	SP2650CaJPgdHp40Rjys2mOknK3z3eQ6ZLo/nE7dqXPh+zP1inV0SBQm2f2LzCvj2IuYMCk3ET4ci
	bueRB8sMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjWfz-00036f-HH; Tue, 15 Jan 2019 21:55:15 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjWfc-0002Gy-R1
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 21:54:54 +0000
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
 by pokefinder.org (Postfix) with ESMTPSA id AEE502CDC7B;
 Tue, 15 Jan 2019 22:54:49 +0100 (CET)
Date: Tue, 15 Jan 2019 22:54:49 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v5 2/2] i2c: imx: improve the error handling in
 i2c_imx_dma_request()
Message-ID: <20190115215449.vm7u5zyhtjzz2ovo@ninjato>
References: <20190109055650.32259-1-o.rempel@pengutronix.de>
 <20190109055650.32259-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20190109055650.32259-3-o.rempel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_135453_042992_8488F361 
X-CRM114-Status: UNSURE (   8.07  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
Content-Type: multipart/mixed; boundary="===============7496490799210449605=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7496490799210449605==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sutkt7n3bvq2ygo"
Content-Disposition: inline


--6sutkt7n3bvq2ygo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 06:56:50AM +0100, Oleksij Rempel wrote:
> Improve the error handling in i2c_imx_dma_request() and let it return an =
error
> indication that the caller then can handle accordingly.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-next, thanks!


--6sutkt7n3bvq2ygo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+VqkACgkQFA3kzBSg
KbbIxhAApWTw1dmnUjsQLwlxrSG2VHCnt2SaZO5TOp35uR2UuirlZm73z+B6oZEG
S8Q+Utcg8BfMiZiueeEvIXFp/Ovomq3e+DZKv8382sYyh+v1CwNVMXU580JKLllX
V6qEsaGTOc166N+Tz1v4mCnEewRptcegwvXjdjwo/iJugEiWj9N702KrORwOrCi+
jne0bBI6Ug8hEXo65VyBh5uCadhCS3C41FzuHRL0mnFKZFq9WcrU7XsucoYRLom+
/OKtOiYeM7RM2+dNYFW/ttSAWTdloIiahXBf4MzhX9558Gw4RZH8ScySxJJ5JXLg
z3RjDCF66GWoT/5TSWe8Rz7/F9FvmHZQDUyykXEHThKNjfSgNALsN1dy5popx53b
/HcGz6oA/8aXBHJi/41Bh+1js2sbFVef1Fug5g8evVMRve8d5DflkAiJiWmyu133
sgTvfQ4g6fWpwuYGl3J1XdYW3b8HZ9bIzuOJ3OmiKSCDk0Z6Ef1D01SLtJI27ETg
WNP8ajAakqkODm0XIUQjJDQxzrkYunT5MAQ8K/wBPAyiueFa9QCrk457IlNXKv+Q
/G2bVjNzp1jjbhw1HzunertH+u69MTFWcsbtfOFGqbvqRpKxbvjrF+aYC9ZjQGKS
o6thGb4Pk0KXdozWC0NBtCibhhGUFmXOyjWTbdY+Vx6jTDtaYss=
=Mw6t
-----END PGP SIGNATURE-----

--6sutkt7n3bvq2ygo--


--===============7496490799210449605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7496490799210449605==--

