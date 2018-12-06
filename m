Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617C8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314DA214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dxkdfjxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314DA214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=92rLwe0I/9/6WEJrz6uCfM57QF0673s9KydFzd7Gh9g=; b=dxkdfjxq8mHxKT
	qb83ntUoOWL9nZIQH6vv6dVMcvaNRrd0hx9XflVxkb8C1jNAERp81w4tIMKpR+FlM+mWiHfMEjYPh
	gxKfTdGBItL8pYLAQydSFSFQeyryqqAYzDQlHG1IoBCiM25yt1fk6maoCzePeuPsc8p6UFVIoalI5
	oMS+rCm8cN6MT2KFAK/P0V8YtK4X2ctQKAhmPHHnIVZ2Y/bMKYFNpsLa7/+16jWMG4vQQZ8uMPHbJ
	ZaTnMT3EDou8ZQ22U3j9Kt3lieC/+3/Sw/v+Ww/oMwL+iW+a2mywFGBICrtXraiaprQSvC/7Wzc1l
	Knotj8vkGyvhTN1MnWSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw3m-0002xM-UX; Thu, 06 Dec 2018 15:59:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw3j-0002wJ-ST
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:59:29 +0000
Received: from vmware.local.home (unknown [208.91.3.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C905214C1;
 Thu,  6 Dec 2018 15:59:17 +0000 (UTC)
Date: Thu, 6 Dec 2018 10:59:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/2] arm64: ftrace: Set FTRACE_SCHEDULABLE before
 ftrace_modify_all_code()
Message-ID: <20181206105914.7a29efa9@vmware.local.home>
In-Reply-To: <20181206132007.GB27744@arm.com>
References: <20181205174852.435233070@goodmis.org>
 <20181205183304.000714627@goodmis.org>
 <20181206132007.GB27744@arm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075928_109599_0BB1DC98 
X-CRM114-Status: GOOD (  19.66  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, keescook@chromium.org,
 arnd@arndb.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 13:20:07 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Dec 05, 2018 at 12:48:54PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > It has been reported that ftrace_replace_code() which is called by
> > ftrace_modify_all_code() can cause a soft lockup warning for an
> > allmodconfig kernel. This is because all the debug options enabled
> > causes the loop in ftrace_replace_code() (which loops over all the
> > functions being enabled where there can be 10s of thousands), is too
> > slow, and never schedules out.
> > 
> > To solve this, setting FTRACE_SCHEDULABLE to the command passed into
> > ftrace_replace_code() will make it call cond_resched() in the loop,
> > which prevents the soft lockup warning from triggering.
> > 
> > Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
> > 
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index 57e962290df3..9a8de0a79f97 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >  
> >  void arch_ftrace_update_code(int command)
> >  {
> > +	command |= FTRACE_SCHEDULABLE;
> >  	ftrace_modify_all_code(command);
> >  }  
> 
> Bikeshed: I'd probably go for FTRACE_MAY_SLEEP, but I'm not going to die
> on that hill so...

I like bike sheds. Hmm, it's not too late to change this. Perhaps I
will.

> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

If I decide to change the name to MAY_SLEEP, I assume I can still keep
your Acked-by.

-- Steve


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
