From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 7 Jun 2011 17:21:06 +0100 (BST)
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to
	a physical address
In-Reply-To: <20110607153654.GA19855@arm.com>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
	<1307379898-14256-5-git-send-email-will.deacon@arm.com>
	<alpine.DEB.2.00.1106071126290.2247@localhost6.localdomain6>
	<alpine.DEB.2.00.1106071223100.2247@localhost6.localdomain6>
	<20110607132220.GB12639@e102144-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1106071435020.2247@localhost6.localdomain6>
	<20110607153654.GA19855@arm.com>
Message-ID: <alpine.DEB.2.00.1106071714400.2236@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 7 Jun 2011, Dave Martin wrote:

> On Tue, Jun 07, 2011 at 02:54:53PM +0100, Frank Hofmann wrote:
>>
>>
>> On Tue, 7 Jun 2011, Will Deacon wrote:
>>
>>> Hi Frank,
>>>
>>> Thanks for looking at this.
>>
>> Thanks for posting it ;-)
>>
>> [ ... ]
>>>>>> +	/* Switch to the identity mapping. */
>>>>>> +	((typeof(cpu_reset) *)virt_to_phys((void *)cpu_reset))(reset_code_phys);
>>>>>
>>>>> void (*reset_func)(unsigned long) = virt_to_phys(cpu_reset)
>>>>
>>>> Sorry, pressed wrong key ... posted too early.
>>>
>>> No problem.
>>>
>>>> I meant to say this line is magic, why not decouple the declaration bit
>>>> from the invocation so that at least the function call looks "normal" ?
>>>
>>> You mean you don't like the LISP-ish look of it?! I take your point, I'll rework
>>> that.
>>
>> 	typeof(cpu_reset)(*phys_reset) =
>> 		(typeof(cpu_reset) *)virt_to_phys(cpu_reset);
>
> This is a declaration, but the extra parentheses confuse me.
>
> How about:
>
> 	typeof(cpu_reset) *phys_reset =
> 		(typeof(cpu_reset) *)virt_to_phys(cpu_reset);

Function pointers ;-)
Thanks.

>
> or even:
>
> 	typedef typeof(cpu_reset) *phys_reset_t;
> 	phys_reset_t phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
>>
>> 	reset_func(reset_code_phys);
>
> Do you mean reset_func(phys_reset) ?

 	phys_reset(reset_code_phys);

me and my copy & paste ...

[ ... ]
>> cpu_reset itself is relocatable, isn't it ? Maybe one could do the
>> same thing with/for it as for the reset code itself. I.e. relocate
>> to a "suitable" page if the 1:1 mapping for all of lowmem isn't
>> possible. The catch with that is of course somehow, such a "1:1
>> candidate page" must be found.
>
> If cpu_reset is guaranteed to be position-independent and self-contained, we could
> just copy it (with fncpy() for example).  We would still need to know the length
> of that function somehow though.  Maybe just assuming that it's not longer than
> a page would be safe enough.

In all current CPU implementations it's position-dependent and 
self-contained; all they do are suitable control reg modifications, ending 
all with "mov pc, r0".

>
> In this case we would just need to find an identity-mappable target location to
> copy the code to; we can find such a location in the same way as that used to
> find space for the alternate stack, i.e., somewhere after the end of the kernel
> image.

If that's a normal thing to do, then this kind of 1:1-bounce-page seems a 
good way of avoiding the address range collision.

best regards,
FrankH.

>
> Cheers
> ---Dave
>
