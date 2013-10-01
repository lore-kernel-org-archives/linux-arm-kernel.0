From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Oct 2013 10:19:20 +0100
Subject: [PATCH] arm64: check for number of arguments in
 syscall_get/set_arguments()
In-Reply-To: <1380605584-22125-1-git-send-email-takahiro.akashi@linaro.org>
References: <1380605584-22125-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20131001091919.GA17667@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 06:33:04AM +0100, AKASHI Takahiro wrote:
> In ftrace_syscall_enter(),
>     syscall_get_arguments(..., 0, n, ...)
> 	if (i == 0) { <handle orig_x0> ...; n--;}
> 	memcpy(..., n * sizeof(args[0]));
> If 'number of arguments(n)' is zero and 'argument index(i)' is also zero in
> syscall_get_arguments(), none of arguments should be copied by memcpy().
> Otherwise 'n--' can be a big positive number and unexpected amount of data
> will be copied. Tracing system calls which take no argument, say sync(void),
> may hit this case and eventually make the system corrupted.
> This patch fixes the issue both in syscall_get_arguments() and
> syscall_set_arguments().
> 
> Please note, however, that asm-generic/syscall.h says,
>  * syscall_get_arguments - extract system call parameter values
>  * @i:          argument index [0,5]
>  * @n:          number of arguments; n+i must be [1,6].
> and so we'd better change the caller's code(ftrace_syscall_enter).

Since (most) other architectures deal with n+i == 0, please can you submit a
separate patch updating that comment?

> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/include/asm/syscall.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index c89821f..01bb8cc 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -63,6 +63,9 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  					 unsigned int i, unsigned int n,
>  					 unsigned long *args)
>  {
> +	if (n == 0)
> +		return;
> +
>  	if (i + n > SYSCALL_MAX_ARGS) {
>  		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
>  		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
> @@ -86,6 +89,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  					 unsigned int i, unsigned int n,
>  					 const unsigned long *args)
>  {
> +	if (n == 0)
> +		return;
> +

Looks sensible. Please can you fix arch/arm/ as well?

Cheers,

Will
