From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 2 Sep 2014 16:49:24 -0700
Subject: [PATCH] ARM: drop ISAR0 workaround for B15
In-Reply-To: <20140813194047.GA18411@ld-irv-0074>
References: <1407797053-12544-1-git-send-email-gregory.0xf0@gmail.com>
 <20140813194047.GA18411@ld-irv-0074>
Message-ID: <20140902234924.GZ18411@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

Is this worthy of 3.17-rc? Or should it just be queued for 3.18, as it's
only removing redundant info?

On Wed, Aug 13, 2014 at 12:40:47PM -0700, Brian Norris wrote:
> The Brahma-B15's ISAR0 correcty advertises UDIV/SDIV support in both ARM
> and Thumb2 modes (CPUID_EXT_ISAR0=02101110), so we don't need to
> manually apply this hwcap.
> 
> The code in question actually predates the following commit, which made
> our hwcaps unnecessary:
> 
>     commit 8164f7af88d9ad3a757bd14f634b23997ee77f6b
>     Author: Stephen Boyd <sboyd@codeaurora.org>
>     Date:   Mon Mar 18 19:44:15 2013 +0100
> 
>         ARM: 7680/1: Detect support for SDIV/UDIV from ISAR0 register
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> Supersedes Gregory's previous patch.
> 
> This addresses some very old review comments from Mark and Will:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/225895.html
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/227916.html
> 
>  arch/arm/mm/proc-v7.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index b5d67db20897..b3a947863ac7 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -570,7 +570,7 @@ __v7_ca15mp_proc_info:
>  __v7_b15mp_proc_info:
>  	.long	0x420f00f0
>  	.long	0xff0ffff0
> -	__v7_proc __v7_b15mp_setup, hwcaps = HWCAP_IDIV
> +	__v7_proc __v7_b15mp_setup
>  	.size	__v7_b15mp_proc_info, . - __v7_b15mp_proc_info
>  
>  	/*
