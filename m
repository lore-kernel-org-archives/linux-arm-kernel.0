Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED63C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71E021929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AquKQmzh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CgSbVqPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71E021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ryzZ+j2jIxlrEZSVCUAggrXohVO8etMCGuxHmeB2YaY=; b=AquKQmzhMlfPLoCvP1so5pEts
	XvbV+3KF9a2jpyzMBZD4W+OcVjf5timFBBTNuEkgM8DglwTz6MJo7Q9gXPl31YBVtiludVgs+Yj8O
	+uEaYVnFb95eRxWorKlDwgvl6gthVccM2ESmh+Bu0d3s5Yz5bmp3PBPkhJQ+UCQchIS4FiCSXQvA2
	PX2lQf5h1XPmoB+IMonxsRObrQy9xPpBxl93/1CYZoQ1UqC2rofUcXYet1Yle0HBZ0rt8GQRK8mam
	zA4YL4vNy85lgTIX56qAJ7JFSWgARNtkclxVDtE2fR2MPoH63shZan/mm6fjTLjUHl/UkfMfHk/A4
	FZ9REgmlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guc0W-0006od-Iw; Fri, 15 Feb 2019 11:50:16 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guc0S-0006o7-Kj
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 11:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c95PgAzIO6iaZB/cwfuElNDev1u2tploAESUHa9b+sU=; b=CgSbVqPRIVE/W/Eq63wfC/Art
 5IpaWVksoBHrJoXzuSKdvl3iPh6LeVmYBVdClF4nonxFe/MI+sXpIpl144Hs1Tb8R5BK52dAfE3W4
 0M9DW0kVUQh5b6ATNfHOGM5FmQRoXUMyN1/RtAwPfKX2mHBF0k0yi1Rtq+Hx4t9QK5F2I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1guc0I-0006Dw-9P; Fri, 15 Feb 2019 11:50:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 2C1A41127748; Fri, 15 Feb 2019 11:50:01 +0000 (GMT)
Date: Fri, 15 Feb 2019 11:50:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
Message-ID: <20190215115001.GA7897@sirena.org.uk>
References: <20190215013959.21320-1-natechancellor@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190215013959.21320-1-natechancellor@gmail.com>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_035012_831662_CBF96618 
X-CRM114-Status: UNSURE (   6.84  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8673449970637339707=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8673449970637339707==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2019 at 06:39:59PM -0700, Nathan Chancellor wrote:
> After commit cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR
> implementation"), Clang builds for arm64 started failing with the
> following error message.

Reviewed-by: Mark Brown <broonie@kernel.org>

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxmp2YACgkQJNaLcl1U
h9DQjgf+Ip4Cg39+BMHVOwgGtQZ8sGLb2muZVuewBtYYoXWujQ/2ACbqGpUTK+l6
bCINCYohI10vWmLlO+pVkjae1tgZ3zVaSxlL/+Kcjf9FjLpWDda2TB1kg39VOd23
mxV+V9uYHJGdtUGaxqp3hSecfUU9isXHugsfakzgxbWagq7h55RRY++4ZUGPAoGw
yed8jvoYDJBVYvpSFAnZsf330/do0f6obFAq5UAUZrRIivc3kPgZo/KAoF92bo2m
rLna+hwqvRt7Xi6YwEH2QZ+CPMfIITK4Rgoc10vzMGs3RNLfJLbUlf3j6zOPn51D
V85AXuaop5+IPMC8l89jVsRJwJXnug==
=uD/V
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


--===============8673449970637339707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8673449970637339707==--

