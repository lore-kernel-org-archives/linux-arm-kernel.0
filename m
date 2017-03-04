From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 4 Mar 2017 08:07:44 +0000
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <4f0a6c67-a50b-ac24-8ffa-0a68802e84b8@free.fr>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
 <4f0a6c67-a50b-ac24-8ffa-0a68802e84b8@free.fr>
Message-ID: <CAKv+Gu_M6aMMfeCy7ZUM46Ptei1suvX+F_KtWG2_QFp_6jbCWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2017 at 00:24, Mason <slash.tmp@free.fr> wrote:
> On 03/03/2017 20:02, Robin Murphy wrote:
>
>> On 03/03/17 17:15, Mason wrote:
>>
>>> [    1.261813] Unable to handle kernel paging request at virtual address d08611e4
>>> [    1.269167] pgd = c0004000
>>> [    1.271979] [d08611e4] *pgd=8f804811, *pte=00000000, *ppte=00000000
>>> [    1.278394] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>>> [    1.283815] Modules linked in:
>>> [    1.286970] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
>>> [    1.293614] Hardware name: Sigma Tango DT
>>> [    1.297726] task: cf82c9c0 task.stack: cf838000
>>> [    1.302364] PC is at quirk_usb_early_handoff+0x3e8/0x790
>>> [    1.307790] LR is at ioremap_page_range+0xf8/0x1a8
>>> [    1.312688] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
>>> [    1.312688] sp : cf839d78  ip : 00000000  fp : cf839e38
>>> [    1.324399] r10: c10248a0  r9 : 00000000  r8 : d08611e4
>>> [    1.329733] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb4e800
>>> [    1.336377] r3 : 000131e4  r2 : 00000000  r1 : 91001e13  r0 : d084e000
>>
>> ...and again. And always at the same PC, too.
>
> By the way, isn't LR supposed to point to the caller of the
> current function? ("LR is at ioremap_page_range")
>
> If so, why does it not appear in the back trace?
>

lr is supposed to point to the return address at function entry. After
that, all bets are off, really, since ARM usually pops the return
address from the stack straight into the pc register. So in this case,
it looks like it still contains the address that the most recent leaf
function returned to (or another function that actually restores the
return address into lr before branching to it). But it could easily
contain garbage as well.
