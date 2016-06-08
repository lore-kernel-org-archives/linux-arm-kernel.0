From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Wed, 8 Jun 2016 10:14:01 +0900
Subject: [PATCH v13 02/10] arm64: Add more test functions to insn.c
In-Reply-To: <1464924384-15269-3-git-send-email-dave.long@linaro.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-3-git-send-email-dave.long@linaro.org>
Message-ID: <20160608101401.7296820ea6ac082ef1c917cb@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  2 Jun 2016 23:26:16 -0400
David Long <dave.long@linaro.org> wrote:
> @@ -367,6 +402,7 @@ bool aarch32_insn_is_wide(u32 insn);
>  #define A32_RT_OFFSET	12
>  #define A32_RT2_OFFSET	 0
>  
> +u32 aarch64_extract_system_register(u32 insn);

This exported symbol is incorrect (see below)

>  u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
>  u32 aarch32_insn_mcr_extract_opc2(u32 insn);
>  u32 aarch32_insn_mcr_extract_crm(u32 insn);
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 368c082..28c6110f 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
[..]
> @@ -1175,6 +1201,14 @@ u32 aarch64_set_branch_offset(u32 insn, s32 offset)
>  	BUG();
>  }
>  
> +/*
> + * Extract the Op/CR data from a msr/mrs instruction.
> + */
> +u32 aarch64_insn_extract_system_reg(u32 insn)
> +{
> +	return (insn & 0x1FFFE0) >> 5;
> +}
> +

aarch64_insn_extract_system_reg() is the right name :)

Thank you,


>  bool aarch32_insn_is_wide(u32 insn)
>  {
>  	return insn >= 0xe800;
> -- 
> 2.5.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
