Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7950C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:50:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B0C21920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lg1daX0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B0C21920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v3otiGvgjgqocU9a/EsZ2rBMlvxJqukJabarmXkFwB8=; b=Lg1daX0hhk6hJ4oXh6GQ1zkeD
	w9pBt2E/nbFOtVm2K4GTRjpXLbh9H/7Ge+ve4f9ENakbnjTZ7mlEknskMro3K4HlDV5wuyHV+i2eY
	MtfrOfnGA4uBhyHDrCfOE9fSDE7uvXNCU31e4+TYM+1Q3fXNodIxyCYukPMezAKBv65pefW5377Qp
	4qqNKd+c5veRSP0FU4dwzy8BzcS3bQQ8n+YftbxvvroeCxv0yvGLD8jLX8vqlu4O4WbMDn7k1aZgX
	F+5pdyeWnsR2QRuAnolxcYTECiQrtnHfs52ozNyezfRB7nK5/KWX3X46b3mTEhpMHQmm+Zv3xOl4F
	GW5HWuhzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaM8O-0005FI-F0; Fri, 21 Dec 2018 14:50:40 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaM8K-0005Bk-HL
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 14:50:38 +0000
Received: from localhost (p54B334FA.dip0.t-ipconnect.de [84.179.52.250])
 by pokefinder.org (Postfix) with ESMTPSA id ABBF62E3542;
 Fri, 21 Dec 2018 15:50:22 +0100 (CET)
Date: Fri, 21 Dec 2018 15:50:22 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Message-ID: <20181221145022.umsugdwadw5a5ag6@ninjato>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_065036_878374_436FD8D5 
X-CRM114-Status: GOOD (  18.96  )
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Lukas Wunner <lukas@wunner.de>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3249551461770272162=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3249551461770272162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2jmrr4347zzegwl"
Content-Disposition: inline


--s2jmrr4347zzegwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > I think this might be as simple as adding:
> > >=20
> > > 	if (WARN_ON(adap->dev.parent->power.is_suspended))
> > > 		return -ESHUTDOWN;

Peter, I think this should work for muxes, too, or? The i2c_transfer()
call to the mux will not be rejected, but it will be later when we reach
the root adapter. And then the error code will be pushed down the tree
until we arrive at the mux again. So, the rejection will not happen at
the earliest time, but it will happen. Is my understanding correct?

> > I have seen this flag but decided against it. One reason is because it
> > is marked as "PM core only".
>=20
> Right and we definitely should not be touching it, but reading it should
> be fine.

Seems like it. So far, no rejection from the other PM people :)

> No you are right, there is a race here, but I don't think we are likely to
> hit that race. Normally there won't be any ongoing i2c-transfers during
> a system suspend and more over, the goal of adding this check is to help
> find problems, so even if the check sometimes does not trigger because
> of the race that is not really a big deal.

You are right that the impact of a missed detection is not fatal. That
helps. The low likeliness was not an argument for me, though, because
detecting rare things is very important IMO. Because, well, they are
rare and especially hard to debug.

> I think we need to get really unlucky to have both a suspend ordering
> problem in the first case (already a somewhat rare thing) combined with
> hitting this race in such a way *each time* that we don't trigger the
> WARN_ON.

And here you convinced me: even if we miss a detection once, I agree it
is super super unlikely to hit the race every time.

> To me this seems a case of perfect being the enemy of good. When we
> first started discussing this you wanted to not have to modify the
> adapter/bus drivers for the check, using adap->dev.parent->power.is_suspe=
nded
> gives us that and it will also work for complex cases like
> the i2c-designware case, so I believe the benefits outway the downsides.

I'll try it.


--s2jmrr4347zzegwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwc/aoACgkQFA3kzBSg
Kbb5bQ//URYlNvbXXExtMF0qLfiMDARGWqfm2kgBo2NeAlG+mCOpUuKOdjzF2Xbc
32cnfKCyw1bvKLMTyLLdaEzuQihOCUlKSsc1le6qepNiOvedI6Tp9XfS17Q6Z73K
fJLIjImgM5ZHOEN0y2GnSfz3QxM265h5VUBqyZzfkAddi5QrDwDP1wniTXVrw0Z7
04q1EQ1ypXbgvkHgRtnzg/gv5OkmovUEV7QBFS9U8RchgiXmYOvlJZkR/l4ZW60K
PEqv6IuBgfC6ikHMaRyovnhVm2jiEm6bsLi/RgwJxxAWPwFJaFcF2hf4r6rnBSi4
sZrDP0jOQxKARqKaiRv/Szp2RlJY5f/PFsrmwDt/LD7F591vhVZdG8/mO4oYLphd
pKgnu2VBFENJVEMVZ76KbhAGz6J4mh+agjOlX0NKKXWO/au0+qFWVrcqJfP0VbiC
CL7Dux/fjMsBvmDwaawP0uR2dSsKgnL8YQhDDxjN9PXU/RmFzF1dpGaAa/nuXKVZ
8KsbZaricdNv+jrHLklZPTZi9a9hTJrOtjeTvbYt2DLpitZRdiTjtC6bds9sWisz
4SGO8KMgxm0tBMSwsTIYNmMA8d/5AdVMCtPxlrUXk7AgPFjzAhU/li+emcQ5pUO4
GkrPLtjbUll25du9Gr4O1I6qcq+x7hwgBr4uSClf63QizTK4L24=
=LQSI
-----END PGP SIGNATURE-----

--s2jmrr4347zzegwl--


--===============3249551461770272162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3249551461770272162==--

