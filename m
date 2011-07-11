From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 11 Jul 2011 14:31:09 -0700
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <20110711201400.GD8486@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
	<20110711184010.GB8486@n2100.arm.linux.org.uk>
	<4E1B5780.6040307@ti.com>
	<20110711201400.GD8486@n2100.arm.linux.org.uk>
Message-ID: <4E1B6B9D.2000500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/11/2011 1:14 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 01:05:20PM -0700, Santosh Shilimkar wrote:
>> (Just to add few more points on top of what Colin already commented)
>>
>> On 7/11/2011 11:40 AM, Russell King - ARM Linux wrote:
>>> On Mon, Jul 11, 2011 at 03:00:47PM +0100, Lorenzo Pieralisi wrote:
>>>> Well, short answer is no. On SMP we do need to save CPU registers
>>>> but if just one single cpu is shutdown L2 is still on.
>>>> cpu_suspend saves regs on the stack that has to be cleaned from
>>>> L2 before shutting a CPU down which make things more complicated than
>>>> they should.
>>>
>>> Hang on.  Please explain something to me here.  You've mentioned a few
>>> times that cpu_suspend() can't be used because of the L2 cache.  Why
>>> is this the case?
>>>
>>> OMAP appears to have code in its sleep path - which has been converted
>>> to cpu_suspend() support - to deal with the L2 issues.
>>>
>> This part is not done yet Russell. Infact the cpu_resume() function
>> need an update to work with L2 enable configuration.
>
> The code does deal with L2 cache enable in the resume path...
>
>>> However, lets recap.  What we do in cpu_suspend() in order is:
>>>
>>> - Save the ABI registers onto the stack, and some private state
>>> - Save the CPU specific state onto the stack
>> We need to disable C bit here to avoid any speculative artifacts
>> during further operations before WFI.
>
> Which you are doing.
>
>>> - Flush the L1 cache
>>> - Call the platform specific suspend finisher
>> Also finisher function should issue the WFI and just in
>> case for some reason CPU doesn't hit the targeted low
>> power state, finisher function takes care of things
>> like enabling C bit, SMP bit etc.
>
> You're restoring the C bit in the non-off paths already which follow a
> failed WFI.  You're not touching the SMP bit there though - was it
> ever reset?  I don't think so.
>
Probably it's not in the code what you have seen but it's being used
in the code base. One tricky issue there is SMP bit access is protected
on OMAP4430 GP silicon where as it is opened up on OMAP4460. We handle
that using NSACR register read and that's what I pointed to Lorenzo.

>>> On resume, with the MMU and caches off:
>>>
>>> - Platform defined entry point is called, which _may_ be cpu_resume
>>>     directly.
>>> - Platform initial code is executed to do whatever that requires
>>> - cpu_resume will be called
>>> - cpu_resume loads the previously saved private state
>>> - The CPU specific state is restored
>>> - Page table is modified to permit 1:1 mapping for MMU enable
>> 1:1 idmap used here should be mapped as non-cached to avoid L2 related
>> issues. I faced similar issue in OMAP sleep code earlier and later
>> thanks to Colin,  we got the fixed my making use of non-cached idmap.
>
> It is specified that if the main control register C bit is clear,
> accesses will be uncached.
>
Does it apply for page table walks as well because that's the case
which fails.

> Whether you get cache hits or not is probably implementation dependent,
> and provided that the state information is cleaned from the L2 cache,
> it doesn't matter if we hit the L2 cached copy or the RAM copy.  It's
> the same data.
I am not sure. Because restored TTRB0 still tells processor that the
entry is cached and then CPU instead of reading the entry from main
memory(written before MMU OFF) it reads a stale entry from L2 which
is the problem.

Regards
Santosh
