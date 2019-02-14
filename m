Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95FDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785AB222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kc/rJFul";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KcjbByeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785AB222DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F7Xj5pSrguCUJ3k4+hx0d3EWm+i+0LUy/y5tz6hbTLE=; b=Kc/rJFuljz8wyhoDo/T2x4j8I
	XkYonwUYOQZhSUawutFENsTB8dxf+4JsXh5Fw78Ho37BsI9xLveMWCw0euCSO6YAOsflimLc7NRCv
	3doK4Z7IZGB6CtMocC/dQeHvJS5TaskAjqWoM4bhtdPbi5qb1VANx+LUqFWCl7ZgQioMNxP1BCSLk
	8WXZnlkFbEk4nztcuFjtUejDeUQkdRx5Jt/Nhiem5O1OfdlnKh8nGKJxSYD9OViQxIJ1YUjt1BRZX
	ZTS1o9VoIOIESKdUauF24zL/mUyvzVpkz+PxTgJKur+Jsl/MSF5na8/8QnGUJgwH4J+8gfLrtN/6u
	X8uvaH4MQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJuf-0002Y8-Ne; Thu, 14 Feb 2019 16:31:01 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJud-0002Xl-Ih
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:31:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6JaMxyHShU29bLw5mnvCWp82QwIO8hPCrso9Qb4yOHg=; b=KcjbByeSl0G/8rhscdjwP7YLx
 UHTukvG92pEpkdlw7MmuW4DDhhEB4rbwwi4S7/R5oRqm9NyoLfZUt+ksRR/5BcDbVaF9Yc2gmqPTi
 DPZcsXx5mob78I/Fr8InofL+0UDwBQYtfMeJ5dEoMlS4zw5bnVQI/e32zmEcapGfaVBXg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1guJuS-0005yY-QU; Thu, 14 Feb 2019 16:30:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 0A2311126F78; Thu, 14 Feb 2019 16:30:48 +0000 (GMT)
Date: Thu, 14 Feb 2019 16:30:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: crypto: Disable xor-neon build when using clang
Message-ID: <20190214163047.GC11988@sirena.org.uk>
References: <20190212194645.32504-1-broonie@kernel.org>
 <CAKv+Gu-W2X32ZCqKsJVqSqyJ04UK2eoNCDKp=2OfsO1HhKaCuw@mail.gmail.com>
 <20190213114033.GA7540@sirena.org.uk>
 <CAKwvOdnx-_KtojEEbnWvygDLXec7ckCfciP4iwigPT5Y3bdmxA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnx-_KtojEEbnWvygDLXec7ckCfciP4iwigPT5Y3bdmxA@mail.gmail.com>
X-Cookie: Bones: "The man's DEAD, Jim!"
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_083059_760179_1BB5C286 
X-CRM114-Status: UNSURE (   7.12  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Jackie Liu <liuyun01@kylinos.cn>,
 Will Deacon <will.deacon@arm.com>, Stephen Hines <srhines@google.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============1863056988781265701=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1863056988781265701==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2019 at 01:45:08PM -0800, Nick Desaulniers wrote:

> Nathan's patch [0] is probably ready to go; with Ard's suggested by
> tag [1].  Again, I'm not happy about it; but KernelCI coverage is
> ultimately more important to the project.

OK, Nathan will you post that?

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxll7cACgkQJNaLcl1U
h9AW1Qf/fS7tlmklItj9sUz9o7GWbR5mp3lZIL86f/vjZxBsKMVdiDfmqRIly5Da
xvaeJ5Dbk3Pf6BXvCBVtvO1raYFzGeMshcjdL5MjR6cZnFU1FJovsEjAxJdAodcL
Sp4tPqJ09s8/ZYRvgqkLK5Cr7Ycd3VkUZFuzAqSPWYJnE2JSlO6/ZTV9SQ0neRrX
xu9dOcThPoQT7suxw7TNwBFYtvSw+jSLVhthn/pKp8+0Gidy3jMmnBAjxLnJgU+/
XnOMYhdGbeefc9i+ZASE3eRxxaq+rPuX9kSg6NWrbwWmpAumie42ubhMIKmfN0K2
dEZ7d49SC/5VImJu2a48Witm3E8/2w==
=eWLT
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--


--===============1863056988781265701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1863056988781265701==--

