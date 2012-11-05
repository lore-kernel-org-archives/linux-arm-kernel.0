From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Nov 2012 19:08:34 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <20121105173640.GR3351@mudshark.cambridge.arm.com>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
Message-ID: <201211051908.34291.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 November 2012, Will Deacon wrote:
> I was playing around with !CONFIG_MMU today and to my dismay noticed that
> you can't select ARCH_VEXPRESS without CONFIG_MMU=y! This is because
> ARCH_VEXPRESS is only selectable via ARCH_MULTI_V7, which depends on
> ARCH_MULTIPLATFORM which in turn depends on MMU.
> 
> I'm inclined to add a dummy VEXPRESS entry to arm/Kconfig which depends on
> !ARCH_MULTIPLATFORM and just selects ARCH_VEXPRESS (with the if ARCH_MULTI_V7
> dependency dropped) but I wondered if you'd got any better ideas?
> 

I don't actually remember what the reason for making ARCH_MULTIPLATFORM
depend on MMU was. Maybe it just works if you drop the dependency.

Presumably it's related to ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR not
working on NOMMU, but if that's the case, we could make it


ARCH_MULTIPLATFORM
	bool "Allow multiple platforms to be selected"
	select ARM_PATCH_PHYS_VIRT if !MMU
	select AUTO_ZRELADDR if !MMU

but maybe those actually work without MMU as well. I have never looked too
closely at NOMMU configurations, every time I tried, they were broken in
combination with something else I wanted to enable.

	Arnd
