Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E2C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1878E218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ixqXbZwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1878E218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zdDXXTLfZSteqAI7JwutAIG58qqq9WQeiLLHZBYRgHw=; b=ixqXbZweK0If4q
	fnHMoAQsv0zqE8lhazpmqyYbg/PfhOeVnGafjxwxtNV96AUcb72cMEjsOtSp2ah57mhyKNYhL7dxb
	7n5fV1Yp9Fe7uUEvCzrRqsQLVMcRdzNQXlg1IdertIXbpw6lMFFp9EgKNNyXGVeqKdGnzZsRJ5U4v
	UOtLRkYHIkA0lBOIEROKRR4k/66uzocci2IyHK5ZODlXmwHpIjrcO5ztOypK4C58UD8swMx7vGcmV
	SIgJEToYCyKgkwLOmdsUwhFjRFsJtbEjlgWr/TleilULOJuRZi7Pdj0Q33XQKdTkTnKqXRuWh4wQ1
	rvhTm126jAM7ccJSUNSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtE3O-0006Yz-GY; Mon, 11 Feb 2019 16:03:30 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtE3K-0006YL-QZ
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 16:03:28 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 54EBB68DD6; Mon, 11 Feb 2019 17:03:25 +0100 (CET)
Date: Mon, 11 Feb 2019 17:03:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 06/19] dma-iommu: fix and refactor iommu_dma_mmap
Message-ID: <20190211160325.GC27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-7-hch@lst.de>
 <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_080327_008808_7D00F48A 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 03:02:23PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> The current iommu_dma_mmap code does not properly handle memory from the
>> page allocator that hasn't been remapped, which can happen in the rare
>> case of allocations for a coherent device that aren't allowed to block.
>>
>> Fix this by replacing iommu_dma_mmap with a slightly tweaked copy of
>> dma_common_mmap with special handling for the remapped array of
>> pages allocated from __iommu_dma_alloc.
>
> If there's an actual bugfix here, can we make that before all of the other 
> code movement? If it's at all related to other reports of weird mmap 
> behaviour it might warrant backporting, and either way I'm finding it 
> needlessly tough to follow what's going on in this patch :(

The bug fix is to handle non-vmalloc pages.  I'll see if I can do
a smaller and more bandaid-y fix first.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
