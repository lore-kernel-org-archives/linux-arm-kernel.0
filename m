From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Sep 2015 18:22:09 +0100
Subject: [PATCH] arm64: head.S: initialise mdcr_el2 in el2_setup
In-Reply-To: <1442249935-13277-1-git-send-email-will.deacon@arm.com>
References: <1442249935-13277-1-git-send-email-will.deacon@arm.com>
Message-ID: <55F70241.20903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/15 17:58, Will Deacon wrote:
> When entering the kernel at EL2, we fail to initialise the MDCR_EL2
> register which controls debug access and PMU capabilities at EL1.
> 
> This patch ensures that the register is initialised so that all traps
> are disabled and all the PMU counters are available to the host. When a
> guest is scheduled, KVM takes care to configure trapping appropriately.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/head.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index a055be6125cf..90d09eddd5b2 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -523,6 +523,11 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
>  	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
>  #endif
>  
> +	/* EL2 debug */
> +	mrs	x0, pmcr_el0			// Disable debug access traps
> +	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
> +	msr	mdcr_el2, x0			// all PMU counters from EL1
> +
>  	/* Stage-2 translation */
>  	msr	vttbr_el2, xzr
>  
> 

Ah! I guess we've been quite lucky so far... FWIW:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I guess you'll merge this via the arm64 tree?

	M.
-- 
Jazz is not dead. It just smells funny...
