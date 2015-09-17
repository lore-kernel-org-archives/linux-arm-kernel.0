From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Sep 2015 11:48:23 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <55FA9708.5070200@arm.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150916112520.GH28771@arm.com> <55FA9708.5070200@arm.com>
Message-ID: <20150917104823.GM25444@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 11:33:44AM +0100, James Morse wrote:
> Hi Will,
> 
> On 16/09/15 12:25, Will Deacon wrote:
> > On Sun, Sep 13, 2015 at 03:42:17PM +0100, Jungseok Lee wrote:
> >> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> >> index dcd06d1..44839c0 100644
> >> --- a/arch/arm64/include/asm/thread_info.h
> >> +++ b/arch/arm64/include/asm/thread_info.h
> >> @@ -73,8 +73,11 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
> >>  
> >>  static inline struct thread_info *current_thread_info(void)
> >>  {
> >> -	return (struct thread_info *)
> >> -		(current_stack_pointer & ~(THREAD_SIZE - 1));
> >> +	unsigned long sp_el0;
> >> +
> >> +	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
> >> +
> >> +	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
> > 
> > This looks like it will generate worse code than our current implementation,
> > thanks to the asm volatile. Maybe just add something like a global
> > current_stack_pointer_el0?
> 
> Like current_stack_pointer does?:
> > register unsigned long current_stack_pointer_el0 asm ("sp_el0");
> 
> Unfortunately the compiler won't accept this, as it doesn't like the
> register name, it also won't accept instructions in this asm string.

But once we do SPSel = 0, can we not just use the SP register here?

(I haven't read the rest of the patch yet)

-- 
Catalin
