From: michal.wrobel@flytronic.pl (=?UTF-8?B?TWljaGHFgiBXcsOzYmVs?=)
Date: Tue, 14 Feb 2012 10:55:05 +0100
Subject: [PATCH RESEND] ixp4xx: clockevent set_next_event fix
In-Reply-To: <4F394D3B.3080909@flytronic.pl>
References: <4F394D3B.3080909@flytronic.pl>
Message-ID: <4F3A2F79.6050806@flytronic.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IXP43x Developer's Manual [17.4.3] and IXP4[56]x Developer's Manual
[18.4.3] say that for predictable operation the timer needs to be
stopped before writing a new value into the reload register. Indeed,
tests on IXP435 show that writing a new value into the reload register
without stopping the timer first has no immediate effect on the timer.
This makes hrtimers started through hrtimer_start() to be delayed until
the currently earliest hrtimer expires.

IXP42x Developer's Manual [14.3] says that the timer will be reloaded
immediately on setting the timer reload register, so the bug probably
doesn't occur on those CPUs. However, stopping the timer shouldn't have
any negative side effects, so it should be safe to apply it
machine-wide.

Signed-off-by: Micha? Wr?bel <michal.wrobel@flytronic.pl>
---
 arch/arm/mach-ixp4xx/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

The previous patch had a mistake in the description - wrong reference to
"General-Purpose Timers" section in IXP42x Developer's Manual.

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 3841ab4..fd37c83 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -434,6 +434,7 @@ static int ixp4xx_set_next_event(unsigned long evt,
 {
 	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
 
+	*IXP4XX_OSRT1 = 0;
 	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | opts;
 
 	return 0;
-- 
1.7.5.4
