Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:18:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4C820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tQxxL11K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G8Q6ZTt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4C820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=M+eIbJuk0h5zcNHd+dbo04aozSB5IVibEa+6iPSqEmE=; b=tQx
	xL11KImloUezGpgp9UAx88ekAxBIaYkXAJm7QroWNNjiNRgg2ECRQw7TGvYS5M1tQjHnbL1V3DnSM
	wthReslSmzdIJBdkJ8MUkOWgEiceYBNeP/nkHFpusLKj7zEpKcgUKN++qwwtkjJguWeE868+PJtc+
	PX6gNYdhc6MMOytBGNHm1m4PxeRueghE7qZeGLTxyDoLNYYLkcCMGV24t9VICgaKmOU0UXK7uNB5m
	NKHBnfK0+LabbqSzdkp3WDfJJ9Hed1x0WTBmf3afHbEYmE7Nl9pw70+w/IbIcIiUVW+O2Xa9IvrOD
	9n3On8eNueU11Mp9RfKVa9T5oXZz/PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYo6Q-0004H4-Sc; Mon, 17 Dec 2018 08:18:14 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYo6M-0004Fv-TF
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:18:12 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JDYG2v6nz9sBh;
 Mon, 17 Dec 2018 19:17:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1545034674;
 bh=5Qbj8eSY6BK+H/tUVFNjmPy3YvUik7VE2iiT+3NDq68=;
 h=Date:From:To:Cc:Subject:From;
 b=G8Q6ZTt8Gf6xZnzwQFabOmMIw5OhBOABkgKED8LCFxfN8BBYgoxRPN2mYYsjVk/X5
 Jj99gCugf5cHsWmbKjpQOX6eVV8xIC+cxO7ioBfD/+UO/wrM0kYFS8OmW3CEfeZSE4
 1c1YEC4Tj0GMa4nbV7QLW2giDaTtGPxlqI0WMe6qy56qOproowtMsiyIniHvsfJd+e
 L3ZqvRyZobq2+Y4e+LB6VD6rTkzCbvOKoTZqtuL93SMxwmUiISP2U2HLz050pl1prN
 x9qwaSGf2zuAuixEz3B7Dnrp/jA65w7fVxrx6dSNARSAdgPX0HbHoJ20yfBRsZ2/Hn
 SbBbSD0YQ76tA==
Date: Mon, 17 Dec 2018 19:17:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Walleij <linus.walleij@linaro.org>, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, ARM
 <linux-arm-kernel@lists.infradead.org>
Subject: linux-next: manual merge of the gpio tree with the arm-soc tree
Message-ID: <20181217191753.172ca200@canb.auug.org.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_001811_185941_B9B0AC12 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: Tony Lindgren <tony@atomide.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============9109510925460654687=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============9109510925460654687==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CvY/7uXN8E.YOrGdwkkP4B1"; protocol="application/pgp-signature"

--Sig_/CvY/7uXN8E.YOrGdwkkP4B1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio tree got a conflict in:

  arch/arm/mach-omap1/board-ams-delta.c

between commit:

  19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED d=
evice")

from the arm-soc tree and commit:

  21abf103818a ("gpio: Pass a flag to gpiochip_request_own_desc()")

from the gpio tree.

I fixed it up (the former removed the code updated by the latter, so
I used that) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/CvY/7uXN8E.YOrGdwkkP4B1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwXW7EACgkQAVBC80lX
0GxrnAf9Hudx1lEWXTwWV/OlWQv+f6TR21Eart36sf/jj2GPbpXVNvDNKSN9f2HO
Rhu6bU3St4uMWuKXAw+5W9F45A4gynKuHMrFZIu9XAlZpXCSschg16X83GOzuddf
wStMikfOsGpXbnM0oXD4/z6CO8iTa42flOcomwMujvAomG/+EJ39XCwVGFuuw3pN
u6wWuSrcDWqDjgzQTGjAJlkocOOgeJDutRAqLS/6Zf5hcML3QIIj8dt9yd6osWZf
Vf97/GoZvjNVqeBJUPz0zxgvzJwj6GH+brvU8LjqOA1/Mc4ZZuXFY2mOyZGm2dy+
79kihxZiRgSM6mT5QWa9l5mDkY6Abw==
=nITP
-----END PGP SIGNATURE-----

--Sig_/CvY/7uXN8E.YOrGdwkkP4B1--


--===============9109510925460654687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9109510925460654687==--

