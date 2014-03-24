From: dave.long@linaro.org (David Long)
Date: Mon, 24 Mar 2014 11:18:11 -0400
Subject: [PATCH 1/3] ARM: kprobes: Prevent known test failures stopping
 other tests running
In-Reply-To: <1394556894-18592-2-git-send-email-tixy@linaro.org>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-2-git-send-email-tixy@linaro.org>
Message-ID: <53304CB3.6040409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/14 12:54, Jon Medhurst wrote:
> Due to a long-standing issue with Thumb symbol lookup [1] the jprobes
> tests fail when built into a kernel compiled as Thumb mode. (They work
> fine for ARM mode kernels or for Thumb when built as a loadable module.)
>
> Rather than have this problem terminate testing prematurely lets instead
> emit an error message and carry on with the main kprobes tests, delaying
> the final failure report until the end.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/063026.html
>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>   arch/arm/kernel/kprobes-test.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index c2fd06b..6de5e94 100644
> --- a/arch/arm/kernel/kprobes-test.c
> +++ b/arch/arm/kernel/kprobes-test.c
> @@ -225,6 +225,7 @@ static int pre_handler_called;
>   static int post_handler_called;
>   static int jprobe_func_called;
>   static int kretprobe_handler_called;
> +static int tests_failed;
>
>   #define FUNC_ARG1 0x12345678
>   #define FUNC_ARG2 0xabcdef
> @@ -461,6 +462,13 @@ static int run_api_tests(long (*func)(long, long))
>
>   	pr_info("    jprobe\n");
>   	ret = test_jprobe(func);
> +#if defined(CONFIG_THUMB2_KERNEL) && !defined(MODULE)
> +	if (ret == -EINVAL) {
> +		pr_err("FAIL: Known longtime bug with jprobe on Thumb kernels\n");
> +		tests_failed = ret;
> +		ret = 0;
> +	}
> +#endif
>   	if (ret < 0)
>   		return ret;
>
> @@ -1671,6 +1679,8 @@ static int __init run_all_tests(void)
>
>   out:
>   	if (ret == 0)
> +		ret = tests_failed;
> +	if (ret == 0)
>   		pr_info("Finished kprobe tests OK\n");
>   	else
>   		pr_err("kprobe tests failed\n");
>

Tixy,

Sorry for the delay in responding.

Because this (correctly) was marked as having no interdependencies it 
got marked as "applied" in the patch-tracker.  That is why I omitted it 
from my v7 patches (although I should have just submitted it separately 
in the first place).  I don't see it in the linux-arm tree though, so I 
guess we do still need it.  If you haven't yet you might want to double 
check that.

I'm happy ack'ing this (if that's useful to you :-).

-dl
