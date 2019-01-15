Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C1720866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/Lfh9Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C1720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k2V+D3qfa8humrRMKGyeNP+zUkxGhNaEysgwMkfpsEU=; b=M/Lfh9MlBxaQjV4p9wLdv12yI
	LK+kMtC9HConHBm86fyETG73QPFiysy+whU88B6UoJE3mrx2Ke0kJ6Ay3k0+1pcUx+iUfWgnplNc7
	FxsthkYp6TzdtN2E3q4wEQgFBfhBLre1Lg/Ch6rjuJ/kPGPGXpTD1zFObOhnIiYNn2EPGI6d4CDdz
	vtp17uCAOcNbgxaMjrl6Ex2QGanm6E690AdmAw1NM2DGMyyQEhSwsnYT9UUZtRNKpq+JMohtNzjvA
	DLsVBZHEMiFGTen9gyfL0N5oc8ejrs6JOwancriXlteiUhvplZg391HPzAzR3w2H2RvfAX4gc9ro0
	PasqnJf9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjWgc-00045C-Sx; Tue, 15 Jan 2019 21:55:54 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjWgZ-00044P-8Y
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 21:55:52 +0000
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
 by pokefinder.org (Postfix) with ESMTPSA id 8262E2C9D2D;
 Tue, 15 Jan 2019 22:55:50 +0100 (CET)
Date: Tue, 15 Jan 2019 22:55:50 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] i2c: imx: defer probing on dma channel request
Message-ID: <20190115215549.sepj7rmpqmtlxwbw@ninjato>
References: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_135551_448532_DBC74BC4 
X-CRM114-Status: UNSURE (   9.50  )
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
Cc: s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 linux-i2c@vger.kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: multipart/mixed; boundary="===============3610315337166004867=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3610315337166004867==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4k6sn2i42q7o326p"
Content-Disposition: inline


--4k6sn2i42q7o326p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 15, 2019 at 04:03:32PM +0200, Laurentiu Tudor wrote:
> If the dma controller is not yet probed, defer i2c probe.
> The error path in probe was slightly modified (no functional change)
> to avoid triggering this WARN_ON():
> "cg-pll0-div1 already disabled
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb=
0"
>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

I just applied this series to i2c/for-next:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D85099&state=3D*

I haven't checked carefully but maybe it fixes/changes your issue? If
not, your patch most likely will need a rebase on top of the above.

Thanks,

   Wolfram


--4k6sn2i42q7o326p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+VuUACgkQFA3kzBSg
KbY/xA//dY9GghhTgU9Ej+l+O1rAOHeUxYTJCWoZ4iUqpPdikDeUeTfMtNAxkpq1
G5XDZqktjN2SuWGbkGZmc2RJ5V5nNq7sMkwr0JxJwF82ViieNiorQB9ZMfor49x2
HZoiCsDVSUU91AbjGdbabffzYgFjylqTS3u1xUPae+MCWfcfOoNLpqfcxNo+qwqg
OQ7SaHwdWSDnkJv+aHXPZzg7O7IdWlDP9+TWRCOVfIWxfv96iZVFXEg7utuztuwj
nSuWRv0lNliAiA8OfcO59791J9aqSrHbD5it15KftdFZBMef/+JD9nLFlTPQnRXo
9KsZ1SNHo2otE6rWwoRID3fmTu7baccvmoCpllR3gn5ARSKeqqp2uf4zdSC5nkwD
d4b3AOppV9ZrPgiG9gzTH/zHFFcKGvkQZuW31Jg24/Dy0gcVyCEEhgR6b4Fc6vYR
qM7Vf+UdewNvdPOyYAAeK0h/xPdzLqyP9TJpQiumypH2eK8JGWmiMwjkfGp3bLUj
7vOfXcvRxLbp4LWXvvcEgwPddBfMTmLeNHGNCmppUUTFH9KsBG6okkskjFGw89kT
1HlwB3XsubRf/onryTWZ0CtZByn7Y+LWje/Pnh4RigSXc4Le/4tW5e/3xHrv3R6C
cHnUg216K+XEtPl9JfCwxjGoPvUPcWox7SJ6NvK4Pb1Nn46CEeU=
=xrXd
-----END PGP SIGNATURE-----

--4k6sn2i42q7o326p--


--===============3610315337166004867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3610315337166004867==--

