From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Dec 2013 11:27:06 +0000
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <20131220082926.5c1b642c@i7>
References: <20131218120306.GC28112@arm.com> <52B1B0E0.6030104@codeaurora.org>
 <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
 <alpine.LFD.2.10.1312181449580.7480@knanqh.ubzr>
 <CAKv+Gu9jw4RHny3L3L6SWm4anhRguhRe4BkLKAxJeqpPB12igg@mail.gmail.com>
 <alpine.LFD.2.10.1312181550271.7480@knanqh.ubzr>
 <CAKv+Gu-1=7ZU+C3NL2_C0BBFkAcOhyZn8UvPtXHUtvwW6PKNYw@mail.gmail.com>
 <20131219084816.7247b1c7@i7> <20131219114816.GB30398@arm.com>
 <20131220082926.5c1b642c@i7>
Message-ID: <20131220112706.GG25477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 06:29:26AM +0000, Siarhei Siamashka wrote:
> On Thu, 19 Dec 2013 11:48:16 +0000
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Dec 19, 2013 at 06:48:16AM +0000, Siarhei Siamashka wrote:
> > > On Wed, 18 Dec 2013 22:57:33 +0100
> > > Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > On 18 December 2013 22:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > > > On Wed, 18 Dec 2013, Ard Biesheuvel wrote:
> > > > >> The nice thing about hwcaps is that it is already integrated into the
> > > > >> ifunc resolution done by the loader, which makes it very easy and
> > > > >> straightforward to offer alternative implementations of library
> > > > >> functions based on CPU capabilities.
> > > > >
> > > > > The library may as well implement its own ifunc that tests the
> > > > > instruction while trapping SIGILL.  On those systems with the supported
> > > > > instruction there will be no trap.  On those that traps then the
> > > > > alternative implementation is going to be much slower anyway.
> > > > 
> > > > True. And the trap still only occurs at load time. But I think we
> > > > agree it is essentially a poor man's hwcaps.
> > > 
> > > And the hwcaps is essentially a poor man's replacement for a userspace
> > > accessible CPUID instruction enjoyed by x86.
> > 
> > hwcaps has its value but I agree that some quicker access would be good
> > in certain cases. However, simply exposing the CPUID scheme to user
> > space may look nice initially but has other problems. All the
> > discussions we had (in ARM) basically ended up with having some scratch
> > registers that could be accessed from user via mrs and the kernel would
> > either copy the CPUID registers or hwcap-like bits (but basically it is
> > just an ABI between user and kernel).
> 
> Sorry, I don't seem to follow what exactly was wrong with this approach.
> It looks like a good idea to me. Was it abandoned?

It isn't present in ARMv8/AArch64. My point was that it pretty much
turns into a software-only ABI with another set of registers similar to
the thread ones. That's where you need to balance between more hardware
registers and a software VDSO-like mechanism.

> > Anyway, for such A7/A15 combinations, the idea is to optimise for A7's
> > pipeline since A15 execution is more out of order and tolerant to
> > instruction order.
> 
> So all the software is supposed to be optimized just for A7 in the
> A7/A15 big.LITTLE combinations?
> 
> Let's take some video codec as an example. If somebody starts
> multi-threaded transcoding of some video hogging all CPU cores, then
> the execution is going to be migrated to A15, right? In this case it
> makes sense to have this codec optimized for A15.

As I said above, the A15 is more tolerant to pipeline optimisations, so
you may not see a significant difference if you optimise for A7 or A15.
But I haven't done any benchmarks, that's what the toolchain guys say.

> > > The best solution would be in my opinion a userspace accessible (and
> > > guaranteed not to trap) CPUID instruction. This has proven to work
> > > nicely for x86, so why inventing something overly complicated instead?
> > > In the case if the OS wants to conceal the CPU features from the
> > > userspace application, some special "I don't want to tell you,
> > > please use the slowest code path possible" value could be defined
> > > and returned by this instruction.
> > 
> > As I said above, just raw access to the CPUID registers may not always
> > be desirable. Some features require kernel support (like FP register
> > saving/restoring), so if you run an older kernel on a newer CPU you
> > shouldn't really use such feature.
> >
> > (I'm also not entirely sure about crypto stuff and export regulations,
> > whether a mobile vendor may want to disable some hwcap bits in kernel
> > even though the hardware supports it)
> 
> AFAIK the new registers saving/restoring is somehow handled in the x86
> world?

ARM is not x86.

A past example is VFP with 16 double registers and we later got Neon
with 32. The kernel needs updating to save/restore the extra registers.

> > > Well, if it's not desired (and already too late) to change how the
> > > hardware works, another solution would be to have runtime CPU
> > > features detection supported as part of the run-time ABI. For example,
> > > make it mandatory for any EABI conforming system to provide some helper
> > > functions like __aeabi_read_midr() or __aeabi_read_hwcaps(). They could
> > > be implemented for ARM Linux via the kernel-provided user helpers, VDSO
> > > or whatever other method that is appropriate. If this works for the
> > > things like TLS (__aeabi_read_tp), why can't it work for runtime CPU
> > > features detection too? The recent gcc versions also have some nice
> > > built-in functions for runtime cpu features detection on x86
> > > such as __builtin_cpu_is(), __builtin_cpu_supports():
> > >     http://gcc.gnu.org/gcc-4.8/changes.html
> > 
> > We discussed this in ARM with the toolchain guys and I'm fine with the
> > idea. But for backwards compatibility, we would need a way for newer
> > software to work on older kernels. On arm64, with VDSO is easier since
> > glibc could have a weak function that returns not-implemented. I would
> > rather have a VDSO on arm as well rather than abusing the vectors page.
> >
> > If you want to distinguish between CPUs, we can use one of the unused
> > TLS registers as offset into a VDSO data array with per-CPU information
> > (all handled via the VDSO code, so user shouldn't really know the
> > meaning). We have a user read-only thread register unused on arm64 (and
> > that's what we had in mind when using the read/write register for user
> > TLS).
> 
> Sounds good. And I like that this proposal has not been immediately
> dismissed yet. Would somebody from ARM or Linaro be willing to invest
> some time into trying to develop some prototype patches (for AArch64)?

I think the kernel patches part is not hard, it's more like talking to
the toolchain/library guys and agreeing on the actual ABI, how much
information we want to expose.

AFAIK so far the decision on which library to use is done at the dynamic
linking time based on the hwcap bits. If we make this some __builtin_*
in gcc, I think it cannot be overridden dynamically via VDSO. So better
get some toolchain guys involved first.

(and yes, it could be a nice Linaro project ;))

> So now I wonder, how difficult would it be to get VDSO working on
> 32-bit arm?

Couple of days I guess ;).

-- 
Catalin
