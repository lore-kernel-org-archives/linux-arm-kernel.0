From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 24 Oct 2013 15:34:14 +0100
Subject: [RFC PATCH] ARM: kexec: Assemble relocate code in ARM mode
In-Reply-To: <52618C25.6040705@linaro.org>
References: <20131015152422.GC2312@localhost.localdomain>
 <52618C25.6040705@linaro.org>
Message-ID: <20131024143408.GA29413@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 10:29:41PM +0300, Taras Kondratiuk wrote:
> On 10/15/2013 06:24 PM, Dave Martin wrote:
> > On Thu, Oct 10, 2013 at 11:36:08PM +0300, Taras Kondratiuk wrote:
> >> I think it won't help, because here is no direct jump to this label.
> >> This code gets copied to a new page and jump is done to the beginning
> >> of that page.
> > 
> > Ah, right.
> > 
> > I think that the fncpy() function should work.  This is for the precise
> > purpsoe of copying a function body from one place to another, while
> > reatining the Thumb bit.
> > 
> > I have to disappear early to today, but I'll try and follow up.
> > 
> > Currently, I have the following, but I've not been able to test it yet.
> > If you'd like to give it a try, that would be much appreciated.
> 
> I've tried the patch on ARM ISA and looks like the code does what

Thanks for giving it a try.

> it should, but the reloaded kernel crashes somewhere at early stages.
> Without this patch it boots fine on ARM. Next week I will try to look
> what is going on.

Hmmm, that's a bit strange.  You're saying that the new kernel gets
loaded and started OK, but crashes during boot?

If relocate_new_kernel() was failing, I would not expect the new
kernel to boot at all, unless part of the kernel doesn't get relocated,
or something like that.

> > 
> > From 94925667e650202e1baf74e1ff223671d316401d Mon Sep 17 00:00:00 2001
> > From: Dave Martin <Dave.Martin@arm.com>
> > Date: Tue, 15 Oct 2013 11:48:46 +0100
> > Subject: [PATCH] ARM: kexec: Use the right ISA for relocate_new_kernel
> > 
> > Copying a function with memcpy() and then trying to execute the
> > result isn't portable to Thumb.
> > 
> > This patch modifies the kexec soft restart code to copy its
> > assembler trampoline relocate_new_kernel() using fncpy() instead,
> > so that relocate_new_kernel can be in the same ISA as the rest of
> > the kernel without problems.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm/kernel/machine_kexec.c   |   20 +++++++++-----------
> >  arch/arm/kernel/relocate_kernel.S |    7 ++++---
> >  2 files changed, 13 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> > index 57221e3..ce135b3 100644
> > --- a/arch/arm/kernel/machine_kexec.c
> > +++ b/arch/arm/kernel/machine_kexec.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/memblock.h>
> >  #include <asm/pgtable.h>
> >  #include <linux/of_fdt.h>
> > +#include <asm/fncpy.h>
> >  #include <asm/pgalloc.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/cacheflush.h>
> > @@ -18,7 +19,7 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/system_misc.h>
> >  
> > -extern const unsigned char relocate_new_kernel[];
> > +extern char relocate_new_kernel;
> 
> Shouldn't it be a function pointer?
> extern void relocate_new_kernel(void);

Actually, it could be.

I was forgetting that fncpy was implemented as a macro, allowing
it to be more forgiving about argument types.

Casting a function pointer type to a non-function pointer type is
illegal in C, but fncpy dodges that problem by hiding the cast
inside an asm so that the compiler can't try to do clever optimisations
that might break things.

Cheers
---Dave
