From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 28 May 2015 11:49:24 +0100
Subject: [PATCH RFC] ARM: use -marm unconditionally for THUMB2_KERNEL=n
 builds
In-Reply-To: <20150527174657.GV2067@n2100.arm.linux.org.uk>
References: <1432719727-28860-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150527095339.GQ2067@n2100.arm.linux.org.uk>
 <20150527145921.GT24769@pengutronix.de>
 <20150527174657.GV2067@n2100.arm.linux.org.uk>
Message-ID: <20150528104923.GC3655@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 06:46:57PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 27, 2015 at 04:59:21PM +0200, Uwe Kleine-K?nig wrote:
> > Hello Russell,
> > 
> > On Wed, May 27, 2015 at 10:53:39AM +0100, Russell King - ARM Linux wrote:
> > > On Wed, May 27, 2015 at 11:42:07AM +0200, Uwe Kleine-K?nig wrote:
> > > > The only possible culprit is a compiler that doesn't understand -marm.
> > > > My compiler collection only goes back to 4.0.3 which does work with this
> > > > option. The use of cc-option to test for -marm was introduced in commit
> > > > 5636810d6f17 ([ARM] 3982/2: Explicitly select 32-bit ARM ISA (-marm))
> > > > back in 2006 when the minimal compiler version was already 3.3.
> > > 
> > > According to gcc 3.3's --target-help, it supports -mthumb, but not -marm.
> > > 
> > > What we could possibly do is to change the := to a plain =, and then
> > > evaluate all the options together via:
> > > 
> > > KBUILD_CFLAGS :=$(KBUILD_CFLAGS)
> > You mean
> > 
> > 	KBUILD_CFLAGS += $(arch-y)
> > 
> > as soon as arch-y is defined to assert it's already present when -marm
> > is tested for, right? I will give that a try.
> 
> I mean:
> 
>  else
> -CFLAGS_ISA	:=$(call cc-option,-marm,)
> -AFLAGS_ISA	:=$(CFLAGS_ISA)
> +CFLAGS_ISA	=$(call cc-option,-marm,)
> +AFLAGS_ISA	=$(CFLAGS_ISA)
>  endif
> ...
> -KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
> -KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> +CFLAGS_TRAPS	:=$(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,))
> +
> +KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(arch-y) $(tune-y) $(CFLAGS_TRAPS) -msoft-float -Uarm
> +KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> 
> +# Ensures that all previous $(call ...) options are evaluated once
> +KBUILD_CFLAGS	:=$(CFLAGS_ISA) $(KBUILD_CFLAGS)
> +KBUILD_AFLAGS	:=$(CFLAGS_ISA) $(KBUILD_AFLAGS)
> 
> This has the effect that "-marm" will be evaluated with all the other
> KBUILD_CFLAGS options already set.  (I think I have this right...)

That should work too.  It requires less code rearrangement than my
approach.

[...]

Cheers
---Dave
