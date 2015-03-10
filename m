From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 10 Mar 2015 14:45:55 -0400
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <54FF2F3E.7050503@list.ru>
References: <54FF21BE.2040506@list.ru> <54FF2B45.8060407@hurleysoftware.com>
 <54FF2F3E.7050503@list.ru>
Message-ID: <54FF3BE3.308@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2015 01:51 PM, Stas Sergeev wrote:
> 10.03.2015 20:35, Peter Hurley ?????:
>> On 03/10/2015 12:54 PM, Stas Sergeev wrote:
>>> Hello, the patch below is needed for a successful boot on armada-xp.
>>>
>>>
>>> -=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
>>> This fixes the following crash at boot:
>>>
>>>  Unhandled fault: external abort on non-linefetch (0x808) at 0xf00ca018
>>>  Internal error: : 808 [#1] SMP ARM
>>>
>>>  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc1 #3
>>>  Hardware name: Marvell Armada 370/XP (Device Tree)
>>>  task: ed41e800 ti: ed43e000 task.ti: ed43e000
>>>  PC is at _set_bit+0x28/0x50
>>>  LR is at n_tty_set_termios+0x328/0x358
>>>  pc : [<c01bc858>]    lr : [<c0207314>]    psr: 40000113
>>>  sp : ed43fd00  ip : 00000000  fp : 00000000
>>>  r10: 00000002  r9 : 00000000  r8 : ec930200
>>>  r7 : 00000000  r6 : f00ca018  r5 : f00ca000  r4 : ed69cc00
>>>  r3 : 00002000  r2 : 00002000  r1 : f00ca018  r0 : 00000000
>>>  Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>>>  Control: 10c5387d  Table: 0000406a  DAC: 00000015
>>>  Process swapper/0 (pid: 1, stack limit = 0xed43e220)
>>>
>>> The offending instruction in _set_bit() is "strex r0, r2, [r1]"
>>> For some reason the exclusive access instructions do not like the
>>> vmalloc() space... While there may be another fix to make them
>>> fine about vmalloc() space, it still looks like a good idea to
>>> use kmalloc() for allocating a small (sub-page) struct.
>> NAK.
>>
>> struct n_tty_data is order 2, not sub-page.
> OK, you are right, sorry. 8844 bytes.
> Is this really a target for vmalloc() though? I thought kmalloc()
> is preferable even for that size.

It doubles as a selftest for arch page table setup :)

I considered only using vmalloc() as a fallback, but problems
like this make me *less* interested in doing that. At least this
way the problem is unambiguous.

Regards,
Peter Hurley
