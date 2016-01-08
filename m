From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 14:13:18 +0300
Subject: [PATCH v6 14/21] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <8354919.jOyEk0znB5@wuerfel>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-15-git-send-email-ynorov@caviumnetworks.com>
 <8354919.jOyEk0znB5@wuerfel>
Message-ID: <20160108111318.GA24066@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 10:21:06AM +0100, Arnd Bergmann wrote:
> On Friday 08 January 2016 02:34:32 Yury Norov wrote:
> 
> > @@ -688,6 +692,12 @@ ni_sys:
> >  	b	ret_fast_syscall
> >  ENDPROC(el0_svc)
> >  
> > +#ifdef CONFIG_ARM64_ILP32
> > +el0_ilp32_svc:
> > +	adrp	stbl, sys_call_ilp32_table // load syscall table pointer
> > +	b el0_svc_naked
> > +#endif
> 
> Don't we still need some code that clears the top halves of the 32-bit
> arguments? That thread has taken so many turns now that I'm confused
> about what we actually need, but I thought we had concluded that your
> current approach has at some some problems.

We are discussing how to do it better - make a generic solution from
s390 with individual syscall handling, or reproduce s390 solution for
ILP32, or zero top-half registers and not use top half of register at
all. As I understand, we stand on 1st option, and agreed to introduce
it separately.

> 
> > +#include <asm/syscall.h>
> > +
> > +#undef __SYSCALL
> > +#undef __SC_COMP
> > +#undef __SC_3264
> > +#undef __SC_COMP_3264
> 
> The four #undef are not needed, right?
> 
> 	Arnd
