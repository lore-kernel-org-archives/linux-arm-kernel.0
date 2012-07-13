From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2012 12:13:37 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FFE7DB2.4040702@renesas.com>
 <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
Message-ID: <20120713111337.GH18079@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 11:48:25AM +0100, Shilimkar, Santosh wrote:
> Wiil,

Hi Saantosh :),

> On Fri, Jul 13, 2012 at 2:27 PM, Will Deacon <will.deacon@arm.com> wrote:
> > That should work, providing you can get a sensible initial estimate for
> > loops_per_jiffy.
> >
> Do you have an updated version of the patch ?

I was anticipating that the platform would set the initial loops_per_jiffy
value if it requires udelays before loop calibration and the default of 4k
is wildly off.

If people need loops_per_jiffy to be updated at the same time as lpj_fine,
I can post that as a separate patch (below) as Russell has merged v2 of these
patches into his delay branch. That said, I'd certainly like to know if this
is actually a real problem (and can't be solved by choosing a compromise value
as the initial loops_per_jiffy). I think Shinya was doing some tests so
I'll wait to see how those went.

Will

---8<---

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index d6dacc6..395d5fb 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -59,6 +59,7 @@ void __init init_current_timer_delay(unsigned long freq)
 {
        pr_info("Switching to timer-based delay loop\n");
        lpj_fine                        = freq / HZ;
+       loops_per_jiffy                 = lpj_fine;
        arm_delay_ops.delay             = __timer_delay;
        arm_delay_ops.const_udelay      = __timer_const_udelay;
        arm_delay_ops.udelay            = __timer_udelay;
