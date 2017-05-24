From: slash.tmp@free.fr (Mason)
Date: Wed, 24 May 2017 23:19:19 +0200
Subject: User-space code aborts on some (but not all) misaligned accesses
In-Reply-To: <43fd0ea8-8403-2122-365c-070984accd0f@arm.com>
References: <e80ee08d-e8ab-9eeb-9555-a743f8681d7d@free.fr>
 <b9060068-5b9b-89b4-851e-430ec02f9fd8@arm.com>
 <382740a0-7d3b-7109-085a-d0ee2cc75638@free.fr>
 <43fd0ea8-8403-2122-365c-070984accd0f@arm.com>
Message-ID: <254ec428-fb12-8a74-86c9-d5524ab18d9a@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/2017 19:25, Robin Murphy wrote:

> On 24/05/17 17:56, Mason wrote:
>
>> On 24/05/2017 17:45, Robin Murphy wrote:
>>
>>> The other thing to say, of course, is "don't make unaligned accesses to
>>> Strongly-Ordered memory in the first place".
>>
>> How would you fix my test case?
> 
> "rm store.c testcase.c"?
> 
> The point being that what you are doing looks fairly nonsensical to
> begin with, since it's not like many peripherals support unaligned reads
> or writes anyway. /dev/mem gives you pgprot_noncached, which translates
> to Strongly Ordered, because as far as the kernel's concerned you're
> mapping random bits of physical address space which could be home to
> anything at all, and using a weaker memory type could be a Very Bad
> Thing. You don't want to waste (significant) time debugging the
> side-effects of the CPU speculatively filling cachelines from some
> read-sensitive register, that's for sure.

For the record, the code base in question is very old, some
of it predates the 2.6 kernel. I do get the urge to send it
to /dev/null on a regular basis (I've rewritten a few drivers
from scratch, which are now upstream.)

Basically, the system provides 2 GB of RAM.

	memory at 80000000 {
		device_type = "memory";
		reg = <0x80000000 0x80000000>; /* 2 GB */
	};

Currently, Linux is given only a fraction of the available RAM
via mem=256M on the boot command-line. The rest is managed by
a cross-processor memory manager. This "foreign" RAM is then
mapped in Linux, and written from user-space to pass information
to other processors in the system (MIPS, DSP).

IIUC, lying to Linux about the nature of this address range has
always been a bad idea. Linux must be aware that it is plain RAM,
without side-effects and similar nastiness.


>> I'm on a Cortex A9, so ARMv7-A
>> But my copy of the ARM ARM is revB.
>> I found rev C.b but that doesn't explain f8c0 vs f840
> 
> Its an immediate-offset STR, not a register-offset one.

I see it now.

A8.8.203 STR (immediate, Thumb)

Encoding T3 ARMv6T2, ARMv7
STR<c>.W <Rt>, [<Rn>, #<imm12>]

1 1 1 1 1 0 0 0 1 1 0 0 Rn Rt imm12

str.w	r1, [r0, #1]
n=0 t=1 imm=1

f8c0 1001

Cool, thanks.


On a tangential topic, between

A8.8.203 STR (immediate, Thumb) Encoding T4 ARMv6T2, ARMv7
1 1 1 1 1 0 0 0 0 1 0 0 Rn Rt 1 P U W imm8  (f84n txxx)

and

A8.8.205 STR (register) Encoding T2 ARMv6T2, ARMv7
1 1 1 1 1 0 0 0 0 1 0 0 Rn Rt 0 0 0 0 0 0 imm2 Rm (f84n t0xm)


The instruction f840 1001 cannot be A8.8.203 Encoding T4
because P and W cannot both be zero, therefore it must
be A8.8.205 Encoding T2?

So the decoder cannot determine the exact instruction just
by looking at a prefix? It has to scan the entire string?

Regards.
