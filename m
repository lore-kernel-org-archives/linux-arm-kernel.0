From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 06 Aug 2014 15:23:23 +0100
Subject: [RFC PATCH] kprobes: arm: enable OPTPROBES for arm 32
In-Reply-To: <1407223697-74911-1-git-send-email-wangnan0@huawei.com>
References: <1407223697-74911-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1407335003.3006.38.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-08-05 at 15:28 +0800, Wang Nan wrote:
> This patch introduce kprobeopt for ARM 32.
> 
> Limitations:
>  - Currently only kernel compiled with ARM ISA is supported.
>
>  - offset between probe point and kprobe pre_handler must not larger
>     than 64MiB. Masami Hiramatsu suggests replacing 2 words, it will
>     make things complex. Futher patch can make such optimization.
> 
> I have tested this patch on qemu vexpress a9 platform.
> 
> Kprobe opt on ARM is relatively simpler than kprobe opt on x86 because
> ARM instruction is always 4 bytes aligned. This patch replace probed
> instruction by a 'b', branch to trampoline code and then calls
> optimized_callback(). optimized_callback() calls kprobe_handler() to
> execute kprobe handler. It also emulate/simulate replaced instruction.
> 
> When unregistering kprobe, the deferred manner of unoptimizer may leave
> branch instruction before optimizer is called. Different from x86_64,
> which only copy the probed insn after optprobe_template_end and
> reexecute them, this patch call singlestep to emulate/simulate the insn
> directly. Futher patch can optimize this behavior.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

I've not reviewed this patch properly as I don't have time at the moment
to study the details of how optprobes work, but I did give it quick look
over to check that it was using the helper functions like patch_text()
which it does :-). I also spotted one duplication of an existing
function, see inline comment below...

[...]

> +static inline int
> +arm_branch_to_addr(unsigned int *pinst, void *src, void *dest)
> +{
> +	unsigned int inst = 0xea000000;
> +	long offset = (unsigned long)(dest) -
> +			((unsigned long)(src) + 8);
> +	if ((offset > 0x3fffffc) || (offset < -0x3fffffc)) {
> +		printk(KERN_WARNING "Failed to instrument %pS to %pS\n", src, dest);
> +		return -EINVAL;
> +	}
> +
> +	inst |= (((unsigned long)offset) >> 2) & (0x00ffffffUL);
> +	*pinst = inst;
> +	return 0;
> +}
> +

This looks remarkably similar to the code in arch/arm/kernel/insn.c so I
think you can probably just use the existing arm_gen_branch() function.

[...]

-- 
Tixy 
