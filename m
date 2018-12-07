Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4862FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:59:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1754420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jGy7Lxcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1754420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xCliXxCdgI3iG+F4i8eJNYGz2u0DFTw6pMNLnLeZkuk=; b=jGy7LxczaompM9
	EeWvdRb+0OxtV0OXaI6vledQfY3lAw40m/6V89xdYTLQyuw8/XgZMaIv75M23y6vWgI1L8zSYpfnG
	hoI2gErej6Nh4HYSG+GCJ8UueyKrxbnt7alOX1XhB2sYfIRNwIafFJQjt4i/3V5Jl+jprE/Z0yXg4
	lozPWtV/Yxw0Kz64zn1Dry1nIS480dPg2iaiXzgLQgDSDRdSHGbvieAs3ekuluOZXw72QNQ2GrUBB
	GftvMHa92RsoFO3zgCcY2c02hGMPqUU1A+gVmdev1TQcIm0p2e+0UK5lNtsuFNkxj8poxJfH+A9V6
	ylqlSxa89lPK3kQRSIYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVMHf-0003mJ-PC; Fri, 07 Dec 2018 19:59:35 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVMHc-0003j3-Kc; Fri, 07 Dec 2018 19:59:33 +0000
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0002BAF;
 Fri,  7 Dec 2018 19:56:27 +0000 (UTC)
Date: Fri, 7 Dec 2018 11:56:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
Message-Id: <20181207115626.dd578402f407e3df798aad0c@linux-foundation.org>
In-Reply-To: <71168447-7470-d2ba-d30e-200ff6202b35@deltatee.com>
References: <20181107173859.24096-1-logang@deltatee.com>
 <20181107173859.24096-3-logang@deltatee.com>
 <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
 <71168447-7470-d2ba-d30e-200ff6202b35@deltatee.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_115932_690955_246BF451 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: linux-arch@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
 Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 10:40:31 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:

> Hey Andrew,
> 
> On 2018-11-07 1:12 p.m., Andrew Morton wrote:
> > Acked-by: Andrew Morton <akpm@linux-foundation.org>
> > 
> > I can grab both patches and shall sneak them into 4.20-rcX, but feel
> > free to merge them into some git tree if you'd prefer.  If I see them
> > turn up in linux-next I shall drop my copy.
> 
> Just wanted to check if you are still planning to get these patches into
> 4.20-rcX. It would really help us if you can do this seeing we then
> won't have to delay a cycle and can target the riscv sparsemem code for
> 4.21.
> 

Ah, OK, I assumed that it would be merged via an arm tree.

I moved 

mm-introduce-common-struct_page_max_shift-define.patch
mm-sparse-add-common-helper-to-mark-all-memblocks-present.patch

to head-of-queue.  Shall send to Linus next week.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
