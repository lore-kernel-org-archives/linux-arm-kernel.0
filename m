From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 07 Sep 2013 01:12:03 -0400 (EDT)
Subject: [PATCH 2/5] arm: LLVMLinux: use current_stack_pointer for percpu
In-Reply-To: <1378502899-1241-3-git-send-email-behanw@converseincode.com>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
 <1378502899-1241-3-git-send-email-behanw@converseincode.com>
Message-ID: <alpine.LFD.2.03.1309070101330.20709@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Sep 2013, behanw at converseincode.com wrote:

> From: Behan Webster <behanw@converseincode.com>
> 
> The existing code uses named registers to get the value of the stack pointer.
> The new current_stack_pointer macro is more readable and allows for a central
> portable implementation of how to get the stack pointer with ASM.  This change
> supports being able to compile the kernel with both gcc and Clang.
> 
> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
> ---
>  arch/arm/include/asm/percpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
> index 209e650..629a975 100644
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -30,14 +30,14 @@ static inline void set_my_cpu_offset(unsigned long off)
>  static inline unsigned long __my_cpu_offset(void)
>  {
>  	unsigned long off;
> -	register unsigned long *sp asm ("sp");
> +	unsigned long sp = current_stack_pointer;
>  
>  	/*
>  	 * Read TPIDRPRW.
>  	 * We want to allow caching the value, so avoid using volatile and
>  	 * instead use a fake stack read to hazard against barrier().
>  	 */
> -	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : "Q" (*sp));
> +	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : "Q" (sp));

This change doesn't look to be equivalent.  Previously the *sp implied a 
memory location which doesn't appear to be the case anymore.

this sp trickery was introduced in commit 509eb76ebf97 to solve bad code 
generation (the commit log has the details).  It would be good if Will 
Deacon could confirm that his test case still works fine with your 
change.


Nicolas
