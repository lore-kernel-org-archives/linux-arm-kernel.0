From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 5 Jan 2016 09:53:38 +0100
Subject: [RFC PATCH] arm64: perf test: Improbe bp_signal
In-Reply-To: <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
References: <20160104165535.GI1616@arm.com>
 <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20160105085338.GB2192@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 04:58:00AM +0000, Wang Nan wrote:

SNIP

> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index fb80c9e..0bc4f76 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -29,14 +29,55 @@
>  
>  static int fd1;
>  static int fd2;
> +static int fd3;
>  static int overflows;
> +static int overflows_2;
> +
> +volatile long the_var;
> +
> +

please put comment in here explaning the assembly is used
to have watchpoint and breakpoint on single instruction

IIUC ;-)

thanks,
jirka

> +#if defined (__x86_64__)
> +extern void __test_function(volatile long *ptr);
> +asm (
> +	".globl __test_function\n"
> +	"__test_function:\n"
> +	"incq (%rdi)\n"
> +	"ret\n");
> +#elif defined (__aarch64__)
> +extern void __test_function(volatile long *ptr);
> +asm (
> +	".globl __test_function\n"
> +	"__test_function:\n"
> +	"str x30, [x0]\n"
> +	"ret\n");
> +
> +#else
> +static void __test_function(volatile long *ptr)
> +{
> +	*ptr++;
> +}
> +#endif
>  
>  __attribute__ ((noinline))
>  static int test_function(void)
>  {
> +	__test_function(&the_var);
> +	the_var++;
>  	return time(NULL);
>  }

SNIP
