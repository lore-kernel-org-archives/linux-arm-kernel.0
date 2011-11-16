From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Nov 2011 10:20:08 -0800
Subject: [PATCH v6 3/5] ARM: soft_restart: disable the outer L2 when the
 last CPU is going down
In-Reply-To: <1321466057-19721-4-git-send-email-will.deacon@arm.com>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
 <1321466057-19721-4-git-send-email-will.deacon@arm.com>
Message-ID: <4EC3FED8.7000307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/11 09:54, Will Deacon wrote:
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 577d092..664d351 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -137,6 +137,10 @@ void soft_restart(unsigned long addr)
>  	local_irq_disable();
>  	local_fiq_disable();
>  
> +	/* Disable the L2 if we're the last man standing. */
> +	if (num_online_cpus() == 1)
> +		outer_disable();
> +

When does this code execute on another cpu? My understanding is that
soft_restart() is only called on one CPU so I would think checking the
number of online cpus isn't necessary.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
