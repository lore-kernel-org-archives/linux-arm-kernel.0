From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 28 Oct 2013 19:54:25 +0100
Subject: [PATCH v2 02/13] uprobes: allow ignoring of probe hits
In-Reply-To: <20131019170214.GA8324@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-3-git-send-email-dave.long@linaro.org>
 <20131019170214.GA8324@redhat.com>
Message-ID: <20131028185425.GA12863@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David, sorry for delay.

On 10/19, Oleg Nesterov wrote:
>
> On 10/15, David Long wrote:
> >
> > @@ -1732,9 +1732,6 @@ static void handle_swbp(struct pt_regs *regs)
> >  		return;
> >  	}
> >
> > -	/* change it in advance for ->handler() and restart */
> > -	instruction_pointer_set(regs, bp_vaddr);
> > -
>
> Well, this looks obviously wrong. This SET_IP() has the comment ;)
>
> Note also that with this breaks __skip_sstep() on x86.

Hmm. Thinking more, it seems that this patch has another problem.

IIUC, the whole point of arch_uprobe_ignore() is to avoid
handler_chain() if the condition was not satisfied, so you need
to call it before handler_chain() ?

Otherwise this logic should go into can_skip_sstep() and we simply
do not need the new hook, just we need to tweak the (ugly)
UPROBE_SKIP_SSTEP logic.

Oleg.
