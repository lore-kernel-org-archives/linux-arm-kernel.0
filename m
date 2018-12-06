Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D12C67838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:09:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C01420700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iwfxea6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C01420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DGAD9+08fj5PMk5Y9uL1jip5Lw5j/S25uEX6pbhnmlA=; b=Iwfxea6CHzsvFG
	fAmy+R5mMn+Z1KDnBuHZpW+e4dJmUrh2ug7nhLcHcBzFF2AA+XXrtFPjSEjy4NZRIt/zOxOYnPHNW
	lTFs6EX14azCLqTIQhGGvCcbPYZQl36ymxNI1DoqVa+XeRacVAHKUzmqfAGU6YkDgBAV8y0661suY
	FhIRsnbzRlcQ9p0H5T6Cw67DZYDu8SFiFfQBgilRfUU03fxb58PH4+WFrIIK4+jaarT2pduj9UOjk
	EVzBsdlZ+Xm8LSvY2DUox5Sy+lGewkN2nKArncK/LB5T4uTC3VGYSybrUKUoIlyf22+tDfcTtOigR
	Dc5RMriTMkuGezVhikDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvGq-0002za-AU; Thu, 06 Dec 2018 15:08:56 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvGm-0002zL-Mm; Thu, 06 Dec 2018 15:08:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CD0A6200F9F91; Thu,  6 Dec 2018 16:08:50 +0100 (CET)
Date: Thu, 6 Dec 2018 16:08:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
Message-ID: <20181206150850.GI13538@hirez.programming.kicks-ass.net>
References: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: ard.biesheuvel@linaro.org, catalin.marinas@arm.com, rml@tech9.net,
 linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 05:34:29PM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I originally posted here:
> 
>   http://lkml.kernel.org/r/1543347902-21170-1-git-send-email-will.deacon@arm.com
> 
> The only change since v1 is that  __preempt_count_dec_and_test() now
> reloads the need_resched flag if it initially saw that it was set. This
> resolves the issue spotted by Peter, where an IRQ coming in during the
> decrement can cause a reschedule to be missed.

Yes, I think this one will work, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

However, this leaves me wondering if the sequence is actually much
better than what you had?

I suppose there's a win due to cache locality -- you only have to load a
single line -- but I'm thinking that on pure instruction count, you're
not actually winning much.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
