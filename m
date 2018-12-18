Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:33:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38EC21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndzUfyWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38EC21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qy3i5V9ZCHfBP1tjIo1ryLrJjuOWyzgi3cqU7LwCdZ0=; b=ndzUfyWWr+N7tS4iSzGW2rWGw
	tbOn20S6jq7sZA1pw5QgwvVyxqxKqc9fBCaQ9rAMIw+t+HxRyZ57fzloxv7yq4zZzHM6WrxSGRQLh
	WkiugvVWYz09d8xdQDNDCX7Nd6Xjya28b4IyDkQCj64d4ZnHfbjdMmSNZprPsKMHiUdatp/neNrXh
	IOXDZd0gCn9F5xeW4khBz2T+CCFQ4z7+iyAvSpXBqrCWxumQyZJT+ZnGOzbXrH4WYSut7+zy+hlIC
	a2eqmobV/WGLDFjLLUVDIZDQ7Ylel45NZyQAuR25TPtcaxULKQ8EMwFxqU+TGAYfCeZUB5DlPgm9H
	c7APA47nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZOrW-0000bQ-3g; Tue, 18 Dec 2018 23:33:18 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZOrR-0000Xt-Se
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 23:33:15 +0000
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
 by pokefinder.org (Postfix) with ESMTPSA id D34E32E3542;
 Wed, 19 Dec 2018 00:32:59 +0100 (CET)
Date: Wed, 19 Dec 2018 00:32:59 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Message-ID: <20181218233259.2ufszlpw5hjlg2hm@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
 <20181218201725.2uqfmsethlkasdvc@ninjato>
 <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_153314_077347_396B769F 
X-CRM114-Status: UNSURE (   6.08  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3854962191544670892=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3854962191544670892==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2zqdnv7q2yfssawi"
Content-Disposition: inline


--2zqdnv7q2yfssawi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I've been thinking along the same lines: your series for the drivers
> with separate runtime and system suspend handlers, "custom" driver
> specific code for troublesome cases like i2c-designware.

Cool, thanks!

> Do you want me to send out a new version of my patch for the i2c-designware
> code?

Yes, please do.


--2zqdnv7q2yfssawi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZg6sACgkQFA3kzBSg
Kbb76A//brac55lwWTzuGQxjrhsSLEQwELKmBFUMND3qoxvsksj7MPwfUes29I22
/40oqppJtH5pvm9a9oLl1EHmvIPKCmECe1kgp9SqrxRtspuMIIvwVL2YVA23bEsk
g29Fo9oIQ23Le7vsh3CT+9hcfrsyuBUnqbQWdpWQVIEgdzwySeDuRzgF5CbV4951
WiPwMH9+dxt4JnQART5cjHIkjf88TMNLNZah2mv+Qc306U/qvxBNPjKRAfMuyMHt
4axCZ6WwuRGB8uXeFu/fkctno7l7Qta/m1iFHIt3t3nGVAlWdOB/fOqS9H3IX0+L
y4MbbS6WVr+mCjddy1T9UBC9U2GXP29aU6Zn4x9XlcBq7AY/LHAGyvWbXHhuB8IO
j4ZFy0P/2DH4VYDEtJdFFR4abyBzpPQZIR4dNQIIDQ4qPN5aWgs6gcRTJ38j3fdd
neCGpf37wKEBzryrRdC4vbMx4CwoeMIcStDz62ARsOV5fOomyg4w8cL6Xlu1Vt+3
4fIimBvfSzeb+wmSvep+9PPaBzXT99Uft6z0WlpPo2oRIS/x2ryD2livFPQYcxkE
a0zyiy+8pYgfhrRc4YYp1K2LEJi2dJWBl0dDMyQMT3Wp0qPL02MAVsUEcodWqP6e
lNasaYCIBijQlWPK6UmIt7ajsXAyXO8TrUZPXFjBK50hFwWYgSk=
=m5jJ
-----END PGP SIGNATURE-----

--2zqdnv7q2yfssawi--


--===============3854962191544670892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3854962191544670892==--

