From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 7 Jan 2016 09:10:14 -0800
Subject: [Qemu-devel] arm64 qemu tests failing in linux-next since 'arm64:
 kernel: enforce pmuserenr_el0 initialization and restore'
In-Reply-To: <20160107163722.GB4064@red-moon>
References: <567B41E3.5060800@roeck-us.net>
 <CAFEAcA_c9DicGF+is6ST3NJv+c5Bi4dHYo2t8Q2n9AS9G4q0+Q@mail.gmail.com>
 <20160107155310.GA4064@red-moon>
 <CAFEAcA_vP93=PE6LNNHodCsdk0gL0kBQPX=xzLJU5RzkvNs2vw@mail.gmail.com>
 <20160107163722.GB4064@red-moon>
Message-ID: <568E9BF6.6020809@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2016 08:37 AM, Lorenzo Pieralisi wrote:
> On Thu, Jan 07, 2016 at 03:58:15PM +0000, Peter Maydell wrote:
>> On 7 January 2016 at 15:53, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>>> On Thu, Jan 07, 2016 at 01:25:35PM +0000, Peter Maydell wrote:
>>>> We had previously been relying on the kernel not attempting to
>>>> touch the PMU if the ID_AA64DFR0_EL1 PMUVer bits read 0000
>>>> ("Performance Monitors extension System registers not implemented").
>>>
>>> Ok, thanks for looking into this. I wonder why reading pmcr_el0 does
>>> not suffer from the same problem though.
>>
>> Just a pragmatic thing on QEMU's end, I expect -- the kernel already
>> touched PMCR_EL0 and we wanted to be able to boot it, so we have an
>> implementation of it.
>
> If that's the case, that was the wrong approach IMHO. QEMU has to comply
> with the Aarch64 architecture which means that either the CPU it models
> has a Performance Monitors extension or it does not. If reading pmcr_el0
> does not fault I could tell you this is a QEMU regression because currently
> it _does_ model pmcr_el0 while (hopefully) ID_AA64DFR0_EL1 PMUVer reports
> it should not.
>

Strictly speaking you may be right (regression is a bit strong, though),
but for my part I tend to be pragmatic.

A warning message such as "Access to unimplemented register X" may be useful,
but effectively disabling all (older) aarch64 Linux kernels in qemu could be
seen as a bit dogmatic and would not be very helpful.

> I will add code that guards both register accesses to fix both bugs at
> once.
>

I assume you'll fix the the unconditional access(es) to pmcr_el0.

Question here is the scope of registers associated with PMUVer. Are there
any other registers which would need to be guarded ?

Thanks,
Guenter
