Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59DAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B533720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V2Hq5B9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B533720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MAeUIXHVMta2lORTAAry4FsWD1igN8YmJL6Xg6dYIHc=; b=V2Hq5B9IaZ2OAO
	lTv3lucO51calbaN6frX2APT1fKDzM0RxZ7i/2HaLPxFqihC6Q5tJLDHe4dieckeMe+fK8qtTCAgx
	ScAjXhhqHasxq5yKTqZZNaTtomrPJAlpPcmal+43RgAD97SAhMOK+15Yh4CAMGUdVZLOpb3Gq1hJI
	H4zMQ77r3ec5MJQwu3eFdnD9FYnYahsGOeoQARNqIIBFUUK2bXGBRlEYemEF4XQpf6yeB3StVZBQu
	SRy1PN05VV+Qd7/8EyR07ovgnKlSDuCVRPDc2GimgfJP+n0ZL9bM2cxo/sGAHUFBOiqTf/9HvrGFo
	LSOAq+ieYaldxziRmXvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU3bK-0001Fk-8e; Tue, 04 Dec 2018 05:50:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU3bF-0000rr-1b
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 05:50:28 +0000
Received: from vmware.local.home (unknown [184.48.106.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BA0F20834;
 Tue,  4 Dec 2018 05:50:14 +0000 (UTC)
Date: Tue, 4 Dec 2018 00:50:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181204005012.11f73df9@vmware.local.home>
In-Reply-To: <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com>
 <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_215025_215186_F2BE0EE3 
X-CRM114-Status: GOOD (  28.73  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 22:51:52 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Dec 3, 2018 at 8:22 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Hi Anders,
> >
> > On Fri, Nov 30, 2018 at 04:09:56PM +0100, Anders Roxell wrote:  
> > > Both of those functions end up calling ftrace_modify_code(), which is
> > > expensive because it changes the page tables and flush caches.
> > > Microseconds add up because this is called in a loop for each dyn_ftrace
> > > record, and this triggers the softlockup watchdog unless we let it sleep
> > > occasionally.
> > > Rework so that we call cond_resched() before going into the
> > > ftrace_modify_code() function.
> > >
> > > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > >  arch/arm64/kernel/ftrace.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)  
> >
> > It sounds like you're running into issues with the existing code, but I'd
> > like to understand a bit more about exactly what you're seeing. Which part
> > of the ftrace patching is proving to be expensive?
> >
> > The page table manipulation only happens once per module when using PLTs,
> > and the cache maintenance is just a single line per patch site without an
> > IPI.
> >
> > Is it the loop in ftrace_replace_code() that is causing the hassle?  
> 
> Yes: with an allmodconfig kernel, the ftrace selftest calls ftrace_replace_code
> to look >40000 through ftrace_make_call/ftrace_make_nop, and these
> end up calling
> 
> static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
> {
>         void *waddr = addr;
>         unsigned long flags = 0;
>         int ret;
> 
>         raw_spin_lock_irqsave(&patch_lock, flags);
>         waddr = patch_map(addr, FIX_TEXT_POKE0);
> 
>         ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
> 
>         patch_unmap(FIX_TEXT_POKE0);
>         raw_spin_unlock_irqrestore(&patch_lock, flags);
> 
>         return ret;
> }
> int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> {
>         u32 *tp = addr;
>         int ret;
> 
>         /* A64 instructions must be word aligned */
>         if ((uintptr_t)tp & 0x3)
>                 return -EINVAL;
> 
>         ret = aarch64_insn_write(tp, insn);
>         if (ret == 0)
>                 __flush_icache_range((uintptr_t)tp,
>                                      (uintptr_t)tp + AARCH64_INSN_SIZE);
> 
>         return ret;
> }
> 
> which seems to be where the main cost is. This is with inside of
> qemu, and with lots of debugging options (in particular
> kcov and ubsan) enabled, that make each function call
> more expensive.

I was thinking more about this. Would something like this work?

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8ef9fc226037..42e89397778b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2393,11 +2393,14 @@ void __weak ftrace_replace_code(int enable)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	bool schedulable;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
 		return;
 
+	schedulable = !irqs_disabled() & !preempt_count();
+
 	do_for_each_ftrace_rec(pg, rec) {
 
 		if (rec->flags & FTRACE_FL_DISABLED)
@@ -2409,6 +2412,8 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		if (schedulable)
+			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
