From: rabin@rab.in (Rabin Vincent)
Date: Tue, 16 Mar 2010 00:15:06 +0530
Subject: [PATCH 03/10] ftrace: allow building without frame pointers
In-Reply-To: <1268501792.3366.7.camel@localhost>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-4-git-send-email-rabin@rab.in>
	<1268501792.3366.7.camel@localhost>
Message-ID: <20100315184506.GA2303@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 13, 2010 at 12:36:32PM -0500, Steven Rostedt wrote:
> On Sat, 2010-03-13 at 12:19 +0530, Rabin Vincent wrote:
> >  ifdef CONFIG_FRAME_POINTER
> >  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> >  else
> > +# Some targets (ARM with Thumb2, for example), can't be built with frame
> > +# pointers.  For those, we don't have FUNCTION_TRACER automatically
> > +# select FRAME_POINTER.  However, FUNCTION_TRACER adds -pg, and this is
> > +# incompatible with -fomit-frame-pointer with current GCC, so we don't use
> > +# -fomit-frame-pointer with FUNCTION_TRACER.
> > +ifndef CONFIG_FUNCTION_TRACER
> >  KBUILD_CFLAGS	+= -fomit-frame-pointer
> 
> I believe this is correct, but have you tested this on other archs other
> than ARM? I can do it for x86 and PPC, but it will need to wait as those
> machines are currently performing stress tests.

I've tested the series on x86-64.

Note that this particular change will not currently affect other archs
since they still have the "select FRAME_POINTER" in FUNCTION_TRACER.

Rabin
