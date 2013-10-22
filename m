From: dave.long@linaro.org (David Long)
Date: Mon, 21 Oct 2013 23:45:47 -0400
Subject: [PATCH v2 02/13] uprobes: allow ignoring of probe hits
In-Reply-To: <20131019170214.GA8324@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-3-git-send-email-dave.long@linaro.org>
 <20131019170214.GA8324@redhat.com>
Message-ID: <5265F4EB.2060803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/13 13:02, Oleg Nesterov wrote:
> On 10/15, David Long wrote:
>>
>> @@ -1732,9 +1732,6 @@ static void handle_swbp(struct pt_regs *regs)
>>   		return;
>>   	}
>>
>> -	/* change it in advance for ->handler() and restart */
>> -	instruction_pointer_set(regs, bp_vaddr);
>> -
>
> Well, this looks obviously wrong. This SET_IP() has the comment ;)
>
> Note also that with this breaks __skip_sstep() on x86.
>
> Oleg.
>

Yes, and there's a missing weak stub function in there too.  It was a 
surprise to me that declaring an external as weak means that it quietly 
ignores the fact there is no definition for it at link time, and makes 
it zero.  I think there may be some similar land mines elsewhere in the 
kernel, unrelated to these changes or uprobes in general.

I have an updated version to go out with the v3 patches.  It is working 
with v3.12-rc6 on x86 and ARM, to the extent I'm able to test it.

-dl
