Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:53:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7073E2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jqGdhRMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7073E2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DvRIiahzDZFW+XWzwp5A8HmF3FfCoWMBmxl8sfQkkSE=; b=jqGdhRMXAiVz79CzStsptFAPg
	LPhj8EXJ3ISzhXfAeHO9GRfQkmyjuXTjioaFhpJirzFEVu/Iw76DoZscFPKTJxtYguzQ/PvsUJ3vk
	4hqgSmgi7IwfrpwCGso6vZ6ZMkX6CLmcoAbXRt5SxNgUgwndC7BoHoSrzITeQqR4HcrGwm7vjkSZd
	Alb42Bz8eRzCILVaGGN0EnvXwAiV/UcKwJ6SUUL2I8S+p39XuIMPykXzRUlmFwYgOlI01M1EAa/vE
	5GECY0YDvzezRFRHA2c+g/xG95cui+65AjBwjd6c/UhRe4rF9yqhaElZb5D56TQ+OTzzfTykPSAsT
	j2mMmYfSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZLQb-0006WH-F9; Tue, 18 Dec 2018 19:53:17 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZLQX-0006Uu-Fy
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 19:53:15 +0000
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
 by pokefinder.org (Postfix) with ESMTPSA id 548912E3542;
 Tue, 18 Dec 2018 20:53:00 +0100 (CET)
Date: Tue, 18 Dec 2018 20:52:56 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter
 suspended
Message-ID: <20181218195256.hvmgl5wt3jeebz5k@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <CGME20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783@epcas5p2.samsung.com>
 <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
 <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
MIME-Version: 1.0
In-Reply-To: <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_115313_682397_9AA67B43 
X-CRM114-Status: UNSURE (   6.41  )
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
Cc: Andrzej Hajda <a.hajda@samsung.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Kukjin Kim <kgene@kernel.org>,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5965933930312321806=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5965933930312321806==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lmgdxylq2cyzuy6g"
Content-Disposition: inline


--lmgdxylq2cyzuy6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for testing!

> Similar warning was already there ('HS-I2C is not initialized' message,
> without backtrace) during system suspend/resume. It looks that cpu freq
> is resumed too early, before any device drivers, but this is not an
> issue for this patchset.

Yes, this is actually a desired outcome :) Raise awareness if the
suspend/resume ordering has issues.


--lmgdxylq2cyzuy6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZUBQACgkQFA3kzBSg
KbaehxAAm4Uf0X43KMdWHwO/Iyha2jVgfyVJCnEMNu0j2wFzirDaaKvmPNyDqFyS
BRhqzCjVsl00sECsaLGQLn0WB1geFHvyj7IPjVy51zaunuPVosslaZsjaS6+TLui
x8IY3u5GxRT4MW6siGMqa8iyjZQ3F0Yk8ZmIhoFvaDC14J/7XGAkkKaNxEkA8KZD
kRCTbdXYnHiwegDOZ8sorv4XNCXynvNyJ7SIuy0aaaipJG/iqIlrED3Bc2+PFz/A
LZuVHv5/mPLSdXddNJ4hIi7cEfJN6n48Ey/XaMBOzHlFBcxpMFeOOpzO7YsNnqfa
SYRqYR315lD3oKP3VCQMGKqmM3AVXMy1rAbC8LnV2Q1GEH6+PWrUPC02IAgOtce9
n2EL+rxgPwepc3ttBspZWldmXX7rbjL7jI9fSKqT71jVugMNGhYz7avM8UkzpjWR
AVAKRS/+E0TW1triR0/vkl4i6UDw3yr47/vyOacrnGpnyU6MYgtJ3kqRICf51Yos
xCltgDSelxBMHPrARsQvuv1sHw9EyEFAIDXbA2Y2h/uMY17saFA+XFhghSsbw4HA
MyGwOHVeQp0dMsWG7llpvGdZBRkodI+5lEpdbC1Uxz51DKJnCiEEHRdE/vpDsDOf
0oK6W91eX5/cWTCvbZUpcW8dY7XAFS7XK2Mi7Lis8hGxoLJOHc4=
=ZoGD
-----END PGP SIGNATURE-----

--lmgdxylq2cyzuy6g--


--===============5965933930312321806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5965933930312321806==--

