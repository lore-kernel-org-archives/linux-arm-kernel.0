From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 May 2017 18:29:48 +0100
Subject: [PATCH] arm64: Fix multiple 'asm-operand-widths' warnings
In-Reply-To: <20170501212622.153720-1-mka@chromium.org>
References: <20170501212622.153720-1-mka@chromium.org>
Message-ID: <20170502172948.GE28132@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 01, 2017 at 02:26:22PM -0700, Matthias Kaehlcke wrote:
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 5308d696311b..7db143689694 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -302,7 +302,7 @@ do {									\
>  	"	.previous\n"						\
>  	_ASM_EXTABLE(1b, 3b)						\
>  	: "+r" (err)							\
> -	: "r" (x), "r" (addr), "i" (-EFAULT))
> +	: "r" ((__u64)x), "r" (addr), "i" (-EFAULT))
>  

For reference, do you have the warning for this case to hand?

In __put_user_err() we make __pu_val the same type as *ptr, then we
switch on sizeof(*ptr), and pass __pu_val to __put_user_asm(), as x.
For cases 1, 2, and 4, we use "%w" as the register template.

So I can't see why we'd  need this cast in __put_user_err().

I must be missing something.

Thanks,
Mark.
