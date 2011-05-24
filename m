From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 24 May 2011 17:23:06 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<20110523132124.GI17672@n2100.arm.linux.org.uk>
	<1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>
	<yw1xipt0p4i9.fsf@unicorn.mansr.com>
	<BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>
Message-ID: <yw1xaaecoyol.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> 2011/5/24 M?ns Rullg?rd <mans@mansr.com>:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>
>>> On Mon, 2011-05-23 at 14:21 +0100, Russell King - ARM Linux wrote:
>>>> On Mon, May 23, 2011 at 12:16:48PM +0100, Catalin Marinas wrote:
>>>> > Newer versions of gcc generate unaligned accesses by default, causing
>>>> > kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
>>>> > -mno-unaligned-access option to gcc.
>>>>
>>>> This description doesn't make sense. ?If we have alignment traps enabled,
>>>> then we _expect_ to fix up unaligned loads and stores.
>>>>
>>>> Therefore there should be no panic if CONFIG_ALIGNMENT_TRAP is enabled.
>>>>
>>>> So what's the _actual_ problem that this is trying to address? ?What's
>>>> the panic/oops look like? ?And that information should be in the commit
>>>> description _anyway_.
>>>
>>> Does the patch below look better?
>>>
>>> We cannot move alignment_init() earlier as we don't know how early the
>>> compiler would generate unaligned accesses. An alternative is some
>>> #ifdef's in head.S. Please let me know which variant you prefer.
>>
>> ifdefs may be ugly, but I don't see a better solution here. ?Crippling
>> the entire build to make a couple of lines slightly more aesthetically
>> pleasing doesn't seem right to me.
>
> BTW, are we sure that the code generated with unaligned accesses is
> better? AFAIK, while processors support unaligned accesses, they may
> not always be optimal.

On Cortex-A8 unaligned loads not crossing a 128-bit boundary have no
penalty.  Crossing a 128-bit boundary stalls for 9 cycles (measured, 8
according to TRM).  On Cortex-A9, unaligned loads crossing a 64-bit
boundary delay 7 cycles (measured), other misalignments have no penalty.
On average these timings are faster than doing 4 byte loads and oring
them together, which uses 6 cycles on A9, 9 cycles on A8.

It may of course be the case that unaligned accesses are rare enough
that this isn't worth worrying about at all.

-- 
M?ns Rullg?rd
mans at mansr.com
