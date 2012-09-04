From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 04 Sep 2012 10:11:51 -0700
Subject: [PATCH v2 2/2] ARM: delay: add registration mechanism for delay
 timer sources
In-Reply-To: <20120904104403.GE2458@mudshark.cambridge.arm.com>
References: <1346275524-13817-1-git-send-email-will.deacon@arm.com>
 <1346275524-13817-2-git-send-email-will.deacon@arm.com>
 <503FFC7D.9050704@codeaurora.org>
 <20120904100750.GC2458@mudshark.cambridge.arm.com>
 <20120904104403.GE2458@mudshark.cambridge.arm.com>
Message-ID: <50463657.1070109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/12 03:44, Will Deacon wrote:
> On Tue, Sep 04, 2012 at 11:07:50AM +0100, Will Deacon wrote:
>> On Fri, Aug 31, 2012 at 12:51:25AM +0100, Stephen Boyd wrote:
>>>> +void __init register_current_timer_delay(struct delay_timer *timer)
>>> const?
>> Sure. I'll send an updated patch.
> Gah, spoke too soon. This isn't going to work, as the frequency may not be
> known until probe time (for example, it could be obtained by the device
> tree) so const data isn't going to cut it.
>

That's fine. We can still do const can't we? I was suggesting you make
the argument const and not the data in arch_timer.c const. This way we
can be sure that delay.c isn't going to muck with the struct, but the
ones who register the struct can fill it in at runtime.

Squash this in and test compile?

----8<------

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index 50928e8..ab98fdd 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -63,7 +63,7 @@ extern void __loop_const_udelay(unsigned long);
 
 /* Delay-loop timer registration. */
 #define ARCH_HAS_READ_CURRENT_TIMER
-extern void register_current_timer_delay(struct delay_timer *timer);
+extern void register_current_timer_delay(const struct delay_timer *timer);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index fe6f4fb..e868ef0 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -34,7 +34,7 @@ struct arm_delay_ops arm_delay_ops = {
        .udelay         = __loop_udelay,
 };
 
-static struct delay_timer *delay_timer;
+static const struct delay_timer *delay_timer;
 static bool delay_calibrated;
 
 int read_current_timer(unsigned long *timer_val)
@@ -62,7 +62,7 @@ static void __timer_udelay(unsigned long usecs)
        __timer_const_udelay(usecs * UDELAY_MULT);
 }
 
-void __init register_current_timer_delay(struct delay_timer *timer)
+void __init register_current_timer_delay(const struct delay_timer *timer)
 {
        if (!delay_calibrated) {
                pr_info("Switching to timer-based delay loop\n");

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
