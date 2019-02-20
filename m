Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55582C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2469C2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6xcByia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2469C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KnS5kgjKQuECpYD758agkdGxjK8988lXin//SqWBhI4=; b=u6xcByiaFaHNBK
	63fLlQQgSo6dtAqKaix1gRwoxvO+r3RX7ld6a9GO5N1rd7U9Yy5PM3wNtPTr+1EsIzKJct+UuG/CK
	Dq/b5DsCrsa8qppoxMrzXbxqIJmnnjHDl4MS9FE2lbDXSAHFecXocCxWbHAm+7nHcY0FkAI2hs7+a
	TIFB2gkv3r3L1goy5JTBnJeA2vdrzzDxYqcuUYtRV1qWiJTRCG6CvCfDX0tQYCAJq64Z10uGALDnU
	GiEzKMnmuVgX+SuQJ3gB+OZSocS2SLxToNXx65ytyn2N21YIeB5Am6e2PkN07LW4J5jbeiUHkkNKL
	AH3PoZSII73fzLIXtrVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwO0U-0001D6-W3; Wed, 20 Feb 2019 09:17:35 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwO0Q-0001Bd-Fo; Wed, 20 Feb 2019 09:17:32 +0000
X-UUID: 4b0e6ac92ee9429294c885f44de1eec0-20190220
X-UUID: 4b0e6ac92ee9429294c885f44de1eec0-20190220
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1194367230; Wed, 20 Feb 2019 01:17:20 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 01:17:18 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 20 Feb 2019 17:17:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 17:17:15 +0800
Message-ID: <1550654235.26244.10.camel@mhfsdcap03>
Subject: Re: [PATCH v6 21/22] iommu/mediatek: Fix iova_to_phys PA start for
 4GB mode
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Wed, 20 Feb 2019 17:17:15 +0800
In-Reply-To: <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
 <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_011730_532380_1C716DA8 
X-CRM114-Status: GOOD (  24.10  )
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
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Matthias
 Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-19 at 15:33 -0800, Evan Green wrote:
> On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In the 4GB mode, the physical address is remapped,
> >
> > Here is the detailed remap relationship.
> > CPU PA         ->    HW PA
> > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > 0x8000_0000          0x1_8000_0000 ...
> > 0xc000_0000          0x1_c000_0000 ...
> > 0x1_0000_0000        0x1_0000_0000 (No change)
> >
> > Thus, we always add bit32 for PA when entering mtk_iommu_map.
> > But in the iova_to_phys, the CPU don't need this bit32 if the
> > PA is from 0x1_4000_0000 to 0x1_ffff_ffff.
> > This patch discards the bit32 in this iova_to_phys in the 4GB mode.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 0277396..076d333 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -119,6 +119,19 @@ struct mtk_iommu_domain {
> >
> >  static const struct iommu_ops mtk_iommu_ops;
> >
> > +/*
> > + * In M4U 4GB mode, the physical address is remapped as below:
> > + *  CPU PA         ->   M4U HW PA
> > + *  0x4000_0000         0x1_4000_0000 (Add bit32)
> > + *  0x8000_0000         0x1_8000_0000 ...
> > + *  0xc000_0000         0x1_c000_0000 ...
> > + *  0x1_0000_0000       0x1_0000_0000 (No change)
> > + *
> > + * Thus, We always add BIT32 in the iommu_map and disable BIT32 if PA is >=
> > + * 0x1_4000_0000 in the iova_to_phys.
> > + */
> > +#define MTK_IOMMU_4GB_MODE_PA_140000000     0x140000000UL
> > +
> >  static LIST_HEAD(m4ulist);     /* List all the M4U HWs */
> >
> >  #define for_each_m4u(data)     list_for_each_entry(data, &m4ulist, list)
> > @@ -415,6 +428,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >                                           dma_addr_t iova)
> >  {
> >         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >         unsigned long flags;
> >         phys_addr_t pa;
> >
> > @@ -422,6 +436,10 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >         pa = dom->iop->iova_to_phys(dom->iop, iova);
> >         spin_unlock_irqrestore(&dom->pgtlock, flags);
> >
> > +       if (data->plat_data->has_4gb_mode && data->dram_is_4gb &&
> > +           pa >= MTK_IOMMU_4GB_MODE_PA_140000000)
> > +               pa &= ~BIT_ULL(32);
> > +
> 
> The define doesn't really make it much better, but I guess it doesn't
> make it worse either. As I was reviewing this I was thinking that this
> should be rolled into patch 6 "iommu/io-pgtable-arm-v7s: Extend
> MediaTek 4GB Mode". But I guess this was returning bad PAs since
> before this series, right? So does this need a Fixes tag?

Thanks very much for your reviewing so many patches.

Yes. The issue exist before this series, It was introduced by this
commit:
30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range for 4GB
mode")

I will send a new version to add this tag.

> -Evan
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
