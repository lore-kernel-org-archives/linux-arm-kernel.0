From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 7 Apr 2015 12:19:42 -0400
Subject: [RESEND PATCH 4.0-rc5 v19 5/6] x86/nmi: Use common printk
 functions
In-Reply-To: <1428421083-9137-6-git-send-email-daniel.thompson@linaro.org>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428421083-9137-1-git-send-email-daniel.thompson@linaro.org>
 <1428421083-9137-6-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150407121942.627d2165@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Apr 2015 16:38:02 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

  
>  void arch_trigger_all_cpu_backtrace(bool include_self)
>  {
> -	struct nmi_seq_buf *s;
> -	int len;
> -	int cpu;
>  	int i;
>  	int this_cpu = get_cpu();
>  
> -	if (test_and_set_bit(0, &backtrace_flag)) {
> +	if (0 != printk_nmi_backtrace_prepare()) {

Not sure what the others think, but I hate this polish notation for
compares. One does not say "if zero does not equal
printk_nmi_backtrace_prepare()", they say "if
printk_nmi_backtrace_prepare() does not return zero".

And the reason for polish notation is to prevent the:

	if (x = 0)

mistake. Which gcc warns about anyway. Also, this doesn't even pertain
to this code because:

	if (printk_nmi_backtrace_prepare() = 0)

would fail to compile.

-- Steve
