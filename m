From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Jan 2011 09:59:53 +0000
Subject: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
	support for arch < ARMv6K
In-Reply-To: <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
	<AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
	<20110127185935.GA1651@n2100.arm.linux.org.uk>
	<1296207966.1799.10.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20110128095953.GA13005@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 09:46:06AM +0000, Catalin Marinas wrote:
> Does this mean that we could still configure a kernel to run on CPU_V6
> with domains disabled? The vectors page becomes read-only and setting
> the TLS would fail.

Yes it will, so that's not acceptable either.

> My point is that we may want SWP_EMULATE disabled (or depending on !
> CPU_USE_DOMAINS). With domains enabled every read-only user page is
> writeable by the kernel. This has the side-effect that SWP emulation
> using LDREX/STREX breaks COW.

Yes, and maybe we should instead just enable the SWP instruction by default
on ARMv7, and if SWP emulation is built, disable it at that point.

> We could change early_trap_init() to always use the vectors_page rather
> than the high mapping and determine at run-time (patch the code) whether
> set_pte_ext sets R/W kernel permissions for RO user pages.

With aliasing caches that becomes much more difficult.
