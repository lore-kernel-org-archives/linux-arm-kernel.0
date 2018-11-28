From: Steve.Capper@arm.com (Steve Capper)
Date: Wed, 28 Nov 2018 16:31:25 +0000
Subject: [PATCH V3 2/5] arm64: mm: Introduce DEFAULT_MAP_WINDOW
In-Reply-To: <20181127170931.GC3563@arrakis.emea.arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-3-steve.capper@arm.com>
 <20181127170931.GC3563@arrakis.emea.arm.com>
Message-ID: <20181128163115.GA20432@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 05:09:32PM +0000, Catalin Marinas wrote:
> Hi Steve,

Hi Catalin,

> 
> On Wed, Nov 14, 2018 at 01:39:17PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 3e2091708b8e..da41a2655b69 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -25,6 +25,9 @@
> >  #define USER_DS		(TASK_SIZE_64 - 1)
> >  
> >  #ifndef __ASSEMBLY__
> > +
> > +#define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
> > +
> >  #ifdef __KERNEL__
> 
> That's a strange place to place DEFAULT_MAP_WINDOW_64. Did you have any
> #include dependency issues? If yes, we could look at cleaning them up,
> maybe moving these definitions into a separate file.
> 
> (also, if you do a clean-up I don't think we need __KERNEL__ anymore)
> 

Okay, I will investigate cleaning this up.

> >  
> >  #include <linux/build_bug.h>
> > @@ -51,13 +54,16 @@
> >  				TASK_SIZE_32 : TASK_SIZE_64)
> >  #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
> >  				TASK_SIZE_32 : TASK_SIZE_64)
> > +#define DEFAULT_MAP_WINDOW	(test_thread_flag(TIF_32BIT) ? \
> > +				TASK_SIZE_32 : DEFAULT_MAP_WINDOW_64)
> >  #else
> >  #define TASK_SIZE		TASK_SIZE_64
> > +#define DEFAULT_MAP_WINDOW	DEFAULT_MAP_WINDOW_64
> >  #endif /* CONFIG_COMPAT */
> >  
> > -#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
> > +#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
> > +#define STACK_TOP_MAX		DEFAULT_MAP_WINDOW_64
> >  
> > -#define STACK_TOP_MAX		TASK_SIZE_64
> >  #ifdef CONFIG_COMPAT
> >  #define AARCH32_VECTORS_BASE	0xffff0000
> >  #define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 9d9582cac6c4..e5a1dc0beef9 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -609,7 +609,7 @@ void __init mem_init(void)
> >  	 * detected at build time already.
> >  	 */
> >  #ifdef CONFIG_COMPAT
> > -	BUILD_BUG_ON(TASK_SIZE_32			> TASK_SIZE_64);
> > +	BUILD_BUG_ON(TASK_SIZE_32			> DEFAULT_MAP_WINDOW_64);
> >  #endif
> 
> Since you are at this, can you please remove the useless white space (I
> guess it was there before when we had more BUILD_BUG_ONs).
> 

Sure thing.

> > diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> > index 30ac0c975f8a..d1ec7136e3e1 100644
> > --- a/drivers/firmware/efi/libstub/arm-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm-stub.c
> > @@ -33,7 +33,7 @@
> >  #define EFI_RT_VIRTUAL_SIZE	SZ_512M
> >  
> >  #ifdef CONFIG_ARM64
> > -# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_64
> > +# define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
> >  #else
> >  # define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
> >  #endif
> 
> Just curious, would anything happen if we leave this to TASK_SIZE_64?
> 

Then it doesn't compile :-). TASK_SIZE_64 is a variable that is outside
the EFI stub's knowledge (and indeed is initialised after the stub has
already executed).

Cheers,
-- 
Steve
