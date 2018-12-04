Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC73C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA77D2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="toelAKQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA77D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gWqX6p3qfzRJvtYiZRYvauxIHGFtEOW3nwP+mj89WSw=; b=toelAKQ6SDffTF
	ulPwiYIcuR0E8Bhq8ElxmbF37YbPMpPL7msDEWtcXVInjDcxS6pak55N38Wmhjg5+DRgJ9YzzY4ay
	36uWsOIrAiBjsb1R1rofZoIROKTVXVYxX50G97nVSC8rh8aypPqoKibMctGgXATLUzQHLxh4kFQSA
	H5xYNCwBGyOFwL8JzKGqKBwoUR7GfdXkBHUbzBB60c8AacGAkoqEd3Fk8StqpKnmiK349nhqH5hOH
	PKIkI2j6Tfg1MccKvhDIxPTjVrXQwY7jNDhXRgxDjN7G0S/AzILSDJ83OoCoAZDR0W4ontOkqIIjN
	f5AGMJhdwKJ+zojBuetQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUET5-0003BY-VX; Tue, 04 Dec 2018 17:26:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUET2-00039Q-KE
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:26:42 +0000
Received: from vmware.local.home (unknown [208.91.3.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABD9A2081C;
 Tue,  4 Dec 2018 17:26:29 +0000 (UTC)
Date: Tue, 4 Dec 2018 12:26:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181204122627.225befaa@vmware.local.home>
In-Reply-To: <20181204111242.GA32596@arm.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com>
 <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
 <20181204005012.11f73df9@vmware.local.home>
 <20181204111242.GA32596@arm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_092640_680780_6F711BD5 
X-CRM114-Status: GOOD (  16.29  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018 11:12:43 +0000
Will Deacon <will.deacon@arm.com> wrote:

> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 8ef9fc226037..42e89397778b 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -2393,11 +2393,14 @@ void __weak ftrace_replace_code(int enable)
> >  {
> >  	struct dyn_ftrace *rec;
> >  	struct ftrace_page *pg;
> > +	bool schedulable;
> >  	int failed;
> >  
> >  	if (unlikely(ftrace_disabled))
> >  		return;
> >  
> > +	schedulable = !irqs_disabled() & !preempt_count();  
> 
> Looks suspiciously like a bitwise preemptible() to me!

Ah, thanks. Yeah, that should have been &&. But what did you expect.
I didn't even compile this ;-)

> 
> > +
> >  	do_for_each_ftrace_rec(pg, rec) {
> >  
> >  		if (rec->flags & FTRACE_FL_DISABLED)
> > @@ -2409,6 +2412,8 @@ void __weak ftrace_replace_code(int enable)
> >  			/* Stop processing */
> >  			return;
> >  		}
> > +		if (schedulable)
> > +			cond_resched();
> >  	} while_for_each_ftrace_rec();
> >  }  
> 
> If this solves the problem in core code, them I'm all for it. Otherwise, I
> was thinking of rolling our own ftrace_replace_code() for arm64, but that's
> going to involve a fair amount of duplication.
> 

If it does, then I'll add it. Or take a patch for it ;-) 

My main concern is that this can be called from non schedulable context.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
