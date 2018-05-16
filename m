From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 16 May 2018 12:33:54 +0100
Subject: [PATCH 06/14] ARM: spectre-v2: harden branch predictor on context
 switches
In-Reply-To: <E1fIuBA-0003pt-00@rmk-PC.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuBA-0003pt-00@rmk-PC.armlinux.org.uk>
Message-ID: <0ddd02c0-0af6-e89a-e6ea-b2bd1290dfaf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/18 12:01, Russell King wrote:
>  __v7_cr7mp_proc_info:
>  	.long	0x410fc170
>  	.long	0xff0ffff0
> -	__v7_proc __v7_cr7mp_proc_info, __v7_cr7mp_setup
> +	__v7_proc __v7_cr7mp_proc_info, __v7_cr7mp_setup, proc_fns = HARDENED_BPIALL_PROCESSOR_FUNCTIONS
>  	.size	__v7_cr7mp_proc_info, . - __v7_cr7mp_proc_info
>  
>  	/*
> @@ -649,7 +700,7 @@ ENDPROC(__v7_setup)
>  __v7_cr8mp_proc_info:
>  	.long	0x410fc180
>  	.long	0xff0ffff0
> -	__v7_proc __v7_cr8mp_proc_info, __v7_cr8mp_setup
> +	__v7_proc __v7_cr8mp_proc_info, __v7_cr8mp_setup, proc_fns = HARDENED_BPIALL_PROCESSOR_FUNCTIONS
>  	.size	__v7_cr8mp_proc_info, . - __v7_cr8mp_proc_info

For R-class cores, the mitigation doesn't make much sense since we do not enforce user/kernel
isolation anyway. I believe the same also applies to A-class cores built with !MMU, so you might
want to guard CPU_SPECTRE with MMU in PATCH 05/14.

Cheers
Vladimir
