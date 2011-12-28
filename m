From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 28 Dec 2011 19:42:52 +0100
Subject: [PATCH v6] ARM: net: JIT compiler for packet filters
In-Reply-To: <1325086527-14277-1-git-send-email-mgherzan@gmail.com>
References: <1325086527-14277-1-git-send-email-mgherzan@gmail.com>
Message-ID: <1325097772.2607.4.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 28 d?cembre 2011 ? 16:35 +0100, Mircea Gherzan a ?crit :
> Based of Matt Evans's PPC64 implementation.
> 
> The compiler generates ARM instructions but interworking is
> supported for Thumb2 kernels.
> 
> Supports both little and big endian. Unaligned loads are emitted
> for ARMv6+. Not all the BPF opcodes that deal with ancillary data
> are supported. The scratch memory of the filter lives on the stack.
> Hardware integer division is used if it is available.
> 
> Enabled in the same way as for x86-64 and PPC64:
> 
> 	echo 1 > /proc/sys/net/core/bpf_jit_enable
> 
> A value greater than 1 enables opcode output.
> 
> Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> ---
> 
> Changes in v6:
>  * fix the code generation for the ANC_CPU opcode
> 
> Changes in v5:
>  * replace SEEN_LEN with SEEN_SKB
>  * set ctx->seen when handling some ancillary data opcodes
> 
> Changes in v4:
>  * first check if the JIT compiler is enabled
>  * fix the code generation for the LDX_MSH opcode
> 
> Changes in v3:
>  * no longer depend on EABI and !Thumb2
>  * add BLX "emulation" for ARMv4 without Thumb
>  * use the integer divide instruction on Cortex-A15
>  * fix the handling of the DIV_K opcode
>  * use a C wrapper for __aeabi_uidiv
>  * fix the generation of the epilogue (non-FP case)
> 
> Changes in v2:
>  * enable the compiler only for ARMv5+ because of the BLX instruction
>  * use the same comparison for the ARM version checks
>  * use misaligned accesses on ARMv6
>  * fix the SEEN_MEM
>  * fix the mem_words_used()
> 

> +
> +static void build_epilogue(struct jit_ctx *ctx)
> +{
> +	u16 reg_set = saved_regs(ctx);
> +
> +	if (ctx->seen & SEEN_MEM)
> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, mem_words_used(ctx) * 4), ctx);
> +
> +	reg_set &= ~(1 << ARM_LR);
> +
> +#ifdef CONFIG_FRAME_POINTER
> +	/* the first instruction of the prologue was: mov ip, sp */
> +	reg_set &= ~(1 << ARM_IP);
> +	reg_set |= (1 << ARM_SP);
> +	emit(ARM_LDM(ARM_SP, reg_set), ctx);
> +#else
> +	if (ctx->seen) {
> +		if (ctx->seen & SEEN_CALL)
> +			reg_set |= 1 << ARM_PC;
> +		emit(ARM_POP(reg_set), ctx);
> +	}
> +
> +	if (!(ctx->seen & SEEN_CALL))
> +		emit(ARM_BX(ARM_LR), ctx);
> +#endif
> +}
> +

It seems you missed Rabin Vincent feedback ?

TEST 9 ==========================================
BPF_STMT(BPF_ALU+BPF_ADD+BPF_K, 1000),
BPF_STMT(BPF_RET+BPF_A, 0)
Code: e92d0010 e3a04000 e2844ffa e1a00004 e12fff1e (0000000000)
(0) retinterp 0x3e8 retjit 0x3e8
+OK
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

All code
========
   0:   e92d0010        push    {r4}
   4:   e3a04000        mov     r4, #0
   8:   e2844ffa        add     r4, r4, #1000   ; 0x3e8
   c:   e1a00004        mov     r0, r4
  10:   e12fff1e        bx      lr              <-- no pop
