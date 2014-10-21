From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Oct 2014 17:15:55 +0100
Subject: where/how arm start first jump from svc to user in kernel
In-Reply-To: <CAOVJa8Eg37q8Mkrs1epraRnwUwSV0MO0p74727gCsdaaDwgoWg@mail.gmail.com>
References: <CAOVJa8Ho8Qz847HipcESsu=tDmd77r=hj4TP3Ut-4DG5nyQosw@mail.gmail.com>
 <20141015162005.GF22949@e104818-lin.cambridge.arm.com>
 <CAOVJa8Fa25W=oNHridmq+zZCRWRgKZtH+Ykt=w_YSwcaqpaNhA@mail.gmail.com>
 <20141021124132.GE15293@leverpostej>
 <CAOVJa8Eg37q8Mkrs1epraRnwUwSV0MO0p74727gCsdaaDwgoWg@mail.gmail.com>
Message-ID: <20141021161555.GG15293@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> 2014-10-21 20:41 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> > There is no movs pc, lr equivalent in AArch64. The eret instruction is
> > the only mechanism for dropping to a lower privileged exception level
> > (e.g. to EL0 userspace from an EL1 kernel).
> >
> > The A32 eret instruction was only added with the ARMv7 virtualization
> Per your explanation, EL0/EL1/EL3 of A32 are still using movs pc, lr, right?

In Linux we use move pc, lr on ARMv7 for dropping from PL1 to PL0. If
that's run on ARMv8, it's no different.

On ARMv8, 32-bit software runnign at EL3 (which would be in PL1) could
use eret, or could use MOVS PC, LR.

> > extensions (and in PL1 behaves as movs pc, lr if present). So it's
> Is here a type? (PL1 should be EL1?)

Not a typo. While ARMv8 defines things in terms of Exception Levels,
ARMv7 defined things in terms of Privilege Levels, and this is carried
over to AArch32 in ARMv8.

The mapping of Privilege Levels to Exception Levels is dependent on
several factors. The ARMv8 ARM ARM describes the two in more detail in
"Execution privilege, Exception levels, and AArch32 Privilege levels".

Thanks,
Mark.
