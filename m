From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Wed, 7 May 2014 18:44:33 +0000
Subject: [PATCH] ARM: at91: fix rtc irq mask for sam9x5 SoCs
In-Reply-To: <1399479649-3247-1-git-send-email-boris.brezillon@free-electrons.com>
References: <957b209589094df48ddedbc57c6ccdfd@BLUPR05MB037.namprd05.prod.outlook.com>
 <1399479649-3247-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <edaf5835a7b14b9a8c053dcd40f2b591@BLUPR05MB037.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris,

> -----Original Message-----
> From: Boris BREZILLON [mailto:boris.brezillon at free-electrons.com]
> Sent: Wednesday, May 07, 2014 12:21 PM
> To: Bryan Evenson
> Cc: Andrew Victor; Nicolas Ferre; Jean-Christophe Plagniol-Villard; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Boris BREZILLON
> Subject: [PATCH] ARM: at91: fix rtc irq mask for sam9x5 SoCs
> 
> The RTC IMR register is not reliable on sam9x5 SoCs, hence why me have to
> mask all interrupts no matter what IMR claims about already masked irqs.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Reported-by: Bryan Evenson <bevenson@melinkcorp.com>
> ---
> Hello Bryan,
> 
> Yet another patch for you ;-).
> 
> As usual, could you tell me if it fixes your bug.
> 
> BTW, thanks for your tests.
> 
> Best Regards,
> 
> Boris

This fixes the issue on my system.  I disconnected my system from the network to guarantee ntp didn't adjust the time.  I power cycled my system 15 times with the RTC backup battery in place, and each time it booted without issue and the RTC kept the correct time.  Before this patch my system would never complete booting with the RTC battery installed.  I also used my previous test script for the previous patch to verify that I could not lockup access to the RTC.

Tested-by: Bryan Evenson <bevenson@melinkcorp.com>

Regards,
Bryan

> 
>  arch/arm/mach-at91/sysirq_mask.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/sysirq_mask.c b/arch/arm/mach-
> at91/sysirq_mask.c
> index 2ba694f..eb3d2a5 100644
> --- a/arch/arm/mach-at91/sysirq_mask.c
> +++ b/arch/arm/mach-at91/sysirq_mask.c
> @@ -37,12 +37,7 @@ void __init at91_sysirq_mask_rtc(u32 rtc_base)
>  	if (!base)
>  		return;
> 
> -	mask = readl_relaxed(base + AT91_RTC_IMR);
> -	if (mask) {
> -		pr_info("AT91: Disabling rtc irq\n");
> -		writel_relaxed(mask, base + AT91_RTC_IDR);
> -		(void)readl_relaxed(base + AT91_RTC_IMR);	/* flush */
> -	}
> +	writel_relaxed(0x1f, base + AT91_RTC_IDR);
> 
>  	iounmap(base);
>  }
> --
> 1.8.3.2
