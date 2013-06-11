From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Jun 2013 11:04:57 +0100
Subject: [GIT PULL] arm: arch_timer cleanups and niceties for 3.11
In-Reply-To: <20130607173902.GJ23311@e106331-lin.cambridge.arm.com>
References: <20130607173902.GJ23311@e106331-lin.cambridge.arm.com>
Message-ID: <20130611100457.GB22334@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 06:39:02PM +0100, Mark Rutland wrote:
> Hi Russell,
> 
> Please pull these arch_timer cleanups I've been holding onto for a while.
> They're the same as my last posting [1], but have been rebased to v3.10-rc3.
> 
> Thanks,
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170602.html

It looks like there was a final ARM_ARCH_TIMER select in multi_v7_defconfig
that's causing architected timer support to not get selected, which the patch
below should fix if appended to the series. I've grepped for ARM_ARCH_TIMER,
and it looks like it's the the last remaining occurence.

Thanks,
Mark.

---->8----
>From 6f09d5692133723c47629b89662bd01467aa526f Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 11 Jun 2013 10:51:35 +0100
Subject: [PATCH] arm: multi_v7_defconfig: select HAVE_ARM_ARCH_TIMER

In 8a4da6e: "arm: arch_timer: move core to drivers/clocksource", the
selection of ARM_ARCH_TIMER was indirected via HAVE_ARM_ARCH_TIMER,
though multi_v7_defconfig wasn't fixed up. This can lead to architected
timer support being unexpectedly disabled when building
multi_v7_defconfig.

This patch fixes up multi_v7_defconfig to select HAVE_ARM_ARCH_TIMER.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2e67a27..c5bdbc9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -17,7 +17,7 @@ CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 CONFIG_SMP=y
-CONFIG_ARM_ARCH_TIMER=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_HIGHPTE=y
-- 
1.8.1.1
