From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 26 Jul 2017 13:23:15 +0200
Subject: [BUG] v4.12 breaks pxa25x
In-Reply-To: <87eftfrs0e.fsf@belgarion.home> (Robert Jarzmik's message of
 "Mon, 17 Jul 2017 17:40:33 +0200")
References: <87inirsgzk.fsf@belgarion.home>
 <20170717081518.GI31807@n2100.armlinux.org.uk>
 <87eftfrs0e.fsf@belgarion.home>
Message-ID: <87o9s7qw64.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
>
>> On Mon, Jul 17, 2017 at 08:41:03AM +0200, Robert Jarzmik wrote:
>>
>>> [    0.000000] Unhandled fault: alignment exception (0x003) at 0xc06f82cd
>>> [    0.000000] pgd = c0004000
>>> [    0.000000] [c06f82cd] *pgd=a060040e(bad)
>>> [    0.000000] Internal error: : 3 [#1] ARM
>>> [    0.000000] Modules linked in:
>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.12.0-11927-g6bf3d68 #4582
>>> [    0.000000] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
>>> [    0.000000] task: c06f6fd8 task.stack: c06f2000
>>> [    0.000000] PC is at __flush_whole_cache+0x4/0x60
>>> [    0.000000] LR is at paging_init+0x4b4/0x590
>>> [    0.000000] pc : [<c0019e24>]    lr : [<c049d274>]    psr: 600000d3
>>> [    0.000000] sp : c06f3f38  ip : 00000000  fp : c0700000
>>> [    0.000000] r10: a4000000  r9 : c06f82c0  r8 : c0723540
>>> [    0.000000] r7 : fe100000  r6 : fe200000  r5 : c06f82a0  r4 : c0705ef4
>>> [    0.000000] r3 : 00000000  r2 : 00000004  r1 : c06f82cd  r0 : c06f82c0
>>
>> Looks like the .data section has become misaligned somehow.  r1 is the
>> address of "clean_addr" which is clearly not 32-bit aligned.
>>
>> Please can you check in System.map to see what's immediately before it?
> Sure, it like this :
> c06f22c8 D user_pmd_table
> c06f22cc d __warned.19178
> c06f22cd d clean_addr
>
> And I have no idea how to link that __warned.19178 with the WARN_xxx() statement ...
>
> This bisection I made points me to :
> # first bad commit: [799c43415442414b1032580c47684cb709dfed6d] kbuild: thin archives make default for all archs
>
> Reverting this commit makes my kernel boot again.

Hi Russell,

I think I know where this is comming from.
  - in file: ~/mio_linux/kernel/include/asm-generic/vmlinux.lds.h:206
  - the definition of DATA_DATA looks like :
    (*.data .data.[0-9a-zA-Z_]*)
    ...
    *(.data.unlikely)
    ...

This doesn't look good to me, as .data.unlikely fullfills the first wildcard,
and the linker is allowed to mix .data and .data.unlikely symbols to its
pleasure, while .data.unlikely symbols (at least in my case) are not 4 bytes
multiples.

I'm clearly not a ld specialist, as I would have put a *(.data.unlikely) first
in DATA_DATA, an align statement, then continued with the current wildcards, but
that might not be the right approach.

If you suggest something else, I'll send a patch for it. If not, I'll send a
patch for my idea. And lastly, if it doesn't fit you, I'll have to modify the
PXA kconfig to toggle the default flag which triggers the error.

Cheers.

-- 
Robert

PS: In the meantime, I'll corner down which exact instruction and code is
creating the .data.unlikely 1 byte data.
