Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68C321019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ji+uqd3B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HiiQVwlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68C321019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=iQqz1GO0wbXvqb4pwQnRV4MbfbH1lpu+ny1UDAONkp4=; b=Ji+
	uqd3BUyLbyLeYI0wW0Cgp33uhwDotyQ4M1iQBCC3ZerKB0Y3brA9p6YdUMg79vVzSxknLQYjsGIXY
	OuWvCUe75ZLdV07I+BcoFAiG+aRCWFwy1cXnZa4dh4xOB9OYAhTjyeMS01dvdu5xoLXl1zY4rUeuc
	Rq0e+IeZeLUElQBwgStFAVlU25aL6c9cOn6TDqEsaMckywVsJhlAdrW7rJWCBQPKbyzflukR9xJDx
	XpaRFPU+z9dMibTGQQR+mTosnAR/qAo15DefjnIdWnnxBB1mCrgJRWEsQsFuT2qZmfuWHrFKV82VV
	zHB+7sqRx4zRbCKyZqsWLMf6bHNj7nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy5By-00022K-06; Mon, 25 Feb 2019 01:36:26 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5Bt-00021s-Rq
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 01:36:23 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4474KW3xFnz9s9y;
 Mon, 25 Feb 2019 12:36:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1551058576;
 bh=5D0Pok9c7S0G7IhF+MP9PbpmghFNJVDqX6CJARVsmBs=;
 h=Date:From:To:Cc:Subject:From;
 b=HiiQVwlmWkXfN0wD1Kc5+c8L1rMiSDnWfnnXvELUSX4UN1A7K7SKUr/eGz6O7TQ/Z
 bItZE2MVGnxzHMFXi+fq7CtdBcNAklygcIP07v9ZELUtUAQvzrZ6EkhoAQrtdQ1+CY
 lg1oYJPV1wn3MUpVKY9m0Vj53gf8yNLJKdXs19wRa9gLmS8NVXxabaQVuv8ycjqDFS
 XQKGumgrPMenDrfnImfpMLTmTx3WYLPYfdx4EcIZdP/2VsMXXvXyLJo1YS6TzKC7I9
 duA59KvpkUQQNpeJjLo94FEmxeqVfQGFX8FzhvDwtjJOXsmfYqbaM9HIgsP3s+UiKt
 DBJnvIASxwMMQ==
Date: Mon, 25 Feb 2019 12:36:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Takashi Iwai <tiwai@suse.de>, Olof Johansson <olof@lixom.net>, Arnd
 Bergmann <arnd@arndb.de>, ARM <linux-arm-kernel@lists.infradead.org>
Subject: linux-next: manual merge of the sound tree with the arm-soc tree
Message-ID: <20190225123615.49bce7cd@canb.auug.org.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_173622_301245_84F1E4E0 
X-CRM114-Status: UNSURE (   8.60  )
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
Cc: Thierry Reding <treding@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============7678860418112035776=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============7678860418112035776==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gOUuL6Xp8A/fATV3sl+Fm2t"; protocol="application/pgp-signature"

--Sig_/gOUuL6Xp8A/fATV3sl+Fm2t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Today's linux-next merge of the sound tree got conflicts in:

  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi

between commits:

  5eef17ee764d ("arm64: tegra: p2972: Sort nodes properly")
  be4f0dd347ad ("arm64: tegra: p2597: Sort nodes by unit-address")

from the arm-soc tree and commit:

  11ce4308307c ("arm64: tegra: custom name for hda sound card")

from the sound tree.

I fixed it up (see below - in tegra194-p2972-0000.dts. the line added
just needed to be moved up a few lines) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 34a7044927fd,39c616737232..000000000000
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
diff --cc arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 8780b5b3d2b9,6096dfb7e17a..000000000000
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@@ -1317,15 -1303,6 +1317,16 @@@
  		clock-frequency =3D <100000>;
  	};
 =20
 +	sata@70020000 {
 +		status =3D "okay";
 +		phys =3D <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
 +	};
 +
 +	hda@70030000 {
++		nvidia,model =3D "jetson-tx1-hda";
 +		status =3D "okay";
 +	};
 +
  	usb@70090000 {
  		phys =3D <&{/padctl@7009f000/pads/usb2/lanes/usb2-0}>,
  		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-1}>,

--Sig_/gOUuL6Xp8A/fATV3sl+Fm2t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzRo8ACgkQAVBC80lX
0GwojQf/axAwG3MvV2YIiXYaY4KBVgwJ8snq1sGpPg1o3rEOz7ykmsKRHTKXT2nV
u4LWA3nV7wJfFBk+r5CzV3gin4WVnaALVwByfHajr/cm3HKgLYQ7bIDRszV7CTUI
zowX38D7+oYbKVTjOYGs7ET/3u+3q+IKLS8frBt3YLHntkuz6/xXADt2u7v2sEVO
EAO4ru6wQ647NFMJroPUDhsNYULHyjPizvDy0Ii0Kg8lj2Cor8q4xiN79Z314CZb
9FLBj+YhEjygYRKUU8uXuPGFzzI4JxV2VMSTxH8e7gBMk9vw4wakPLNquzCUlA2k
gJv6w966C3F8M5sqf2F3nulFp8ptOA==
=iJlS
-----END PGP SIGNATURE-----

--Sig_/gOUuL6Xp8A/fATV3sl+Fm2t--


--===============7678860418112035776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7678860418112035776==--

