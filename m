From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Feb 2018 12:09:47 +0000
Subject: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
In-Reply-To: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
Message-ID: <8c648c07-3611-bd18-eca9-3a34f43c8d44@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/18 06:39, Bhupesh Sharma wrote:
> Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> Silence Sparse warnings), compilation of arm64 architecture is broken
> with the following error messages:
> 
>    AR      arch/arm64/kernel/built-in.o
>    arch/arm64/kernel/head.S: Assembler messages:
>    arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>    arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>    arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>    arch/arm64/kernel/head.S:677: Error: junk at end of line, first
>    unrecognized character is `L'
>    arch/arm64/kernel/head.S:677: Error: unexpected characters following
>    instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
>    arch/arm64/kernel/head.S:677: Error: unexpected characters following
>    instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
> 
> This patch fixes the same by using the UL() macro correctly for
> assigning the MPIDR_HWID_BITMASK macro value.

Sorry! I am however rather puzzled at how I didn't hit this with my 
toolchain (Linaro 17.11), and neither did the LKP robot. Oh well.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>   arch/arm64/include/asm/cputype.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index eda8c5f629fc..350c76a1d15b 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -20,7 +20,7 @@
>   
>   #define MPIDR_UP_BITMASK	(0x1 << 30)
>   #define MPIDR_MT_BITMASK	(0x1 << 24)
> -#define MPIDR_HWID_BITMASK	0xff00ffffffUL
> +#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
>   
>   #define MPIDR_LEVEL_BITS_SHIFT	3
>   #define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
> 
