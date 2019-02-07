Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC68CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:25:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE782175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gHkSsHAm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O2c4Ycl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE782175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4lOsZ7XsaO1f0dLK1F1ljzRBjuPVzhKuCNfl9hnzHe4=; b=gHk
	SsHAmMIwYaLXssXLus5Tesh8UdD5hM+NPrja7ZkLwNoPt2kBoleAIDFv+ayvXdOzISWtogx2Zhjv7
	awOlFWu6OSXOxuGEasManYDNVr0Tamvzd6NE/7womnW+Uh9NGULV0dw0sEMlriibe6JhiID3vHBoP
	Lzc5mPSPRIViwzbVGxi3AvACIUoV888DSc/FDuFSUBO2zOMvsBy9pZbho4EFu+NkOsbAADKfBjPfv
	DCUcGR5Z8CcPl3qCoIasSwok2bNKlTg/m5Uc8yxiV2JkM582P39bBUBUxsuxmGDPA9x7FzRzdFBE0
	JI6c0Ao16jdB0v4yGCclPIZyBeWCKOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grYRS-00069L-6x; Thu, 07 Feb 2019 01:25:26 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grYRO-00068M-AX
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 01:25:24 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43w0x225wsz9sLw;
 Thu,  7 Feb 2019 12:25:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1549502711;
 bh=gGbamqHJf6wbfaPtlgZc1h5BSkkx9aFe/q3/FUo6vrc=;
 h=Date:From:To:Cc:Subject:From;
 b=O2c4Ycl217latYdMpF8rxD0ul6zmH+n+obEyMpr40l09iteH51C2QCL2/1xFAPlFV
 MTfobSLC/1IeIbp59RUvgdIiJcyNnIkh3u0qpUqLO7pELdDowD8bxo0oWwXp3C/YuW
 KabPgFszMkrWPtoi3UgO/Ae5h2YPrUc9XeH2omw5isrcOwpSm4fsMxxnSeJsk1Xl9r
 6x5KkWGn1DxViahXEPXNry8tYLEwFceFm1MQkCaGzrcVPfeqT3awcf4Ls0BTnY5nPK
 ZQADE/LBpQfwKKJyoOTQSMIL5wm3T5f+RdGCDq8G3IfKnjMaITM8NCz6v32/oHyJpV
 WrBuykLBVol/w==
Date: Thu, 7 Feb 2019 12:25:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <boris.brezillon@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew
 Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, ARM
 <linux-arm-kernel@lists.infradead.org>
Subject: linux-next: manual merge of the nand tree with the mvebu tree
Message-ID: <20190207122509.68144d86@canb.auug.org.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_172522_549767_C1AD98E3 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: Vladimir Vid <vladimir.vid@sartura.hr>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jianxin Pan <jianxin.pan@amlogic.com>
Content-Type: multipart/mixed; boundary="===============8099938602479517018=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============8099938602479517018==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/erH/6b8z4jz=/2fEeJwtDsJ"; protocol="application/pgp-signature"

--Sig_/erH/6b8z4jz=/2fEeJwtDsJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  MAINTAINERS

between commit:

  2e73bb33366d ("arm64: dts: marvell: Add device tree for uDPU board")

from the mvebu tree and commit:

  0f416a463ecc ("MAINTAINERS: Add entry for Amlogic NAND controller driver")

from the nand tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 2d958beee76f,e6b902c7c828..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9887,11 -9849,13 +9887,18 @@@ F:	drivers/media/platform/meson/ao-cec.
  F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
  T:	git git://linuxtv.org/media_tree.git
 =20
+ MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
+ M:	Liang Yang <liang.yang@amlogic.com>
+ L:	linux-mtd@lists.infradead.org
+ S:	Maintained
+ F:	drivers/mtd/nand/raw/meson_*
+ F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
+=20
 +METHODE UDPU SUPPORT
 +M:	Vladimir Vid <vladimir.vid@sartura.hr>
 +S:	Maintained
 +F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 +
  MICROBLAZE ARCHITECTURE
  M:	Michal Simek <monstr@monstr.eu>
  W:	http://www.monstr.eu/fdt/

--Sig_/erH/6b8z4jz=/2fEeJwtDsJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbiPUACgkQAVBC80lX
0GyH1gf/a6LAWUFi6kZSTqxMHXZFZj1xcglu51VmEcCgrCh9ooQvqF510dVdr9LS
21FvQrp7TvudZRef3PrL+dGX4HJGP7tT+5HlGID3f1mmrR1xnA6lOhY4ecThx8GY
Vk9yYxFFbuL3u7mCKlfevDmh1nw3kuGPfHcyLnkKEYgDKsQTNnuHUvBiwdtGhFq+
Fc12gV7BvSmrWt8OstFGO89sx1unQMJV9O2faWykT4OHhrO7ZDHFblUDEyVQH8IW
Gn82LWyi5RbjUpVi3nt4p8rDqTXVoQMm5q3ChMYVF1o68CO5NT2JVTIX9A4rOfVu
X8LhnLJp3iieUYLa71DsaL7MHujp4g==
=tYPF
-----END PGP SIGNATURE-----

--Sig_/erH/6b8z4jz=/2fEeJwtDsJ--


--===============8099938602479517018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8099938602479517018==--

