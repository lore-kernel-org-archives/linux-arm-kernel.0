From: viktor.rosendahl@nokia.com (Viktor Rosendahl)
Date: Tue, 29 Mar 2011 14:26:39 +0300
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <alpine.LFD.2.00.1103281822170.11889@xanadu.home>
References: <1301087944.2744.85.camel@computer2.home>
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
	<alpine.LFD.2.00.1103281822170.11889@xanadu.home>
Message-ID: <4D91C1EF.1040102@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2011 01:39 AM, ext Nicolas Pitre wrote:
>
> Please send to RMK's patch system.
>

OK, will do.

> I agree that it might be a better idea to simply reject the dubious
> cases upfront from arm_kprobe_decode_insn() and keep the actual

What do you mean by "dubious cases" ?

Do you mean oddball special cases of instructions that are fully legal 
with a well defined behavior, although they are unlikely to be emitted 
by gcc ?

..or do you mean instructions whose behavior are undefined by the 
current architecture but would not necessarily cause an illegal 
instruction exception ?

My take is that it could be worth checking for as many as possible of 
the legal oddball cases. When it comes to instructions with undefined 
behavior, I think the ideal would be if they are rejected by 
arm_kprobe_decode_insn().

My guess is that most of the kprobe slowdown will not anyway come from a 
few extra checks in the emulation/simulation code but from the handling 
of the illegal instruction exceptions that will occur when the probe is 
hit and at the end of single stepping.

> emulation code fast and free from odd conditions that might never be
> useful in practice.  I think this is highly unlikely that we would find
> some usage of LDRD/STRD indexed by r15 in the kernel.
>

I guess that depends on the gcc backend. When doing an "objdump -d 
vmlinux", I found this:

b00165fc <sort_main_extable>:
b00165fc:	e59f0004 	ldr	r0, [pc, #4]	; b0016608
b0016600:	e59f1004 	ldr	r1, [pc, #4]	; b001660c
b0016604:	ea074262 	b	b01e6f94 <sort_extable>
b0016608:	b0548840 	.word	0xb0548840
b001660c:	b0549770 	.word	0xb0549770

Now, I admit that it's possible that somewhere beyond the horizon of my 
understanding there is some good reason to do two LDRs into adjacent 
registers from adjacent memory addresses, instead of merging them into 
one LDRD.

However, it gives me the impression that it would not be that unlikely 
that some future version of gcc could generate an LDRD in some function 
prologues.

BTW, in my kernel, LDR indexed by r15 is a really common instruction at 
the very beginning of functions. I am not sure why; it could have 
something to do with the fact that the kernel is compiled without frame 
pointers.

best regards,

Viktor
