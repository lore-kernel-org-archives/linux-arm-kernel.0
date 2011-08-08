From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 08 Aug 2011 10:33:38 -0700
Subject: [PATCH 4/6] ARM: smp: set thread_info->cpu to hardware CPU number
	for boot thread
In-Reply-To: <1312823424-9654-5-git-send-email-will.deacon@arm.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
	<1312823424-9654-5-git-send-email-will.deacon@arm.com>
Message-ID: <4E401DF2.10801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2011 10:10 AM, Will Deacon wrote:
>
>  
> +void __init smp_setup_processor_id(void)
> +{
> +	u32 mpidr;
> +
> +	/* Read the MPIDR to find the hardware ID of the current CPU. */
> +	asm("1:		mrc	p15, 0, %0, c0, c0, 5\n"
> +	    "		.pushsection \".alt.smp.init\", \"a\"\n"
> +	    "		.long	1b\n"
> +	    "		mov	%0, #0\n"
> +	    "		.popsection"
> +	    : "=r" (mpidr));

Would it be a good idea to put this into asm/cputype.h? I suppose the
smp alternatives part would need to be written in C.

    mpidr = is_smp() ? read_cpuid_mpidr() : 0;

>
> +
> +	current_thread_info()->cpu = mpidr & 0xff;
> +	printk("Booting Linux on CPU %d\n", current_thread_info()->cpu);
> +}
> +

Should there be a KERN_INFO there?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
