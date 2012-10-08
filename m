From: snijsure@grid-net.com (Subodh Nijsure)
Date: Mon, 8 Oct 2012 13:55:30 -0700
Subject: Kernel panic in mxs_auart_irq_handle with latest kernel?
In-Reply-To: <20121008082450.GB18531@pengutronix.de>
References: <B437D8FD67C39240BFA9DD878702A627EB4BD8@mx2.grid-net.com>
 <20121008074547.GA18531@pengutronix.de>
 <20121008080754.GW4625@n2100.arm.linux.org.uk>
 <20121008082450.GB18531@pengutronix.de>
Message-ID: <50733DC2.8000908@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 01:24 AM, Uwe Kleine-K?nig wrote:
> Hello Russell,
>
> On Mon, Oct 08, 2012 at 09:07:54AM +0100, Russell King - ARM Linux wrote:
>> On Mon, Oct 08, 2012 at 09:45:47AM +0200, Uwe Kleine-K?nig wrote:
>>> On Fri, Oct 05, 2012 at 11:58:26PM +0000, Subodh Nijsure wrote:
>>>> On my MX28 based board with top of the Linus's git tree I am consistently getting following kernel panic, anybody else seen this?
>>>> (I will start bisecting and see if I can find a reason this wknd)
>>>>
>>>> -Subodh
>>>>
>>> This dump is not complete, there is at least a line missing that reads
>>>
>>> 	[   $timestamp] pgd = ....
>>>
>>> It's a good habit to always provide the full info.
>>>
>>>> [    9.700000] [00000118] *pgd=00000000
>> Uwe, yes it is, it is the line above.  It's saying that there is no
>> pgd entry at address 0x118 (which is correct.)
> I'm not sure I got you right, but show_pte() has:
>
>          printk(KERN_ALERT "pgd = %p\n", mm->pgd);
>          pgd = pgd_offset(mm, addr);
>          printk(KERN_ALERT "[%08lx] *pgd=%08llx",
>                          addr, (long long)pgd_val(*pgd));
>
> So there is indeed missing a line. I don't think it's essential here,
> still I think in general it's advisable to let people know not to
> shorten the output. Probably even let them post the complete kernel log.
> (Isn't there an oops marker, too?)
>   
>>>> [    9.700000] Internal error: Oops: 5 [#1] PREEMPT ARM
>>>> [    9.700000] Modules linked in:
>>>> [    9.700000] CPU: 0    Not tainted  (3.6.0-11641-gbe4ae13-dirty #1)
>>>> [    9.700000] PC is at uart_insert_char+0x38/0x130
>>>> [    9.700000] LR is at mxs_auart_irq_handle+0x198/0x2b0
>>>> [    9.700000] pc : [<c025a3e0>]    lr : [<c0261700>]    psr: 40000093
>>>> [    9.700000] sp : c0549ea0  ip : 00000000  fp : 00000001
>>>> [    9.700000] r10: 00000000  r9 : c057e64e  r8 : 00000020
>>>> [    9.700000] r7 : 00000000  r6 : 00080000  r5 : 00000000  r4 : c39566c0
>>>> [    9.700000] r3 : 00000020  r2 : 00000000  r1 : 00000000  r0 : 00000000
>>> I don't see what should access the address 0x118 here, can you please
>>> provide the output of
>>>
>>> 	objdump -d vmlinux | sed -nr '/^[0-9]{8} <uart_insert_char/,/^$/p'
>> 	objdump -d vmlinux --start-addr=0xc025a3a8 | less
>>
>> will give you the disassembly starting at uart_insert_char().
>>
>> The faulting instruction is (which is below in the Code: line of the oops
>> dump):
> Ah, I already knew some time ago that the code is included in the dump,
> I just did miss it because there are no address infos included there.
>
>> 	e5973118
>>
>> It's an "ldr r3, [r7, #280]  ; 0x118" instruction.  r7 is zero, and the
>> instruction has an pre-indexed offset of 0x118.  _That_ is where 0x118
>> is coming from.
> obviously.
>
>> The full code line is:
>>
>>    28:   1a000012        bne     0x78
>>    2c:   e59d2020        ldr     r2, [sp, #32]
>>    30:   e5cd3006        strb    r3, [sp, #6]
>>    34:   e5cd2007        strb    r2, [sp, #7]
>>    38:   e5973118        ldr     r3, [r7, #280]  ; 0x118
>>
>> I suspect the problem is that the mxs serial driver is calling
>> uart_insert_char() when the port has been closed by userland, which
>> means there's no tty associated with it.
> Thanks for your insights. At least my mail wasn't for nothing because I
> learned again something about oopses.
My apologies.  Problem that I came across was caused by some other 
vendor driver for a wireless device that is on this board.
As soon as I disable that driver I don't see this kernel panic.

-Subodh
