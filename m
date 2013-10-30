From: dave.long@linaro.org (David Long)
Date: Wed, 30 Oct 2013 17:11:07 -0400
Subject: [PATCH v2 02/13] uprobes: allow ignoring of probe hits
In-Reply-To: <20131028185425.GA12863@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-3-git-send-email-dave.long@linaro.org>
 <20131019170214.GA8324@redhat.com> <20131028185425.GA12863@redhat.com>
Message-ID: <527175EB.9000809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the delay, all this week it's me that's traveling.


On 10/28/13 14:54, Oleg Nesterov wrote:
> David, sorry for delay.
>
> On 10/19, Oleg Nesterov wrote:
>>
>> On 10/15, David Long wrote:
>>>
>>> @@ -1732,9 +1732,6 @@ static void handle_swbp(struct pt_regs *regs)
>>>   		return;
>>>   	}
>>>
>>> -	/* change it in advance for ->handler() and restart */
>>> -	instruction_pointer_set(regs, bp_vaddr);
>>> -
>>
>> Well, this looks obviously wrong. This SET_IP() has the comment ;)
>>
>> Note also that with this breaks __skip_sstep() on x86.
>
> Hmm. Thinking more, it seems that this patch has another problem.
>
> IIUC, the whole point of arch_uprobe_ignore() is to avoid
> handler_chain() if the condition was not satisfied, so you need
> to call it before handler_chain() ?

Yes, you're right.  I can see now that is a bad merge of an earlier 
version of the patch.  I have just tested the fix.  Thanks for finding this.

>
> Otherwise this logic should go into can_skip_sstep() and we simply
> do not need the new hook, just we need to tweak the (ugly)
> UPROBE_SKIP_SSTEP logic.
>
> Oleg.
>


-dl
