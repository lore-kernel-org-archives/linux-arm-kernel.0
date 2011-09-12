From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Sep 2011 15:42:54 +0100
Subject: [PATCH v2] ARM: make cpu_is_v6_unaligned() and safe_usermode()
	independent of CONFIG_PROC_FS
In-Reply-To: <1315630186-29654-1-git-send-email-eric.miao@linaro.org>
References: <1315630186-29654-1-git-send-email-eric.miao@linaro.org>
Message-ID: <20110912144253.GC2020@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 09:49:46PM -0700, eric.miao at linaro.org wrote:
> From: Eric Miao <eric.miao@linaro.org>
> 
> Signed-off-by: Eric Miao <eric.miao@linaro.org>

Yes, including that function inside the #ifdef was unintentional.

The change looks sensible to me.

Reviewed-by: Dave Martin <dave.martin@linaro.org>

> ---
> 
> It turned out both cpu_is_v6_unaligned and safe_usermode() could be
> referenced without CONFIG_PROC_FS being defined.
> 
>  arch/arm/mm/alignment.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index cfbcf8b..c335c76 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -86,16 +86,6 @@ core_param(alignment, ai_usermode, int, 0600);
>  #define UM_FIXUP	(1 << 1)
>  #define UM_SIGNAL	(1 << 2)
>  
> -#ifdef CONFIG_PROC_FS
> -static const char *usermode_action[] = {
> -	"ignored",
> -	"warn",
> -	"fixup",
> -	"fixup+warn",
> -	"signal",
> -	"signal+warn"
> -};
> -
>  /* Return true if and only if the ARMv6 unaligned access model is in use. */
>  static bool cpu_is_v6_unaligned(void)
>  {
> @@ -123,6 +113,16 @@ static int safe_usermode(int new_usermode, bool warn)
>  	return new_usermode;
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static const char *usermode_action[] = {
> +	"ignored",
> +	"warn",
> +	"fixup",
> +	"fixup+warn",
> +	"signal",
> +	"signal+warn"
> +};
> +
>  static int alignment_proc_show(struct seq_file *m, void *v)
>  {
>  	seq_printf(m, "User:\t\t%lu\n", ai_user);
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
