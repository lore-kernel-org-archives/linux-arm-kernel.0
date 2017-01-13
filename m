From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Jan 2017 19:21:14 +0000
Subject: [RFC PATCH v2 04/10] arm64: head.S: Enable EL1 (host) access to
 SPE when entered at EL2
In-Reply-To: <1484323429-15231-5-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-5-git-send-email-will.deacon@arm.com>
Message-ID: <110f31fc-4480-6218-0e7c-1576cb5368ba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 16:03, Will Deacon wrote:
> The SPE architecture requires each exception level to enable access
> to the SPE controls for the exception level below it, since additional
> context-switch logic may be required to handle the buffer safely.
> 
> This patch allows EL1 (host) access to the SPE controls when entered at
> EL2.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/head.S | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4b1abac3485a..6a97831dcf3b 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -592,8 +592,8 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
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
> @@ -601,6 +601,16 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
>  4:
>  	csel	x0, xzr, x0, lt			// all PMU counters from EL1
>  	msr	mdcr_el2, x0			// (if they exist)
> +	/* Statistical profiling */
> +	ubfx	x0, x1, #32, #4			// Check ID_AA64DFR0_EL1 PMSVer
> +	cbz	x0, 5f				// Skip if SPE not present
> +	mrs	x0, mdcr_el2			// Preserve HPMN field
> +	cmp	x2, xzr				// If VHE is not enabled,
> +	mov	x1, #3				// use EL1&0 translations,
> +	cinc	x1, x1, ne			// otherwise use EL2 and
> +	bfi	x0, x1, #12, #3			// enable/disable access
> +	msr	mdcr_el2, x0			// traps accordingly.

Man, this hack to set TPMS and E2PB is horrid. It does the trick, but it
took me a couple of minutes to realize what it was doing. Can't we just
have named flags and a some form of conditional select instead? It would
hurt a lot less...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
