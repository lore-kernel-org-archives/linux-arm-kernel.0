From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Aug 2015 11:46:34 +0100
Subject: [PATCH] arm: Handle starting up in secure mode
In-Reply-To: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
References: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
Message-ID: <20150826104634.GB21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 09:55:26AM -0400, Christopher Covington wrote:
> +/*
> + * ARM Linux has the most features available in hypervisor mode and
> + * running in non-secure mode is recommended. Thus, try to get into
> + * hypervisor mode if we're not already there, or failing that, try
> + * to get into non-secure supervisor mode.
> + */
> +ENTRY(__mon_stub_install)
> +	/*
> +	 * Store the mode field of the CPSR in r4 and return early if we're
> +	 * already in hypervisor mode.
> +	 */
> +	mrs	r4, cpsr
> +	and	r4, r4, #MODE_MASK
> +	cmp	r4, #HYP_MODE
> +	reteq	lr
> +
> +	/*
> +	 * Save the link register in a non-banked register, r5, so that we
> +	 * still have access to it after mode switches.
> +	 */
> +	mov	r5, lr
> +
> +	/*
> +	 * Read ID_PFR1 and store the value in r6. This register indicates
> +	 * the presence of the security and virtualization extensions. The
> +	 * former is interesting because we must traverse secure monitor mode
> +	 * to get to hypervisor mode and it allows easy manipulation of
> +	 * exception vectors via the Vector Base Address Register (VBAR).
> +	 *
> +	 * ID_PFR1 also indicates whether the generic timer is present, which
> +	 * has a handy register for our purposes, CNTFRQ. Accesses won't trap
> +	 * even with higher exception levels in AArch64 and writes will only
> +	 * succeed from the highest exception level on a system (the undefined
> +	 * exception from a failed write is used as a branch).
> +	 */
> +
> +	mrc   p15, 0, r6, c0, c1, 1	@ ID_PFR1

As this code can be built into any kernel for a CPU containing a MMU,
including all the way back to ARMv4, you had better make sure that
this code will run there without causing faults.

You should probably be checking the main ID register and ensuring that
the CPU supports the new ID scheme before trying to read CP15 registers
that may not be present in older cores.

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 7c6b976..32fa451 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -676,7 +676,7 @@ config ARM_THUMBEE
>  	  make use of it. Say N for code that can run on CPUs without ThumbEE.
>  
>  config ARM_VIRT_EXT
> -	bool
> +	bool "Support for Virtualization Extensions"

This change is not explained in the commit message.

>  	depends on MMU
>  	default y if CPU_V7
>  	help
> @@ -684,9 +684,21 @@ config ARM_VIRT_EXT
>  	  Extensions to install hypervisors without run-time firmware
>  	  assistance.
>  
> -	  A compliant bootloader is required in order to make maximum
> -	  use of this feature.  Refer to Documentation/arm/Booting for
> -	  details.
> +	  A compliant bootloader or enabling ARM_SEC_EXT is required in
> +	  order to make maximum use of this feature. Refer to
> +	  Documentation/arm/Booting for details.
> +
> +config ARM_SEC_EXT
> +	bool "Support for Security Extensions"
> +	depends on MMU
> +	default n

Please get rid of this redundant "default n".

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
