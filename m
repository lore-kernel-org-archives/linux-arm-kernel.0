From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Oct 2013 17:19:49 +0100
Subject: [PATCH v2 2/3] arm: check for number of arguments in
 syscall_get/set_arguments()
In-Reply-To: <1380779266-11753-3-git-send-email-takahiro.akashi@linaro.org>
References: <1380605584-22125-git-send-email-takahiro.akashi@linaro.org>
 <1380779266-11753-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20131003161949.GD7408@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 06:47:45AM +0100, AKASHI Takahiro wrote:
> In ftrace_syscall_enter(),
>     syscall_get_arguments(..., 0, n, ...)
>         if (i == 0) { <handle ORIG_r0> ...; n--;}
>         memcpy(..., n * sizeof(args[0]));
> If 'number of arguments(n)' is zero and 'argument index(i)' is also zero in
> syscall_get_arguments(), none of arguments should be copied by memcpy().
> Otherwise 'n--' can be a big positive number and unexpected amount of data
> will be copied. Tracing system calls which take no argument, say sync(void),
> may hit this case and eventually make the system corrupted.
> This patch fixes the issue both in syscall_get_arguments() and
> syscall_set_arguments().
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm/include/asm/syscall.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
> index f1d96d4..73ddd72 100644
> --- a/arch/arm/include/asm/syscall.h
> +++ b/arch/arm/include/asm/syscall.h
> @@ -57,6 +57,9 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
> +	if (n == 0)
> +		return;
> +
>  	if (i + n > SYSCALL_MAX_ARGS) {
>  		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
>  		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
> @@ -81,6 +84,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  					 unsigned int i, unsigned int n,
>  					 const unsigned long *args)
>  {
> +	if (n == 0)
> +		return;
> +
>  	if (i + n > SYSCALL_MAX_ARGS) {
>  		pr_warning("%s called with max args %d, handling only %d\n",
>  			   __func__, i + n, SYSCALL_MAX_ARGS);

  Acked-by: Will Deacon <will.deacon@arm.com>

Please can you put this into the patch system, with a CC stable tag?

Will
