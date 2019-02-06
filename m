Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61068C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECCA2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mYK+feoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECCA2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tV72YSYYEFsQzr/+/qQNlrEOsFM0zUU0+ZR3lCrZo5k=; b=mYK+feooWqGXtw
	+1bW/OqL0sZtrkOc0isKROu30q0Zy/QpUeReEgSbkB4I9ouAjYTABUUTe2GqdK1vQ2fsRl/LSxIdG
	tcMbMGO5bDmRQk1AHlkz9MuC6BBGo0G1OylBupbNiU0YE3VbjglcHoVEfWOUoYiiyGin/pdO3Iv+g
	beOyLGMJhUSpKa1izZVxLEc3QSyji41FC1zclg7WwW7d2NMk9MNDm9YJqEke8rzZSaPO7E+W5s6E6
	agVfN57NfBV7pRcf18h7FzxyYMXKnI02R4oA7Q7pBRcCi8QPPv5zJNPQ7apZ7rRnKiDKCwyNO4w4R
	R1wNjGZ8hpV4wJgKlR+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOld-0000CK-OO; Wed, 06 Feb 2019 15:05:37 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOlZ-0000BL-FD
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:05:35 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id B3CA168D93; Wed,  6 Feb 2019 16:05:24 +0100 (CET)
Date: Wed, 6 Feb 2019 16:05:24 +0100
From: Torsten Duwe <duwe@lst.de>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190206150524.GA28892@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_070533_661816_B47EC62C 
X-CRM114-Status: GOOD (  20.18  )
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
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 08:59:44AM +0000, Julien Thierry wrote:
> Hi Torsten,
> 
> On 18/01/2019 16:39, Torsten Duwe wrote:
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

Now that you mention it - yes indeed that's the correct facility to fix
the deviating address, as Steve has also confirmed. I had totally forgotten
about this hook.

> Also, I'm unsure whether it would be safe, but we could patch the "mov
> x9, lr" there as well. In theory, this would be called at init time
> (before secondary CPUs are brought up) and when loading a module (so I'd
> expect no-one is executing that code *yet*.
> 
> If this is possible, I think it would make things a bit cleaner.

This is in fact very tempting, but it will introduce a nasty side effect
to ftrace_call_adjust. Is there any obvious documentation that specifies
guarantees about ftrace_call_adjust being called exactly once for each site?

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
