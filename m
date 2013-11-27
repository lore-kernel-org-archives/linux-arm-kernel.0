From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Wed, 27 Nov 2013 19:16:26 +0900
Subject: [PATCH v3 06/15] ARM: Disable jprobes test when built into
 thumb-mode kernel
In-Reply-To: <1385520814-10663-7-git-send-email-dave.long@linaro.org>
References: <1385520814-10663-1-git-send-email-dave.long@linaro.org>
 <1385520814-10663-7-git-send-email-dave.long@linaro.org>
Message-ID: <5295C67A.3070308@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/11/27 11:53), David Long wrote:
> From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> 
> For now the jprobes tests fail on ARM for when built into a kernel compiled
> in thumb mode. They work fine for ARM kernels, and when built as a loadable
> module.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>

You'd better add Jon's signed-off-by here.

Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

> ---
>  arch/arm/kernel/kprobes-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index 0cd63d0..65230b2 100644
> --- a/arch/arm/kernel/kprobes-test.c
> +++ b/arch/arm/kernel/kprobes-test.c
> @@ -221,6 +221,7 @@ static int pre_handler_called;
>  static int post_handler_called;
>  static int jprobe_func_called;
>  static int kretprobe_handler_called;
> +static int tests_failed;
>  
>  #define FUNC_ARG1 0x12345678
>  #define FUNC_ARG2 0xabcdef
> @@ -457,6 +458,13 @@ static int run_api_tests(long (*func)(long, long))
>  
>  	pr_info("    jprobe\n");
>  	ret = test_jprobe(func);
> +#if defined(CONFIG_THUMB2_KERNEL) && !defined(MODULE)
> +	if (ret == -EINVAL) {
> +		pr_err("FAIL: Known longtime bug with jprobe on Thumb kernels");
> +		tests_failed = ret;
> +		ret = 0;
> +	}
> +#endif
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1667,6 +1675,8 @@ static int __init run_all_tests(void)
>  
>  out:
>  	if (ret == 0)
> +		ret = tests_failed;
> +	if (ret == 0)
>  		pr_info("Finished kprobe tests OK\n");
>  	else
>  		pr_err("kprobe tests failed\n");
> 


-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
