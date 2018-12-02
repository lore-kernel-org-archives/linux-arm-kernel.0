Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3EAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5A52081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="usNwvQn0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b7tjqRIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5A52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vj31o8jYT5MYUqSKNUeS03N2mUOI1AVu5w4p3KYydmg=; b=usN
	wvQn0nqRjkpDMzDIMVezUvSrareWaQElIriGxr0UoQeCgc2x1QKwjWGmiJVr3DzB2oYBD5vtoctUb
	uxPMsGNgie4xCh31DSnseLwc3jALYqvB+Jo9MhdEzsq50Cpog4DfgdGMPfvZgWnrBRw4lBcesMskN
	nMI680rTNO6rTFlp34ia5fAhQKSaiLVZMt6/db9ZwKgx3xKpJTa7nIc70x5IzczkA6wsb0HWYpt9b
	kICIp69D7wpBao+71OJCOn2D7b7flMDSwR5w17xZAG9ZqDmylU93gemsSZkcYg0xX0x8cRlsFMd1D
	wFVjmJugZNZ7icH4ZcBdlZvYJKRaOrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaCN-00055c-NZ; Sun, 02 Dec 2018 22:26:47 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaCJ-00054b-RN
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 22:26:45 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 437N5H1Djzz9s47;
 Mon,  3 Dec 2018 09:26:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1543789587;
 bh=7ZuWb/iry3L60djYiiSGpAf7zGKhe7yQxwKzjQNk/y8=;
 h=Date:From:To:Cc:Subject:From;
 b=b7tjqRIETwIID+PvFXyhSwea1CprhD6zPs0GuRHigcguv+AKy1uiL+BqooeQZwfq9
 36kwDyeSeQeX3+IqTAmOL0oI0vLfAW7m43JsEwUvu5fIniqYxW2REoE+vqm/iS1Qhl
 exXzHlFl5xB27pjv7uKPOUTx62u1VT6vvU+xRu566oeBh8QTn7mhNm5x113sAU0bVL
 bG33kxlkTcX0O5in+sEfJ9mPDiclUuq3lwqC01mlcl4SD38JZUeR52HXuPya8KoQJ/
 /kiTyKjB9UhGLbHOUbtHPrG3RdsIfapQlr2UbcVq0710PN8I9kV/uRoPGppkYHSYc/
 izWGEpc5/2Yzw==
Date: Mon, 3 Dec 2018 09:26:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Philipp Zabel <p.zabel@pengutronix.de>, Olof Johansson <olof@lixom.net>,
 Arnd Bergmann <arnd@arndb.de>, ARM <linux-arm-kernel@lists.infradead.org>
Subject: linux-next: manual merge of the reset tree with the arm-soc tree
Message-ID: <20181203092626.7f1ab2f5@canb.auug.org.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_142644_066344_B1D42117 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: Dinh Nguyen <dinguyen@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 =?UTF-8?B?Q2zDqW1lbnQgUMOp?= =?UTF-8?B?cm9u?= <peron.clem@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============6673129984731366999=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============6673129984731366999==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6+JRWsYlHtqSZBx10FeT+8L"; protocol="application/pgp-signature"

--Sig_/6+JRWsYlHtqSZBx10FeT+8L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

Today's linux-next merge of the reset tree got a conflict in:

  arch/arm/mach-socfpga/socfpga.c

between commit:

  8f6f8c77fc4d ("reset: socfpga: add an early reset driver for SoCFPGA")

from the arm-soc tree and commit:

  48e2bab90d8e ("ARM: socfpga: Clean unused functions")

from the reset tree.

Note that it is generally a bad idea to declare extern functions in c
files ... the declaration should be in some header file that is included
by the files containing the definition and usage.  That would
have also removed the need for the forward declaration in
drivers/reset/reset-socfpga.c.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-socfpga/socfpga.c
index 5fb6f79059a8,cc64576c102b..000000000000
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@@ -32,7 -32,9 +32,9 @@@ void __iomem *rst_manager_base_addr
  void __iomem *sdr_ctl_base_addr;
  unsigned long socfpga_cpu1start_addr;
 =20
+ extern void __init socfpga_reset_init(void);
+=20
 -void __init socfpga_sysmgr_init(void)
 +static void __init socfpga_sysmgr_init(void)
  {
  	struct device_node *np;
 =20

--Sig_/6+JRWsYlHtqSZBx10FeT+8L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwEXBIACgkQAVBC80lX
0GwlFwf/ZvuY4YXQnBH4c26EhsKjK5qLAR1or+i2kALicm5U3PfoIbwJHkq6wmL+
BzutVSJYd+a1LMVdbOV3ayY4bu4In5GuSmsKC35vBqGF9TY8ORZde1hZalIcsG5A
AMQEr7bbhnTWC+L0RFx6lE3NLShh4VzGLAXlT7sxTzlR7sEUYMexIhFFpPQSgMII
neYawUX2PROpF/+9BbVMKhxIDS0Lgsm8Y6ujiTbeCqoHGrobTnY5R0lTBUV8NL18
hOYUGrSPO38E3t8aC1K6jwHFGb1fWJ1cc4HK1Vn/H92HEuP12boqZjbClNfMOMek
bbcxbNO75piJCDp+O5ndgyzKKKD3og==
=F0UW
-----END PGP SIGNATURE-----

--Sig_/6+JRWsYlHtqSZBx10FeT+8L--


--===============6673129984731366999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6673129984731366999==--

