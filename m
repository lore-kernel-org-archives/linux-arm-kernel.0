Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D28C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:26:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F47321738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sjG4l6jW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Hu6+nl8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UhxJ8CLUHyrRU3GPudm2Q7JP9fkbMLU/MXzxZojNGTQ=; b=sjG4l6jWx6QakWo7ocoTpH154
	a7IYOmFuxG8ns7tmTXg2vUbuwvOWY5rwe1/tA6rl8bv4gnjqkB3peVtI5bw2DzlI56Eiw8ksVEMF1
	N7HJW1XEM88OMD45vbthOxCRX3WnQHR3deWDn/nFoMY5BtTO9SBN+JvHXKcdETlW6G3TYDq8JraX9
	jm4LmshN7XPu7HHuJncz/1cian4/76uvxCgzKYCaqYE1dfnm1E1pYesAOpe4kMdmQHlo78yKPA/oj
	6kVLdFeZ02sOByA1bL/ilIyFpX4bMR9zDjhLGf13szsqDcQ/kXUfYv3rdcWcLoPRv/370TiAK1+gP
	DOXvzuGig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5zu-0003sR-P0; Mon, 28 Jan 2019 12:26:42 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5zq-0003rq-Nt; Mon, 28 Jan 2019 12:26:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cEneVQDt5owcuCiSpjo8HwrddzUQYEnP2+VEv83KNZI=; b=Hu6+nl8U6+gMmN/x3f7vHD9cV
 fRfbVg3aUMkaeRB/0WA9/NCaHMp/MMndIPmUIoUNyrtcVBD13cZLwBIAiu2y3riaOkBkACL7nU6eM
 +yV7u3cAMvzDxsslSfsWZJkAtwrh68+uCX7OXwcm5l9JHxySK2gHFVh/2cKRfxHpmU6WY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1go5zk-0002RE-7J; Mon, 28 Jan 2019 12:26:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id AA6F51127D29; Mon, 28 Jan 2019 12:26:31 +0000 (GMT)
Date: Mon, 28 Jan 2019 12:26:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Message-ID: <20190128122631.GD11699@sirena.org.uk>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
In-Reply-To: <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_042638_918411_32DC5EFB 
X-CRM114-Status: UNSURE (   9.05  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "vigneshr@ti.com" <vigneshr@ti.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============4428545686196516247=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4428545686196516247==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 10:05:29AM +0000, Yogesh Narayan Gaur wrote:

> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index e23ad9ef028e..adc3c0e14f38 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)

This does not apply against current code, the above file is not present
upstream.  Please do not submit patches to out of tree code upstream.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO9PYACgkQJNaLcl1U
h9Bc7wf+PzfVYK47sKb7gYCwrFPhskxTV0PfgznGOSHdzhtJmhuLjfDzsgLC+PH5
T25AIY5kF5IKbod3WbKT8atM1uQCDHDae81MTD0m6da0uNCpqPsGBquyU+WPiwJA
SOEpzPRyV0GSI/TQW5fKWnWVUxLVKdMEzTBZnvu9I7EvOpv+eiS0udKenqsE8iVp
U0EgQng2D51VRhvVOmRY4bmvtby54bzZXjt/4TYsdvNux2ar00OzH8FOJ2XTKnOO
JdDZlmY/K0NSgjE5T1JYHT4CDn8LLL1wJQ4g04CN/WAKdbGU1GgSMcnxK8OD0C2i
t3E/tHBlG4R/WC4KdDO76rZk6mCTTg==
=DbNg
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--


--===============4428545686196516247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4428545686196516247==--

