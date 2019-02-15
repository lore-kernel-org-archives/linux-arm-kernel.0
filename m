Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD714C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC47321B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vAPKpc2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47321B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wF05VYXTz5qEZGwC7mh40BUy+RmrwICUqr9Fn/NO7BQ=; b=vAPKpc2BKZDGpDhalYuKc49e5
	xomlznq/Nqpttb0bMdrmb+Ko/PmB5MvvEA5fIwwh4oszOJcLcddcpNQa+kFgQgARgSPAMVqxJPFla
	bYcY3LPPvmdj0xHXadxATrq8x8laAt+We/8fNWor3WlbsKzqnWaRXg76NZ400SxnUA+FHT4fugFdE
	rgfJWaupY4R/85ve1F6IvJrVsD7jc9Wbles7JJun5+bMfmagegdmVZtoryodkorvE9uv0RNj4WTqa
	r7oSd3zCyr/jRDduRGloEDxteVsV0saDa28eGUXRjX7jex5vTRmVyiiyAPt64UIq5rGbEmDKcwIVB
	gGG+GM2+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZA1-0004MY-Mj; Fri, 15 Feb 2019 08:47:53 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZ9j-00046t-OT; Fri, 15 Feb 2019 08:47:37 +0000
Received: from localhost (unknown [83.221.228.209])
 by pokefinder.org (Postfix) with ESMTPSA id 3D2F22E3551;
 Fri, 15 Feb 2019 09:47:32 +0100 (CET)
Date: Fri, 15 Feb 2019 09:47:31 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and
 counts after a transfer
Message-ID: <20190215084731.gy7khiydgyzgfsjk@ninjato>
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004735_936045_5FBFDD35 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Eben Upton <eben@raspberrypi.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3253540754925632842=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3253540754925632842==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zp4qokiwiqe3hwav"
Content-Disposition: inline


--zp4qokiwiqe3hwav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 04:42:25PM +0100, Paul Kocialkowski wrote:
> The driver's interrupt handler checks whether a message is currently
> being handled with the curr_msg pointer. When it is NULL, the interrupt
> is considered to be unexpected. Similarly, the i2c_start_transfer
> routine checks for the remaining number of messages to handle in
> num_msgs.
>=20
> However, these values are never cleared and always keep the message and
> number relevant to the latest transfer (which might be done already and
> the underlying message memory might have been freed).
>=20
> When an unexpected interrupt hits with the DONE bit set, the isr will
> then try to access the flags field of the curr_msg structure, leading
> to a fatal page fault.
>=20
> The msg_buf and msg_buf_remaining fields are also never cleared at the
> end of the transfer, which can lead to similar pitfalls.
>=20
> Fix these issues by introducing a cleanup function and always calling
> it after a transfer is finished.
>=20
> Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger =
than 16 bytes")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied to for-current, thanks!


--zp4qokiwiqe3hwav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmfKMACgkQFA3kzBSg
KbZtrxAAohPOgZx5no3ThwDEyYTFd9bMJTKd+4Vz+n1rXHl2K9Ib1/rNfkPq9fiq
7HteQbVVbxw+KOLBUUjGBv6oqF7Wf7D6Im6JDEJvMINRXXvkyKODS/x+4QkPLmzl
4h+r2BkzJpR9Bd5hmWYvot8dia8sUM0qJpEGxKoxezbarIwK6gGeXBZb5hDm94R+
Qb2robryMxM5URI15D8wPFPUhnOxFhv01fRb1bVgJgcF1k2iBIFWHDU+13YGqgPX
v2q6DjebSMv/riI5o/wxOuM9o77cvYA8O8OKyc2bdtLxVuoi9yHIvR0LtG/t4ylS
ZODqbfhu2hk4qlqGVYaq9kYxtH0W/eiE7nTUpM8aNvqLKOrK0HVM6kCm2Tt+TBJI
XpZGBUPdS9YHv5bWJEQvT2svoli0whFKa16glpK3lzl7f6e2xxG2rqfV4xiqaZSt
vW+x2XO07lvZgVYBi/PyfPD+WazQZaZdxk8kWuYwO6KN8if4h8ltoqrfbbhFGQGa
Bs/kFkddb5hzAXBPUdHGr+dEgKT9VrIEYRrdc1PtSeSrbOFeu+xJviH8zgnlar56
romtLgZ3AoxcColAq7JFrMa1ZiYI1torjIxfMFtoNRZZv/JxgDMPuaSwCBMywlxZ
joUf0GbmiGtLW+zMeTb0B6RNTVMimxXB/XqQ0rirCkv8o0N0oP8=
=JjNL
-----END PGP SIGNATURE-----

--zp4qokiwiqe3hwav--


--===============3253540754925632842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3253540754925632842==--

