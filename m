Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BEAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:17:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE15B20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uHmXifc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE15B20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WxOQeAh3xORcjorv70jDNnYcsCaiwK8UX6Ae4/PUtB8=; b=uHmXifc/xiBUYlfvq0110/xIp
	ywwhystzlaZC+XehMfQKO/Goov9weoQbmPoG4cncuHAVSwV213qWXQ0SWWvdx3wAIVKNdu3wpXZwY
	Jrqw781uI32QWEJ4RXALg0wVA/obUN5NuN3SJJvSG9L4EJ9WIcthgiYJh9g+F2THx6S3PtKu/3NsD
	lmIvvFGVn77x/Uw6xARPPpzIeHFQpkZ0o/EEz3OWXKhMNmOW1KIgFbZMj60LT06BYtMULL/oiuByW
	ZtjUQ1Dm3x2iRG+fqgXseO/45/SQCnnr0/1F+buE6JCPx8tMF3UVbPyhHk/SBc4kskurkRLfCykkS
	InL4Wj0sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZLoC-0000DS-9f; Tue, 18 Dec 2018 20:17:40 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZLo8-0000CB-R5
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 20:17:38 +0000
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
 by pokefinder.org (Postfix) with ESMTPSA id EBF762E3542;
 Tue, 18 Dec 2018 21:17:25 +0100 (CET)
Date: Tue, 18 Dec 2018 21:17:25 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Message-ID: <20181218201725.2uqfmsethlkasdvc@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_121737_183454_27D576E6 
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2239053727926907888=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2239053727926907888==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xjz6c4seersbpqak"
Content-Disposition: inline


--xjz6c4seersbpqak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hans, all,

> > ... this. I don't know what these flags do (and reading SMART in there
> > gives me more a 'uh-oh' feeling)
>=20
> On x86 the lines between runtime suspend and system-suspend are blurring
> with technologies like "connected standby" and in general devices moving
> to suspend2idle as system-suspend state, I guess this also applies to
> modern smartphone platforms but I'm not following those closely.

I'd guess so, too. I am not aware of any existing mechanism for that at
the moment, though. If somebody does, please enlighten us.

> The "SMART" bit is really not all that smart, SMART_PREPARE means that
> the drivers pm prepare callback will return positive non 0 (e.g. 1) to
> indicate that the device may not be kept in its runtime suspended
> state when transitioning to system-suspend, otoh when the prepare
> callback returns 0 and the SMART_PREPARE flag is set then *all* suspend/
> resume handling can be skipped during a system suspend.

Thanks for the detailed explanation! Much appreciated.

> > Looking at the open coded version you did for the designware driver, I
> > wonder now if it is better to just leave it at driver level? Need to
> > sleep over it, though.
>=20
> I myself was thinking in the same direction (leave the entire suspended
> check at the driver level).

So, I was giving it some more thoughts, and my feeling is to still apply
this series with the review comments addressed. Plus, clearly mark the
new 'is_suspended' flag and the helper function as *optional* to allow
for driver specific solutions as well. The then-to-be-added
documentation would state that it is mostly useful for seperated system
suspend and runtime suspend. For more complex situations, custom
solutions are accepted, too. Which means your patch for designware
should be added to the series.

My take is there are enough drivers out there already which can benefit
=66rom this new helper. If it turns out to be useless somewhen in the
future, we can still remove it.

What do you (and all others, of course) think?

Thanks,

   Wolfram

--xjz6c4seersbpqak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZVdUACgkQFA3kzBSg
KbZgCg/+Mi5R4bOlSvy+L7fIs79nM05v0QMNCbEAXOZ3EmZKkt9sHHiEeGzFdzKY
Iiawm2BGLUW+sVrCoxsnav0k+hSl+5TNlKd1C72V3inzemIbkEQTOiVbDPmp7fTV
0UE5WO6CUfZHirCk3XnA8xNSn8YxfHMKUOq2GuMUZEQcXyIk0mwlO84WPkWXjLTu
pHNovX+74FM6iGL3IId6KQI6773u79o8d4OA5R3pCOzPD1O7OtWAJjcP2oyD/Ge7
+45+F1eIH5GupW0zn+ByR4tU2XiDFw7uUX/6WYvPPmqPbpz/6l5Ujs1pGC9nYyPx
S8TuIAiTU8CEDVBLF1IN2Kh6+TEo0iwXpKL821lCL4lwb0ahTq/NjcyqZR0yeyYK
3bCaupT4sScf/LACYeHLPCSD3gNzK5WnaddFWnGB8YqAmQeqG1bDB+5wYxV5+FjB
V8YiuuLm+kwF4jAMZITO+iDJIHeZ5HF62JeCE0lFCf21AqlWS2KoYfcJgjln3WHU
Lk2CFEQidCTk2Vjb2U1AHBjGiAyzhle/fop8L/gMmXoCv9J+b5Jz4bIgJD+76d/A
apkIbW9HRg90t+WdzecpdU+R9qJMqeyxeKCTRga7PPO+buBJszke+8ozXvtcN+Dw
l3nKZh+uXk+nhF1T1mUW9QJ88NuCSX0SOxthrlS85oWRoiko0qk=
=SIgX
-----END PGP SIGNATURE-----

--xjz6c4seersbpqak--


--===============2239053727926907888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2239053727926907888==--

