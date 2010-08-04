From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 03 Aug 2010 17:51:34 -0700
Subject: hotplug and init section
In-Reply-To: <20100803230541.GA30769@n2100.arm.linux.org.uk>
References: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>	<20100722205753.GU31293@n2100.arm.linux.org.uk>	<4C5898AD.9020300@codeaurora.org>
	<20100803230541.GA30769@n2100.arm.linux.org.uk>
Message-ID: <4C58B996.3000601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Try this - I've only build-tested this so far:
>
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index b9505aa..98949b2 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -143,7 +143,7 @@ __error:
>  	b	1b
>  ENDPROC(__error)
>  
> -
> +	__CPUINIT
>  /*
>   * Read processor ID register (CP#15, CR0), and look up in the linker-built
>   * supported processor list.  Note that we can't use the absolute addresses
> @@ -235,6 +235,7 @@ ENTRY(lookup_machine_type)
>  	ldmfd	sp!, {r4 - r6, pc}
>  ENDPROC(lookup_machine_type)
>  
> +	__HEAD
>  /* Determine validity of the r2 atags pointer.  The heuristic requires
>   * that the pointer be aligned, in the first 16k of physical RAM and
>   * that the ATAG_CORE marker is first and present.  Future revisions
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index eb62bf9..7e0a673 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -104,6 +104,7 @@ ENTRY(stext)
>  ENDPROC(stext)
>  
>  #if defined(CONFIG_SMP)
> +	__CPUINIT
>  ENTRY(secondary_startup)
>  	/*
>  	 * Common entry point for secondary CPUs.
> @@ -202,7 +203,7 @@ __turn_mmu_on:
>  	mov	pc, r3
>  ENDPROC(__turn_mmu_on)
>  
> -
> +	__HEAD
>  /*
>   * Setup the initial page tables.  We only setup the barest
>   * amount which are required to get the kernel running, which
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>   
This doesn't boot for me, I will look into it further. I am using a 
2.6.32 kernel, but I think commit 
a1c29fa34b6be6b7c1d9075f4057c3995c993e8c or  "ARM: convert to use __HEAD 
and HEAD_TEXT macros" should be sufficient.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
