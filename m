From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Thu, 24 Mar 2011 19:11:16 +0100
Subject: RFC: ARM: Support for VFP/NEON registers in coredumps
In-Reply-To: <AANLkTinzxmULwhgXHbAUw0zveYXYj8zxRgZkoPYdOPhc@mail.gmail.com>
References: <20110324141826.GA3810@arm.com>	<OF1A9833E7.A620B0FF-ONC125785D.004F4BC3-C125785D.0052255A@de.ibm.com>
	<AANLkTin+X7BNBE9ZuDQhHVeNQqeNPjqj16pZDLTag_n+@mail.gmail.com>	<OFAB8D9B91.5F6DE70D-ONC125785D.0059E446-C125785D.005B916C@de.ibm.com>
	<AANLkTinzxmULwhgXHbAUw0zveYXYj8zxRgZkoPYdOPhc@mail.gmail.com>
Message-ID: <OF17449AB0.36DF06DD-ONC125785D.00635CD3-C125785D.0063E8BB@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <dave.martin@linaro.org> wrote:
> On Thu, Mar 24, 2011 at 4:40 PM, Ulrich Weigand
<Ulrich.Weigand@de.ibm.com> wrote:
> > I would prefer to keep the contents of NT_VFPREGSET identical to the
> > contents of the PTRACE_GETVPFREGS/PTRACE_SETVPFREGS buffer:
> >
> > - This would allow implementation via the new generic user_regset_view
> > ?mechanism (which the ARM kernel doesn't use yet, but probably should)
> >
> > - In any case, GDB likes to have the same set of information available
> > ?when debugging core files and native targets
> >
> > So if there is indeed additional information that would be interesting,
> > I'd argue this should be presented as a *new* core file note, *and* as
> > a new set of PTRACE_... APIs. ? (But for GDB's purpose NT_AUXV right
> > now is sufficent. ?Everything else could be displayed to the user if
> > of interest.)
>
> OK, that sounds reasonable.
>
> If I'm reading the kernel code correctly, the size of the data
> returned by PTRACE_GETVFPREGS is already dependent on the number of
> registers (D16/D32) implemented by the hardware, and this is
> determinable from the auxv contents; so I guess we don't have a new
> problem to solve here.
>
> The other info can always be added in a later pass, if it looks like
> it would be useful...

OK, agreed.

So to summarize: the kernel will write additional note sections as if
generated via user_regset_view, containing the PTRACE_GETVFPREGS data.

Note name: "LINUX"
Note type: t.b.d. [*]

[*] Looking at elf.h a logical name/value might be:

#define NT_ARM_VFP            0x400		/* ARM VFP/NEON registers */


GDB support along those lines ought to be straightforward.



Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  STSM, GNU compiler and toolchain for Linux on System z and Cell/B.E.
  IBM Deutschland Research & Development GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch?ftsf?hrung: Dirk
Wittkopp
  Sitz der Gesellschaft: B?blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294
