From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Jul 2012 11:19:41 -0700
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
 <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
Message-ID: <5016D03D.8010607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/12 23:34, Kukjin Kim wrote:
> Stephen Boyd wrote:
>> Great. Kukjin Kim, can exynos use SGI0? It looks like exynos is the only
>> one left to move to SGI0.
>>
> Yeah, EXYNOS can use SGI0 instead of SGI1 :)
>
>

Russell, can we apply something like this?

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 36c3984..090e32b 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -139,7 +139,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		__raw_writel(virt_to_phys(exynos4_secondary_startup),
 			CPU1_BOOT_REG);
-		gic_raise_softirq(cpumask_of(cpu), 1);
+		gic_raise_softirq(cpumask_of(cpu), 0);
 
 		if (pen_release == -1)
 			break;


I see we have another user of SGI1. Magnus/Rafael, can we move
smp-emev2.c to use SGI0 instead of SGI1?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
