From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Nov 2014 14:34:03 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117133035.GF10829@port70.net>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141117114832.GB29595@e104818-lin.cambridge.arm.com>
 <4211926.t6Cc7quoTR@wuerfel> <20141117133035.GF10829@port70.net>
Message-ID: <20141117143403.GD29595@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 01:30:35PM +0000, Szabolcs Nagy wrote:
> * Arnd Bergmann <arnd@arndb.de> [2014-11-17 13:21:03 +0100]:
> > On Monday 17 November 2014 11:48:33 Catalin Marinas wrote:
> > > On Sun, Nov 16, 2014 at 04:33:56PM +0000, Russell King - ARM Linux wrote:
> > > > On Sun, Nov 16, 2014 at 12:56:56AM -0500, Rich Felker wrote:
> > > > > Aside from that, the only case among the above that's "right" already
> > > > > is v7+. Hard-coding the mcr-based barrier on v6 is wrong because it's
> > > > 
> > > > I don't think it's wrong at all.  The instruction isn't going away from
> > > > ARMv7, because ARMv7 deprecates it, but it _still_ has to be implemented
> > > > by a CPU conforming to ARMv7.  As ARMv7 is going to be the last 32-bit
> > > > ARM architecture, we aren't going to see the MCR instruction disappearing
> > > > on 32-bit CPUs.
> > > 
> > > You are wrong here. ARMv8-A supports 32-bit at all levels. ARMv8-R is
> > > 32-bit only (and it even has an MMU at EL1). And there is a slight
> > > chance that we may even see 32-bit only ARMv8-A implementations (I'm not
> > > really giving a hint and I'm not aware of any but I don't see anything
> > > preventing this, it's all marketing driven).
> > 
> > FWIW, both Samsung EXYNOS and Qualcomm Snapdragon SoCs based on Cortex-A53
> > have been shipped in 32-bit only devices.
> 
> ARMv8-A manual talks about two execution sates:
> - aarch64 with 64 bit registers and A64 instruction set
> - aarch32 with 32 bit registers and A32 or T32 instruction sets
> 
> (i thought an armv8-a cpu must support both but that is not
> relevant to userspace)

I'm not sure there is a clear statement that both must be supported.
Even if they are, an SoC manufacturer may decide to hardwire the EL3
register width (external pin) to 32-bit only which makes the CPU a
32-bit one (as Arnd already mentioned).

> for userspace the two states are different architectures
> so i guess for libc aarch32 backward compatibility is the
> interesting question (does armv7 instructions, syscalls, elf
> abi work on aarch32) and how to recognize it when its new
> features can be used in the libc

The AT_PLATFORM on an AArch32 kernel running on ARMv8 would report
"v7l". An AArch64 kernel would report "v8l" to _compat_ tasks.

The AArch32 kernel could (and I think it should) be aligned to ARMv8 as
well. This is a trivial patch adding the corresponding proc_info in
proc-v7.S for Cortex-A53 etc. (we don't really need a proc-v8.S).

The differences between AArch32 binaries running on ARMv7 and ARMv8 are
around /proc/cpuinfo and uname (the latter matches x86 behaviour
already but for the former we wrongly thought people would just use
HWCAP). 32-bit binaries would need to use PER_LINUX32 personality for
uname and /proc/cpuinfo (the latter from 3.19) if they want the
ARMv7-like information.

The other things like syscall, HWCAP, AT_PLATFORM are all provided in a
compatible way to 32-bit binaries.

> if aarch32 has cp15 barrier then that is an option for portable
> binaries and the other approach is runtime dispatch but then libc
> needs a reliable check for >=armv7

AT_PLATFORM should work. We could also add a HWCAP bit for the presence
of DMB/DSB/ISB as well but it does not solve the problem of older
kernels, so I wouldn't recommend it.

We've had a long thread about deprecated/obsolete instructions and how
we inform user space about them. My proposal is here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/269675.html

which means that for CP15 barriers, we emulate the instructions even
though they are present to give an advanced warning to user space that
these may no longer be optimal at some point (e.g. emulated). As a
consequence, see the thread below implementing emulation, with the
possibility of quick hardware execution if available (e.g. for CP15
barriers, though defaulting to emulation):

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/297448.html

-- 
Catalin
