From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Sep 2016 11:33:34 +0100
Subject: [PATCH] arm64: kgdb: handle read-only text / modules
In-Reply-To: <20160920100321.17846-1-takahiro.akashi@linaro.org>
References: <20160920100321.17846-1-takahiro.akashi@linaro.org>
Message-ID: <20160920103333.GB1045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 07:03:21PM +0900, AKASHI Takahiro wrote:
> Handle read-only cases (CONFIG_DEBUG_RODATA/CONFIG_DEBUG_SET_MODULE_RONX)
> by using aarch64_insn_write() instead of probe_kernel_write().
> See how this works:
>     commit 2f896d586610 ("arm64: use fixmap for text patching")
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: <stable@vger.kernel.org> # 4.0-

We had SET_MODULE_RONX in v3.17, and we had KGDB before that, so we need
something for v3.17+.

> ---
>  arch/arm64/kernel/kgdb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 6732a27..133cfe3 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -382,3 +382,23 @@ struct kgdb_arch arch_kgdb_ops = {
>  		KGDB_DYN_BRK_INS_BYTE(3),
>  	}
>  };
> +int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
> +{
> +	int err;
> +
> +	BUILD_BUG_ON(AARCH64_INSN_SIZE != BREAK_INSTR_SIZE);
> +
> +	err = aarch64_insn_read((void *)bpt->bpt_addr, (u32 *)bpt->saved_instr);
> +	if (err)
> +		return err;
> +
> +	return aarch64_insn_write((void *)bpt->bpt_addr,
> +			(u32)AARCH64_BREAK_KGDB_DYN_DBG);
> +}

This changes the endianness of saved_instr (on BE), but it looks like
that's handed as an opaque token by the core code anyway, so that should
be fine.

This also renders arch_kgdb_ops.gdb_bpt_instr unused. Can/should we get
rid of that?

> +int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
> +{
> +	return aarch64_insn_write((void *)bpt->bpt_addr,
> +			*(u32 *)bpt->saved_instr);
> +}

We also need a few additional includes:

<asm/debug-monitors.h> # for BREAK_INSTR_SIZE, AARCH64_BREAK_KGDB_DYN_DBG
<asm/insn.h> # for AARCH64_INSN_SIZE, insn_{read,write}
<linux/bug.h> # for BUILD_BUG_ON()

I take it that we're protected against nesting within
aarch64_insn_write(), so that we can't deadlock on patch_lock?

Other than that, this looks good to me.

Thanks,
Mark.
