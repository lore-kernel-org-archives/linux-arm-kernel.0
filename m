From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 23 Dec 2011 05:44:17 +0100
Subject: [PATCH v5] ARM: net: JIT compiler for packet filters
In-Reply-To: <1324601625-20351-1-git-send-email-mgherzan@gmail.com>
References: <1324601625-20351-1-git-send-email-mgherzan@gmail.com>
Message-ID: <1324615457.2674.6.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 23 d?cembre 2011 ? 01:53 +0100, Mircea Gherzan a ?crit :
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
> Changes in v5:
>  * replace SEEN_LEN with SEEN_SKB
>  * set ctx->seen when handling some ancillary data opcodes

> +		case BPF_S_ANC_CPU:
> +			/* A = current_thread_info()->cpu */
> +			emit_mov_i(r_scratch, (~(THREAD_SIZE - 1)), ctx);
> +			emit(ARM_ADD_R(r_scratch, ARM_SP, r_scratch), ctx);

This cant be right ;)

> +
> +			BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info, cpu) != 4);
> +			off = offsetof(struct thread_info, cpu);
> +			emit(ARM_LDR_I(r_A, r_scratch, off), ctx);
> +			break;

code for r_A = raw_smp_processor_id(); should be something like :

mov r0, sp
bic r0, r0, #8128   ; 0x1fc0
bic r0, r0, #63 ; 0x3f
ldr r4, [r0, #20] 
