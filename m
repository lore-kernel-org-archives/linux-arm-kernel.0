From: nsz@port70.net (Szabolcs Nagy)
Date: Mon, 17 Nov 2014 14:30:35 +0100
Subject: ARM atomics overhaul for musl
In-Reply-To: <4211926.t6Cc7quoTR@wuerfel>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141117114832.GB29595@e104818-lin.cambridge.arm.com>
 <4211926.t6Cc7quoTR@wuerfel>
Message-ID: <20141117133035.GF10829@port70.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [2014-11-17 13:21:03 +0100]:
> On Monday 17 November 2014 11:48:33 Catalin Marinas wrote:
> > On Sun, Nov 16, 2014 at 04:33:56PM +0000, Russell King - ARM Linux wrote:
> > > On Sun, Nov 16, 2014 at 12:56:56AM -0500, Rich Felker wrote:
> > > > Aside from that, the only case among the above that's "right" already
> > > > is v7+. Hard-coding the mcr-based barrier on v6 is wrong because it's
> > > 
> > > I don't think it's wrong at all.  The instruction isn't going away from
> > > ARMv7, because ARMv7 deprecates it, but it _still_ has to be implemented
> > > by a CPU conforming to ARMv7.  As ARMv7 is going to be the last 32-bit
> > > ARM architecture, we aren't going to see the MCR instruction disappearing
> > > on 32-bit CPUs.
> > 
> > You are wrong here. ARMv8-A supports 32-bit at all levels. ARMv8-R is
> > 32-bit only (and it even has an MMU at EL1). And there is a slight
> > chance that we may even see 32-bit only ARMv8-A implementations (I'm not
> > really giving a hint and I'm not aware of any but I don't see anything
> > preventing this, it's all marketing driven).
> 
> FWIW, both Samsung EXYNOS and Qualcomm Snapdragon SoCs based on Cortex-A53
> have been shipped in 32-bit only devices.
> 

ARMv8-A manual talks about two execution sates:
- aarch64 with 64 bit registers and A64 instruction set
- aarch32 with 32 bit registers and A32 or T32 instruction sets

(i thought an armv8-a cpu must support both but that is not
relevant to userspace)

for userspace the two states are different architectures
so i guess for libc aarch32 backward compatibility is the
interesting question (does armv7 instructions, syscalls, elf
abi work on aarch32) and how to recognize it when its new
features can be used in the libc

if aarch32 has cp15 barrier then that is an option for portable
binaries and the other approach is runtime dispatch but then libc
needs a reliable check for >=armv7
