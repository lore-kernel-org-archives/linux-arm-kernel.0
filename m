Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA750C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9102084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KDbSHRFJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NIhEaiFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9102084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ULRgnpS6XR+Wcs8Hk3RpTUT5d1T5mKDq9LBxK1FvS0w=; b=KDbSHRFJpWcSoa4+jBm5xMJro
	+jwlkAZOG/VcSyPZ+Yf4m9CmOaj5aUmLqGczoQ0gpEDZFVV2aUmW/081q9WbnHqP3n4OhHR4XRtF1
	rPPL+3UHnKFcClkA/XtGy7Nt6ZXZb9ug/d2heUlLbtKyu9Jta1Rq3NBSMjuF3DfqKJNzvERAoAxkQ
	svR7tHSrKxDYmg/XXWpvSDM825SGVbd9E0BFCpwbiGG9w6068ca4VB0U0cm+4p89iNG2xWWYOvoNn
	jDwPXGLyEs0fxso2ymBXOjKy9jnm+r4KksRKRd9GKSm7TSgn++ItuXUhH3k6Fhkdt1bVYbcndN0te
	zvMCL61WA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWWdM-0004j0-6p; Tue, 11 Dec 2018 01:14:48 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWWdI-0004i4-TB
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 01:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nZLKOzrwvaeHexrG8HoWOUhuIMjdVHR9eZk5SLivDFA=; b=NIhEaiFmx5baSejNZs0Ylufl/
 j6b0gkE2uo6bijNROzv5hZt86SKM6gmL5PoIeQ0UWOuddnNDrIkgb8YtTt/DgJPtoVpTJuWWc6xte
 N6XUII+r9WemcJ8dubrPlJjDKN6BhOpcRhwLM1lzoTLAUe30/vQ76l9hrQUN3d1T2LVoQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWWd3-0000Jz-6o; Tue, 11 Dec 2018 01:14:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id A92F911254C7; Tue, 11 Dec 2018 01:14:28 +0000 (GMT)
Date: Tue, 11 Dec 2018 01:14:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Message-ID: <20181211011428.GH3004@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
X-Cookie: Now I am depressed ...
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_171445_094954_ECD34842 
X-CRM114-Status: UNSURE (   9.62  )
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
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5264927719322542878=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5264927719322542878==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:52:41PM +0100, Uwe Kleine-K=F6nig wrote:

> In my eyes this series is ready to go in. The feedback I got so far was
> only that there could be done still more. And given that patch 2 is a
> fix I'd like to see this in 4.21.

It looked like there was an unanswered question about if patch 2 was
needed or not?  Marek?

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPD3MACgkQJNaLcl1U
h9AoxQf+LAD4Pl6CalbY2GtA8alHYRlKMnsKRqnBlErXW8A5weLHG8rrdQIgE32C
ZSLn0bw5p1za+knDvnPWKLNKDIRfEajbYLGzkXmKW4puG9N2Q3tzIXOa6lh0vBkB
U5LisSa152c+q9O/6cHQthLRUkj/gvifJbZl8Dio0iD6dnGWwnujV/AHyNKTbvP0
d7SG3Qhe7osp92wKVM5RhOdOrMm1p69vM26ph8mj8DXS8/py9LDD7wUbGhaggvp8
OpUMV2/7LWmO4mdYmCqTYuIAJgo69GPatHcDKkjA8mGgqqS5ibvPqWHkF306/uGt
1wFf3AjpjX6J1QjJ1/L+A/KGICSEdw==
=kIjU
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--


--===============5264927719322542878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5264927719322542878==--

