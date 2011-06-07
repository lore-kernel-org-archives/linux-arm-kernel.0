From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 7 Jun 2011 14:54:53 +0100 (BST)
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to
	a physical address
In-Reply-To: <20110607132220.GB12639@e102144-lin.cambridge.arm.com>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
	<1307379898-14256-5-git-send-email-will.deacon@arm.com>
	<alpine.DEB.2.00.1106071126290.2247@localhost6.localdomain6>
	<alpine.DEB.2.00.1106071223100.2247@localhost6.localdomain6>
	<20110607132220.GB12639@e102144-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1106071435020.2247@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 7 Jun 2011, Will Deacon wrote:

> Hi Frank,
>
> Thanks for looking at this.

Thanks for posting it ;-)

[ ... ]
>>>> +	/* Switch to the identity mapping. */
>>>> +	((typeof(cpu_reset) *)virt_to_phys((void *)cpu_reset))(reset_code_phys);
>>>
>>> void (*reset_func)(unsigned long) = virt_to_phys(cpu_reset)
>>
>> Sorry, pressed wrong key ... posted too early.
>
> No problem.
>
>> I meant to say this line is magic, why not decouple the declaration bit
>> from the invocation so that at least the function call looks "normal" ?
>
> You mean you don't like the LISP-ish look of it?! I take your point, I'll rework
> that.

 	typeof(cpu_reset)(*phys_reset) =
 		(typeof(cpu_reset) *)virt_to_phys(cpu_reset);

 	reset_func(reset_code_phys);

Works for me. Was experimenting with this when I pressed the wrong key.

>
>> Regarding the use of local_irq/fiq_disable - is it safe to call these
>> multiple times, i.e. is it safe to invoke the reset function from a
>> context where IRQ/FIQ are already off ?
>
> Yes, they just mask at the CPSR level.

Good, thx for the confirmation.

>
>>
>> Another question regarding the MMU tables.
>>
>> prepare_for_reboot / setup_mm_for_reboot assume that current->mm is
>> available _and_ lowmem / user area there can be blotted over.
>>
>> Wrt. to hibernation, that's a stretch unless some way is found to fully
>> "fake a context". With that I mean to create a threadinfo and pagedir
>> that's guaranteed to sit outside the target kernel heap.
>
> Ouch, ok.
>
>> Currently, the hibernation code switches to swapper_pg_dir and puts the
>> 1:1 mappings in there; I'm starting to think that is safe if for no other
>> reason than swapper_pg_dir having _nothing_ in the user area ?
>
> That sounds ok providing that, when you come out of hibernate, the 1:1 mapping
> doesn't persist in swapper_pg_dir.

I can delete those mappings - as they're created by identity_mapping_add() 
they can be ditched with identity_mapping_del() - which might be 
sufficient, provided, and there's the critical bit why I ask, that 
swapper_pg_dir _normally_ has nothing in the range anyway.

Thing is, just because something appears to work doesn't mean it has no 
unexpected/undesired side effects ... and I'm no ARM VM guru.


>
> However, stepping back a bit here, there is a bigger problem to tackle. If the
> physical address of cpu_reset is bigger than TASK_SIZE, then we fail to map it
> using the current identity mapping code [that piggy backs on the current task].
> If PHYS_OFFSET > TASK_SIZE, this will *always* be the case and is probably quite
> common for a 2:2 split.
>
> I can think of two ways to get around this:
>
> (1) Use /another/ set of page tables for mapping the cpu_reset code only [and
>    nothing else]. This is tricky since it will need to be set extremely late-on
>    where we don't care about mapping in the rest of the kernel, data, stack etc.
>
> (2) Make the assumption that the physical address of cpu_reset will not conflict
>    with a virtual address that points at the kernel text via the linear mapping.
>    This is probably a reasonable thing to assume, given that the kernel lives
>    near the start of memory on most platforms. We could then take out the ID map
>    but leaving the kernel text alone. We'd probably have to change to a new stack,
>    which we could place immediately after the kernel text.
>
> What do you reckon?

cpu_reset itself is relocatable, isn't it ? Maybe one could do the same 
thing with/for it as for the reset code itself. I.e. relocate to a 
"suitable" page if the 1:1 mapping for all of lowmem isn't possible. The 
catch with that is of course somehow, such a "1:1 candidate page" must be 
found.

>
>> Is it convention, design or accident that swapper_pg_dir doesn't map
>> anything in the low range ?
>
> With the new switch_mm stuff, it's absolutely critical that we don't have
> user mappings in there during normal execution (going down for hibernate
> is probably ok since we'll clobber the caches and TLBs anyway).

I'm using swapper_pg_dir for hibernate (restore) for the simple reason 
that it maps all of kernel text/data writeable.

When invoking resume via uswsusp and/or tuxonice, it's triggered from a 
user context which is insufficient to _rewrite_ "universe".

So when the time comes to do the cpu_reset / cpu_resume dance, the active 
mm context is swapper_pg_dir; hence creating the identity mappings in 
there.

It's not hard to zap them afterwards; it'd be far more difficult to 
restore previous contents if there had been any.

Short: Good news that the user pagedir section in swapper_pg_dir is empty 
by design.


Thanks,
FrankH.
