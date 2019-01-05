Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148BAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:00:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA0821915
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRZ7c7I3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA0821915
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cmI8XtWcX6CGuH3DwrNPwNS6+MzcHDKdmyUX4aipmGo=; b=QRZ7c7I33aRNPv
	r63bXSEGBmvCi80MaxCHIsDGCrnj8ADgBCYPnJp1XWMmJhM0DfZXfigFNQe/1iObc7gtVK2sqD8QA
	MmSWPbaVDDFPr6qdWCTwB7LoUtSr1sUrkmjEj2NtYCsD/b6W0U8x3WMMozisD1KlqovWlehV5A55d
	7/vXDCA5oqmSUeoc3BOJlDUd95GE1zQG8Y7W1G/Q5/kwZ4er0uHKhpUtSEvXzOEmFLKpFis92nMCj
	Ve9DMe2WyMzKQdmcRYbHXDlIztNQFF3BvZmEgdT5m6OXy4E6utkdIvnc/qodL3mnCp4EDmvUWH06F
	Xi9IW+9d+yVZjEdvHFbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfs7I-0007XR-1w; Sat, 05 Jan 2019 20:00:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfs7E-0007W8-EE
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 20:00:18 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CBF8421915;
 Sat,  5 Jan 2019 20:00:13 +0000 (UTC)
Date: Sat, 5 Jan 2019 15:00:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190105150011.6062d818@gandalf.local.home>
In-Reply-To: <20190105110543.GA4298@lst.de>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190104130648.02657f3f@gandalf.local.home>
 <20190104224145.GA28236@lst.de> <20190105110543.GA4298@lst.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_120016_498140_DB9EFF9C 
X-CRM114-Status: GOOD (  21.15  )
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
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 5 Jan 2019 12:05:43 +0100
Torsten Duwe <duwe@lst.de> wrote:

> > My point is: those 2 insn will _never_ be split by any alignment
> > boundary > 8; does that mean anything, have you considered this?  
> 
> Forget that. Steve mentioned the keyword *interrupt*, which creates a
> completely different situation. In short, only the instruction pointer
> will be saved; and i-cache and pipeline will be freshly reloaded on return,
> so this threat is highly unlikely (interrupt taken exactly after 1st nop),
> but not impossible. "Puking horses..." as we say in German.

Correct.

> 
> > > > I wonder if we could solve that by patching the kernel at build-time, to
> > > > add the MOV X9, X30 in place of the first NOP. If we were to do that, we
> > > > could also update the addresses to pooint at the second NOP, simplifying
> > > > the changes to the runtime code.  
> > > 
> > > You can also patch it at boot up when there's only one CPU running, and
> > > interrupts are disabled.  
> > 
> > May I remind about possible performance hits? Even the NOPs had a tiny impact
> > on certain in-order implementations. I'd rather switch between the mov and
> > a "b +2".  
> 
> This one however still holds.

Now, if you can add one of the changes, do a synchronization to make
sure that all tasks are not preempted there, and see that first change,
then make the other change to complete the transaction, there may be a
solution: synchronize_rcu_tasks()!

	convert all first nops to "MOV X9, X30"
	synchronize_rcu_tasks();
	convert all second nops to "BL ftrace_regs_caller"

That would work. What synchronize_rcu_tasks() does, is that it wont
return until all tasks have either called schedule voluntarily (not
preempted), goes into user space, or goes idle.

Tasks that are idle (not preempted) are not counted.

Then you are guaranteed that no task was preempted at the first nop and
will come back and call "BL ftrace_regs_caller".

The only caveat is that synchronize_rcu_tasks() can take some time to
complete (seconds even) if something was preempted and is starved from
the CPU for some time. This is why you would need to group the
conversions together, by changing all the first nops for all the
functions you want to trace before calling the synchronization routine.

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
