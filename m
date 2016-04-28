From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 28 Apr 2016 15:17:22 +0100
Subject: [RFC PATCH] arm64: Make arch_randomize_brk avoid stack area
In-Reply-To: <1461848638.2848.19.camel@linaro.org>
References: <1461848638.2848.19.camel@linaro.org>
Message-ID: <1461853042.2848.24.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, the code patch has errors (I forgot to commit fixes before
running git format-patch), the correct code, which was in the kernel I
built and tested, is at the end of this email.

On Thu, 2016-04-28 at 14:03 +0100, Jon Medhurst (Tixy) wrote:
Some incorrect code...
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 8062482..7126a5a 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -382,13 +382,24 @@ unsigned long arch_align_stack(unsigned long sp)
>  	return sp & ~0xf;
>  }
>  
> -static unsigned long randomize_base(unsigned long base)
> +unsigned long arch_randomize_brk(struct mm_struct *mm)
>  {
>  	unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
> -	return randomize_range(base, range_end, 0) ? : base;
> -}
> +	unsigned long max_stack, range_limit;
>  
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -	return randomize_base(mm->brk);
> +	/*
> +	 * Determine how much room do we need to leave available for the stack.
> +	 * We limit this to a reasonable value, because extremely large or
> +	 * unlimited stacks are always going to bump up against brk at some
> +	 * point and we don't want to fail to randomise brk in those cases.
> +	 */
> +	max_stack = rlimit(RLIMIT_STACK);
> +	if (max_stack > SZ_128M)
> +		max_stack = SZ_128M;
> +
> +	range_limit = mm->start_stack - max_stack - 1;
> +	if (range_end > range_limit)
> +		range_end > range_limit
> +
> +	return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
>  }

Corrected code...

 arch/arm64/kernel/process.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 07c4c53..7e0f404 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -434,13 +434,25 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ~0xf;
 }
 
-static unsigned long randomize_base(unsigned long base)
+unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
+	unsigned long base = mm->brk;
 	unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
-	return randomize_range(base, range_end, 0) ? : base;
-}
+	unsigned long max_stack, range_limit;
 
-unsigned long arch_randomize_brk(struct mm_struct *mm)
-{
-	return randomize_base(mm->brk);
+	/*
+	 * Determine how much room do we need to leave available for the stack.
+	 * We limit this to a reasonable value, because extremely large or
+	 * unlimited stacks are always going to bump up against brk at some
+	 * point and we don't want to fail to randomise brk in those cases.
+	 */
+	max_stack = rlimit(RLIMIT_STACK);
+	if (max_stack > SZ_128M)
+		max_stack = SZ_128M;
+
+	range_limit = mm->start_stack - max_stack - 1;
+	if (range_end > range_limit)
+		range_end = range_limit;
+
+	return randomize_range(base, range_end, 0) ? : base;
 }
-- 
2.1.4
