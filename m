From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 3 Dec 2015 22:12:41 -0500
Subject: [PATCH v2 1/2] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <1449195519-17901-2-git-send-email-huawei.libin@huawei.com>
References: <1449195519-17901-1-git-send-email-huawei.libin@huawei.com>
 <1449195519-17901-2-git-send-email-huawei.libin@huawei.com>
Message-ID: <20151203221241.07ff092e@grimm.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Dec 2015 10:18:38 +0800
Li Bin <huawei.libin@huawei.com> wrote:

> For ftrace on arm64, kstop_machine which is hugely disruptive
> to a running system is not needed to convert nops to ftrace calls
> or back, because that to be modified instrucions, that NOP, B or BL,
> are all safe instructions which called "concurrent modification
> and execution of instructions", that can be executed by one
> thread of execution as they are being modified by another thread
> of execution without requiring explicit synchronization.
> 
> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> ---
>  arch/arm64/kernel/ftrace.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index c851be7..9669b33 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -93,6 +93,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  	return ftrace_modify_code(pc, old, new, true);
>  }
>  
> +void arch_ftrace_update_code(int command)
> +{
> +	ftrace_modify_all_code(command);

Hmm, I wonder why I haven't done this for powerpc. I probably should.

Anyway,

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

If it is indeed safe not to do any special handling.

-- Steve

> +}
> +
>  int __init ftrace_dyn_arch_init(void)
>  {
>  	return 0;
