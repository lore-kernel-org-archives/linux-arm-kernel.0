From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 21 Nov 2014 18:09:27 +0100
Subject: arm: pxa: CPU_PXA27x?
In-Reply-To: <87vbm85wjs.fsf@free.fr>
References: <1416566627.6958.16.camel@x220> <87vbm85wjs.fsf@free.fr>
Message-ID: <1416589767.1114.9.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-21 at 17:48 +0100, Robert Jarzmik wrote:
> Paul Bolle <pebolle@tiscali.nl> writes:
> > Your commit 03ec7fe70c5c ("arm: pxa: add pxa27x device-tree support") is
> > included in today's linux-next (ie, next-20141121). It adds a select
> > statement for CPU_PXA27x. But there's no Kconfig symbol CPU_PXA27x.
> Ah yes, you're perfectly right, CPU_PXA27x was not the one, it was PXA27x, sic
> ..
> 
> >
> > Why is that select needed? For what it's worth: __cpu_is_pxa27x()
> > compiles to something interesting if CONFIG_PXA27x is defined.
> You mean "is not defined", right ?

Perhaps I was ambiguous. This referred to these lines in
arch/arm/mach-pxa/include/mach/hardware.h:
    #ifdef CONFIG_PXA27x
    #define __cpu_is_pxa27x(id)                             \
            ({                                              \
                    unsigned int _id = (id) >> 4 & 0xfff;   \
                    _id == 0x411;                           \
            })
    #else
    #define __cpu_is_pxa27x(id)     (0)
    #endif

But you needed PXA27x anyway, so this seems moot now.

> That (CONFIG_PXA27x) select is needed because without it the arm cpu
> architecture is not selected, ie. CONFIG_CPU_XSCALE is not set. And this in turn
> is needed to choose the basic arm operations like TLB handling, cache handling,
> etc ... You cannot compile a single platform kernel without this.
> 
> As a poor excuse, I hadn't seen this because this resulted from a poor merge
> resolution which brought in both "select PXA27x" and "select CPU_PXA27x".

Stuff happens. Would my patch have been included you might have seen the
warning and this thread wouldn't exist.

> > In https://lkml.org/lkml/2014/9/30/578 I proposed a patch that emits a
> > warning in cases like this. Like _all_ Kconfig related patches I've seen
> > flying by lately it appears to be dropped in /dev/null. What's going on?
> For that one I don't know.

Here I'm dragging you into a discussion about something that's been
bugging me for a while now. Hence the addresses that have nothing to do
with pxa in Cc:.

> Ah, and yes I'll send an update patch to remove the "select CPU_PXA27x", thanks
> for noticing this.

Great!


Paul Bolle
