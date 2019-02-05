Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A14FC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D2A2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="momBo09z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D2A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uldiBeFHbsZMjUx7rgOroaQxik1KsV7B8a2nR/p//wc=; b=momBo09zmB/eoGZ9s3HOiv5Fj
	HLEHspFdFg9+JRUZVbeOEa66NqfqmbwfOlZZKITLzSk38gq29EeSHM74ZY6l48sO2KCu1sciq1aFC
	zEvopwKfomTLfJ8Zzmy7ylvb+FRKI5k4SVRpzpHINvmACzvRD38merp5T0k479LdUeoAH8G4j+j2J
	CNzBxBomhVZZex44EWM8GiqbaqT7Ap/5p07Jw2xkIE7Xjy7Z1eOX63eB0lfHjM3Oyl5NGlEDhczz9
	bJuZgEePSbjRRP7vFT6VNbcbjmUrgA9GUcrI6J3Fy0nsU5d/1LNgyCYw1gkeMP630w20PMjh12IlW
	arbSpXoEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqzXR-000614-Vm; Tue, 05 Feb 2019 12:09:17 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqzXN-00060O-J3; Tue, 05 Feb 2019 12:09:15 +0000
Received: from localhost (unknown [46.183.103.8])
 by pokefinder.org (Postfix) with ESMTPSA id BB9252C0509;
 Tue,  5 Feb 2019 13:09:08 +0100 (CET)
Date: Tue, 5 Feb 2019 13:09:06 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and
 counts after a transfer
Message-ID: <20190205120905.GB1045@kunai>
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_040913_776239_308B1E78 
X-CRM114-Status: GOOD (  15.39  )
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
Content-Type: multipart/mixed; boundary="===============8920057819728643935=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8920057819728643935==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline


--tjCHc7DPkfUGtrlw
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

Stefan, Florian, any comment about this patch?


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZfOEACgkQFA3kzBSg
KbYpQw/+I5EVIhwbmysIh+L9Au4/Gm2PS/klKGFRPiiV5gJZWeYg6Pnb7exKsPet
Jht6B6C5nDf2c8UcGc4Sj3vdJMeu3hln3j8Xv/mQQo5bUYU2VYsf5+wTwrh8NFbH
CUBP32dXvZMyDl5wI4dDXwyiOOtJYwMr76SXaeQuxsNZITBPMqI8sl3TYbCeaT2x
/UoYyCD4GTBed3lRUknOqmtr07bbnsohBS3IFVKZMCiSSCoTAHNe9q3XptYVEdlp
0KyaaKrlEa4XvrZmolJMlgcHMoQMSptmARj6ZTl664WmwD90TrjsHoyPKAtFPn/B
bP+XzwsAJqhasN/CrUrebDxd1vzMSGtj0kShlQABvZRXN7DK4vdmLfKrOYcCZ5ra
bWigpqGuGOnyQOJCWfPh4o0EpHQt8Fqu06cKZLQDIGz7x7n7rqp5PRFJzxhGK3Go
gY7ESo/VZ0rXGawuYFWVpGw3r/TAWNNIR39v1vmN7+lr7mfnKjvnZnwOS7+HwcBN
CehQ9lS/pM2jvZZfs8mWbWx3wnmZ1tfWooacHBi9FRksTylHLoiOaPONfUXB4l5z
exhP7ryt4iN/HS/wAVUYcTVzpIlDsDyf0kwsfXwRg+rj9ykl6DKC72nnK1bg/lEh
HPuolBp1p71U5oY3AgfDSwtuEL1CR6IU/+vI6fnWTgRMJqbyxNY=
=fC0y
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--


--===============8920057819728643935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8920057819728643935==--

