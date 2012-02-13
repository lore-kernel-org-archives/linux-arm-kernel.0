From: mgherzan@gmail.com (Mircea Gherzan)
Date: Mon, 13 Feb 2012 16:36:29 +0100
Subject: [PATCH v7] ARM: net: JIT compiler for packet filters
In-Reply-To: <1325937154-2656-1-git-send-email-mgherzan@gmail.com>
References: <1325937154-2656-1-git-send-email-mgherzan@gmail.com>
Message-ID: <4F392DFD.4070600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 07.01.2012 12:52, schrieb Mircea Gherzan:
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
> Changes in v7:
>  * fix the intruction generation for LDX_MSH, OR_X, LSH_K,
>    RSH_K and JMP_JA
>  * fix the condition for saving the A register
>  * use fls() instead of the compiler builtin
>  * punt to the interpreter on absolute loads with K < 0
>  * check for invalid data references
>  * support the NEG opcode
>  * clear X in the prologue based on a context flag
>  * simplify the conditional jumps
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
>  arch/arm/Kconfig          |    1 +
>  arch/arm/Makefile         |    1 +
>  arch/arm/net/Makefile     |    3 +
>  arch/arm/net/bpf_jit_32.c |  912 +++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/net/bpf_jit_32.h |  190 ++++++++++
>  5 files changed, 1107 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/net/Makefile
>  create mode 100644 arch/arm/net/bpf_jit_32.c
>  create mode 100644 arch/arm/net/bpf_jit_32.h

Gentle ping. This patch has been in the tracking system for over a
month. Is there any reason not to apply it in arm/for-next?

Thanks,
Mircea
