From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Nov 2010 12:38:54 +0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101126122811.GM9310@n2100.arm.linux.org.uk>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<4CEE6AB1.7090404@ti.com>
	<20101125165048.GA2367@n2100.arm.linux.org.uk>
	<4CEF9B8D.3010106@ti.com>
	<20101126114509.GL9310@n2100.arm.linux.org.uk>
	<000101cb8d64$8fe819f0$afb84dd0$@deacon@arm.com>
	<20101126122811.GM9310@n2100.arm.linux.org.uk>
Message-ID: <1290775134.15771.42.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-26 at 12:28 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 26, 2010 at 12:22:15PM -0000, Will Deacon wrote:
> > Hi Russell,
> >
> > > $ arm-linux-as -v -o /dev/null /dev/null
> > > GNU assembler version 2.19.1 (arm-linux) using BFD version (GNU Binutils) 2.19.1
> > > $ arm-linux-as -march=armv6 -mfloat-abi=soft -meabi=5 -march=armv7-a -o /dev/null t.s
> > > $ arm-linux-as -march=armv6 -mfloat-abi=soft -meabi=5 -o /dev/null t.s
> > > t.s: Assembler messages:
> > > t.s:1: Error: selected processor does not support `ldrexb r7,[r6]'
> > >
> > > So it looks like someone's changed the behaviour of the assembler so it's
> > > no longer possible to override the -march= argument from the gcc frontend.
> > >
> > > Maybe Will can shed some light on this?
> >
> > Well we pass -march=armv6 to GCC and -march=v7-a to the assembler using the -Wa
> > option. This means that the compiler generates a .arch armv6 directive in the .s
> > file and the assembler barfs.
> >
> > Please can you try this patch?
> 
> We can't do this - we'll end up running ARMv7 code on ARMv6 CPUs.

An alternative would be to add the '.arch armv7-a' in the inline
assembly in swp_emulate.c. But that's an ugly workaround and you can't
revert to the previous .arch unless you add another '.arch armv6' at the
end of the asm (with lots of #ifdef's).

We need to check with tools people here since, as you said, there are
wider implications.

-- 
Catalin
