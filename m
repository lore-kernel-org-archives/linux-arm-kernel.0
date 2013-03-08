From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 07 Mar 2013 17:14:01 -0800
Subject: [PATCH 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <20130308004011.GD11806@atomide.com>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-4-git-send-email-sboyd@codeaurora.org>
 <20130308004011.GD11806@atomide.com>
Message-ID: <51393B59.3070200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/13 16:40, Tony Lindgren wrote:
> Hi,
>
> * Stephen Boyd <sboyd@codeaurora.org> [130306 17:53]:
>> Separate the smp_twd timers from the local timer API. This will
>> allow us to remove ARM local timer support in the near future and
>> gets us closer to moving this driver to drivers/clocksource.
> Looks like applying this patch makes omap4 to stop booting for
> some reason.
>
>

Hm... Perhaps you need the clock?

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 2439843..081de6f 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -345,11 +345,11 @@ static int __init twd_local_timer_common_register(struct device_node *np)
        if (err)
                goto out_irq;
 
+       twd_get_clock(np);
+
        /* Immediately configure the timer on the boot CPU */
        twd_timer_setup(this_cpu_ptr(twd_evt));
 
-       twd_get_clock(np);
-
        return 0;
 
 out_irq:

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
