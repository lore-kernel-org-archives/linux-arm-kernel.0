Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D9C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31D22087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O4NuUH/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31D22087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5d7I/pTka4yhju5rzeFHOrG3wFR96qDgH8oN8EesWoE=; b=O4NuUH/vOVk3EB
	iQfWu6AInb5thGbwXiSoZZGs/pyibX6fH/KxBCqkJSLWxCEoknX5AIExxwIGlEuv3jNbyP0Kh+FFl
	M5URXvw60jddFMC7jkKZqsKaT3R+3NSb0A3QgtHcXxNigu2zCXufQHdg/FwQvYYn+OZ4iTB2d+upa
	rUgfkqa4NwI3bJkO6JCjeAs12EbGghCdla2ro+7pF61/D2fGdJ5fCh0JfF3LIs7UkJ2muPqT40Wls
	5qW5Sz6SSczitF8VCYT7IgUvLocyRCxEWgJaPAvcQAs9njeWR+0PyDLBgfTfmd8+/Wbem7eK3rX65
	R9LXKL2+OOlaCbjgcEZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouUj-0001QG-F2; Wed, 30 Jan 2019 18:21:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouUY-0001HU-0p
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:21:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAEA180D;
 Wed, 30 Jan 2019 10:21:41 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312693F557;
 Wed, 30 Jan 2019 10:21:40 -0800 (PST)
Date: Wed, 30 Jan 2019 18:21:37 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Message-ID: <20190130182137.GN18558@fuggles.cambridge.arm.com>
References: <20190128094301.151252-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128094301.151252-1-drinkcat@chromium.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_102142_911509_EC2C5C52 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 05:43:01PM +0800, Nicolas Boichat wrote:
> L1 tables are allocated with __get_dma_pages, and therefore already
> ignored by kmemleak.
> 
> Without this, the kernel would print this error message on boot,
> when the first L1 table is allocated:
> 
> [    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
> [    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
> [    2.831227] Workqueue: events deferred_probe_work_func
> [    2.836353] Call trace:
> ...
> [    2.852532]  paint_ptr+0xa0/0xa8
> [    2.855750]  kmemleak_ignore+0x38/0x6c
> [    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
> [    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
> [    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
> ...
> 
> Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> I only tested this on top of my other series
> (https://patchwork.kernel.org/patch/10720495/), but I think the same fix
> applies. I'm still a bit confused as to why this only shows up now, as IIUC,
> the kmemleak_ignore call was always wrong with L1 tables.

Yes, I managed to reproduce this on top of -rc4 (see below). I suspect you
/are/ the intersection of people using v7s w/ kmemleak, so this has just
lingered and never been hit until now.

For the patch (assuming this is going via Joerg):

Acked-by: Will Deacon <will.deacon@arm.com>

Will

--->8

[    0.124473] kmemleak: Trying to color unknown object at 0xffff8000042d8000 as Black
[    0.125312] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc4-00012-g40b114779944 #1
[    0.126181] Hardware name: linux,dummy-virt (DT)
[    0.126680] Call trace:
[    0.126950]  dump_backtrace+0x0/0x140
[    0.127346]  show_stack+0x14/0x20
[    0.127706]  dump_stack+0x90/0xb4
[    0.128066]  paint_ptr+0x94/0xa8
[    0.128417]  kmemleak_ignore+0x54/0x60
[    0.128991]  __arm_v7s_alloc_table+0x6c/0x240
[    0.129661]  arm_v7s_alloc_pgtable+0x10c/0x188
[    0.130359]  alloc_io_pgtable_ops+0x44/0xb0
[    0.131006]  arm_v7s_do_selftests+0x84/0x4bc
[    0.131663]  do_one_initcall+0x74/0x178
[    0.132253]  kernel_init_freeable+0x188/0x220
[    0.132923]  kernel_init+0x10/0x100
[    0.133460]  ret_from_fork+0x10/0x18
[    0.142102] arm-v7s io-pgtable: self test ok

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
