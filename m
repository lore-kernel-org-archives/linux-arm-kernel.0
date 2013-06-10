From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Jun 2013 11:39:27 -0700
Subject: [PATCH] arm: versatile: don't mark pen as __INIT
In-Reply-To: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
References: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
Message-ID: <51B61D5F.1090906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/13 08:07, Mark Rutland wrote:
> When booting fewer cores than are physically present on a versatile
> platform (e.g. when passing maxcpus=N on the command line), some
> secondary cores may remain in the holding pen, which is marked __INIT.
> Late in the boot process, the memory comprising the holding pen will be
> released to the kernel for more general use, and may be overwritten with
> arbitrary data, which can cause the held secondaries to start behaving
> unpredictably. This can lead to all manner of odd behaviour from the
> kernel.
>
> Instead don't mark the section as __INIT. This means we can't reuse the
> pen memory, but we won't get secondaries corrupting the rest of the
> kernel.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/plat-versatile/headsmp.S | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
> index b178d44..2677bc3 100644
> --- a/arch/arm/plat-versatile/headsmp.S
> +++ b/arch/arm/plat-versatile/headsmp.S
> @@ -11,8 +11,6 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  
> -	__INIT
> -
>  /*
>   * Realview/Versatile Express specific entry point for secondary CPUs.
>   * This provides a "holding pen" into which all secondary cores are held

Why doesn't __CPUINIT work?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
