Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0099BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:22:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42BC2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YpxAtrEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42BC2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AdxRYoySStgFkGqlKYD1oh2hX+8vQ12FN5udd9bcrbY=; b=YpxAtrEjT21Rj+
	rFU6ZpE/2nRglbvq6gSqFg2iukiE1ByTDiO3DQXg7c67EmfhagagZi0HEvjXE/UzPyuTQFqI7A1v2
	6Gl1mSUNAoj+lKp+VezyJVBGdDF1tuCxBP3ecENiLLqjsczhir5cmLqyROMmACwZyPhNWoeFrcc2v
	x2s/5Kh3V3Ycy8fmGuk47Xb5swJZaVw8gCrphqjk0bks2oGWjfXPDlQbG48KmF4BYvlrx5XHcvjYI
	dsFTl0drfbWYxIoWFHXeUXeQbU7I6u9LShrgMF5MmrQ02MbfilVESH/aAyY/9UR9zo2g9YQrPSFBs
	gYfo6jt9HgeqsYHrV9fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtx2-0005RY-Gm; Fri, 11 Jan 2019 10:22:08 +0000
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtwz-0005QR-3q
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:22:06 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 4DAA3434; Fri, 11 Jan 2019 11:21:57 +0100 (CET)
Date: Fri, 11 Jan 2019 11:21:55 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20190111102155.in5rctq5krs4ewfi@8bytes.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_022205_312885_E1CDD1D2 
X-CRM114-Status: UNSURE (   7.77  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Matthew Wilcox <willy@infradead.org>, hch@infradead.org,
 Yong Wu <yong.wu@mediatek.com>, David Rientjes <rientjes@google.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 iommu@lists.linux-foundation.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> Does anyone have any further comment on this series? If not, which
> maintainer is going to pick this up? I assume Andrew Morton?

Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
this should go through mm.

Regards,

	Joerg

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
