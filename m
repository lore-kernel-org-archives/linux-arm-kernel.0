From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 4 Jun 2015 14:43:37 +0100
Subject: [PATCH v4] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <1433419121-18726-1-git-send-email-michael@smart-africa.com>
References: <1433257803-25318-1-git-send-email-michael@smart-africa.com>
 <1433419121-18726-1-git-send-email-michael@smart-africa.com>
Message-ID: <20150604134337.GC10388@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 01:58:41PM +0200, Michael van der Westhuizen wrote:
> Fixes the TCM initialisation code to handle TCM banks that are
> present but inaccessible due to TrustZone configuration.  This is
> the default case when enabling the non-secure world.  It may also
> be the case that that the user decided to use TCM for TrustZone.
> 
> This change has exposed a bug in handling of TCM where no TCM bank
> was usable (the 0 size TCM case).  This change addresses the
> resulting hang.
> 
> This code only handles the ARMv6 TCMTR register format, and will not
> work correctly on boards that use the ARMv7 (or any other) format.
> This is handled by performing an early exit from the initialisation
> function when the TCMTR reports any format other than v6.
> 
> Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
> 
> Changes in v4:
>   - Clarify that the instruction encoding for unconditional MRC
>     happens to be identical between ARM and Thumb-2 modes.
> 
> Changes in v3:
>   - Add some documentation about the undefined handler hook and
>     how the values used in that hook are derived.
>   - Use symbolic values for the handler instruction and mask.
>   - Use symbolic values for the shift-and-mask operation that
>     extracts the destination register for the trapped operation.
>   - Reformat added comments to match the style in the remainder
>     of the file.
> 
> Changes in v2:
>   - Mark the TCM undefined hook data structure as __initdata, since
>     that's what it is.
>   - Ensure that we're dealing with an ARMv6 TCMTR format.
> 
>  arch/arm/kernel/tcm.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
> index 7a3be1d..b10e136 100644
> --- a/arch/arm/kernel/tcm.c
> +++ b/arch/arm/kernel/tcm.c
> @@ -17,6 +17,9 @@
>  #include <asm/mach/map.h>
>  #include <asm/memory.h>
>  #include <asm/system_info.h>
> +#include <asm/traps.h>
> +
> +#define TCMTR_FORMAT_MASK	0xe0000000U
>  
>  static struct gen_pool *tcm_pool;
>  static bool dtcm_present;
> @@ -176,6 +179,77 @@ static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
>  }
>  
>  /*
> + * When we are running in the non-secure world and the secure world
> + * has not explicitly given us access to the TCM we will get an
> + * undefined error when reading the TCM region register in the
> + * setup_tcm_bank function (above).
> + *
> + * There are two variants of this register read that we need to trap,
> + * the read for the data TCM and the read for the instruction TCM:
> + *  c0370628:       ee196f11        mrc     15, 0, r6, cr9, cr1, {0}
> + *  c0370674:       ee196f31        mrc     15, 0, r6, cr9, cr1, {1}
> + *
> + * Our undef hook mask explicitly matches all fields of the encoded
> + * instruction other than the destination register.  The mask also
> + * only allows operand 2 to have the values 0 or 1.
> + *
> + * The undefined hook is defined as __init and __initdata, and therefore
> + * must be removed before tcm_init returns.
> + *
> + * In this particular case (MRC with ARM condition code ALways) the
> + * Thumb-2 and ARM instruction encoding are identical, so this hook
> + * will work on a Thumb-2 kernel.
> + *
> + * See A8.8.107, DDI0406C_C ARM Architecture Reference Manual, Encoding
> + * T1/A1 for the bit-by-bit details.
> + *
> + *  mrc   p15, 0, XX, c9, c1, 0
> + *  mrc   p15, 0, XX, c9, c1, 1
> + *   |  |  |   |   |   |   |  +---- opc2           0|1 = 000|001
> + *   |  |  |   |   |   |   +------- CRm              0 = 0001
> + *   |  |  |   |   |   +----------- CRn              0 = 1001
> + *   |  |  |   |   +--------------- Rt               ? = ????
> + *   |  |  |   +------------------- opc1             0 =  000
> + *   |  |  +----------------------- coproc          15 = 1111
> + *   |  +-------------------------- condition   ALways = 1110
> + *   +----------------------------- instruction    MRC = 1110
> + *
> + * Encoding this as per A8.8.107 of DDI0406C, Encoding T1/A1, yields:
> + *  1111 1111 1111 1111 0000 1111 1101 1111 Required Mask
> + *  1110 1110 0001 1001 ???? 1111 0001 0001 mrc p15, 0, XX, c9, c1, 0
> + *  1110 1110 0001 1001 ???? 1111 0011 0001 mrc p15, 0, XX, c9, c1, 1
> + *  [  ] [  ] [ ]| [  ] [  ] [  ] [ ]| +--- CRm
> + *    |    |   | |   |    |    |   | +----- SBO
> + *    |    |   | |   |    |    |   +------- opc2
> + *    |    |   | |   |    |    +----------- coproc
> + *    |    |   | |   |    +---------------- Rt
> + *    |    |   | |   +--------------------- CRn
> + *    |    |   | +------------------------- SBO
> + *    |    |   +--------------------------- opc1
> + *    |    +------------------------------- instruction
> + *    +------------------------------------ condition
> + */
> +#define TCM_REGION_READ_MASK		0xffff0fdf
> +#define TCM_REGION_READ_INSTR		0xee190f11
> +#define DEST_REG_SHIFT			12
> +#define DEST_REG_MASK			0xf
> +
> +static int __init tcm_handler(struct pt_regs *regs, unsigned int instr)
> +{
> +	regs->uregs[(instr >> DEST_REG_SHIFT) & DEST_REG_MASK] = 0;
> +	regs->ARM_pc += 4;
> +	return 0;
> +}
> +
> +static struct undef_hook tcm_hook __initdata = {
> +	.instr_mask	= TCM_REGION_READ_MASK,
> +	.instr_val	= TCM_REGION_READ_INSTR,
> +	.cpsr_mask	= MODE_MASK,
> +	.cpsr_val	= SVC_MODE,
> +	.fn		= tcm_handler
> +};
> +
> +/*
>   * This initializes the TCM memory
>   */
>  void __init tcm_init(void)
> @@ -204,9 +278,18 @@ void __init tcm_init(void)
>  	}
>  
>  	tcm_status = read_cpuid_tcmstatus();
> +
> +	/*
> +	 * This code only supports v6-compatible TCMTR implementations.
> +	 */
> +	if (tcm_status & TCMTR_FORMAT_MASK)
> +		return;
> +
>  	dtcm_banks = (tcm_status >> 16) & 0x03;
>  	itcm_banks = (tcm_status & 0x03);
>  
> +	register_undef_hook(&tcm_hook);
> +
>  	/* Values greater than 2 for D/ITCM banks are "reserved" */
>  	if (dtcm_banks > 2)
>  		dtcm_banks = 0;
> @@ -218,7 +301,7 @@ void __init tcm_init(void)
>  		for (i = 0; i < dtcm_banks; i++) {
>  			ret = setup_tcm_bank(0, i, dtcm_banks, &dtcm_end);
>  			if (ret)
> -				return;
> +				goto unregister;
>  		}
>  		/* This means you compiled more code than fits into DTCM */
>  		if (dtcm_code_sz > (dtcm_end - DTCM_OFFSET)) {
> @@ -227,6 +310,12 @@ void __init tcm_init(void)
>  				dtcm_code_sz, (dtcm_end - DTCM_OFFSET));
>  			goto no_dtcm;
>  		}
> +		/*
> +		 * This means that the DTCM sizes were 0 or the DTCM banks
> +		 * were inaccessible due to TrustZone configuration.
> +		 */
> +		if (!(dtcm_end - DTCM_OFFSET))
> +			goto no_dtcm;
>  		dtcm_res.end = dtcm_end - 1;
>  		request_resource(&iomem_resource, &dtcm_res);
>  		dtcm_iomap[0].length = dtcm_end - DTCM_OFFSET;
> @@ -250,15 +339,21 @@ no_dtcm:
>  		for (i = 0; i < itcm_banks; i++) {
>  			ret = setup_tcm_bank(1, i, itcm_banks, &itcm_end);
>  			if (ret)
> -				return;
> +				goto unregister;
>  		}
>  		/* This means you compiled more code than fits into ITCM */
>  		if (itcm_code_sz > (itcm_end - ITCM_OFFSET)) {
>  			pr_info("CPU ITCM: %u bytes of code compiled to "
>  				"ITCM but only %lu bytes of ITCM present\n",
>  				itcm_code_sz, (itcm_end - ITCM_OFFSET));
> -			return;
> +			goto unregister;
>  		}
> +		/*
> +		 * This means that the ITCM sizes were 0 or the ITCM banks
> +		 * were inaccessible due to TrustZone configuration.
> +		 */
> +		if (!(itcm_end - ITCM_OFFSET))
> +			goto unregister;
>  		itcm_res.end = itcm_end - 1;
>  		request_resource(&iomem_resource, &itcm_res);
>  		itcm_iomap[0].length = itcm_end - ITCM_OFFSET;
> @@ -275,6 +370,9 @@ no_dtcm:
>  		pr_info("CPU ITCM: %u bytes of code compiled to ITCM but no "
>  			"ITCM banks present in CPU\n", itcm_code_sz);
>  	}
> +
> +unregister:
> +	unregister_undef_hook(&tcm_hook);
>  }
>  
>  /*
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
