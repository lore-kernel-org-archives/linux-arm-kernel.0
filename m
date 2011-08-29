From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 29 Aug 2011 12:33:41 -0400 (EDT)
Subject: [RFC PATCH] arm: fiq: convert enable/disable_fiq to inline
	functions
In-Reply-To: <CANfBPZ-MbHP8zAqmi3m6=PjSkvBeWO=H18B+ALZToeHrQdbcfw@mail.gmail.com>
References: <1314628177-3193-1-git-send-email-svenkatr@ti.com>
	<alpine.LFD.2.00.1108291112010.20358@xanadu.home>
	<CANfBPZ-MbHP8zAqmi3m6=PjSkvBeWO=H18B+ALZToeHrQdbcfw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1108291224580.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Aug 2011, S, Venkatraman wrote:

> On Mon, Aug 29, 2011 at 8:44 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Mon, 29 Aug 2011, Venkatraman S wrote:
> >
> >> FIQ_START is an platform specific constant used in the
> >> implementation of enable_fiq and disable_fiq.
> >> Converting then to inline functions enables different
> >> architectures which use the FIQ module to exist in a single
> >> zImage with different values of FIQ_START.
> >>
> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> >
> > I fail to see how this patch inproves things. The asm/fiq.h file is just
> > as global as kernel/fiq.c is.
> >
> 
> Argh!! I intended this to be a macro like this
> #define enable_fiq(x)  enable_irq((x) + FIQ_START)
> so that the constant is needed only at places where it is expanded.
> 
> This way different platforms can have their local irqs.h supply the constant,
> where the macros are used.
> 
> Somehow I thought inline functions are more readable and assumed the
> same macro'ish behaviour.
> 
> Will a macro variant of this be more useful ?

Well... I think that, given that this FIQ_START is not widely 
used/defined anyway, it would probably make sense to simply get rid of 
it and fold its value directly in the actual FIQ definition being used, 
directly in irqs.h.  For example, arch/arm/mach-rpc/include/mach/irqs.h 
could look like:

#define FIQ_START               64

#define FIQ_FLOPPYDATA          (FIQ_START + 0)
#define FIQ_ECONET              (FIQ_START + 2)
#define FIQ_SERIALPORT          (FIQ_START + 4)
#define FIQ_EXPANSIONCARD       (FIQ_START + 6)
#define FIQ_FORCE               (FIQ_START + 7)

And then FIQ_START wouldn't have to be used anywhere else.

But looking at the whole source tree I still fail to see the usefulness 
of this FIQ_START symbol, meaning that it could perhaps simply be 
removed outright.


Nicolas
