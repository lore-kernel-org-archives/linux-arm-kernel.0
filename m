Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A1C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB002084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="be37mWeO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qqia4I3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB002084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3A3lPmcsrcHoj79RPnhtKObAw81R3zGoH3X7wutuwvg=; b=be37mWeOvqKylyZG9LHM7vub7
	RJXRkAC9AFLLzBLbOt4MexlYFvXYawHwVuRuS9ROVXQfx+ZAcZxI2ko1BW1j4EkNn6TMDKHw8Z4/w
	6saR46N/WnGwG/sH6rCtTapcIYad8TuWqCnEhBsw0EOgQhrtF9TbCjhgEyhbIYNOJ8CSSxr14N1xB
	qvtEcwdJtc2l/m3DFAsJ92M7OYQTaFzlgnywSs7GfOem6VJYj7w1czWmcCEQuHOARn8qSeEvo2pj1
	VXVUsvTRdoyGDhlz5XFx8rWxstjX6o8AfTOtjpLWKwamfFl8SdbAeYXLFYZUNgDsvm94qMfpv3/+L
	G5CCBLjGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsuD-0001sf-Ma; Wed, 13 Feb 2019 11:40:45 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsuA-0001s9-PT
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D+jWwSUoa0VzooG62bZVqLf3M2j5wnfgEKAy1unGa1c=; b=qqia4I3V/Fkw5OlFYJhJmJRBr
 t2N2CyL+TZsuzq9uKoPnq+9w9UvW0BYP1JcHgwOaYnHuFb243SwgvjaLjbh8sA2eF06BOg+JvCZJu
 e/xMHlmScm/qn6PPzBwlttCUfcNwc4EKp7bElK9J6/6/Somc1qCHtHGJSM+wHIUPQ6lOc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gtsu2-0003vK-Lb; Wed, 13 Feb 2019 11:40:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id C0C5A1128158; Wed, 13 Feb 2019 11:40:33 +0000 (GMT)
Date: Wed, 13 Feb 2019 11:40:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: crypto: Disable xor-neon build when using clang
Message-ID: <20190213114033.GA7540@sirena.org.uk>
References: <20190212194645.32504-1-broonie@kernel.org>
 <CAKv+Gu-W2X32ZCqKsJVqSqyJ04UK2eoNCDKp=2OfsO1HhKaCuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-W2X32ZCqKsJVqSqyJ04UK2eoNCDKp=2OfsO1HhKaCuw@mail.gmail.com>
X-Cookie: Nothing is but what is not.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_034043_018005_AC564831 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jackie Liu <liuyun01@kylinos.cn>,
 Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will.deacon@arm.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============0698680290756221355=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0698680290756221355==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 08:33:57PM +0000, Ard Biesheuvel wrote:

> Can we just add the pragma to neon-instrinsics.h and be done with it?
> As long as Clang is not the dominant compiler, I don't buy the 'hiding
> real bugs' argument, especially since neon-intrinsics.h should never
> be included transitively, so it only affects source files that
> actually call NEON intrinsics.

That's fine from my point of view, when posting this I was basically
just going for the most conservative workaround possible.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkAi4ACgkQJNaLcl1U
h9Af9gf+NJGdFRUyiA4VuRHIoiRqhTqiG/JjnLWAW3gx9SpM2a8yJ6wmj8gUhSro
TEbq7cUiQ20VPSR3eAAlYFsg4qiuvefr6LvATcVglc+4zVkJO1Kn+qKMvBdLVin3
NuvgxsdKM0NHI3IENU14bosmgq8bQdn9dfaV1epGrRH2mhFQ48VLE16bUk8t3WqB
TDpXqGG0j+FC9o/73ttsceYMHSs06ZQXp6TKOtIBUa0L3BIw8N4NUhIlUMzJw8a6
PQtJixIM55+uIfNCQVJA0gS48pwhL7m/o3gMb2I7xsBO6ZxmCNDqu2idnen5lX58
sGGBCeUglJ+kkCYS4yTlJT0grchHhA==
=ECk9
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


--===============0698680290756221355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0698680290756221355==--

