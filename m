From: richard.guenther@gmail.com (Richard Guenther)
Date: Thu, 17 Dec 2009 18:17:11 +0100
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <4B2A65C6.7080009@caviumnetworks.com>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
Message-ID: <84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 6:09 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> Jamie Lokier wrote:
>>
>> Uwe Kleine-K?nig wrote:
>>>
>>> Use the new unreachable() macro instead of for(;;);
>>> ? ? ? ?*(int *)0 = 0;
>>> ? ? ? ? ?/* Avoid "noreturn function does return" */
>>> - ? ? ? for (;;);
>>> + ? ? ? unreachable();
>>
>> Will GCC-4.5 remove ("optimise away") the *(int *)0 = 0 because it
>> knows the branch of the code leading to unreachable can never be reached?
>>
>
> I don't know the definitive answer, so I am sending to gcc at ...
>
> FYI: #define unreachable() __builtin_unreachable()

It shouldn't as *(int *)0 = 0; might trap.  But if you want to be sure
use
   __builtin_trap ();
instead for the whole sequence (the unreachable is implied then).
GCC choses a size-optimal trap representation for your target then.

Richard.

>
>> If GCC-4.5 does not, are you sure a future version of GCC will never
>> remove it? ?In other words, is __builtin_unreachable() _defined_ in
>> such a way that it cannot remove the previous assignment?
>>
>> We have seen problems with GCC optimising away important tests for
>> NULL pointers in the kernel, due to similar propagation of "impossible
>> to occur" conditions, so it's worth checking with GCC people what the
>> effect of this one would be.
>>
>> In C, there is a general theoretical problem with back-propagation of
>> optimisations from code with undefined behaviour. ?In the case of
>> __builtin_unreachable(), it would depend on all sorts of unclearly
>> defined semantics whether it can remove a preceding *(int *)0 = 0.
>>
>> I'd strongly suggest asking on the GCC list. ?(I'd have mentioned this
>> earlier, if I'd known about the patch for other architectures).
>>
>> The documentation for __builtin_unreachable() only says the program is
>> undefined if control flow reaches it. ?In other words, it does not say
>> what effect it can have on previous instructions, and I think it's
>> quite likely that it has not been analysed in a case like this.
>>
>> One thing that would give me a lot more confidence, because the GCC
>> documentation does mention asm(), is this:
>>
>>> ? ? ?*(int *)0 = 0;
>>> ? ? ?/* Ensure unreachableness optimisations cannot propagate back. *I/
>>> ? ? ?__asm__ volatile("");
>>> ? ? ?/* Avoid "noreturn function does return" */
>>> ? ? ?unreachable();
>>
>> -- Jamie
>
>
