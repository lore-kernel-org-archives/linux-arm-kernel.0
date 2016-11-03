From: asavkov@redhat.com (Artem Savkov)
Date: Thu, 3 Nov 2016 12:12:38 +0100
Subject: arm64 build failure with CONFIG_ARM64_LSE_ATOMICS=y
In-Reply-To: <1efb101a-a8ab-5ad9-f2bd-e7d485c71904@arm.com>
References: <20161102164427.GB24243@shodan.usersys.redhat.com>
 <20161102232854.GO22791@arm.com>
 <1efb101a-a8ab-5ad9-f2bd-e7d485c71904@arm.com>
Message-ID: <20161103111238.GC24243@shodan.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 10:39:43AM +0000, Suzuki K Poulose wrote:
> On 02/11/16 23:28, Will Deacon wrote:
> > Hi Artem,
> > 
> > On Wed, Nov 02, 2016 at 05:44:27PM +0100, Artem Savkov wrote:
> > > Hello Catalin,
> > > 
> > > Looks like your patch "efd9e03 arm64: Use static keys for CPU features"
> > > breaks arm64 build with "CONFIG_ARM64_LSE_ATOMICS=y" because it creates a
> > > circular dependency for asm/lse.h through jump_label.h:
> > > 
> > >   CC      arch/arm64/kernel/asm-offsets.s
> > > In file included from ./arch/arm64/include/asm/atomic.h:34:0,
> > >                  from ./include/linux/atomic.h:4,
> > >                  from ./include/linux/jump_label.h:169,
> > >                  from ./arch/arm64/include/asm/cpufeature.h:12,
> > >                  from ./arch/arm64/include/asm/alternative.h:4,
> > >                  from ./arch/arm64/include/asm/lse.h:7,
> > >                  from ./arch/arm64/include/asm/spinlock.h:19,
> > >                  from ./include/linux/spinlock.h:87,
> > >                  from ./include/linux/seqlock.h:35,
> > >                  from ./include/linux/time.h:5,
> > >                  from ./include/uapi/linux/timex.h:56,
> > >                  from ./include/linux/timex.h:56,
> > >                  from ./include/linux/sched.h:19,
> > >                  from arch/arm64/kernel/asm-offsets.c:21:
> > > ./arch/arm64/include/asm/atomic_lse.h: In function ?atomic_andnot?:
> > > ./arch/arm64/include/asm/atomic_lse.h:35:15: error: expected string literal before ?	?
> > >   asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(op),  \
> > > 
> > > ...
> > > 
> > > ./arch/arm64/include/asm/cmpxchg.h: In function ?__xchg_case_1?:
> > > ./arch/arm64/include/asm/cmpxchg.h:38:15: error: expected string literal before ?ARM64_LSE_ATOMIC_INSN?
> > >   asm volatile(ARM64_LSE_ATOMIC_INSN(    \
> > 
> > I'm unable to reproduce this. I've tried enabling LSE with defconfig and
> > mainline, using compilers that both do and don't support the instructions.
> 
> I am not able to reproduce it either. One minor problem I see with the commit could
> be fixed with the following change : Does it help ?

Apparently it fails with an older gcc (4.8.5), but doesn't with 6.2.0.
The different bit is that with 4.8.5 I don't have CC_HAVE_ASM_GOTO set.
It is reproducible with 6.2.0 if you manually remove CC_HAVE_ASM_GOTO.

> ----8>-----
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 758d74f..62db988 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -9,7 +9,6 @@
>  #ifndef __ASM_CPUFEATURE_H
>  #define __ASM_CPUFEATURE_H
> -#include <linux/jump_label.h>
>  #include <asm/hwcap.h>
>  #include <asm/sysreg.h>
> @@ -45,6 +44,7 @@
>  #ifndef __ASSEMBLY__
> +#include <linux/jump_label.h>
>  #include <linux/kernel.h>
>  /* CPU feature register tracking */

No, this doesn't help.

-- 
Regards,
  Artem
