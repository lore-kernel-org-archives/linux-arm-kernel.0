Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FDA217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DHGZ3Og9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FDA217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DlKqA0PaeRPZP9zaaGfkxhKubIxWxGwncYwUCSjrGU4=; b=DHGZ3Og98cHpWttMhrIrmeZJH
	gYE6922pNVyIjuifG9/6AhZn+GXZY6aOwfsLIQ68JC5F5QhSNhbJb4/us3+FfGhB9koj6zr4pf0qL
	ENFpgCyBzOA8/H2fi6SC7bIhQu1+QAofFlMUyLFTgu9es5cV+VKLjZfvMHUF0y2RH2X0e0w5WcQmT
	xVGhZFkZYmav/Pqv/pVd/WhJO7WlgY1V1x0LMza4y2XY5NlCG6PkwKZatYTGDD2ZH8xlE8XS/nfJ0
	B4eE/tjHbxM/BAPFEc1PZ8mluVB1tstJrvWgqP/nHDZjeFRM0+/WCPxMA0mKbJM3oPIuaIht+qDz0
	xMi62JxQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLrR-00072a-Dc; Fri, 04 Jan 2019 09:33:49 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLrN-00071m-OG
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 09:33:47 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 7895080961; Fri,  4 Jan 2019 10:33:36 +0100 (CET)
Date: Fri, 4 Jan 2019 10:33:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v6 07/13] arm64: add basic pointer authentication support
Message-ID: <20190104093340.GA28150@amd>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-8-kristina.martsenko@arm.com>
 <20190103202901.GA21564@amd>
 <681a2835-1a70-f3c3-3534-7b4cf6139cac@arm.com>
MIME-Version: 1.0
In-Reply-To: <681a2835-1a70-f3c3-3534-7b4cf6139cac@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_013345_942866_53AC87AF 
X-CRM114-Status: GOOD (  18.50  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 linux-kernel@vger.kernel.org, Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: multipart/mixed; boundary="===============4363254044426437682=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4363254044426437682==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-04 09:21:30, Marc Zyngier wrote:
> On 03/01/2019 20:29, Pavel Machek wrote:
> > On Fri 2018-12-07 18:39:25, Kristina Martsenko wrote:
> >> From: Mark Rutland <mark.rutland@arm.com>
> >>=20
> >> This patch adds basic support for pointer authentication,
> >> allowing userspace to make use of APIAKey, APIBKey, APDAKey,
> >> APDBKey, and APGAKey. The kernel maintains key values for each
> >> process (shared by all threads within), which are initialised to
> >> random values at exec()
> > time.
> >=20
> > ...
> >=20
> >> +/* + * We give each process its own keys, which are shared by
> >> all threads. The keys + * are inherited upon fork(), and
> >> reinitialised upon exec*(). + */ +struct ptrauth_keys { +	struct
> >> ptrauth_key apia; +	struct ptrauth_key apib; +	struct ptrauth_key
> >> apda; +	struct ptrauth_key apdb; +	struct ptrauth_key apga; +};
> >=20
> > intstruction_a, data_a, generic_a? Should be easier to understand
> > than "apdb" ...
>=20
> ... until you realize that these names do match the documentation,
> which makes it even easier to understand how the code uses the
> architecture.

See how not even the commit log matches the documentation then?

Naming something "apdb" is just bad... Just because the documentation
is evil does not mean it should be followed...

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwvKHQACgkQMOfwapXb+vId1ACfZu1/2mlOKgYdetcH5OjGU8y2
f8oAnjknOWchHLjiz4DjrU/M29jxFfKp
=vyqJ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


--===============4363254044426437682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4363254044426437682==--

