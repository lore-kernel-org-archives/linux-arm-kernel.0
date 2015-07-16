From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 16 Jul 2015 10:34:45 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150716142834.GD28631@leverpostej>
References: <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <20150716142834.GD28631@leverpostej>
Message-ID: <20150716103445.3e94f0ee@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015 15:28:34 +0100
Mark Rutland <mark.rutland@arm.com> wrote:


> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index c5534fa..868d6f1 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -15,6 +15,7 @@
> > 
> >   #define MCOUNT_ADDR		((unsigned long)_mcount)
> >   #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> > +#define FTRACE_STACK_FRAME_OFFSET 4 /* sync it up with stacktrace.c */
> 
> Is there any reason we couldn't have the arch code dump the stack depth
> for each function when it walks the stack to generate the stack trace?
> 
> That means we can provide a more precise result (because we know the
> layour of our own stackframes), and we only need walk the stack once to
> do so.
> 
> The downside is that we need a new function per-arch to do so.

Or we make check_patch() a weak function, and let archs override it. I
can possibly break up the code a bit to have helper functions where
things are the same.

I want x86 to be able to track irq stacks as well, but there's no way
to do that generically yet, so having arch specific functions has been
on my todo list.

-- Steve
