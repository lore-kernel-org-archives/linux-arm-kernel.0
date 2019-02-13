Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36452C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:40:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FED20835
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rAQISYpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FED20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DeglUuBQdBbgZSS/PQxV/j52EqPzreDDFZUm+/CKag8=; b=rAQISYpdB9cpId
	8Mv2j9jNoZeYhmOwWPs4QmGBHKGGofbmkHjybBkngXdAKkSyd9LukSo0LNV9HCx09k2gAdZTCrrFf
	cexiH4fivpw7nIpepQIkE/llHoj0iW1n7vZ/ELOBfZYc+gQCCkO1s5QQ/iBYQkqh2bTlpZwWYFmwp
	GGBotY4MKBi7WBTXg7ZKqDp2wBMksZbwUCL8iz/R992Sg5c02ars051S4Fhj/llY1keYetlX9TD+R
	bHpUpoqG+aGENZYZfaJN5MFaTUnz9KSZDlaTrrG4q4sugyjC8ixiPhpDp6800IMCZFJF2rAaf6JCn
	qO0hUaRYPcMsSRDINn4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvhl-0001cd-DL; Wed, 13 Feb 2019 14:40:05 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvhi-00018v-Go; Wed, 13 Feb 2019 14:40:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CCA2422BBEBE6; Wed, 13 Feb 2019 15:40:00 +0100 (CET)
Date: Wed, 13 Feb 2019 15:40:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213144000.GX32494@hirez.programming.kicks-ass.net>
References: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213141712.GV32494@hirez.programming.kicks-ass.net>
 <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
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
Cc: catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 02:24:34PM +0000, Julien Thierry wrote:
> On 13/02/2019 14:17, Peter Zijlstra wrote:
> > On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
> >>> This; how is getting preempted fundamentally different from scheduling
> >>> ourselves?
> >>
> >> The difference is because getting preempted in the sequence above is
> >> triggered off the back of an interrupt. On arm64, and I think also on x86,
> >> the user access state (SMAP or PAN) is saved and restored across exceptions
> >> but not across context switch. Consequently, taking an irq in a
> >> user_access_{begin,end} section and then scheduling is fine, but calling
> >> schedule directly within such a section is not.
> > 
> > So how's this then:
> > 
> > 	if (user_access_begin()) {
> > 
> > 		preempt_disable();
> > 
> > 		<IRQ>
> > 			set_need_resched();
> > 		</IRQ no preempt>
> > 
> > 		preempt_enable()
> > 		  __schedule();
> > 
> > 		user_access_end();
> > 	}
> > 
> > That _should_ work just fine but explodes with the proposed nonsense.
> 
> AFAICT, This does not work properly because when you schedule out this
> task, you won't be saving the EFLAGS.AF/PSTATE.PAN bit on the stack, and

EFLAGS.AC, but yes.

> next time you schedule the task back in, it might no longer have the
> correct flag value (so an unsafe_get/put_user() will fail even though
> you haven't reached user_access_end()).

/me looks at __switch_to_asm() and there is indeed a distinct lack of
pushing and popping EFLAGS :/

> One solution is to deal with this in task switching code, but so far
> I've been told that calling schedule() in such a context is not expected
> to be supported.

Well, per the above it breaks the preemption model. And I hates that.

And the added WARN doesn't even begin to cover it, since you'd have to
actually hit the preempt_enable() reschedule for it trigger.

So far, all 6 in-tree users are indeed free of dodgy code, but *groan*.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
