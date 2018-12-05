Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF60C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:43:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A2120892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pwJFqGNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A2120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f/1nlYKZnwuD73vKxsHmeZ+h5yNdSceLiwyqJnr9haY=; b=pwJFqGNPclPP1I
	58mRNUYjvGUtpB9+jql7mLZVLkVSWPdHhro35x8CT83DfnRS9zfL/65fuSSBre38ocsjN88d3ua/R
	VuwNlNW96EqEa3Xs+yETSBA9zEaN7bvAaWIAE83+vTRH2d0mju7WiXH6uk+SdN8hZPveV3XF7M+u7
	DdlyEZW8mzNb5CyUe+pGtWE3yFF9w+z4Ggrd0EdrLpe/oI+W8rteeV6dsiWmzXEnXwIF5+NVhItgw
	6wVeQFPK4TZHbMC35kbogs971MIZgeK5PLimFUydP1HSZhd4zNrAqgpyBBKAsmJTsCsaDUWnCG2Vo
	z/JRfwxpB1u/IyX3R3sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYON-0007gj-Rk; Wed, 05 Dec 2018 14:43:11 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUYOK-0007gE-O2; Wed, 05 Dec 2018 14:43:08 +0000
Date: Wed, 5 Dec 2018 06:43:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Message-ID: <20181205144308.GA28409@infradead.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-4-drinkcat@chromium.org>
 <20181205135406.GA29031@infradead.org>
 <1d211576-9153-cca1-5cd0-8c9881bd3fa4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d211576-9153-cca1-5cd0-8c9881bd3fa4@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
 Christoph Lameter <cl@linux.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Huaisheng Ye <yehs1@lenovo.com>, Joerg Roedel <joro@8bytes.org>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Yong Wu <yong.wu@mediatek.com>, David Rientjes <rientjes@google.com>,
 yingjoe.chen@mediatek.com, Vlastimil Babka <vbabka@suse.cz>,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 02:40:06PM +0000, Robin Murphy wrote:
> 32-bit Arm doesn't have ZONE_DMA32, but has (or at least had at the time) a
> 2GB ZONE_DMA. Whether we actually need that or not depends on how this all
> interacts with LPAE and highmem, but I'm not sure of those details off-hand.

Well, arm32 can't address more than 32-bits in the linear kernel
mapping, so GFP_KERNEL should be perfectly fine there if the limit
really is 32-bits and not 31 or smaller because someone stole a bit
or two somewhere.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
