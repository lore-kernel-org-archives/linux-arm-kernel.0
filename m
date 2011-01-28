From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Jan 2011 09:46:06 +0000
Subject: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
	support for arch < ARMv6K
In-Reply-To: <20110127185935.GA1651@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
	<AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
	<20110127185935.GA1651@n2100.arm.linux.org.uk>
Message-ID: <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-27 at 18:59 +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 27, 2011 at 06:14:56PM +0000, Catalin Marinas wrote:
> > On 17 January 2011 19:24, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > Rather than turning off CPU domain switching when the build architecture
> > > includes ARMv6K, thereby causing problems for ARMv6-supporting kernels,
> > > turn it on when it's required to support a CPU architecture.
> >
> > (sorry, I'm well behind list messages, didn't reply earlier)
> >
> > Does it mean that we get domains enabled even for ARMv7 when ARMv6 is
> > built in the same kernel? The side effect is that user read-only
> > addresses are writable by the kernel and SWP emulation no longer
> > works.
> 
> It means that a kernel with ARMv6 through to ARMv7 will have CPU
> domains enabled.  So maybe we want:
> 
> config CPU_32v6
>         select CPU_USE_DOMAINS if !CPU_V6K && MMU
> 
> instead?

Does this mean that we could still configure a kernel to run on CPU_V6
with domains disabled? The vectors page becomes read-only and setting
the TLS would fail.

My point is that we may want SWP_EMULATE disabled (or depending on !
CPU_USE_DOMAINS). With domains enabled every read-only user page is
writeable by the kernel. This has the side-effect that SWP emulation
using LDREX/STREX breaks COW.

We could change early_trap_init() to always use the vectors_page rather
than the high mapping and determine at run-time (patch the code) whether
set_pte_ext sets R/W kernel permissions for RO user pages.

-- 
Catalin
