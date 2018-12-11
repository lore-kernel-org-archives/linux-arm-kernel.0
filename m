Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D0C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:41:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EA92084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AwfOnVVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EA92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wveSKBgOuonRWL/WGkBhe1+koQ57ZEYYquq4UfKqKeU=; b=AwfOnVVmfAg7nZGsQdx5Kxw0J
	qgeb/LPwcqU/BKsuqn/jn2b3ZO2sd/TIrlC96OQeCBvbqK9GGo6MWyFqT4CGNJ7nNmgbDOwD//lRN
	ewUWHr7jnmXQlk0gFFafC21kOb/C/edQxtDNOp9uVQtNVuWOhspbGc/iDmDMZpPgqEYJnLNtfdgE7
	1UYkiQOoUHADYZNMR4eh3v7dv7KhGDORCCyaTzjyV0RCauY+yFr8LCIiXBrsvzE+zfBJ8knfxTuq/
	5qsiMSvOB0zlQAiSmOV1x2ZUK1wODtOLu7/RLApnnPIEhgYLb0cCzyOX/u829s7uHIFx0G7E/V5dN
	IG5KXa85g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWreP-0006k0-PA; Tue, 11 Dec 2018 23:41:17 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWreN-0006jd-1H
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:41:16 +0000
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
 by pokefinder.org (Postfix) with ESMTPSA id A950F4C0E8F;
 Wed, 12 Dec 2018 00:41:03 +0100 (CET)
Date: Wed, 12 Dec 2018 00:41:03 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
Message-ID: <20181211234102.GA6701@kunai>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_154115_236093_76DBCA87 
X-CRM114-Status: GOOD (  10.75  )
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
Content-Type: multipart/mixed; boundary="===============8715852425376858835=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8715852425376858835==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

thanks for testing this series!

> Note that the i2c-sprd driver changes in your patchset also get close
> to triggering this problem, but they dodge the bullet because there
> are separate system-wide and runtime suspend handlers and only the
> system-wide handlers call the new i2c_mark_adapter_suspended() function.

Yes, this what I assumed to be all around - seperate handlers for RPM
and PM. And I also assumed that they could be seperated if they aren't
already. Until I read...

> As I explain in the commit message of the first attached patch
> simply always using split handlers is not really an option because
> of adapter drivers using DPM_FLAG_SMART_PREPARE or
> DPM_FLAG_SMART_SUSPEND.

... this. I don't know what these flags do (and reading SMART in there
gives me more a 'uh-oh' feeling) but if the handlers can't be split, the
issues you were seeing are a consequence, yes.

For me, this sadly spoils the whole concept. The patches you add make
things even more complicated. Not happy about that.

Looking at the open coded version you did for the designware driver, I
wonder now if it is better to just leave it at driver level? Need to
sleep over it, though.

Thanks again,

   Wolfram


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQSwoACgkQFA3kzBSg
KbZaWhAAqL4UJf4q20FrE3tk+nfMGtcTU2zNWCwJpJFXNnbUYjRE77mFF6PuBym/
CUMjKU6iKIF30DpsJFPgf1/fPnNQJy2+qM4X7oSjZfLE31sp7WMtx4juxX3GV0+E
+hVGNP4qkwytLwEz+bo4kAkBoRIszttFRKcE5Zur706OwlSh/DzVWYAgiKsA65aW
jueC7gS9FB3/4X9LfZAiKWi88NVa2DeL5l19N/uWxkfW3zNxO8u5J6x+ihqGuGXx
Sjf6gpMq9gV9WaBQtZnRSbuNNaGB3D0gmcEhShBAYmYwQBBIUVFzBlJoZnO6rhRr
lrYxym0dqgH2szh23QFwta/4qGKAbc3yyAsxh4brsAtkv7P4MgCYrNtRJhdq3LIV
qEZG7V4QFzYmdi+1dJdvc5nDxsRH3ijBMZf45884GXUxIhSpnh9qqEeOzGs94nc+
GoU+TSbNrznuTy77P3KuQfnaiY+KQVLTZi10zN2UuZbIUFLOxOSD/dRQo7zDju+1
PaKKXYh0q8Z5JmYTXqlFgBUo2zd3W0gvOWo+SNVSuFchVzg8XQSC1xTv/0UO45us
H96p+HZNmbuFIBsz04VpkLy49+YEb7F7bRFQuqkrQlnMVnUDfvcbAHseCIohonN4
RZv0M6iFGj5kObRiCJOqlacQbuT4XOdikuJDgaCBinPXCNGUoWE=
=L8ZM
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--


--===============8715852425376858835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8715852425376858835==--

