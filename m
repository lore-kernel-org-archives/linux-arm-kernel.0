From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 7 Jan 2016 18:31:44 +0000
Subject: [Qemu-devel] arm64 qemu tests failing in linux-next since
 'arm64: kernel: enforce pmuserenr_el0 initialization and restore'
In-Reply-To: <568E9BF6.6020809@roeck-us.net>
References: <567B41E3.5060800@roeck-us.net>
 <CAFEAcA_c9DicGF+is6ST3NJv+c5Bi4dHYo2t8Q2n9AS9G4q0+Q@mail.gmail.com>
 <20160107155310.GA4064@red-moon>
 <CAFEAcA_vP93=PE6LNNHodCsdk0gL0kBQPX=xzLJU5RzkvNs2vw@mail.gmail.com>
 <20160107163722.GB4064@red-moon> <568E9BF6.6020809@roeck-us.net>
Message-ID: <20160107183144.GA3869@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 09:10:14AM -0800, Guenter Roeck wrote:

[...]

> >If that's the case, that was the wrong approach IMHO. QEMU has to comply
> >with the Aarch64 architecture which means that either the CPU it models
> >has a Performance Monitors extension or it does not. If reading pmcr_el0
> >does not fault I could tell you this is a QEMU regression because currently
> >it _does_ model pmcr_el0 while (hopefully) ID_AA64DFR0_EL1 PMUVer reports
> >it should not.
> >
> 
> Strictly speaking you may be right (regression is a bit strong, though),
> but for my part I tend to be pragmatic.

It is a kernel bug and I will fix it. Regardless, I still think that
modelling pmcr_el0 to make sure the kernel boot even with ID_AA64DFR0_EL1
PMUVer reporting that the CPU is not implementing a Performance Monitors
extension was wrong.

> A warning message such as "Access to unimplemented register X" may be useful,
> but effectively disabling all (older) aarch64 Linux kernels in qemu could be
> seen as a bit dogmatic and would not be very helpful.
> 
> >I will add code that guards both register accesses to fix both bugs at
> >once.
> >
> 
> I assume you'll fix the the unconditional access(es) to pmcr_el0.

Yes.

> Question here is the scope of registers associated with PMUVer. Are there
> any other registers which would need to be guarded ?

None that I am aware of, other PMU registers are accessed only if PMUs
are probed (since they are present in DT or ACPI), which means that at
that point QEMU will have to model the Performance Monitors extension
entirely since it advertises them in the respective FW.

I could add a warning in the v8 PMU probing path to check PMUVer if we
think that's helpful.

Lorenzo
