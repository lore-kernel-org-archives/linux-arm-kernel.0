From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 14:52:17 +0100
Subject: [PATCH v7 6/7] arm64: ftrace: Add CALLER_ADDRx macros
In-Reply-To: <1394862353-28963-7-git-send-email-takahiro.akashi@linaro.org>
References: <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862353-28963-7-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140416135217.GF1001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 05:45:52AM +0000, AKASHI Takahiro wrote:
> CALLER_ADDRx returns caller's address at specified level in call stacks.
> They are used for several tracers like irqsoff and preemptoff.
> Strange to say, however, they are refered even without FTRACE.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/include/asm/ftrace.h    | 13 ++++++++-
>  arch/arm64/kernel/Makefile         |  3 ++-
>  arch/arm64/kernel/return_address.c | 55 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/kernel/return_address.c
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index ed5c448..c44c4b1 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -18,6 +18,7 @@
>  
>  #ifndef __ASSEMBLY__
>  extern void _mcount(unsigned long);
> +extern void *return_address(unsigned int);
>  
>  struct dyn_arch_ftrace {
>  	/* No extra data needed for arm64 */
> @@ -33,6 +34,16 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	 */
>  	return addr;
>  }
> -#endif /* __ASSEMBLY__ */
> +
> +#define HAVE_ARCH_CALLER_ADDR
> +
> +#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> +#define CALLER_ADDR1 ((unsigned long)return_address(1))
> +#define CALLER_ADDR2 ((unsigned long)return_address(2))
> +#define CALLER_ADDR3 ((unsigned long)return_address(3))
> +#define CALLER_ADDR4 ((unsigned long)return_address(4))
> +#define CALLER_ADDR5 ((unsigned long)return_address(5))
> +#define CALLER_ADDR6 ((unsigned long)return_address(6))
> +#endif /* ifndef __ASSEMBLY__ */

Hmm, I thought you were going to take a look at reworking the core code for
this, as Steve and I suggested?

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/240239.html

Will
