From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Thu, 19 Dec 2013 08:48:16 +0200
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <CAKv+Gu-1=7ZU+C3NL2_C0BBFkAcOhyZn8UvPtXHUtvwW6PKNYw@mail.gmail.com>
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
 <alpine.LFD.2.10.1312181550271.7480@knanqh.ubzr>
 <CAKv+Gu-1=7ZU+C3NL2_C0BBFkAcOhyZn8UvPtXHUtvwW6PKNYw@mail.gmail.com>
Message-ID: <20131219084816.7247b1c7@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Dec 2013 22:57:33 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 18 December 2013 22:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Wed, 18 Dec 2013, Ard Biesheuvel wrote:
> >> The nice thing about hwcaps is that it is already integrated into the
> >> ifunc resolution done by the loader, which makes it very easy and
> >> straightforward to offer alternative implementations of library
> >> functions based on CPU capabilities.
> >
> > The library may as well implement its own ifunc that tests the
> > instruction while trapping SIGILL.  On those systems with the supported
> > instruction there will be no trap.  On those that traps then the
> > alternative implementation is going to be much slower anyway.
> >
> 
> True. And the trap still only occurs at load time. But I think we
> agree it is essentially a poor man's hwcaps.

And the hwcaps is essentially a poor man's replacement for a userspace
accessible CPUID instruction enjoyed by x86.

It's sad to see that the runtime CPU features detection still remains
a PITA with AArch64. Basically, it's not enough to know if the
instruction is supported or not. Different microarchitectures may
various performance quirks for certain instructions. For example,
VFPLite in Cortex-A8 is non-pipelined and slow. Cortex-A15 can
dual-issue NEON instructions (nice for the code which can enjoy
high ILP), but Cortex-A15 NEON instructions have relatively high
latency (bad for the code, which is essentially a long dependency
chain). The fastest way to read uncached memory for most ARM
processors is to use the VFP load multiple instruction with as
many registers as possible, but this is slow on Marvell PJ4. And
so on.

The information, usable for basic microarchitecture identification
(the value from MIDR register) is only exposed in /proc/cpuinfo, which
makes it an overall winner for the runtime CPU features detection
method. Additionally, reading /proc/self/auxv for retrieving hwcaps has
issues when run under qemu or valgrind. Instructions trapping is a very
bad idea for multiple reasons (one of them is the fact that we can't
easily distinguish between trapped&emulated and natively supported
by hardware, think about FP instructions emulation for example).

So there is no really good alternative to /proc/cpuinfo parsing. But
text parsing is relatively cumbersome to implement. And this method is
obviously not blazingly fast. Also the big.LITTLE systems introduce
an interesting new challenge. How do we know whether we are running
the code on Cortex-A7 or Cortex-A15 at any arbitrary moment? We might
want to have several different assembly optimized functions, one
optimized for Cortex-A15 pipeline and another one optimized for
Cortex-A7. It would be nice to be able to frequently poll for the CPU
features of the currently running CPU core (for example, once per
frame in a video encoder/decoder) to select the fastest code path.
With /proc/cpuinfo text parsing this is not going to work nicely.

The best solution would be in my opinion a userspace accessible (and
guaranteed not to trap) CPUID instruction. This has proven to work
nicely for x86, so why inventing something overly complicated instead?
In the case if the OS wants to conceal the CPU features from the
userspace application, some special "I don't want to tell you,
please use the slowest code path possible" value could be defined
and returned by this instruction.

Well, if it's not desired (and already too late) to change how the
hardware works, another solution would be to have runtime CPU
features detection supported as part of the run-time ABI. For example,
make it mandatory for any EABI conforming system to provide some helper
functions like __aeabi_read_midr() or __aeabi_read_hwcaps(). They could
be implemented for ARM Linux via the kernel-provided user helpers, VDSO
or whatever other method that is appropriate. If this works for the
things like TLS (__aeabi_read_tp), why can't it work for runtime CPU
features detection too? The recent gcc versions also have some nice
built-in functions for runtime cpu features detection on x86
such as __builtin_cpu_is(), __builtin_cpu_supports():
    http://gcc.gnu.org/gcc-4.8/changes.html

Please, could we finally have something sane for the runtime CPU
features detection on ARM hardware?

-- 
Best regards,
Siarhei Siamashka
