From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Mar 2015 06:54:40 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB056105B026481446243452FC8A0D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150322165710.GO8656@n2100.arm.linux.org.uk>
 <HK2PR06MB056105B026481446243452FC8A0D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <201503230654.40287.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 March 2015, Chris Brandt wrote:
> > Yes, that makes sense if we agree that we want to have multi-platform XIP kernels.
> 
> My initial ambition was to simply understand what the minimum Kconfig changes were
> needed to build XIP on the current upstream kernel.

I think it should be enough to change the dependency from !ARCH_MULTIPLATFORM
to !SMP_ON_UP as a start, and drop the reverse dependency in SMP_ON_UP.

Try running 'make randconfig' a few hundred times (without building the kernel)
and see if any obvious Kconfig warnings come up after doing that.

> I'm not convinced XIP and multi-platform really make sense together (unless ARM
> comes up with a new supper speedy configurable cache system just for DDR reads,
> but DDR writes have to be done from different address location).

There are two different scenarios to consider here:

a) building a kernel for a single machine while CONFIG_ARCH_MULTIPLATFORM is
   enabled
b) actually enabling all sorts of machines

I have patches to make ARCH_MULTIPLATFORM always enabled on all ARMv6/v7
targets and would like to get them into the next kernel. The main reasons
for this are to get rid of the special cases for non-multiplatform targets,
and to allow 'make allmodconfig' to include all known v6/v7 targets. This
means that I would definitely want to see XIP_KERNEL being possible on your
machine with a), but I agree that there is not much use for b) here.
 
> I guess my first goal is to make sure the existing XIP_KERNEL code doesn't
> get yanked out because no one thought it was being used.
 
Don't worry about that. We definitely rely on XIP_KERNEL for some of the
NOMMU targets, and it's not going away.

	Arnd
