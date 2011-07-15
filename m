From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 15 Jul 2011 16:59:00 +0100 (BST)
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <4E20440C.80902@st.com>
References: <mailman.2928.1310636156.20023.linux-arm-kernel@lists.infradead.org>
	<alpine.DEB.2.00.1107141054400.2609@localhost6.localdomain6>
	<4E20440C.80902@st.com>
Message-ID: <alpine.DEB.2.00.1107151611540.2303@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jul 2011, Wolfgang BETZ wrote:

> Hallo Frank,
>
> On 07/14/2011 12:24 PM, Frank Hofmann wrote:
>
> The aim of this patch is to enable thread support in the context ID register
> (CONTEXTIDR) as it comes with ARM architectures v6 & v7.
>
>
> [ ... ]
>
>
> +/*
> + * Set context ID for task and mm
> + */
> +static inline
> +void set_context_id(struct task_struct *tsk, struct mm_struct *mm)
> +{
> +       unsigned int ctxid = (unsigned int)calc_context_id(tsk, mm);
> +
> +       /* set the new ContextID */
> +       asm("mcr        p15, 0, %0, c13, c0, 1\n" : : "r" (ctxid));
> +       isb();
> +}
>
>
>
> While I'm not qualified to comment on the technical correctness of the
> patch, I've got a few questions about the way this change is done:
>
> Specifically:
>
> 1. about the above, (unsigned int)calc_context_id(), the cast and/or
>    the data type isn't required, the asm doesn't care about types.
>
>
> Well, this is not in because of the asm statement but just in order to make the compiler happier regarding the initialization of ctxid, i.e. to avoid getting a potential warning about incompatible types in an assignment. In any case it's a no-op.
>
>
>
> Generally:
>
> 2. the patch changes the signature of cpu_switch_mm() but not all the
>    callers (doesn't touch the kexec / reset / suspend paths), why ?
>
>
> Could you pls. specify more precisely (i.e. kernel source file, line number, etc.) which calls to cpu_switch_mm() you are exactly referring to?

Ah, ok, I see now ...


We were a bit ahead of the world; Will Deacon and myself have recently 
(June) submitted patches for discussion that require / use MMU-off 
codepaths.

These:

http://www.spinics.net/lists/arm-kernel/msg127556.html
http://www.spinics.net/lists/arm-kernel/msg128605.html


To get that, the method is to put 1:1 mappings into the pagedir in use, so 
that cpu_reset() on ARMv6/7 can switch the MMU off just as it does on all 
other architectures.


The pagedir best suitable for this is the initial one, swapper_pg_dir, and 
hence the abovementioned changes call

 	cpu_switch_mm(swapper_pg_dir, &init_mm)

What should Will and myself do there ?


Again, I think the interface change is unnecessarily complicated - three 
versions of a wrapper, some of them empty, arg#2 to cpu_switch_mm 
scope-reduced from a full mmu context reference to an integer.

If using the task struct input is unavoidable, then why not at least make 
it resemble the generic switch_mm signature ? Like:

--- arch/arm/include/asm/proc-fns.h	2011-06-15 14:28:06.261757007 +0100
+++ x	2011-07-15 16:36:28.820353998 +0100
@@ -97,7 +97,7 @@

  #ifdef CONFIG_MMU

-#define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
+#define cpu_switch_mm(pgd,mm,tsk) cpu_do_switch_mm(virt_to_phys(pgd) calc_context_id(mm, tsk))

  #define cpu_get_pgd()	\
  	({						\


That's just an idea and sneaky because it forces calc_context_id() to be a 
macro by drawing the comma in so the argument marshaling can be completely 
discarded at compile time on cpu types where it's not used/useful.

The reset code could then:

 	cpu_switch_mm(swapper_pg_dir, &init_mm, &init_task);



Is there a special need for doing the change _the way you proposed_ ?


FrankH.
