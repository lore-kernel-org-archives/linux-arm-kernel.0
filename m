Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6F9C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9354218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2ROr7QR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="k25pvIRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9354218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hlHIWj1OJyRMw+uLTq3MH/8Z6rFY1jssxIcabNmuqN0=; b=X2ROr7QRHLBpW+YS0HAG6zIVz
	4EeEzZRJmqz6QMs83vSHqfWcrDkmsvXzoe8KOH0rbQeO39tIYm0YoUED6GC72OWQSjOzmUe6nADeK
	9BSB1v11Ma/qsy7wVZcxopmw5saqRE6x2pjMv2WKwaU+tpZFXEw/gzaZ4Y2tbjYMbho2Zyn2bGId4
	5E5SXsW6m7FxxwrhawguKjjBmgbAUHzk8jgjJrXhCvAoXQPECQ09r5xBvG0n62+i8k1IdiZ13W74G
	DsIlasSqcTqHTCUbXk6ncg1P4zgRWyT+dnpLxvWczzUIKLJ4fo5WD00eu4TIvo3QYtllV1xdPhefb
	FBztjkm4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYbe-0003Fl-Ec; Fri, 01 Feb 2019 13:11:42 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYVZ-0004oL-Cn
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sgQRooGZozZW3iAo+OQkbQNFgu3wdNLM7Zl+zazJbcU=; b=k25pvIROhtP8FI0S0PiHssWb4
 H1tw5zUIVaFbHQVWdaL8AhiIjovj5dFZDflGcptpkEy35Q8r/S5O3PQq0aDfNB6dbGSXTnwhYNcU+
 0JgfXAYc30zqApCwgPzGBM/KCeY+5c1DCqU+4YOnKJLriuYnKWDTfOMfsYSmZeiXKgEIg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gpYVU-0005Da-3W; Fri, 01 Feb 2019 13:05:20 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 44DD2440082; Fri,  1 Feb 2019 13:05:19 +0000 (GMT)
Date: Fri, 1 Feb 2019 13:05:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
Message-ID: <20190201130519.GH20797@sirena.org.uk>
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_050525_723042_E949209D 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lyra Zhang <zhang.lyra@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5601687943590666756=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5601687943590666756==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 08:05:30PM +0800, Baolin Wang wrote:

> On Spreadtrum platform, we use one mfd driver [1] to populate the
> SC27XX series PMICs including SC2731, SC2721, SC2720 and SC2730. So we
> use sc27xx to be compatible with different PMICs' devices, otherwise
> it will be difficult to define the mfd cell arrays in mfd driver. Do
> you have any good suggestion? Thanks.

You can just list all the individual device names in the of_match_table
for the MFD and then it can bind to any of them.  You can always map
them onto the same behaviour in the MFD driver if they are identical
=66rom a software point of view.

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxURA4ACgkQJNaLcl1U
h9CmfQf/YnVOFQBR/ZdKkjt44v9jtogltQorJrsUP4SjfNU6eEDwFekGutld//0B
ymGkp7vX9jhWfoLvSl/U8R8iHdhuiI9n/0nE5ryQAPoPc9/CFTpDi+V3F5eR0OR4
CvahpdUXfPJ81Z5NjIFfpeAw086b1kzrceNnPLk9+r6L1jZSu6g4i5r+b8nLGUih
2I3PngIQvW+RKpXm8cpQLnIbyuec7nsQM2yoZi2Lsf4MM3u5saLEVakirb5vND7c
M/Y8uhtiKXQIzeOvi3LtZWMorRulBycpDIT9FjQLvUMDFVQrbtrCIGcaBGnWyq19
bV2dEgsE4ucI6gbuDOn9xMxpO7tUgA==
=zaWr
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--


--===============5601687943590666756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5601687943590666756==--

