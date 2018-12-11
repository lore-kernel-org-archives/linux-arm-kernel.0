Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E9FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33E420849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mjES+3CU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EMvfw+jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33E420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QQF/gjg5hPWnqt+wDVsbmwMUEzLUxAEBUE49aye5n2c=; b=mjES+3CUzMqNSviKdfpnxREGq
	E/0FGKOCtukp13uEP2b/WW9LVZrTlsIWpuChVvHpSehPHceSi9zWdYJLUEDr3FdSNnMZnr0X/WIuJ
	zoKOyvlL5hxZA3mhRxATXL/UrmHYQ4urQ/oaguhH/u4mrWUWi8HHJWRABFZ2Kz2wJyj0eF16KBjWG
	KPvoilqpc/FWfN0bv+wgXMi+l7D7xvrrHu7LKr1a+t7ymcnJgX2DHRP2ZRfzIthQHda7suvEG9Vqx
	Gf6NTaKYSoFJNT6D52ZSZs/iMK5HTT+u0CxS8GvXJI6jUpYrxFMp3txxnXBUazhB/dIXEEskz+UnA
	NSBhqGeWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjsq-0007RM-5K; Tue, 11 Dec 2018 15:23:40 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjsn-0007Qw-7B
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:23:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rcU1QPt0VxkIC8AOQJYNwHPSUM4V4V3Zy52wECk57EQ=; b=EMvfw+jT+ZIfSmcHW/t/xhDCz
 tEONwEMkizqwmauZF+MOm6u0xGSG3RmdAynqgSY/JfvZLkuEPyz+KLm2Y4XkbixamKOqmWaXhsX3X
 tiRUZqdKOLaRtp8cxQX5OYmLD3U0xJQGy2cvxYx9Ye2Fns5RQ4E7MbTCw35tYMWYi9p7M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWjsO-0001A6-Ja; Tue, 11 Dec 2018 15:23:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 03728112540E; Tue, 11 Dec 2018 15:23:12 +0000 (GMT)
Date: Tue, 11 Dec 2018 15:23:11 +0000
From: Mark Brown <broonie@kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com,
 Wei Xu <xuwei5@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: Re: next/master boot: 175 boots: 18 failed, 143 passed with 10
 offline, 1 untried/unknown, 3 conflicts (next-20181211)
Message-ID: <20181211152311.GK6686@sirena.org.uk>
References: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_072337_420169_D21FB302 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org
Content-Type: multipart/mixed; boundary="===============3666709363361386096=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3666709363361386096==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 05:10:16AM -0800, kernelci.org bot wrote:

Today's -next fails to boot on D05:

>     defconfig:
>         hip07-d05:
>             lab-collabora: new failure (last pass: next-20181210)

It takes an oops during IPMI initialization:

09:51:45.224591  [   87.646247] ipmi_si: Adding SMBIOS-specified bt state machine
09:51:45.242352  [   87.652129] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
09:51:45.242646  [   87.661875] Unable to handle kernel paging request at virtual address ffff7dfffee000e4

...

09:51:45.429194  [   87.845965] Call trace:
09:51:45.429426  [   87.848400]  logic_inb+0x80/0xb8
09:51:45.429640  [   87.851620]  port_inb+0x18/0x20 [ipmi_si]
09:51:45.443075  [   87.855620]  bt_detect+0x40/0x250 [ipmi_si]
09:51:45.443320  [   87.859793]  try_smi_init+0x1a8/0x868 [ipmi_si]
09:51:45.443539  [   87.864313]  init_ipmi_si+0x190/0x220 [ipmi_si]

...

09:51:45.479097  [   87.910207] udevd[2569]: worker [2589] terminated by signal 11 (Segmentation fault)
09:51:45.501664  [   87.917863] udevd[2569]: worker [2589] failed while handling '/devices/platform/dmi-ipmi-si.0'

Full details here, including bisection information and full logs:

   https://kernelci.org/boot/id/5c0f88d259b514823d4925c0/

Unfortunately it looks like the bug has actually been around for a while
but wasn't stopping us getting to a prompt:

   https://storage.kernelci.org/next/master/next-20181210/arm64/defconfig/lab-collabora/boot-hip07-d05.html

and it might still be some unrelated hang there.

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwP1l8ACgkQJNaLcl1U
h9CmIQf+OQ98ayVSxSawsB2MWVN1ObYQazmISNIRkGHT5HfauAGw6oo5QTD8bqNx
eKbtnEK8kav8BUH+g/6tB6PRmadZ99qsGTubWMgW8gju5iO/i5kG/N2dz+Lskgc8
2GRQ3mEKUTE1CNIZhm8vnTUhEz1S4gYhwC/RPoNPE3KPmXpRyuBOph2D1Hn1VMDg
7KPh2RlqYGJZL5ubxDQT7LcU8gx3mHnqETBeqe4aYSaaikPNiOONjGJ/8Svbi+qk
vCGNvrC71kk092I7e5pJP2y9dYuGK3au1bAtKjmvScYT+MMzYIgpyA4w17oRVwrO
8dYhLD9FaHtaBrDeTXnWhrI7p+lvdg==
=JJ5o
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--


--===============3666709363361386096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3666709363361386096==--

