From: mark.rutland@arm.com (Mark Rutland)
Date: Sun, 11 Nov 2018 17:23:33 +0000
Subject: [PATCH] arm64: disable KASAN for save_trace()
In-Reply-To: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
References: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
Message-ID: <20181111172333.ov25gdmlsmhc6ysp@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2018 at 08:07:16PM +0800, Zhizhou Zhang wrote:
> save_trace() which is called from walk_stackframe() always try to
> read/write caller's stack. This results KASAN stack-out-of-bounds
> warning. So mute it.

The save_trace() function should never perform an out-of-bounds access on the
caller's stack, so this is papering over a bug elsewhere.

Can you please given an example report from KASAN?

Thanks,
Mark.

> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  arch/arm64/kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 4989f7e..e93ca67 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -107,7 +107,7 @@ struct stack_trace_data {
>  	unsigned int skip;
>  };
>  
> -static int save_trace(struct stackframe *frame, void *d)
> +static int __no_sanitize_address save_trace(struct stackframe *frame, void *d)
>  {
>  	struct stack_trace_data *data = d;
>  	struct stack_trace *trace = data->trace;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
