From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Dec 2013 16:18:48 -0500 (EST)
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <CAKv+Gu9jw4RHny3L3L6SWm4anhRguhRe4BkLKAxJeqpPB12igg@mail.gmail.com>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
 <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
 <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
 <20131218105541.GE4360@n2100.arm.linux.org.uk>
 <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
 <20131218112713.GA28112@arm.com>
 <20131218114211.GF4360@n2100.arm.linux.org.uk>
 <20131218120306.GC28112@arm.com> <52B1B0E0.6030104@codeaurora.org>
 <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
 <alpine.LFD.2.10.1312181449580.7480@knanqh.ubzr>
 <CAKv+Gu9jw4RHny3L3L6SWm4anhRguhRe4BkLKAxJeqpPB12igg@mail.gmail.com>
Message-ID: <alpine.LFD.2.10.1312181550271.7480@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Dec 2013, Ard Biesheuvel wrote:

> On 18 December 2013 20:57, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Wed, 18 Dec 2013, Ard Biesheuvel wrote:
> >
> >> On 18 December 2013 15:27, Christopher Covington <cov@codeaurora.org> wrote:
> >> >
> >> > I do not think that Russell is the source of the confusion. Ard wrote, "The
> >> > idea is that a binary built for ARM will have access to the extended
> >> > instructions which ARM64 offers to ARM32 binaries running in 32 bit
> >> > compatibility mode (such as AES, SHAx etc)." I think s/ARM64/ARMv8/ is
> >> > necessary to make the statement correct, and hopefully less confusing.
> >> >
> >>
> >> My apologies for adding to the confusion (or creating it in the first place).
> >>
> >> However, the bottom line is that, as the 32 bit and 64 bit kernels are
> >> both able to support userland processes running in the execution state
> >> that has retroactively been dubbed 'AArch32', they should both honor
> >> the same contract with AArch32 userland on how to discover CPU
> >> capabilities at runtime. I do understand Russell's reservations about
> >> allocating 6 of the remaining 10 hwcaps bits, and I am open to
> >> suggestions on a better approach.
> >
> > What is the reason for eating a grand total of 6 bits at once in the
> > first place?
> >
> 
> I wasn't entirely accurate: it's 5 bits not 6 ...
> 
> > Are those capabilities really going to be independently integrated?  In
> > other words, what is the probability for a vendor to integrate some but
> > not the others?  If this probability is low then maybe a smaller set of
> > wider-covering bits would be good enough in practice, and then some
> > kernel emulation could be added for the odd cases.
> >
> 
> The capabilities in question are:
> * AES
> * 64 bit polynomial (carry-less) multiply
> * SHA1
> * SHA2
> * CRC32
> and it is up to the implementor to choose the combination. To me,
> there are no obviously more likely combinations, but perhaps others
> have other ideas?

In any case, I agree with Russell that this looks a bit excessive to 
have a single bit for individual instructions.  The current hwcaps is 
certainly not suitable for that level of granularity without a way to 
extend it.

What does the ARM ARM say about those instructions?  Are they 
individually optional?

> The nice thing about hwcaps is that it is already integrated into the
> ifunc resolution done by the loader, which makes it very easy and
> straightforward to offer alternative implementations of library
> functions based on CPU capabilities.

The library may as well implement its own ifunc that tests the 
instruction while trapping SIGILL.  On those systems with the supported 
instruction there will be no trap.  On those that traps then the 
alternative implementation is going to be much slower anyway.

> As any kind of emulation in the kernel is likely to be slower than an
> optimized implementation for a CPU without the feature in question,
> trapping SIGILL to infer hwcaps is probably the only viable alternate
> approach that does not require a new kernel interface.

True.  However the kernel side infrastructure to emulate any instruction 
is already there.  So this is just a matter of adding an additional 
entry making the call to the existing libs.  At least that would make 
things work in case the user space libs, or some inline assembly in 
application code, is not expecting the lack of hardware support.


Nicolas
