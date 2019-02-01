Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059FC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:19:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149CF2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bEnpBidQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149CF2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8eY8R5wI/jRGbt/9cKvcKktwOjiQSY/WGIA0PjP1N5g=; b=bEnpBidQAMbvYa
	gzNVb/mOO9F2+3Gffebm8eCIszeiJbM5SiKrTrZMXdApkUUgUuS+aBaMdHmvju+1JWCQltLOCscRB
	w6VGz+YWZJVO41oI+OJ/g5Owxnvsjo8+IQ425KuLmMMn9Q7O+zFuY9riPH4YYqEazzWM8GD4ipNz0
	R0nOywKAu8dp9QT/5J4fl1Tr1AZgpeUoIWvh5Ok3e6OUdQp/sga8xPS5hfW5kySVi81tQ6h4Q3nSM
	BUvn/g3fAGYgMb32Uat1qsOB/DJAwva7cs63iIum2G3dFvECg4/GUlLFstmCpsZFoOz5cBQ3+sObX
	S6WGHZ2j8nJmj3lHrzoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpVv5-0007jK-57; Fri, 01 Feb 2019 10:19:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpVv2-0007iu-5R
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 10:19:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7B515BE;
 Fri,  1 Feb 2019 02:19:26 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB9843F71E;
 Fri,  1 Feb 2019 02:19:24 -0800 (PST)
Date: Fri, 1 Feb 2019 10:19:19 +0000
From: Will Deacon <will.deacon@arm.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <20190201101919.GA26637@fuggles.cambridge.arm.com>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_021932_210701_FC49C8CD 
X-CRM114-Status: GOOD (  15.03  )
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
 linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Russell,

On Fri, Jan 25, 2019 at 09:03:57PM +0000, Russell King wrote:
> Executing loops such as:
> 
> 	while (1)
> 		cpu_relax();
> 
> with interrupts disabled results in a livelock of the entire system,
> as other CPUs are prevented making progress.  This is most noticable
> as a failure of crashdump kexec, which stops just after issuing:
> 
> 	Loading crashdump kernel...
> 
> to the system console.  A workaround for this is to use 10 nops in
> cpu_relax().
> 
> We also use wfe() in while (1) loops to avoid burning cycles in a
> tight loop, giving the CPU a hint that we're not doing anything
> useful.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> It's been a while since this was posted, Will's suggestion was to use
> 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> these infinite-not-doing-anything-ever loops.
> 
>  arch/arm/include/asm/barrier.h   | 2 ++
>  arch/arm/include/asm/processor.h | 6 +++++-
>  arch/arm/kernel/machine_kexec.c  | 5 ++++-
>  arch/arm/kernel/smp.c            | 4 +++-
>  arch/arm/mach-omap2/prm_common.c | 4 +++-
>  5 files changed, 17 insertions(+), 4 deletions(-)

Thanks, this looks good to me and your explanation later in the thread makes
a lot of sense:

Acked-by: Will Deacon <will.deacon@arm.com>

Feel free to put some of the erratum writeup that I shared in the commit
message, if you like.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
