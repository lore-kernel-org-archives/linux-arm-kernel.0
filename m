Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91DC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30698218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VyIrUgpm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="evinLO5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30698218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ei9VpV3wppPfiMhBWdOhjTmzOMNsT8e7g6I9Q/Oe57c=; b=VyIrUgpm5ltVgokxdwE2glcqp
	C15CxKPIEnWDunHdNx6CWRixgZOq0gJ1JYmjfNRyrL9ddt7dcqc6cRGL6S3SxIVJrPBLeMu2ORHeS
	aCZFELBwkN8rMMK83Tr7f/A7jaDJidoOQyiLCNpxTBZX+iMc2xBLAuW3DKQQzyMtlDaQaTyrV5WHv
	LX9t1VDwBRO2EEf6cEtntMl9EQZRZaLXEa0bvBFwEgNPfegxisbv3mf1mM9n/llDrYPDELfodpAMK
	Lk/LD1ffKlxtXc3+o0ej12Szanayu94SjLeNtYsH9n2GlQaPW2k1YcRyM4juYJh//qDSVD9fs2ow5
	Ovpx5hRqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gordM-0006Po-DM; Wed, 30 Jan 2019 15:18:36 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gordI-0006PA-Pp; Wed, 30 Jan 2019 15:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gxnR5oWhLd3lQKrlIvE02j5DEvzUXaEu7fAA/lsg4RU=; b=evinLO5P8nPTc9zTahKm3579t
 M4stWoa2c9dkviTq+De8brSVDi9kXAydD0jpzLBDkRdNelg3m2SR8OilKZPYeHpc+IDIQEQ7fhXSj
 iQDXGij6eDgxf6KUjl9Ql+fGFd5vo9wnVXZhxOYj3DaiNNek0jqaYecMBo6uxBLb3pPcc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gordC-0006OH-5B; Wed, 30 Jan 2019 15:18:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 9A2E61127D43; Wed, 30 Jan 2019 15:18:25 +0000 (GMT)
Date: Wed, 30 Jan 2019 15:18:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH 5/6] regulator: mt6358: Add support for MT6358 regulator
Message-ID: <20190130151825.GA10665@sirena.org.uk>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-6-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1548839891-20932-6-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_071832_982802_9C072E0E 
X-CRM114-Status: UNSURE (   9.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4738306183067756951=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4738306183067756951==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 30, 2019 at 05:18:10PM +0800, Hsin-Hsiung Wang wrote:

> +static const struct of_device_id mt6358_of_match[] = {
> +	{ .compatible = "mediatek,mt6358-regulator", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mt6358_of_match);

There should be no need for a separate compatbile string here - we
aren't describing the hardware any more than we already did with the
parent node for the MFD, we're describing how Linux currently splits the
software that controls the hardware up.  Just have the MFD instantiate
the regulator driver when it probes.

Otherwise this driver looks very good and clean.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxRwEAACgkQJNaLcl1U
h9Aikgf/Y+gvwbaHHnHQ0m8MNdKRqSYNJudae95ToA35RJTxhcN+utenn65RCAbl
wMdcbp2yfyGBbfGu8AMOG9P+9aF+IIaigPFsLWqo7PMhIz7GwoVW0lqo7viKIXv8
EZe5yLTk9famVTksAOQaDpd3KymoSU5r5keiK+4StsPw3+uc4xAgmOnNrRHBQyCD
1Sjy8egYfQHEKtP0anNEoIqVN6nKGk+cpdXyuTum32aE5P7cUuQrX5sVBVQ+jNlw
kKxIa8Pesrr3VJivGgtrcwIC3UIXEbOPS2MjBKe/qplqeuxqkdfz+3k5DfygC/5T
k0gmxZsGWBc4PlqPX9Q0MLTKsT8h4A==
=iJPx
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


--===============4738306183067756951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4738306183067756951==--

