Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC64C67838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:41:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C483208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m957rjQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C483208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Z5h6+vTTZgD/3m+exPMImuwWW8MX1Vz93IDQzX/KKmw=; b=m957rjQeD/epiY
	y0T8F4XxPDFVGuLr6aRsr9P+ZwkedsPSx8CwWHPm94HHIMx9pCp1297lizxreMXKUOinaVhih7Gu7
	r0nvdrVAVLTM3gxm0OkkiVhqMYKmWOQmsNSFDPJJNgRW25hKZ2BqMiNZBI/rS/X8xNrKqNYgchQTA
	oovFHLrFP1ZEQEl08PeHgQfMuuOpIm7YBU7cHQWoyNPSGjN4qON1YJKlRQrWMRGMqlq6sUQRYnN5N
	6XQyARraP9v0DIArwPmCvGZK3deaO7fv51mkuX1kQy7NUmG0/C02pihXZEVB8OlKLYcMYEE15gV7u
	SCrnKSncGauD+M+ojiRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgbT-0000eu-I8; Sat, 08 Dec 2018 17:41:23 +0000
Received: from [184.48.100.57] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgbM-0000YE-Am; Sat, 08 Dec 2018 17:41:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: make the non-consistent DMA allocator more userful (resend)
Date: Sat,  8 Dec 2018 09:41:09 -0800
Message-Id: <20181208174115.16237-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
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
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
 openrisc@lists.librecores.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[sorry for the spam, had to resend due a wrongly typed linux-arm-kernel
 address]

Hi all,

we had all kinds of discussions about how to best allocate DMAable memory
without having to deal with the problem that your normal "coherent"
DMA allocator can be very slow on platforms where DMA is not DMA
coherent.

To work around this drivers basically two choices at the moment:

 (1) just allocate memory using the page or slab allocator and the call
     one of the dma_map_* APIs on it.  This has a few drawbacks:

       - normal GFP_KERNEL memory might not actually be DMA addressable
	 for all devices, forcing fallbacks to slow bounce buffering
       - there is no easy way to access the CMA allocator for large
	 chunks, or to map small pages into single device and virtually
	 contigous chunks using the iommu and vmap

 (2) use dma_alloc_attrs with the DMA_ATTR_NON_CONSISTENT flag.  This
     has a different set of drawbacks

       - only very few architectures actually implement this API fully,
	 if it is not implemented it falls back to the potentially
	 uncached and slow coherent allocator
       - the dma_cache_sync API to use with it is not very well
	 specified and problematic in that it does not clearly
	 transfer ownership

Based on that I've been planning to introduce a proper API for
allocating DMAable memory for a while.  In the end I've ended up
improving the DMA_ATTR_NON_CONSISTENT flag instead of designing
something new.  To make it useful we need to:

 (a) ensure we don't fall back to the slow coherent allocator except
     on fully coherent platforms where they are the same anyway
 (b) replace the odd dma_cache_sync calls with the proper
     dma_sync_* APIs that we also use for other ownership trasnfers

This turned out to be surprisingly simple now that we have consolidated
most of the direct mapping code.  Note that this series is missing
the updates for powerpc which is in the process of being migrated to
the common direct mapping code in another series and would be covered
by that.

Note that these patches don't use iommu/vmap coalescing as they can
be problematic depending on the cache architecture.  But we could
opt into those when we know we don't have cache interaction problems
based on the API.

All the patches are on top of the dma-mapping for-net tree and also
available as a git tree here:

    git://git.infradead.org/users/hch/misc.git dma-noncoherent-allocator

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-noncoherent-allocator

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
