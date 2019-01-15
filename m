Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E92C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C3520866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJtgfiXE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LZ81sli+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C3520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sFED3mVltAb6q4S6mAPdtaIoqZT0vbtjQ/bRSwerMmA=; b=JJtgfiXEMETii0Idw+43SxGrv
	gxrcuMWA0g0lfWZc98ox/Gho/9c8QiQcPChFjFdjO2ZiJujtirTLJbIaHTmlprZ3VNi9n0DHYNWWP
	ArHX1yXQyzKqcUJHJ3/OBPydKLO730XYzoNdecurtgKEtlcC7MO1ohYxzBAco0hkUuEMxZtkZCqwr
	gojvy06oq/8I+o3HqAKIEOKmA4WVQGaJcq6GwIjIP2M5OR53EGJZ4ZU08bQdp4GkEZ+Zs5Dsascua
	wqo1VtvV45aBWpPmvCcQiXCPcBk03VzXxpe8ecjdjPmnHt9qwiVs+TJOJ79uj5iL7pc0SNYLWnoNa
	EO3JoxsqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQeU-00083C-RW; Tue, 15 Jan 2019 15:29:18 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQeS-00082m-3u
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:29:17 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c3dfc2e0000>; Tue, 15 Jan 2019 07:28:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 15 Jan 2019 07:29:15 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 07:29:15 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 15 Jan 2019 15:29:14 +0000
Date: Tue, 15 Jan 2019 16:29:11 +0100
From: Thierry Reding <treding@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
Message-ID: <20190115152910.GA12652@ulmo>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo>
 <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
MIME-Version: 1.0
In-Reply-To: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1547566126; bh=GivISyv5wDifw3bU4wrS5ZESZcrE9h8tpoH0rPhfzoc=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:
 Content-Disposition;
 b=LZ81sli+r63/kTW0onfgk4XLvffHXKSNK4kV1cG1nz28HRMSyaJMkLvTPYl0/18HB
 GKXfLQnMh9kNnMNjvxbqgeaQ6jvhCnVT77nwJyVuaag2bvasnYSHy+4brc1Xtu5hEq
 RJzm0uVd2Bk9d4sN/Q7vxewVoA4s9s3+/yVZFe6Yq5vz4AxSmtD5COtz6WJ/5+Rd7y
 Q8MPlHlgTdX4sa5c/eJopQBOtjJlIHeCQcflSU+eQv8N7FzuxhqACIV+tXP1bNUhsh
 eeRvvyKG1TG9TbTSWFK54JxBWtZKf+BWQncRd2QCq4lEpNbGzsnze0OUQx3Xn3AYIm
 PT/RWtPYq2AuA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_072916_164982_13B7579E 
X-CRM114-Status: GOOD (  21.23  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: multipart/mixed; boundary="===============6096260513435541759=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============6096260513435541759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 04:38:20PM +0000, Robin Murphy wrote:
> On 14/01/2019 16:09, Thierry Reding wrote:
> > On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
> > > This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
> > >=20
> > > That patch broke IOMMU support for devices, which fails to probe for =
the
> > > first time and use deferred probe approach. When non-NULL dma_ops is =
set
> > > in arm_iommu_detach_device(), the given device later ignored by
> > > arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
> > >=20
> > > Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> > > Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iomm=
u_detach_device()"
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >   arch/arm/mm/dma-mapping.c | 12 ++++++------
> > >   1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > Can you point out exactly what drivers break because of this change? We
> > need to find a solution that works for everyone. Reverting is only
> > marginally useful because somebody will just end up wanting to revert
> > the revert because a different driver is now broken.
>=20
> At first glance, it sounds like what we really want is for
> arch_teardown_iommu_ops() to completely clear any ops that
> arch_setup_dma_ops() installed - does the below suffice?
>=20
> Robin.
>=20
> ----->8-----
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922e447c..1e3e08a1c456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
>  		return;
>=20
>  	arm_teardown_iommu_dma_ops(dev);
> +	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
> +	set_dma_ops(dev, NULL);
>  }

Seems to work fine on Tegra:

Tested-by: Thierry Reding <treding@nvidia.com>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw9/EIACgkQ3SOs138+
s6FxyQ//ZXUg6+LaxF3qtCgUCjlJAxBQEY573IAkyXQRnqOtvp01En0lJhfI5fRy
oPY84NIYecY/Okx9GKAnsOSZ3/qDKN+XwHiwEnIF8Jwom8zDholM7xxHdQQDBxCE
QW9pHFDVVxNlm2tI1S//+Rrb/V8mSbxt/4Ufn9pOwh9ZEghQgyAVzXM8O0WYr+lu
ddkl/u50sBNO3VfJPTUP4gJFMus1RuYV35U37hqdgZNK9Scy8aB2ocpk0phA5LK1
7kX/jrFSkCw9mvGgnBH1Lqfwxl4ts6c+MWSz8A7tNFOhFystJLi7qQOkYHujU1on
yAFaC7Mq8VuUdigXsQ3pyTxBLQFAm/ifV1ut44VXnZU3OIuSCJHPHoVL9FnO3237
bqQBvA8LxO9mWsP9GFaHs38TaMkD1hoLispjSeZbRNa+EvI8xRBsqOBIW5mvXE8p
p125mj1mNIKdzOtmh2x1tFrorXMT6JgpD4AkDyj8450dpKeT73CELCntYkvdBzyh
pV8XidIaT1ilF5s2UOYzY8od4QeH1RyMIPiqCZHQQzqnx5U+u7KBeyCBi4osqtCj
pDwGeMuz6IxnPdKJRnfVIgOpq1YTelR/SknqK5mEI8vJGqHKDLsLWZRN0+kPB1dh
u9abmsyph4ctT+vL1gy8xh0moEBIBix0C7rodaP2MzxfrymikjM=
=hfU3
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--


--===============6096260513435541759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6096260513435541759==--

