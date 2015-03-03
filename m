From: pmladek@suse.cz (Petr Mladek)
Date: Tue, 3 Mar 2015 18:06:33 +0100
Subject: [PATCH 3/3] early kprobes: x86: don't try to recover ftraced
 instruction before ftrace get ready.
In-Reply-To: <1425359345-38714-4-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
 <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
 <1425359345-38714-4-git-send-email-wangnan0@huawei.com>
Message-ID: <20150303170633.GG3703@dhcp128.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-03-03 13:09:05, Wang Nan wrote:
> Before ftrace convertin instruction to nop, if an early kprobe is
> registered then unregistered, without this patch its first bytes will
> be replaced by head of NOP, which may confuse ftrace.
> 
> Actually, since we have a patch which convert ftrace entry to nop
> when probing, this problem should never be triggered. Provide it for
> safety.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 87beb64..c7d304d 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -225,6 +225,9 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
>  	struct kprobe *kp;
>  	unsigned long faddr;
>  
> +	if (!kprobes_on_ftrace_initialized)
> +		return addr;

This is not correct. The function has to return a buffer with the original
code also when it is modified by normal kprobes. If it is a normal
Kprobe, it reads the current code and replaces the first byte (INT3
instruction) with the saved kp->opcode.

> +
>  	kp = get_kprobe((void *)addr);
>  	faddr = ftrace_location(addr);

IMHO, the proper fix might be to replace the above line with

	if (kprobes_on_ftrace_initialized)
		faddr = ftrace_location(addr);
	else
		faddr = 0UL;

By other words, it might pretend that it is not a ftrace location
when the ftrace is not ready yet.

Or is the code modified another special way when it is a ftrace location but
ftrace has not been initialized yet?

Best Regards,
Petr

>  	/*
> -- 
> 1.8.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
