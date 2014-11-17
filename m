From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Nov 2014 14:47:04 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117141123.GG10829@port70.net>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117141123.GG10829@port70.net>
Message-ID: <20141117144704.GE29595@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 02:11:23PM +0000, Szabolcs Nagy wrote:
> * Catalin Marinas <catalin.marinas@arm.com> [2014-11-17 13:54:13 +0000]:
> > ARM11MPCore). ARM is trying to move away from architecture version
> > numbers, which are rather useful for marketing, to proper feature
> > detection based on CPUID. Whether there is an ARMv9 or not, it's
> > irrelevant to what Linux should do (i.e. use CPUID rather than guess
> > features based on architecture version numbers).
> 
> how to use cpuid from userspace?

It's not possible and not recommended either. Just because the hardware
supports a feature line Neon doesn't mean that the kernel supports it as
well (e.g. saving/restoring registers).

> should linux export those bits into hwcap?

For many things we do. Unfortunately, we didn't do this for DMB, maybe
because we relied too much on the kuser helpers.

> (i assume all relevant info will be available in /proc/cpuinfo but
> that does not work for libc)

I wouldn't recommend /proc/cpuinfo.

If you want to put a dependency on newer kernel versions, there are
options like hwcap, more info in auxv (e.g. an arch-specific dump of the
CPUID registers) or even emulating CPUID access in user space (trap the
undefined instruction and return something that the kernel knows it can
support).

I'm happy with any of these options but I would like to see a concrete
proposal accepted by the libc people before committing to
implementing/supporting such ABI.

-- 
Catalin
