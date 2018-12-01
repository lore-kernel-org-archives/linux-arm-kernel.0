Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:03:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C24A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JOxhex16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C24A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=19Caxx6CDOrzgbyWAgn4QZwI27L8hK7lMcPX2Bd2yWU=; b=JOxhex16/aD9+i
	5lTdR25u1sNseNal4uQHTMQmFuphNbjTgosVRl9mmCz9gHOE7rCc3rJMN+kB6miR/d7OOPcMs3m4Y
	EOkpjxjJiqb6nRcU0MyDssfcs2KEylYF3ojX3+auxBNlJByNCui5YxH2TS95upxFWocpya07vCSHu
	UeX4y3+nyMnaRJJJdcPQ42ke0s+ssgDZbTfi50rnowXY8rarbL65/RSH/ujiIWQdokxrQSjcmqmch
	j48BVwifxd0/tF0OU1oo2C0EhMN3emR/Q4tkX9HC3eit5nwbRB2Sk98TwGc8p1aNT7URxfx/AgFiE
	pZJbUYI8VuYEU2P+o45Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT8g8-0007GO-4F; Sat, 01 Dec 2018 17:03:40 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT8g5-0007Fl-8G
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 17:03:38 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id BD4726732A; Sat,  1 Dec 2018 18:03:25 +0100 (CET)
Date: Sat, 1 Dec 2018 18:03:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Message-ID: <20181201170325.GD20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-5-hch@lst.de>
 <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_090337_441521_6470FB09 
X-CRM114-Status: GOOD (  13.16  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Ren <ren_guo@c-sky.com>,
 Laura Abbott <labbott@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 07:05:23PM +0000, Robin Murphy wrote:
> It's a bit yuck that we now end up with arch_* hooks being a mix of arch 
> code and not-actually-arch-code, but I guess there's some hope of coming 
> back and streamlining things in future once all the big moves are done.

Yes, I hope we can use some form of common code here for most
architectures eventually.  But that will some time.

> I can't really be bothered to nitpick the typos above and the slight 
> inconsistencies in some of the cosmetic code changes, but one worthwhile 
> thing stands out...

I'm usually fine picking up nitpicks.  For now I'll apply the series
with the pointed out fixups, but if you want to send the fixups
I'd be glad.

>> +	val = gen_pool_alloc(atomic_pool, size);
>> +	if (val) {
>> +		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
>> +
>> +		*ret_page = phys_to_page(phys);
>
> Looks like phys_to_page() isn't particularly portable, so we probably want 
> an explicit pfn_to_page(__phys_to_pfn(phys)) here. Otherwise, the 
> fundamental refactoring looks OK.

Ok, I'll updated it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
