Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:59:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1069321479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J3lOHyiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1069321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cIS47hJNVKDydS1sTES8SLs0cRk3ptT/4su3FcLl3PY=; b=J3lOHyiBSYrEiPWlmcCAe8Kay
	vrEm9thzfIPbN7rmtP9XhcdXbKci+uTXterg6SiOa1hVYkK2r0+vVP63CMiTDeMYh6nohmaAqH+WX
	+M91uJjTwLheWg1PfslcE/o8ZyGPN0Rmq8zt1PaDyY0xLN9B+Hf9f8sNai0VhGV6sfJcLzg04H4gh
	fzMLlde0fTNvOge10Xyau3zV3oLygazGTNba8HU2zY92RignIo8H55aWQ/5/RxMOTbuQr5DQFxn+E
	KdYlLRBPEZ0IRfzGEh40ed8SBpt8EU8YHFXy/adWJ/dxEl/kcCGBKGvnPPHIvjBy6jmrFJ8DiwD0N
	ejUJbcXGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8DK-0003Ec-IH; Thu, 03 Jan 2019 18:59:30 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8DF-0003EI-LL
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:59:28 +0000
Received: from localhost (p54B3379A.dip0.t-ipconnect.de [84.179.55.154])
 by pokefinder.org (Postfix) with ESMTPSA id 399392E3614;
 Thu,  3 Jan 2019 19:59:22 +0100 (CET)
Date: Thu, 3 Jan 2019 19:59:18 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/9] i2c: reject new transfers when adapters are
 suspended
Message-ID: <20190103185917.zfcw24n5w4n4qu2q@ninjato>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
 <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_105926_419035_B47C57E3 
X-CRM114-Status: UNSURE (   6.45  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7119284426952212707=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7119284426952212707==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="waep5l5pjqydoewa"
Content-Disposition: inline


--waep5l5pjqydoewa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I share your desire to have the check for this shared in core code,
> but I'm afraid that just is not going to work.

Okay, so this series is definately not it. Probably the previous one
which exposes helpers is not a bad idea after all. Because it is
ulitmately the driver's decision when to use the helpers...


--waep5l5pjqydoewa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuW4EACgkQFA3kzBSg
KbbIYA//U3lleoAK/oWl+9UNpk7CP0tKUplkb/9WLfa5od5R+/aqf5OcavI6ebxa
WELpu0Hu849QTMrm5eYiADrtR4nRdsCHwxtUTfpgbyX63j8DIb0PoQOX6T7vDHNm
ODoIzVQ/rBEK0CFBGGUhqBrU6ZeH2Cgp30WsgB76KhRQptrtK7why4J4afBlGeMS
ZwEkd+bHyY4iFB4DY685UcvK4x0W+PJbmgEDnSG2ArR4M/G9M8RTljd+5aYO96zb
feEp0CTL3huFaVRyUKam6+V8aQc4FgLUl+WlSzlK4zdZ+CVUlxB3r45KA9QXDhi0
xxScjdMoYWAhQ1VZPCMSYgCzV3duiChgztBtzI+uiSOlI1Og94uu0VzasIQ7diNM
VeOgKLEiO4viwncZOY/cg/tnwz/PJFjubY2xrXdWGURnlNBGfxznso9FCnEy06Pk
jWShb8+X0q3NQFMepdD2DlzQYUYGguEANRXkkRICBqXoHhjo8GOyd1Rf7HiA+hqO
cYYHo3+zY6hllamSTkuEHKLLGPu7GP+seUyVXz2MvEgq3yL763MEviUCCt1/xb/G
5v2XkY0Jv5NaRj6n0xD+xj1lS//vUNDtIf8JegowCQqaAAsLXJeT1/MJyo7xMQvC
YggEZWu+12HQvPZyq446l9wP46xV8D95GukSI6HCnJsDSqDaTkA=
=ujG8
-----END PGP SIGNATURE-----

--waep5l5pjqydoewa--


--===============7119284426952212707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7119284426952212707==--

