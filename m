From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Jul 2016 16:13:15 +0100
Subject: [PATCH v15 01/10] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API
 feature
In-Reply-To: <5788F86B.60305@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-2-git-send-email-dave.long@linaro.org>
 <20160715105701.GB14792@e104818-lin.cambridge.arm.com>
 <5788F86B.60305@linaro.org>
Message-ID: <20160715150532.GA22563@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 10:51:23AM -0400, David Long wrote:
> On 07/15/2016 06:57 AM, Catalin Marinas wrote:
> > On Fri, Jul 08, 2016 at 12:35:45PM -0400, David Long wrote:
> > > --- a/arch/arm64/include/asm/ptrace.h
> > > +++ b/arch/arm64/include/asm/ptrace.h
> > > @@ -74,6 +74,7 @@
> > >   #define COMPAT_PT_DATA_ADDR		0x10004
> > >   #define COMPAT_PT_TEXT_END_ADDR		0x10008
> > >   #ifndef __ASSEMBLY__
> > > +#include <linux/bug.h>
> > > 
> > >   /* sizeof(struct user) for AArch32 */
> > >   #define COMPAT_USER_SZ	296
> > > @@ -119,6 +120,8 @@ struct pt_regs {
> > >   	u64 syscallno;
> > >   };
> > > 
> > > +#define MAX_REG_OFFSET offsetof(struct pt_regs, pstate)
> > > +
> > >   #define arch_has_single_step()	(1)
> > > 
> > >   #ifdef CONFIG_COMPAT
> > > @@ -147,6 +150,55 @@ struct pt_regs {
> > >   #define user_stack_pointer(regs) \
> > >   	(!compat_user_mode(regs) ? (regs)->sp : (regs)->compat_sp)
> > > 
> > > +extern int regs_query_register_offset(const char *name);
> > > +extern const char *regs_query_register_name(unsigned int offset);
> > 
> > Is regs_query_register_offset() used anywhere? I grep'ed the kernel with
> > these patches applied but couldn't find any use.
> 
> It's referenced in kernel/trace/trace_probe.c.

I meant regs_query_register_name() (vim completion wrote the first one).

> > > +extern bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr);
> > 
> > This one only seems to be used in arch/arm64/kernel/ptrace.c. Can we
> > make it static and remove the declaration?
> 
> OK.

I can change it locally.

Are these going to be used in the future by uprobes?

-- 
Catalin
