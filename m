From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 29 Oct 2018 15:54:36 +0000
Subject: [PATCH] arm: mm: fault: check ADFSR in case of abort
In-Reply-To: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
Message-ID: <20181029155435.prz2htt4ktte7pxb@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 02:20:51PM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
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
> 
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>  arch/arm/mm/fault.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 3232afb6fdc0..5e240deb6ed6 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -547,6 +547,22 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
>  	fsr_info[nr].name = name;
>  }
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
>  /*
>   * Dispatch a data abort to the relevant handler.
>   */
> @@ -559,6 +575,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
>  		return;
>  
> +	check_adfsr_for_ecc();
>  	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
>  		inf->name, fsr, addr);
>  	show_pte(current->mm, addr);
> @@ -593,6 +610,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
>  	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
>  		return;
>  
> +	check_adfsr_for_ecc();
>  	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
>  		inf->name, ifsr, addr);

IIUC at this point the task is preemptible (and interruptible), so I
believe this is too late to snapshot the ADFSR. The task could have been
migrated to a different core, with an irrelavant ADFSR, or a fault could
have occured within an interrupt handler, etc.

Thanks,
Mark.
