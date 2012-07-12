From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 12 Jul 2012 16:33:06 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <1340991231-17682-3-git-send-email-will.deacon@arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
Message-ID: <4FFE7DB2.4040702@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Stephen,

On 6/30/2012 2:33 AM, Will Deacon wrote:
> +void __init init_current_timer_delay(unsigned long freq)
> +{
> +	pr_info("Switching to timer-based delay loop\n");
> +	lpj_fine			= freq / HZ;
> +	arm_delay_ops.delay		= __timer_delay;
> +	arm_delay_ops.const_udelay	= __timer_const_udelay;
> +	arm_delay_ops.udelay		= __timer_udelay;
> +}

Once this function is processed, the udelay() behavior changes
_immediately_ from loop-based delay to timer-based one, without waiting
for 'loops_per_jiffy' itself being corrected in calibrate_delay().

As a result, actual udelay()s may be toooo long than expected, in
particular udelay()s used between init_current_timer_delay() and
calibrate_delay().  It's unlikely be short, as the frequency of a
counter for read_current_timer is typically slower than CPU frequency.

I'm not sure udelay()s used in this period are legitimate, but if it's
there we'll in trouble somehow.  This is not so great.

If this assumption is correct, it might be better to adjust / correct
loops_per_jiffy itself along with lpj_fine, prior to calibrate_delay().

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index cb881c3..9065d30 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -57,7 +57,7 @@ static void __timer_udelay(unsigned long usecs)
 
 void __init init_current_timer_delay(unsigned long freq)
 {
-	lpj_fine			= (freq + HZ/2) / HZ;
+	loops_per_jiffy = lpj_fine	= (freq + HZ/2) / HZ;
 	arm_delay_ops.delay		= __timer_delay;
 	arm_delay_ops.const_udelay	= __timer_const_udelay;
 	arm_delay_ops.udelay		= __timer_udelay;


What do you think?  Am I missing something?

  Shinya
