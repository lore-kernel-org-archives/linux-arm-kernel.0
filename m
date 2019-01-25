Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D552BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A444520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GDPc92ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A444520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7/NLzWD3CBimXsjPhwZo5Ua+/hKpx3+ayy8DqB7jtf8=; b=GDPc92edRru8TA
	mw0L5kdIKurTbKav6fjSuAjnGPGpRAYQ4/hTg6+3uSzGIPAZnO1bOEAadZPjLCcIMkQdOxuBxdTGG
	TZY/vaJvy5z/L0+mM6Fs22mOLXomnOY56GTGCgMbcQiQwqVKSWOFMNiULuyufYE/b1e6OMgj9dUg1
	w7yj1Rr1p5nU4wAqmF8D+tVmvBoqGyzVr7lviSnxej2y5iSXyWVO/YxXaBnIg5OKTkCWk+DoTV6tL
	osl8i2GKpgz/hm9Tel8UcqaF71dkTE/HnUSKx18dL2Mu6BgjWky26DnAH7YTQipgv0YgDukeHPW6w
	N9w2t77OQfPpNPS1puDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnAlv-0000uQ-O7; Fri, 25 Jan 2019 23:20:27 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnAlt-0000tv-7W
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 23:20:26 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6239F806C;
 Fri, 25 Jan 2019 23:20:31 +0000 (UTC)
Date: Fri, 25 Jan 2019 15:20:20 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <20190125232020.GX5720@atomide.com>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_152025_335505_D704B2C0 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>,
 linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Russell King <rmk+kernel@armlinux.org.uk> [190125 21:04]:
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

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
