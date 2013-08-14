From: ddaney.cavm@gmail.com (David Daney)
Date: Wed, 14 Aug 2013 14:51:32 -0700
Subject: [PATCH] ARM: LLVMLinux: Change "extern inline" to "gnu_inline"
 in ARM ftrace.h
In-Reply-To: <1376516261-2071-2-git-send-email-behanw@converseincode.com>
References: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
 <1376516261-2071-2-git-send-email-behanw@converseincode.com>
Message-ID: <520BFBE4.4040807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 02:37 PM, behanw at converseincode.com wrote:
> From: Mark Charlebois <charlebm@gmail.com>
>
> With compilers which follow the C99 standard (like modern versions of gcc and
> clang), "extern inline" does the wrong thing (emits code for an externally
> linkable version of the inline function). In this case using the gnu_inline
> attribute makes inline do the right thing on gcc and on clang.
>
> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> ---
>   arch/arm/include/asm/ftrace.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index f89515a..fb7fdc4 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -45,7 +45,8 @@ void *return_address(unsigned int);
>
>   #else
>
> -extern inline void *return_address(unsigned int level)
> +extern inline __attribute__((gnu_inline))

That seems very ugly.

Is it possible to put something in linux/compiler.h that encapsulates 
the desired semantics, and then use that instead?

We already define "inline" that way, if you need something else, put it 
in compiler.h with a nice symbolic name, and then use it.


> +void *return_address(unsigned int level)
>   {
>   	return NULL;
>   }
>
