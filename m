From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 9 Aug 2016 20:49:44 +0200
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
Message-ID: <20160809184943.GA17112@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02, Pratyush Anand wrote:
>
> This patch adds support for uprobe on ARM64 architecture.

I know nothing about ARM, so I can't actually review this change.
But it looks good to me ;)

Just one note,

> +int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> +{
> +	struct uprobe_task *utask = current->utask;
> +
> +	/* saved fault code is restored in post_xol */
> +	utask->autask.saved_fault_code = current->thread.fault_code;
> +
> +	/* An invalid fault code between pre/post xol event */
> +	current->thread.fault_code = UPROBE_INV_FAULT_CODE;
> +
> +	/* Instruction point to execute ol */
> +	instruction_pointer_set(regs, utask->xol_vaddr);
> +
> +	user_enable_single_step(current);

I don't think we want user_{enable,disable{_single_step in the long term,
please look at 9bd1190a11c9d2 "uprobes/x86: Do not (ab)use TIF_SINGLESTEP
/user_*_single_step() for single-stepping". it seems that ARM64 sets/clears
TIF_SINGLESTEP. You can also lool at saved_tf logic, probably ARM64 needs
the same.

However, I agree we can do this later and initial version can use these
ptrace helpers.

Oleg.
