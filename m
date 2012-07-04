From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2012 16:36:24 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <4FF2E0FB.4040008@renesas.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FF2E0FB.4040008@renesas.com>
Message-ID: <20120704153624.GI15104@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 01:09:31PM +0100, Shinya Kuribayashi wrote:
> Hello,

Hi Shinya,

> Looking at init/calibrate.c, 'lpj_fine' can save the first loop
> calibration, but does not save the second and subsequent calls to
> calibrate_delay().
> 
> Magnus first noticed this, and changed to use 'preset_lpj' instead.
> See the commit 173bf69a7a (ARM / mach-shmobile: Use preset_lpj with
> calibrate_delay(), 2012-05-10).
> 
> If we use 'lpj_fine' for this, we need to skip secondary CPU calibration
> explicitly in another way, something like this:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/039506.html
> [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up boot

How about keeping it simple like this:?


diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index e1030e1..84bb5da 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -63,4 +63,9 @@ void __init init_current_timer_delay(unsigned long freq)
        arm_delay_ops.const_udelay      = __timer_const_udelay;
        arm_delay_ops.udelay            = __timer_udelay;
 }
+
+unsigned long __cpuinit calibrate_delay_is_known(void)
+{
+       return lpj_fine ?: 0;
+}
 #endif


Will
