From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Nov 2012 17:33:44 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <20121106122011.GE29853@mudshark.cambridge.arm.com>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211051908.34291.arnd@arndb.de>
 <20121106122011.GE29853@mudshark.cambridge.arm.com>
Message-ID: <201211061733.44781.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012, Will Deacon wrote:
> > ARCH_MULTIPLATFORM
> >       bool "Allow multiple platforms to be selected"
> >       select ARM_PATCH_PHYS_VIRT if !MMU
> >       select AUTO_ZRELADDR if !MMU
> 
> you mean if MMU, right?

Yes.

> > but maybe those actually work without MMU as well. I have never looked too
> > closely at NOMMU configurations, every time I tried, they were broken in
> > combination with something else I wanted to enable.
> 
> ARM_PATCH_PHYS_VIRT wouldn't make any sense, but I can't see why
> AUTO_ZRELADDR wouldn't be ok.

Ok.

> nommu-XIP kernels are a different kettle
> of fish, but we don't care about a decompressor there.

XIP is only supported on ARCH_PXA and ARCH_SA1100. I don't see either
of them moving to CONFIG_MULTIPLATFORM any time soon, given how much
work that would be. ARCH_MMP should be possible in the future, but
has never supported XIP so far.

> The real problem will hit with things like CONFIG_DRAM_BASE, where !MMU
> can't realistically support multiple platforms, so allowing
> ARCH_MULTIPLATFORM doesn't feel quite right either...

Anybody who wants to build a !MMU kernel already needs to tweak the
configuration quite a lot and usually knows more about the system than
a typical end user. Having to pick the correct DRAM_BASE probably
isn't too bad in that case, as long as the kernels actually build.

	Arnd
