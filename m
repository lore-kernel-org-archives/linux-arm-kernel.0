From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Nov 2012 12:20:11 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <201211051908.34291.arnd@arndb.de>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211051908.34291.arnd@arndb.de>
Message-ID: <20121106122011.GE29853@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 07:08:34PM +0000, Arnd Bergmann wrote:
> On Monday 05 November 2012, Will Deacon wrote:
> > I was playing around with !CONFIG_MMU today and to my dismay noticed that
> > you can't select ARCH_VEXPRESS without CONFIG_MMU=y! This is because
> > ARCH_VEXPRESS is only selectable via ARCH_MULTI_V7, which depends on
> > ARCH_MULTIPLATFORM which in turn depends on MMU.
> > 
> > I'm inclined to add a dummy VEXPRESS entry to arm/Kconfig which depends on
> > !ARCH_MULTIPLATFORM and just selects ARCH_VEXPRESS (with the if ARCH_MULTI_V7
> > dependency dropped) but I wondered if you'd got any better ideas?
> > 
> 
> I don't actually remember what the reason for making ARCH_MULTIPLATFORM
> depend on MMU was. Maybe it just works if you drop the dependency.
> 
> Presumably it's related to ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR not
> working on NOMMU, but if that's the case, we could make it
> 
> 
> ARCH_MULTIPLATFORM
> 	bool "Allow multiple platforms to be selected"
> 	select ARM_PATCH_PHYS_VIRT if !MMU
> 	select AUTO_ZRELADDR if !MMU

you mean if MMU, right?

> but maybe those actually work without MMU as well. I have never looked too
> closely at NOMMU configurations, every time I tried, they were broken in
> combination with something else I wanted to enable.

ARM_PATCH_PHYS_VIRT wouldn't make any sense, but I can't see why
AUTO_ZRELADDR wouldn't be ok. nommu-XIP kernels are a different kettle
of fish, but we don't care about a decompressor there.

The real problem will hit with things like CONFIG_DRAM_BASE, where !MMU
can't realistically support multiple platforms, so allowing
ARCH_MULTIPLATFORM doesn't feel quite right either...

Will
