Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C240C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2523E20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qX6b2nnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2523E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WWUNlRs9i+9dS9Ee9XdJTsphXtbmwDGyYaHYqUgplu4=; b=qX6b2nnwGthWgU
	mQXIjlhAYwXal7BkymwblgZr2wlJuTFxXQsuVVmax4fZUmMcASysnyHQsKblPnSy4vbkrWWbb8PsW
	niTvb1Mrf7CWspmXyu2KJHAo5EdP7o9r8eRuXI72yYwBR8xPwpoJsUETynDQLAPFQ3rHU6f7VNCcz
	+4ySmK3vNmHe7KY/g0mWxB8ByfwZRly+IokhcSGCmXj50TqAUpbRrX0CZNfZ8MT5b6daRNrBxJbku
	ssMAPm5/LVaytofwE4nIV/roAO6v78Sbg2jguOuCgtz9JZdoTqm39de0AO9hRQ91qGSK0EhUAAF4x
	iQT2Dad5jjnXNUogJ0OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gloqg-0001uS-M9; Tue, 22 Jan 2019 05:43:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gloqd-0001ty-Fd
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 05:43:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD37A78;
 Mon, 21 Jan 2019 21:43:40 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C31E3F6A8;
 Mon, 21 Jan 2019 21:43:39 -0800 (PST)
Date: Tue, 22 Jan 2019 05:43:28 +0000
From: Will Deacon <will.deacon@arm.com>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
Message-ID: <20190122054326.GA6445@brain-police>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org>
 <20190120000117.GH26876@brain-police>
 <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_214343_526950_2D4C8D08 
X-CRM114-Status: GOOD (  16.64  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 11:35:30AM +0530, Vivek Gautam wrote:
> On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > > Adding a device tree option for arm smmu to enable non-cacheable
> > > memory for page tables.
> > > We already enable a smmu feature for coherent walk based on
> > > whether the smmu device is dma-coherent or not. Have an option
> > > to enable non-cacheable page table memory to force set it for
> > > particular smmu devices.
> >
> > Hmm, I must be missing something here. What is the difference between this
> > new property, and simply omitting dma-coherent on the SMMU?
> 
> So, this is what I understood from the email thread for Last level
> cache support -
> Robin pointed to the fact that we may need to add support for setting
> non-cacheable
> mappings in the TCR.
> Currently, we don't do that for SMMUs that omit dma-coherent.
> We rely on the interconnect to handle the configuration set in TCR,
> and let interconnect
> ignore the cacheability if it can't support.

I think that's a bug. With that fixed, can you get what you want by omitting
"dma-coherent"?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
