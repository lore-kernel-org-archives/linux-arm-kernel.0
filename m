From: nikolay.borisov@arm.com (Nikolay Borisov)
Date: Fri, 23 May 2014 12:53:43 +0100
Subject: [PATCH RESEND 1/7] ARM: Make thread_save_fp macro aware of THUMB2
 mode
In-Reply-To: <20140523095356.GH20155@pengutronix.de>
References: <1400837196-22339-1-git-send-email-Nikolay.Borisov@arm.com>
 <1400837196-22339-2-git-send-email-Nikolay.Borisov@arm.com>
 <20140523095356.GH20155@pengutronix.de>
Message-ID: <000001cf767d$a5dd3140$f19793c0$@borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Uwe Kleine-K?nig
> Sent: 23 May 2014 10:54
> To: Nikolay Borisov
> Cc: rric at kernel.org; a.p.zijlstra at chello.nl; jld at mozilla.com;
> sboyd at codeaurora.org; Will Deacon; dave.long at linaro.org; Dave P Martin;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH RESEND 1/7] ARM: Make thread_save_fp macro aware of
> THUMB2 mode
> 
> Hello,
> 
> On Fri, May 23, 2014 at 10:26:30AM +0100, Nikolay Borisov wrote:
> > The thread_save_fp macro has been defined so that it always reads the
> fp member
> > of the cpu_context_save struct. However, in the case of THUMB2 the fp
> is saved
> > not in the fp (r11) member but rather in r7.
> >
> > This patch changes the way the macro is defined such that FP is read
> from the
> > correct place depending on whether we are a THUMB2 kernel or not.
> This enables
> > the backtrace in sitaution such as "echo t > /proc/sysrq-trigger" or
> the
> > function in which a process sleeping when "ps -Al" is invoked.
> >
> > Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> > Reviewed-by: Anurag Aggarwal <anurag19aggarwal@gmail.com>
> > ---
> >  arch/arm/include/asm/thread_info.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/include/asm/thread_info.h
> b/arch/arm/include/asm/thread_info.h
> > index f989d7c..e4e4208 100644
> > --- a/arch/arm/include/asm/thread_info.h
> > +++ b/arch/arm/include/asm/thread_info.h
> > @@ -114,8 +114,14 @@ static inline struct thread_info
> *current_thread_info(void)
> >  	((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
> >  #define thread_saved_sp(tsk)	\
> >  	((unsigned long)(task_thread_info(tsk)->cpu_context.sp))
> > +
> > +#ifndef CONFIG_THUMB2_KERNEL
> >  #define thread_saved_fp(tsk)	\
> >  	((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
> > +#else
> > +#define thread_saved_fp(tsk)	\
> > +	((unsigned long)(task_thread_info(tsk)->cpu_context.r7))
> > +#endif
> A comment would be nice here describing that it's gcc who forces this
> on
> us. Did you test if the same happens with clang?
> 

Just checked with one of the LLVM compiler engineers and he said that 
LLVM also conforms to this behaviour e.g. R7 is used as a frame pointer 
in THUMB2 mode. In addition to that, mainline doesn't compile with LLVM 
(yet). 

> Uwe
> 

Regards, 
Nikolay 

> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
