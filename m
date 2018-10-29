From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 29 Oct 2018 14:52:01 +0000
Subject: [PATCH] arm: mm: fault: check ADFSR in case of abort
In-Reply-To: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
Message-ID: <d9195ffb-f766-363e-21f3-e3737526c7de@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/2018 14:20, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> When running into situations like:
> "Unhandled fault: synchronous external abort (0x210) at 0xXXX"
> or
> "Unhandled prefetch abort: synchronous external abort (0x210) at 0xXXX"
> it is useful to know the content of ADFSR (Auxiliary Data Fault Status
> Register) to indicate an ECC double-bit error in L1 or L2 cache.
> 
> Refer to:
> Cortex-A15 Technical Reference Manual, Revision: r2p1
> [6.4.8. Error Correction Code]

The contents of ADFSR are implementation-defined, though, so this 
interpretation is *only* valid on Cortex-A15. Other processors may use 
those bit positions to report something else, at which point printing a 
message about ECC errors would be totally misleading.

Robin.

> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>   arch/arm/mm/fault.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 3232afb6fdc0..5e240deb6ed6 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -547,6 +547,22 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
>   	fsr_info[nr].name = name;
>   }
>   
> +/*
> + * Check for ECC double-bit errors in Auxiliary Data Fault Status Register
> + */
> +static void check_adfsr_for_ecc(void)
> +{
> +	u32 adfsr = 0;
> +
> +	asm("mrc p15, 0, %0, c5, c1, 0" : "=r" (adfsr));
> +
> +	if (adfsr & (BIT(31) | BIT(23))) {
> +		pr_alert("ADFSR status 0x%x indicates that an L1 or L2 cache\n"
> +			 "ECC double-bit error occurred at some time.\n",
> +			  adfsr);
> +	}
> +}
> +
>   /*
>    * Dispatch a data abort to the relevant handler.
>    */
> @@ -559,6 +575,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>   	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
>   		return;
>   
> +	check_adfsr_for_ecc();
>   	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
>   		inf->name, fsr, addr);
>   	show_pte(current->mm, addr);
> @@ -593,6 +610,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
>   	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
>   		return;
>   
> +	check_adfsr_for_ecc();
>   	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
>   		inf->name, ifsr, addr);
>   
> 
