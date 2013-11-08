From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Nov 2013 15:06:02 +0000
Subject: [RFC v1 PATCH] ARM64: KGDB: Add FP/SIMD debug support
In-Reply-To: <1383827921-18526-2-git-send-email-vijay.kilari@gmail.com>
References: <1383827921-18526-1-git-send-email-vijay.kilari@gmail.com>
 <1383827921-18526-2-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20131108150602.GN17461@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 12:38:41PM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Add KGDB debug support for FP/SIMD processor.This support
> only debugging of FP/SIMD in kernel mode.
> With this patch one can view or set FP/SIMD registers in
> kernel context
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> ---
>  arch/arm64/kernel/kgdb.c |   98 ++++++++++++++++++++++++++++------------------
>  1 file changed, 60 insertions(+), 38 deletions(-)

[...]

> @@ -100,11 +108,18 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>  	if (regno >= DBG_MAX_REG_NUM || regno < 0)
>  		return NULL;
>  
> -	if (dbg_reg_def[regno].offset != -1)
> +	if (dbg_reg_def[regno].offset != -1 && regno < _GP_REGS)
>  		memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
>  		       dbg_reg_def[regno].size);
> -	else
> +	else {
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +		fpsimd_save_state(&kgdb_fpsimd_regs);
> +		memcpy(mem, (void *)&kgdb_fpsimd_regs +
> +			dbg_reg_def[regno].offset, dbg_reg_def[regno].size);

Don't you only want to do this if you're inside a kernel_neon_{begin,end}
section? Otherwise, you'll be copying out user registers. It really depends
on what semantics you want.

Will
