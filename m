From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Thu, 9 Feb 2017 06:45:32 +0900
Subject: [BUGFIX PATCH tip/master 2/3] kprobes/arm64: Fix a possible
 deadlock case in kretprobe
In-Reply-To: <20170208150654.GJ3986@arm.com>
References: <148648024215.30949.11929183640906306731.stgit@devbox>
 <148648038381.30949.1443281264586280005.stgit@devbox>
 <20170208150654.GJ3986@arm.com>
Message-ID: <20170209064532.6788c08a63e04876b3ae0b7a@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2017 15:06:55 +0000
Will Deacon <will.deacon@arm.com> wrote:

> [adding linux-arm-kernel]
> 
> On Wed, Feb 08, 2017 at 12:13:14AM +0900, Masami Hiramatsu wrote:
> > Similar to x86 kretprobe deadlock issue, arm64 also implements
> > kretprobe-booster (trampoline code directly call handler.)
> > So it has same deadlock issue if there are 2 kretprobes on
> > normal function and the function called from FIQ (or anywhere
> > which can be invoked when local_irq_disabled).
> 
> We don't support FIQ on arm64, so I'm not worried about that particular
> case. What are the other cases? I can think of debug exceptions, but those
> shouldn't be generally kprobe-able, and taking data aborts in things like
> get_user/put_user. Are those affected by this bug?

Hmm, in that case, this may not needed at this point. Would you have
any plan to support FIQ like as NMI in x86?
If something can interrupt while the critical region between 
spin_lock_irqsave() and spin_unlock_irqrestore(), and it can be
kprobe'd, it is safer to apply this patch.

> Either way, could you please expand the commit message like you have
> for x86? It makes it much easier to understand the change when looking
> back at the log in future.

Ah, sorry. I will update the comment.

Thank you,

> 
> Thanks,
> 
> Will


-- 
Masami Hiramatsu <mhiramat@kernel.org>
