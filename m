Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D3C2F42E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:40:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F4920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oo7w0usB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iYoirHZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F4920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0x68Qml6WqE/DYAGDg7gffC7yf8zF1WvpNEu/RqgnvE=; b=oo7w0usBJnDGYsllQBQtEBsAq
	J1SlQJZOAXR7uEYKLVRmiKlxR+w2P1uQux1UMqOr0TQX+vT9QR+tut8FiN9vmBnkt3++8R6mjrovL
	fEZVLVkVIJmxQ8MmhIT5l0dwh612qVMimEumRdWIfj+7bYOboaDL15J7DR0ennXXPlypJKE1ovgbM
	nUBDZRmJnquSl3m+JDlLxuyHKy51/DIynWro0jQaC8BNYGJt6nFDWn0a9dZrpV77Oef1fjUjyDV9D
	TN/0aVvcbZ3zwxMQ6xlxn/0jqNKS5L+vgwZM8wjPG4eFG6klRGRzys96fOQyvR/oT6kLT/hfNcGRZ
	AmDOX8OBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbgB-0003Zv-Mi; Mon, 21 Jan 2019 15:40:03 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbb4-0005pV-TL
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:35:28 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c45e6710000>; Mon, 21 Jan 2019 07:34:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 21 Jan 2019 07:34:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 21 Jan 2019 07:34:43 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 21 Jan 2019 15:34:42 +0000
Date: Mon, 21 Jan 2019 16:34:40 +0100
From: Thierry Reding <treding@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] ARM: dma-mapping: Clear DMA ops on teardown
Message-ID: <20190121153439.GA21078@ulmo>
References: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
MIME-Version: 1.0
In-Reply-To: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548084849; bh=10LZ1mtxpIfqj+R9CVQkhdg+32AqVCTSZIVyHC9oUxM=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:
 Content-Disposition;
 b=iYoirHZ1CuEkXMqTPnnak45ZTCLsmEUxDlyYGhn1yGZ0qkxZCzc2EIGWEnDqNmlnI
 tXY+dzsLO769NT4XOfzo8Bx3097ShU5u1ti6kHD0qJQeJYUQV7iylcJF4qRH17+4Zw
 q2i+kRu0nbL7KpRZpGPNYWqFRRb4OjVErhhROB33df1i+h9IGbkXN26cHK76bOMDDk
 d+1MrtFG62YusvLz1ZWa0mocChM2j+RIAiCrwvYvhDuDZK9weoNUjukFj7jjzJHzX3
 fRS31qblheD6TqbKq0xXVuPswizofLV9bOYjYaoOg9Wlj0SoLYHFAhPLusoIs02TuA
 A6sVW8WxEGO5Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073447_736547_2C024E87 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: b.zolnierkie@samsung.com, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org, tjakobi@math.uni-bielefeld.de,
 iommu@lists.linux-foundation.org, bskeggs@redhat.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: multipart/mixed; boundary="===============8962879724582736315=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============8962879724582736315==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 02:52:16PM +0000, Robin Murphy wrote:
> Installing the appropriate non-IOMMU DMA ops in arm_iommu_detch_device()
> serves the case where IOMMU-aware drivers choose to control their own
> mapping but still make DMA API calls, however it also affects the case
> when the arch code itself tears down the mapping upon driver unbinding,
> where the ops now get left in place and can inhibit arch_setup_dma_ops()
> on subsequent re-probe attempts.
>=20
> Fix the latter case by making sure that arch_teardown_dma_ops() cleans
> up whenever the ops were automatically installed by its counterpart.
>=20
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_de=
tach_device()"
> Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> Sorry for the delay - there was a giant email infrastructure cock-up just
> at the point I wanted to go back through my archive and double-check the
> discussion around the original commit...
>=20
> Robin.
>=20
>  arch/arm/mm/dma-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)

I had also tested your draft on Tegra last week and this looks
identical, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxF5osACgkQ3SOs138+
s6Hu1w/+PREMHDE0jWgKBN3n9eINXN6aliHOhCeWQxco5/iJjCSeCofcMvFzuKx2
p8nZ8OfIMZvj4AatYeryqn7bPLSQiRfwVtC8qOfERTv7z+8m4F+o4rPSKmr0/1qI
rSqpTFY4exsTlp7Lp7DHsg2sbd0Av6UvgiNJSLpTLai0loCYfPuF+lvbdlw/x6wC
CNa6SBE+rI/u+QRNY1jRPkgEMovOnsvkKY4bf7+v3elI3X7bZhObqyNLnTLkNpYL
w01hvCpxpo4vrX12kTDzuhOxxnKF1md/QrlviZWl/K6CI5L/UqlP1ttSj3p5INna
nGQ4Zjr+ykq1enUBHlLwkfVGD7mV//BaVxvIyMtKtWewJ3YoQbPhrcWCAg1pqjJ7
C9ksb5Njf7vOyF5KPGdcyePUIVw7NaIytAQrRE3ww7iuZg78fBs7oxjdzyK4D6G5
+2DcaumIx18jwD44wP8g6z0foo1GgN6IitWoAcH/UhVX9ID/eMl5KNxHogW1N2bW
GJDagpZCD09vxmKBcYFctXGbL3RoLKS4+mVu93vjPNhRs813nXAPMC5E+NZcI6vZ
l7CYkq3/V6af54QGr7/0K87mIT6dIjkOCVYNjH4ZHPLjJolBZ8iS5636DyDoldk0
SlUgLWwfZ80fcqNh19syiJRaVIpW2CahirFJilXtoFd2cvDOLPM=
=LcGP
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--


--===============8962879724582736315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8962879724582736315==--

