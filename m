Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C52BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:09:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0011720844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbKFcsyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0011720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y6JqgZPmt2NPqSlchAtosg0T4K5QpIVoPPPisErasAQ=; b=ZbKFcsyObPHRVw
	NOFbN3QhjvujkfBTllyrPC7UeUe+cKY0H1IdjHME5JbZQ/FniBhjnkVJGJL5Yc6VYfkxxrqQqeJxB
	fu+GGwcZE4x0dCb+ztbZHoV0HQOG+ZtyLcpjXelD89tcxInqYjO6uqM+cbyowLtfSablYHsP3uc9z
	spz8Jo/Ybt76x7DtrFnTw6350Rj1AXnDiSF+E3qJvG1mcCNsG6vZZpA8KZAlOvNVjxFm7pFmcuSPO
	BMmfx5IBPvp159UdqrARZzvEyuOCkeAr2iTKjFL6XWh3Ssq82+f7sb32v/E/Z/Biwo1+ScaV4akRg
	R2dyubPFEYOSC22yQniQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNt5-00026V-9x; Wed, 06 Feb 2019 14:09:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNt2-000266-9N
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:09:13 +0000
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28B7D20844;
 Wed,  6 Feb 2019 14:09:09 +0000 (UTC)
Date: Wed, 6 Feb 2019 09:09:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190206090907.311259df@gandalf.local.home>
In-Reply-To: <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_060912_356313_F1A6F304 
X-CRM114-Status: GOOD (  23.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Torsten Duwe <duwe@lst.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 6 Feb 2019 08:59:44 +0000
Julien Thierry <julien.thierry@arm.com> wrote:

> Hi Torsten,
> 
> On 18/01/2019 16:39, Torsten Duwe wrote:
> > Once gcc8 adds 2 NOPs at the beginning of each function, replace the
> > first NOP thus generated with a quick LR saver (move it to scratch reg
> > x9), so the 2nd replacement insn, the call to ftrace, does not clobber
> > the value. Ftrace will then generate the standard stack frames.
> > 
> > Note that patchable-function-entry in GCC disables IPA-RA, which means
> > ABI register calling conventions are obeyed *and* scratch registers
> > such as x9 are available.
> > 
> > Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> > after ftrace_trampoline, and double the size of this special section.
> > 
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > 
> > ---
> > 
> > Mark, if you see your ftrace entry macro code being represented correctly
> > here, please add your sign-off, As I've initially copied it from your mail.
> > 
> > ---
> >  arch/arm64/include/asm/ftrace.h  |   17 ++++-
> >  arch/arm64/include/asm/module.h  |    3 
> >  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
> >  arch/arm64/kernel/ftrace.c       |  114 ++++++++++++++++++++++++++---------
> >  arch/arm64/kernel/module-plts.c  |    3 
> >  arch/arm64/kernel/module.c       |    2 
> >  6 files changed, 227 insertions(+), 37 deletions(-)  
> 
> [...]
> 
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -133,17 +163,45 @@ int ftrace_make_call(struct dyn_ftrace *
> >  	return ftrace_modify_code(pc, old, new, true);
> >  }
> >  
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> > +			unsigned long addr)
> > +{
> > +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> > +	u32 old, new;
> > +
> > +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> > +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
> > +
> > +	return ftrace_modify_code(pc, old, new, true);
> > +}
> > +#endif
> > +
> >  /*
> >   * Turn off the call to ftrace_caller() in instrumented function
> >   */
> >  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >  		    unsigned long addr)
> >  {
> > -	unsigned long pc = rec->ip;
> > +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;  
> 
> Sorry to come back on this patch again, but I was looking at the ftrace
> code a bit, and I see that when processing the ftrace call locations,
> ftrace calls ftrace_call_adjust() on every ip registered as mcount
> caller (or in our case patchable entries). This ftrace_call_adjust() is
> arch specific, so I was thinking we could place the offset in here once
> and for all so we don't have to worry about it in the future.

The ftrace_call_adjust() is there in case what is saved in the mcount
table is different than what is needed for the addresses. Which this
looks to be the case here.

-- Steve


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
