From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Oct 2012 15:53:29 -0700
Subject: [PATCH 1/7] ARM: hw_breakpoint: only clear OS lock when
 implemented on v7
In-Reply-To: <1350487901-3108-2-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
 <1350487901-3108-2-git-send-email-will.deacon@arm.com>
Message-ID: <50887169.4060209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/12 08:31, Will Deacon wrote:
> The OS save and restore register are optional in debug architecture v7,
> so check the status register before attempting to clear the OS lock.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

> ---
>  arch/arm/kernel/hw_breakpoint.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index 281bf33..ec16ada 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -929,6 +929,13 @@ static void reset_ctrl_regs(void *unused)
>  		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (dbg_power));
>  		if ((dbg_power & 0x1) == 0)
>  			err = -EPERM;
> +
> +		/*
> +		 * Check whether we implement OS save and restore.
> +		 */
> +		asm volatile("mrc p14, 0, %0, c1, c1, 4" : "=r" (dbg_power));

minor nit for this series. dbg_power has become a catch-all variable in
this code. It would be nice if we named the variables used to hold the
read register the same as the register or if we made the name of the
variable generic like 'val'.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
