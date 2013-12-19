From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 19 Dec 2013 13:29:33 +0100
Subject: [PATCH v4 2/2] provide -fstack-protector-strong build option
In-Reply-To: <1387390796-5860-3-git-send-email-keescook@chromium.org>
References: <1387390796-5860-1-git-send-email-keescook@chromium.org>
 <1387390796-5860-3-git-send-email-keescook@chromium.org>
Message-ID: <20131219122933.GB18110@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> This changes the stack protector config option into a choice of "None",
> "Regular", and "Strong". For "Strong", the kernel is built with
> -fstack-protector-strong (gcc 4.9 and later). This options increases
> the coverage of the stack protector without the heavy performance hit
> of -fstack-protector-all.
> 
> For reference, the stack protector options available in gcc are:
> 
> -fstack-protector-all:
> Adds the stack-canary saving prefix and stack-canary checking suffix to
> _all_ function entry and exit. Results in substantial use of stack space
> for saving the canary for deep stack users (e.g. historically xfs), and
> measurable (though shockingly still low) performance hit due to all the
> saving/checking. Really not suitable for sane systems, and was entirely
> removed as an option from the kernel many years ago.
> 
> -fstack-protector:
> Adds the canary save/check to functions that define an 8
> (--param=ssp-buffer-size=N, N=8 by default) or more byte local char
> array. Traditionally, stack overflows happened with string-based
> manipulations, so this was a way to find those functions. Very few
> total functions actually get the canary; no measurable performance or
> size overhead.
> 
> -fstack-protector-strong
> Adds the canary for a wider set of functions, since it's not just those
> with strings that have ultimately been vulnerable to stack-busting. With
> this superset, more functions end up with a canary, but it still
> remains small compared to all functions with no measurable change in
> performance. Based on the original design document, a function gets the
> canary when it contains any of:
> - local variable's address used as part of the RHS of an assignment or
>   function argument
> - local variable is an array (or union containing an array), regardless
>   of array type or length
> - uses register local variables
> https://docs.google.com/a/google.com/document/d/1xXBH6rRZue4f296vGt9YQcuLVQHeE516stHwt8M9xyU
> 
> Comparison of "size" and "objdump" output when built with gcc-4.9 in
> three configurations:
> - defconfig
> 	11430641 text size
> 	36110 function bodies
> - defconfig + CONFIG_CC_STACKPROTECTOR
> 	11468490 text size (+0.33%)
> 	1015 of 36110 functions stack-protected (2.81%)
> - defconfig + CONFIG_CC_STACKPROTECTOR_STRONG via this patch
> 	11692790 text size (+2.24%)
> 	7401 of 36110 functions stack-protected (20.5%)

Ok, these patches now look pretty good to me.

One final detail is that I think the information about the percentage 
of functions affected should be propagated into the help text:

> +config CC_STACKPROTECTOR_REGULAR
> +	bool "Regular"
> +	select CC_STACKPROTECTOR
> +	help
> +	  Functions will have the stack-protector canary logic added if they
> +	  have an 8-byte or larger character array on the stack.
> +
>  	  This feature requires gcc version 4.2 or above, or a distribution
>  	  gcc with the feature backported.
>  
> +	  On an x86 "defconfig" build, this increases the kernel text by 0.3%.
> +
> +config CC_STACKPROTECTOR_STRONG
> +	bool "Strong"
> +	select CC_STACKPROTECTOR
> +	help
> +	  Functions will have the stack-protector canary logic added in any
> +	  of the following conditions:
> +	  - local variable's address used as part of the RHS of an
> +	    assignment or function argument
> +	  - local variable is an array (or union containing an array),
> +	    regardless of array type or length
> +	  - uses register local variables
> +
> +	  This feature requires gcc version 4.9 or above, or a distribution
> +	  gcc with the feature backported.
> +
> +	  On an x86 "defconfig" build, this increases the kernel text by 2%.

It should say something like:

	  On an x86 "defconfig" build, this feature adds canary checks 
	  to about 3% of all kernel functions, which increases kernel
	  code size by about 0.3%.

and for the _STRONG option:

	  On an x86 "defconfig" build, this feature adds canary checks 
	  to ~20% of all kernel functions, which increases kernel code 
	  size by ~2%.

this way distibutions and users can make an informed decision about 
the level of checks they want to employ.

Thanks,

	Ingo
