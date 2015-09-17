From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Sep 2015 18:07:05 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <8C4599C6-E5F8-4527-AAFF-9FEF295526BB@gmail.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150916112520.GH28771@arm.com> <55FA9708.5070200@arm.com>
 <8C4599C6-E5F8-4527-AAFF-9FEF295526BB@gmail.com>
Message-ID: <20150917170705.GQ25444@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 09:36:04PM +0900, Jungseok Lee wrote:
> On Sep 17, 2015, at 7:33 PM, James Morse wrote:
> > On 16/09/15 12:25, Will Deacon wrote:
> >> On Sun, Sep 13, 2015 at 03:42:17PM +0100, Jungseok Lee wrote:
> >>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> >>> index dcd06d1..44839c0 100644
> >>> --- a/arch/arm64/include/asm/thread_info.h
> >>> +++ b/arch/arm64/include/asm/thread_info.h
> >>> @@ -73,8 +73,11 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
> >>> 
> >>> static inline struct thread_info *current_thread_info(void)
> >>> {
> >>> -	return (struct thread_info *)
> >>> -		(current_stack_pointer & ~(THREAD_SIZE - 1));
> >>> +	unsigned long sp_el0;
> >>> +
> >>> +	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
> >>> +
> >>> +	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
> >> 
> >> This looks like it will generate worse code than our current implementation,
> >> thanks to the asm volatile. Maybe just add something like a global
> >> current_stack_pointer_el0?
[...]
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -77,7 +77,7 @@ static inline struct thread_info *current_thread_info(void)
>  
>  	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
>  
> -	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
> +	return (struct thread_info *)sp_el0;
>  }

This makes sense, since we just use sp_el0 as a scratch register, store
the current thread_info address directly. But, as James mentioned, I
don't think you need asm volatile, just asm (it has a small impact in my
tests).

-- 
Catalin
