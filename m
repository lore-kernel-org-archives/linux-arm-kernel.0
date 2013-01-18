From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 17 Jan 2013 23:56:16 -0500 (EST)
Subject: [PATCH 2/3] ARM: convert platform hotplug inline assembly to C
In-Reply-To: <50F8C2D5.4070405@gmail.com>
References: <1358391205-23943-1-git-send-email-robherring2@gmail.com>
 <1358391205-23943-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1301162338420.6300@xanadu.home> <50F8082F.1050906@gmail.com>
 <alpine.LFD.2.02.1301171038590.6300@xanadu.home> <50F8C2D5.4070405@gmail.com>
Message-ID: <alpine.LFD.2.02.1301172340290.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Jan 2013, Rob Herring wrote:

> On 01/17/2013 09:42 AM, Nicolas Pitre wrote:
> > On Thu, 17 Jan 2013, Rob Herring wrote:
> > 
> >> On 01/16/2013 10:40 PM, Nicolas Pitre wrote:
> >>> On Wed, 16 Jan 2013, Rob Herring wrote:
> >>>
> >>>> From: Rob Herring <rob.herring@calxeda.com>
> >>>>
> >>>> With the addition of set_auxcr/get_auxcr, all the hotplug inline assembly
> >>>> code for exynos, imx, realview, spear13xx and vexpress can be converted to
> >>>> C code.
> >>>
> >>> That might not be all safe.  Please see
> >>> http://article.gmane.org/gmane.linux.ports.arm.kernel/209584
> >>
> >> Other than the OR/AND operations, it's all just inline assembly
> >> functions that are called, so it gets compiled to the same code. Perhaps
> >> I should put noinline on the functions so they stay of limited
> >> complexity. If you don't think doing this in C is okay, then there is
> >> probably no point in having the set_auxcr/get_auxcr functions.
> > 
> > I think set_auxcr/get_auxcr is fine.
> > 
> > But your patch goes beyond simply converting those.  You also converted 
> > the cache flush and disable from assembly to C, which on a Cortex A9 
> > might be unsafe if the stack is modified in the sequence according to 
> > the discussion I referenced.
> 
> The referenced discussion is mainly for the A15, not the A9, right?

Yes, however Santosh and Lorenzo were concerned by the fact that some 
people could look at the A15 code where accessing the stack is fine and 
copy it for some A9 where it apparently it is not.  See that message I 
directed you to and the responses to it.

> It seems the sequences are a bit different. So this is the code for A9 
> (spear13xx):
> 
> 	flush_cache_all();
> 	__flush_icache_all();
> 	dsb();
> 
> 	/*
> 	 * Turn off coherency
> 	 */
> 	set_auxcr(get_auxcr() & ~0x40);
> 	set_cr(get_cr() & ~CR_C);
> 
> which generates this:
> 
> c027f36c:       ebf648d2        bl      c00116bc <v7_flush_kern_cache_all>
> c027f370:       e3a03000        mov     r3, #0
> c027f374:       ee073f11        mcr     15, 0, r3, cr7, cr1, {0}
> c027f378:       f57ff04f        dsb     sy
> c027f37c:       ee113f30        mrc     15, 0, r3, cr1, cr0, {1}
> c027f380:       e3c33040        bic     r3, r3, #64     ; 0x40
> c027f384:       ee013f30        mcr     15, 0, r3, cr1, cr0, {1}
> c027f388:       f57ff06f        isb     sy
> c027f38c:       ee113f10        mrc     15, 0, r3, cr1, cr0, {0}
> c027f390:       e3c33004        bic     r3, r3, #4
> c027f394:       ee013f10        mcr     15, 0, r3, cr1, cr0, {0}
> c027f398:       f57ff06f        isb     sy
> c027f39c:       e320f003        wfi
> 
> v7_flush_kern_cache_all will generate stack accesses, but I didn't change that
> fact. The I cache invalidate changed from invalidate all to invalidate
> inner-shareable. I believe that should be equivalent. And the mcr version of
> dsb changed to a dsb instruction. Some isb's are inserted as well.
> 
> So I don't follow your concern.

_Their_ concern.  I did not stop to think about the alleged implications 
myself yet.  And that doesn't mean the existing code is correct either.

> You can't guarantee that the compiler wouldn't
> insert a data access in the middle, but then you could not guarantee that here
> either (exynos A15):
> 
>         asm volatile(
>         "       mrc     p15, 0, %0, c1, c0, 0\n"
>         "       bic     %0, %0, %1\n"
>         "       mcr     p15, 0, %0, c1, c0, 0\n"
>           : "=&r" (v)
>           : "Ir" (CR_C)
>           : "cc");
> 
>         flush_cache_louis();

Hence Lorenzo's argument that this should be done from assembly in a 
single stretch without memory access in the middle.

So, given the uncertainty around the correctness of the cache flush on a 
Cortex-A9, I'd suggest you steer clear of the debate and only convert 
accesses to the aux ctrl register.


Nicolas
