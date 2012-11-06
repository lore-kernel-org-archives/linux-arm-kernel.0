From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Nov 2012 15:58:12 -0500 (EST)
Subject: Building for MMU-less vexpress targets
In-Reply-To: <201211061733.44781.arnd@arndb.de>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211051908.34291.arnd@arndb.de>
 <20121106122011.GE29853@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Nov 2012, Arnd Bergmann wrote:

> On Tuesday 06 November 2012, Will Deacon wrote:
> > nommu-XIP kernels are a different kettle
> > of fish, but we don't care about a decompressor there.
> 
> XIP is only supported on ARCH_PXA and ARCH_SA1100. I don't see either
> of them moving to CONFIG_MULTIPLATFORM any time soon, given how much
> work that would be. ARCH_MMP should be possible in the future, but
> has never supported XIP so far.

XIP kernels (CONFIG_XIP_KERNEL) are supported on any architecture.  
This doesn't require any platform specific support.  You just need a 
range of physical memory addresses where to get the kernel text from 
(that could even be unmapped RAM if you wanted to play with it on a 
platform with no NOR flash).  The prospect of PRAM usage might renew 
interest in a XIP kernel.

Maybe you are confused by CONFIG_ARCH_MTD_XIP where special support is 
needed in order to make writable MTD devices compatible with a XIP 
kernel located on them.  That is indeed only available for ARCH_PXA and 
ARCH_SA1100.

> > The real problem will hit with things like CONFIG_DRAM_BASE, where !MMU
> > can't realistically support multiple platforms, so allowing
> > ARCH_MULTIPLATFORM doesn't feel quite right either...
> 
> Anybody who wants to build a !MMU kernel already needs to tweak the
> configuration quite a lot and usually knows more about the system than
> a typical end user. Having to pick the correct DRAM_BASE probably
> isn't too bad in that case, as long as the kernels actually build.

I really think that it makes no sense at all to support !MMU kernels in 
a multi-platform kernel build, even if the set of included platforms 
were all !MMU.  The kernel has to be linked for the physical address of 
the target and not a common invariant virtual address.


Nicolas
