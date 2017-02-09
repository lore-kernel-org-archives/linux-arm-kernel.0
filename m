From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Feb 2017 18:26:26 +0000
Subject: [PATCH 04/10] arm64: head.S: Enable EL1 (host) access to SPE
 when entered at EL2
In-Reply-To: <1485540470-11469-5-git-send-email-will.deacon@arm.com>
References: <1485540470-11469-1-git-send-email-will.deacon@arm.com>
 <1485540470-11469-5-git-send-email-will.deacon@arm.com>
Message-ID: <20170209182626.GA26879@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 06:07:43PM +0000, Will Deacon wrote:
> The SPE architecture requires each exception level to enable access
> to the SPE controls for the exception level below it, since additional
> context-switch logic may be required to handle the buffer safely.
> 
> This patch allows EL1 (host) access to the SPE controls when entered at
> EL2.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/head.S | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4b1abac3485a..7f625d2e8e45 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -592,15 +592,26 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
>  #endif
>  
>  	/* EL2 debug */
> -	mrs	x0, id_aa64dfr0_el1		// Check ID_AA64DFR0_EL1 PMUVer
> -	sbfx	x0, x0, #8, #4
> +	mrs	x1, id_aa64dfr0_el1		// Check ID_AA64DFR0_EL1 PMUVer
> +	sbfx	x0, x1, #8, #4
>  	cmp	x0, #1
>  	b.lt	4f				// Skip if no PMU present
>  	mrs	x0, pmcr_el0			// Disable debug access traps
>  	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
>  4:
> -	csel	x0, xzr, x0, lt			// all PMU counters from EL1
> -	msr	mdcr_el2, x0			// (if they exist)
> +	csel	x3, xzr, x0, lt			// all PMU counters from EL1
> +
> +	/* Statistical profiling */
> +	ubfx	x0, x1, #32, #4			// Check ID_AA64DFR0_EL1 PMSVer
> +	cbz	x0, 6f				// Skip if SPE not present
> +	cbnz	x2, 5f				// VHE?
> +	mov	x1, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
> +	orr	x3, x3, x1			// If we don't have VHE, then
> +	b	6f				// use EL1&0 translation.
> +5:						// For VHE, use EL2 translation
> +	orr	x3, x3, #MDCR_EL2_TPMS		// and disable access from EL1
> +6:
> +	msr	mdcr_el2, x3			// Configure debug traps
>  
>  	/* Stage-2 translation */
>  	msr	vttbr_el2, xzr
> -- 
> 2.1.4
> 
