From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 3 Mar 2017 19:02:02 +0000
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
Message-ID: <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/17 17:15, Mason wrote:
[...]
>>> [    1.264893] Unable to handle kernel paging request at virtual address d08664f4

Note that that's a reasonable approximation of a vmalloc address...

>>> [    1.272248] pgd = c0004000
>>> [    1.275060] [d08664f4] *pgd=8f804811, *pte=00000000, *ppte=00000000
>>> [    1.281476] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>>> [    1.286897] Modules linked in:
>>> [    1.290053] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #151
>>> [    1.296696] Hardware name: Sigma Tango DT
>>> [    1.300808] task: cf82c9c0 task.stack: cf838000
>>> [    1.305446] PC is at quirk_usb_early_handoff+0x3e8/0x790
>>> [    1.310873] LR is at ioremap_page_range+0xf8/0x1a8
>>> [    1.315771] pc : [<c039fe8c>]    lr : [<c02d0a10>]    psr: 000e0013
>>> [    1.315771] sp : cf839d78  ip : 00000000  fp : cf839e38
>>> [    1.327482] r10: c10248a0  r9 : 00000000  r8 : d08664f4
>>> [    1.332816] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb5f800
>>> [    1.339460] r3 : 000184f4  r2 : 00000000  r1 : 91001e13  r0 : d084e000

...and that specifically it's r0 + r3...

[...]
>> [    1.258926] Unable to handle kernel paging request at virtual address d0863f70
>> [    1.266284] pgd = c0004000
>> [    1.269097] [d0863f70] *pgd=8f804811, *pte=00000000, *ppte=00000000
>> [    1.275512] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>> [    1.280933] Modules linked in:
>> [    1.284089] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
>> [    1.290732] Hardware name: Sigma Tango DT
>> [    1.294843] task: cf82c9c0 task.stack: cf838000
>> [    1.299482] PC is at quirk_usb_early_handoff+0x3e8/0x790
>> [    1.304907] LR is at ioremap_page_range+0xf8/0x1a8
>> [    1.309806] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
>> [    1.309806] sp : cf839d78  ip : 00000000  fp : cf839e38
>> [    1.321517] r10: c10248a0  r9 : 00000000  r8 : d0863f70
>> [    1.326851] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb52800
>> [    1.333495] r3 : 00015f70  r2 : 00000000  r1 : 91001e13  r0 : d084e000

...and again...

[...]
> [    1.261813] Unable to handle kernel paging request at virtual address d08611e4
> [    1.269167] pgd = c0004000
> [    1.271979] [d08611e4] *pgd=8f804811, *pte=00000000, *ppte=00000000
> [    1.278394] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
> [    1.283815] Modules linked in:
> [    1.286970] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
> [    1.293614] Hardware name: Sigma Tango DT
> [    1.297726] task: cf82c9c0 task.stack: cf838000
> [    1.302364] PC is at quirk_usb_early_handoff+0x3e8/0x790
> [    1.307790] LR is at ioremap_page_range+0xf8/0x1a8
> [    1.312688] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
> [    1.312688] sp : cf839d78  ip : 00000000  fp : cf839e38
> [    1.324399] r10: c10248a0  r9 : 00000000  r8 : d08611e4
> [    1.329733] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb4e800
> [    1.336377] r3 : 000131e4  r2 : 00000000  r1 : 91001e13  r0 : d084e000

...and again. And always at the same PC, too. Looking at
quirk_usb_early_handoff(), it mostly seems to go off poking bridge
resources, so I'd hazard a guess that it's down to your host driver,
with something uninitialised (or already freed) being used as an offset
into some ioremapped resource (which given the consistency of r0 is
probably allocated pretty early on).

"addr2line -i -e vmlinux c039fe44", and work backwards from there ;) In
particular I'd follow the provenance of r3.

Robin.
