Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1A12089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DVFovGPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1A12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mb3TCnOgNj0iN80BlLQcrihHoMyfl0ua84uyRUe2fTM=; b=DVFovGPA+9RWYeMKuK9oi7u+K
	XmKFNWljU3cLaG1m5l+44uR/7qGYeRdy09alQ6tyRp2GGtNhaDR7pp+BEm5hJntxDhJyIaz0ZORrS
	bD7nXuqKWAxzU3hcw3czkxmsaICg/bf9DT0mM3G5WyT81nJD89Z/tqHgK3SMmjJ/2r43zFIoTtl75
	DGv81SMQxNoZYFDyfxMgwUGw+rDb+f0KrwVOiltJwnTe2HRGQZOK4llQy4dRKWBQcXVhmfNXn55VI
	A2A8SvXoYwWb2VlMiSVP+Nj8OYeGuURyyco3tCwUxWx8Xx+iyVoc921U+sNtKBBw1p+FADodLqiMQ
	G0C078tVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLIe-0001o6-H5; Thu, 14 Feb 2019 17:59:52 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLHa-0000h5-6h
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:59:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16491EBD;
 Thu, 14 Feb 2019 09:58:45 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D053F589;
 Thu, 14 Feb 2019 09:58:43 -0800 (PST)
Subject: Re: ARM64 boot failure on espressobin with 5.0.0-rc6
 (1f947a7a011fcceb14cb912f5481a53b18f1879a)
To: Christoph Hellwig <hch@lst.de>, John David Anglin <dave.anglin@bell.net>
References: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
 <6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com> <20190214173642.GA2704@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fd389e6a-b10c-77fb-ac79-b15ffd805a7d@arm.com>
Date: Thu, 14 Feb 2019 17:58:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214173642.GA2704@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095846_579601_50E8037A 
X-CRM114-Status: GOOD (  22.70  )
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
Cc: dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/2019 17:36, Christoph Hellwig wrote:
> On Thu, Feb 14, 2019 at 05:27:41PM +0000, Robin Murphy wrote:
>> Oh wow, that driver has possibly the most inventive way of passing a NULL
>> device to the DMA API that I've ever seen, and on arm64 it will certainly
>> have been failing since 4.2, but of course there's also no error checking
>> for anyone to notice...
> 
> I did take a brief look and didn't see how we got the NULL device
> pointer, so it is well hidden for sure.
> 
>> This crash will be a fallout from 356da6d0cd (plus the subsequent fix in
>> 9ab91e7c5c51) that's otherwise missed Christoph's big cleanup. Obviously
>> the right thing to do is for someone to try to figure out the steaming pile
>> of mess in that driver, but if necessary I think the quick fix below should
>> probably suffice to mitigate the change in the short term.
> 
> The fix looks ok.  And for 5.2 I plan to explicitly reject all uses of
> NULL device arguments in the DMA API.  I've sent patches out for all
> the obviously problemetic drivers, and most of them got accepted by the
> maintainers for the 5.1 merge window.
> 
> It seems like the mv_xor code is mostly unmaintained as far as I can
> tell unfortunately.

Hmm, having felt brave enough to take a closer look, it might actually 
be as simple as this - Dave, are you able to give the diff below a spin?

Robin.

----->8-----
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7f595355fb79..fe4a7c71fede 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1059,6 +1059,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
  		mv_chan->op_in_desc = XOR_MODE_IN_DESC;

  	dma_dev = &mv_chan->dmadev;
+	dma_dev->dev = &pdev->dev;
  	mv_chan->xordev = xordev;

  	/*
@@ -1091,7 +1092,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
  	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
  	dma_dev->device_tx_status = mv_xor_status;
  	dma_dev->device_issue_pending = mv_xor_issue_pending;
-	dma_dev->dev = &pdev->dev;

  	/* set prep routines based on capability */
  	if (dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask))

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
