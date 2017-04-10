From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Apr 2017 11:44:03 +0100
Subject: [PATCH] efi/libstub: arm/arm64: don't use TASK_SIZE when
 randomising the RT space
In-Reply-To: <20170410103038.20117-1-ard.biesheuvel@linaro.org>
References: <20170410103038.20117-1-ard.biesheuvel@linaro.org>
Message-ID: <20170410104403.GC13899@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 11:30:38AM +0100, Ard Biesheuvel wrote:
> As reported by James, Catalin and Mark, commit e69176d68d26
> ("ef/libstub/arm/arm64: Randomize the base of the UEFI rt services
> region") results in a crash in the firmware regardless of whether KASLR
> is in effect or not, and whether the firmware implements EFI_RNG_PROTOCOL
> or not.
> 
> Mark has identified the root cause to be the inappropriate use of
> TASK_SIZE in the stub, which arm64 defines as
> 
>   #define TASK_SIZE             (test_thread_flag(TIF_32BIT) ? \
>                                 TASK_SIZE_32 : TASK_SIZE_64)
> 
> and testing thread flags at this point results in the dereference of
> pointers in uninitialized structures.
> 
> So instead, introduce a preprocessor symbol EFI_RT_VIRTUAL_LIMIT and
> define it to TASK_SIZE_64 on arm64 and TASK_SIZE on ARM, both of which
> are compile time constants. Also, change the 'headroom' variable to
> static const to force an error if this changes in the future.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

With this patch applied atop of next-20170410, a defconfig arm64 kernel
built with the Linaro 15.08 toolchain boots happily for me on Juno R1.

So FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
> 
> Apologies for the breakage. On the systems I have tested, sp_el0 apparently
> pointed somewhere sane when I inadvertently dereferenced it, and the
> resulting addresses looked sufficiently random to me.
> 
> Ingo, once we have some confirmation that this makes the problem go away,
> could you please take this straight into efi/core? Thanks. 
> 
>  drivers/firmware/efi/libstub/arm-stub.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index 1e45ec51b094..34010ff3b77e 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -32,6 +32,12 @@
>  #define EFI_RT_VIRTUAL_BASE	SZ_512M
>  #define EFI_RT_VIRTUAL_SIZE	SZ_512M
>  
> +#ifdef CONFIG_ARM64
> +#define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_64
> +#else
> +#define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
> +#endif
> +
>  static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
>  
>  efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
> @@ -236,8 +242,9 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
>  		 * shift of 21 bit positions into account when scaling
>  		 * the headroom value using a 32-bit random value.
>  		 */
> -		u64 headroom = TASK_SIZE - EFI_RT_VIRTUAL_BASE -
> -			       EFI_RT_VIRTUAL_SIZE;
> +		static const u64 headroom = EFI_RT_VIRTUAL_LIMIT -
> +					    EFI_RT_VIRTUAL_BASE -
> +					    EFI_RT_VIRTUAL_SIZE;
>  		u32 rnd;
>  
>  		status = efi_get_random_bytes(sys_table, sizeof(rnd),
> -- 
> 2.9.3
> 
