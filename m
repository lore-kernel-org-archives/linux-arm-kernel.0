From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 6 Nov 2012 13:33:28 +0000
Subject: [PATCH] ARM: Fix the "WFI" instruction opcode definition.
In-Reply-To: <0bee01cdbc11$4a59afb0$df0d0f10$%kim@samsung.com>
References: <DA41BE1DDCA941489001C7FBD7A8820E3CB5512E@szxeml549-mbx.china.huawei.com>
 <5091D13B.6060106@gmail.com>
 <CAKw8HL0ymmNRB=jgGcZn1+6k0s=FKA+qBV04y_wfeu7xMpUpkw@mail.gmail.com>
 <20121105173604.GF2005@linaro.org>
 <0bee01cdbc11$4a59afb0$df0d0f10$%kim@samsung.com>
Message-ID: <20121106133318.GA2038@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 08:24:31PM +0900, Kukjin Kim wrote:
> Dave Martin wrote:
> > 
> 
> [...]
> 
> > > >> -             asm(".word      0xe320f003\n"
> > > >> +             asm(__WFI
> > > >
> > > > Wouldn't using the actual wfi instruction fix this. There is a wfi()
> > > > macro.
> > > >
> > > > Or just call cpu_do_idle() which will do any other things needed
> > before
> > > > wfi like a dsb instruction.
> > > >
> > > > Rob
> > > >>                   :
> > > >>                   :
> > > >>                   : "memory", "cc");
> > >
> > > <Cut>
> > >
> > > Hi Rob,
> > >     Thanks for the reply. The way you suggested is more elegant. But
> > > here we worried about the version of the compiler toolchain used to
> > > build the kernel. The "WFI" assembler instruction may not be
> > > recognized if the toolchain is too old. Need the related ARM board
> > > maintainers to confirm this.
> > 
> > Maybe all the exynos platforms are new enough for this not to be a
> > problem?
> > 
> Yeah, I think there is no problem on exynos now.
> 
> > I think mach-exynos is pretty new and v7-only anyway.  If so, then it
> 
> Yes, right at the moment.
> 
> BTW, if mach-exynos includes ARMv8 later?...ARMv8 platform codes will be put
> in the arch/arm/ or arch/arm/64/ if some platform codes share with ARMv7?
> Just wondering...

That's a question for Catalin, I guess.

> > may be better to put
> > 
> > CFLAGS_hotplug.o	:= -march=armv7-a
> > 
> > in arch/arm/mach-exynos/Makefile, and use the real "wfi" mnemonic
> > directly.  People should _really_ not be building kernels containig
> > v7 board support with tools that are too old to support this.
> > 
> I think so...

OK, thanks for commenting.

Cheers
---Dave
