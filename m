From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 24 Mar 2011 16:11:32 +0000
Subject: RFC: ARM: Support for VFP/NEON registers in coredumps
In-Reply-To: <OF1A9833E7.A620B0FF-ONC125785D.004F4BC3-C125785D.0052255A@de.ibm.com>
References: <20110324141826.GA3810@arm.com>
	<OF1A9833E7.A620B0FF-ONC125785D.004F4BC3-C125785D.0052255A@de.ibm.com>
Message-ID: <AANLkTin+X7BNBE9ZuDQhHVeNQqeNPjqj16pZDLTag_n+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2011 at 2:57 PM, Ulrich Weigand
<Ulrich.Weigand@de.ibm.com> wrote:
> Dave Martin <dave.martin@linaro.org> wrote:
>
>> ?c) Create a new note type specially for this, and dump the
>> ? ? VFP/NEON regs in there. ?This is closest to the model followed
>> ? ? by ptrace, where PTRACE_GETREGS, PTRACE_GETFPREGS and
>> ? ? PTRAGE_GETVFPREGS are all distinct.
>
> From a GDB perspective, I'd consider this the preferred solution;
> there are precedents for this on other platforms (e.g. PowerPC),
> and there is existing GDB/BFD infrastructure to check for presence/
> absence of such notes.
>
> However, we also need to be able to distinguish the various cases:
> VFPv2 vs. VFPv3-D16 vs. VFPv3-D32 vs. VFPv32-D32+NEON
> These cause GDB to display/interact with the register set in
> different ways ...
>
> To distinguish 16 vs. 32 registers, we can of course simply look
> at the size of the note. ?But how to detect support for NEON as
> opposed to plain VFPv32-D32? ?I could think of two ways:
>
> 1) Have *two* new note types, one for VFP, and one for NEON

That may not make sense, since really it's a single register file
shared by VFP and NEON.  With NEON, you always have 32 x 64-bit regs,
but it's possible (although rare) to have this many regs on ARMv7 even
if NEON is absent.

> 2) Have GDB look into the AT_HWCAP setting in the NT_AUXV note
>
> Option 2) seems preferable to me, since NT_AUXV is already there,
> and it can also be used to detect the integer-only NEON case.

We could also dump the relevant hardware capability registers, which
can be more informative, though I'm in two minds about whether this is
appropriate / beneficial.  A layout something like this might work:

NT_VFPREGSET*

    unsigned long flags;
    unsigned long feature_registers[3];
    unsigned long fpscr;
    unsigned long long regs[16 or 32];

There are currently 3 relevant feature registers, the main
floating-point ID register FPSID, and the floating-point / SIMD
feature registers MVFR0, MVFR1.

In either case, we define the contents of the flags field in such a
way as to allow gdb to understand the format, and to allow for future
expansion if this is ever needed.

(*The note types seem to use different names in linux/elf.h compared
with /usr/include/elf.h and GDB.  I've followed the outside world's
convention here.)

Does this look workable?

---Dave

>
> Thoughts?
>
>
> Mit freundlichen Gruessen / Best Regards
>
> Ulrich Weigand
>
> --
> ?Dr. Ulrich Weigand | Phone: +49-7031/16-3727
> ?STSM, GNU compiler and toolchain for Linux on System z and Cell/B.E.
> ?IBM Deutschland Research & Development GmbH
> ?Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch?ftsf?hrung: Dirk
> Wittkopp
> ?Sitz der Gesellschaft: B?blingen | Registergericht: Amtsgericht
> Stuttgart, HRB 243294
>
>
