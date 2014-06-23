From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 23 Jun 2014 13:47:55 -0700
Subject: [PATCHv5 2/2] arm: Get rid of meminfo
In-Reply-To: <20140623091754.GD14781@pengutronix.de>
References: <1396544698-15596-1-git-send-email-lauraa@codeaurora.org>
 <1396544698-15596-3-git-send-email-lauraa@codeaurora.org>
 <20140623091754.GD14781@pengutronix.de>
Message-ID: <53A8927B.3020409@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the report.

On 6/23/2014 2:17 AM, Uwe Kleine-K?nig wrote:
> This patch is in 3.16-rc1 as 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76
> now.
> 
> Unfortunately it makes my efm32 machine unbootable.
> 
> With earlyprintk enabled I get the following output:
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.15.0-rc1-00028-g1c2f87c22566-dirty (ukleinek at perseus) (gcc version 4.7.2 (OSELAS.Toolchain-2012.12.1) ) #280 PREEMPT Mon Jun 23 11:05:34 CEST 2014
> [    0.000000] CPU: ARMv7-M [412fc231] revision 1 (ARMv7M), cr=00000000
> [    0.000000] CPU: unknown data cache, unknown instruction cache
> [    0.000000] Machine model: Energy Micro Giant Gecko Development Kit
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] On node 0 totalpages: 1024
> [    0.000000] free_area_init_node: node 0, pgdat 880208f4, node_mem_map 00000000
> [    0.000000]   Normal zone: 3840 pages exceeds freesize 1024

This looks off. The number of pages for the memmap exceeds the available free
size. Working backwards, I think the wrong bounds are being calculated in
find_limits in arch/arm/mm/init.c . max_low is now calculated via the current
limit but nommu never sets a limit unlike the mmu case. Can you try the
following patch and see if it fixes the issue? If this doesn't work, can
you share working bootup logs so I can do a bit more compare and contrast?

Thanks,
Laura

---8<----
>From 9b19241d577caf91928e26e55413047d1be90feb Mon Sep 17 00:00:00 2001
From: Laura Abbott <lauraa@codeaurora.org>
Date: Mon, 23 Jun 2014 13:26:56 -0700
Subject: [PATCH] arm: Set memblock limit for nommu

Commit 1c2f87c (ARM: 8025/1: Get rid of meminfo) changed find_limits
to use memblock_get_current_limit for calculating the max_low pfn.
nommu targets never actually set a limit on memblock though which
means memblock_get_current_limit will just return the default
value. Set the memblock_limit to be the end of DDR to make sure
bounds are calculated correctly.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/nommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index da1874f..a014dfa 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -300,6 +300,7 @@ void __init sanity_check_meminfo(void)
        sanity_check_meminfo_mpu();
        end = memblock_end_of_DRAM();
        high_memory = __va(end - 1) + 1;
+       memblock_set_current_limit(end);
 }
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
