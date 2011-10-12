From: gdavis@mvista.com (gdavis at mvista.com)
Date: Wed, 12 Oct 2011 02:04:33 -0400
Subject: [RFC/PATCH 5/7] ARM: Move get_thread_info macro definition to
	<asm/assembler.h>
In-Reply-To: <20111011095639.GB23848@arm.com>
References: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1317955121-28047-6-git-send-email-gdavis@mvista.com>
	<20111011095639.GB23848@arm.com>
Message-ID: <20111012060433.GE188@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 10:56:39AM +0100, Catalin Marinas wrote:
> On Fri, Oct 07, 2011 at 03:38:39AM +0100, gdavis at mvista.com wrote:
> > diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> > index 29035e8..78397d0 100644
> > --- a/arch/arm/include/asm/assembler.h
> > +++ b/arch/arm/include/asm/assembler.h
> > @@ -23,6 +23,19 @@
> >  #include <asm/ptrace.h>
> >  #include <asm/domain.h>
> >  
> > +#ifndef CONFIG_THUMB2_KERNEL
> > +	.macro	get_thread_info, rd
> > +	mov	\rd, sp, lsr #13
> > +	mov	\rd, \rd, lsl #13
> > +	.endm
> > +#else   /* CONFIG_THUMB2_KERNEL */
> > +	.macro	get_thread_info, rd
> > +	mov	\rd, sp
> > +	lsr	\rd, \rd, #13
> > +	mov	\rd, \rd, lsl #13
> > +	.endm
> > +#endif  /* !CONFIG_THUMB2_KERNEL */
> 
> We could even write some preempt_enable and preempt_disable asm macros,
> I think it would simplify the code in the other files.

Like so (based on above patch and not even compile tested):

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 78397d0..eaf4939 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -36,6 +36,20 @@
 	.endm
 #endif  /* !CONFIG_THUMB2_KERNEL */
 
+	.macro	preempt_disable, tsk, cnt
+	get_thread_info \tsk
+	ldr	\cnt, [\tsk, #TI_PREEMPT]
+	add	\cnt, \cnt, #1
+	str	\cnt, [\tsk, #TI_PREEMPT]
+	.endm
+
+	.macro	preempt_enable, tsk, cnt
+	get_thread_info \tsk
+	ldr	\cnt, [\tsk, #TI_PREEMPT]
+	sub	\cnt, \cnt, #1
+	str	\cnt, [\tsk, #TI_PREEMPT]
+	.endm
+
 /*
  * Endian independent macros for shifting bytes within registers.
  */


Not as efficient as it could be but I imagine the macros could
be written to support optional load of \tsk and/or optional \tmp
parameters to cover other common cases.

--
Regards,
George

> 
> -- 
> Catalin
