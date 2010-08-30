From: robert.richter@amd.com (Robert Richter)
Date: Mon, 30 Aug 2010 11:09:29 +0200
Subject: [PATCH 3/3] x86: oprofile: fix oprofile_arch_init behaviour on
	failure
In-Reply-To: <1283107921-21464-4-git-send-email-will.deacon@arm.com>
References: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
	<1283107921-21464-2-git-send-email-will.deacon@arm.com>
	<1283107921-21464-3-git-send-email-will.deacon@arm.com>
	<1283107921-21464-4-git-send-email-will.deacon@arm.com>
Message-ID: <20100830090929.GU22783@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.08.10 14:52:01, Will Deacon wrote:
> The OProfile driver no longer calls oprofile_arch_exit when
> oprofile_arch_init return failure.
> 
> This patch fixes the x86 implementation of oprofile_arch_init
> to ensure that op_nmi_exit is called if necessary.
> 
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/x86/oprofile/init.c |   26 +++++++++++++++-----------
>  1 files changed, 15 insertions(+), 11 deletions(-)
> 

>  int __init oprofile_arch_init(struct oprofile_operations *ops)
>  {
>  	int ret;
>  
> -	ret = -ENODEV;
> -
> -#ifdef CONFIG_X86_LOCAL_APIC
>  	ret = op_nmi_init(ops);
> -#endif
> -#ifdef CONFIG_X86_IO_APIC
>  	if (ret < 0)
> +#ifdef CONFIG_X86_IO_APIC
>  		ret = op_nmi_timer_init(ops);
> +#else
> +		return ret;
>  #endif
> +
>  	ops->backtrace = x86_backtrace;
>  
> +	if (ret < 0)
> +		op_nmi_exit();
> +

I don't see why we have to do this. All init functions above clean up
properly on failure. If op_nmi_init() succeeds we don't call
op_nmi_timer_init(), so we don't need to free it it either.

-Robert

>  	return ret;
>  }

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
