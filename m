Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AEFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4975D21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tGDUsnep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4975D21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jZsTpB4SSG6ctrWOjwA5TO7nHla9xNHv0BsRTO8uaWs=; b=tGDUsnepgCjuJ9
	R6J7F2TnEPjnKNDKR9ob9LL1z5maFSkjWp2f4APlflJo+AsyXnIezzx/UCFBME8sfeqeXdBbf+tJD
	aJLoLAxkbOQQH9Qn+k7gAvfavybOc6HIXiDUU8cWarhkBmO0hYqe7O5/mhLzq7GTjmswqvHj/3wP9
	YvfOF5iTIhCA1zjXPTLdU1uIVmvrsftx9acudr40qsy6ZzO7pSfcR4C6Ncy4VVoL/NFmAB1fTJZ6F
	TrbYmpjn99U7NfnHgQWrDi6Cw248lP1ljUdgzxeg0pVqoD5u+0lR/ZsITxsfdafShdSFqB5YuP2Wa
	Zgb5sDR4edNc8s65LotA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1Uz-0007ee-1s; Tue, 19 Feb 2019 09:15:33 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1Ut-0007a9-OW; Tue, 19 Feb 2019 09:15:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 04640286C98DE; Tue, 19 Feb 2019 10:15:26 +0100 (CET)
Date: Tue, 19 Feb 2019 10:15:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190219091525.GX32494@hirez.programming.kicks-ass.net>
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
 Brian Gerst <brgerst@gmail.com>, Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 04:24:30PM -0800, Linus Torvalds wrote:
> On Mon, Feb 18, 2019 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > The question is what "fix it" means. I'm really concerned about AC escapes,
> > and everyone else should be, too.
> 
> I do think that it might be the right thing to do to add some kind of
> WARN_ON_ONCE() for AC being set in various can-reschedule situations.

So I disagree.

Either we set AC with preempt disabled, and then we don't need an extra
warning, because we already have a warning about scheduling with
preemption disabled, or we accept that the fault handler can run.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
