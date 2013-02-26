From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 26 Feb 2013 17:44:28 +0530
Subject: [PATCH 1/2] time : pass broadcast device parameter
In-Reply-To: <512C9D20.8020309@linaro.org>
References: <5123C299.3080005@linaro.org>
 <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
 <CAKohpomqooF6DzzzdUFByA0wDxQ3RuPne15a9Vy1sScKjZfeyA@mail.gmail.com>
 <512C9D20.8020309@linaro.org>
Message-ID: <CAKohpong=ioMvnWErKQ1gEcG71f5et26EDJFtbsE1SOr=TN_tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2013 17:01, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> Oh, by the way, could send me the patch to set the flag to the timer
> device ? I will include it to the patchset.

Sure. Find it attached too as gmail may break it.

commit 14422c760bb5b2485867f3efb7842d296081ad86
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Feb 22 12:42:39 2013 +0530

    ARM/timer-sp: Set dynamic irq affinity

    When a cpu goes to a deep idle state where its local timer is shutdown, it
    notifies the time frame work to use the broadcast timer instead.

    Unfortunately, the broadcast device could wake up any CPU,
including an idle one
    which is not concerned by the wake up at all.

    This implies, in the worst case, an idle CPU will wake up to send an IPI to
    another idle cpu.

    This patch fixes this for ARM platforms using timer-sp, by setting
    CLOCK_EVT_FEAT_DYNIRQ feature.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/common/timer-sp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 9d2d3ba..ae3c0f9 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -158,7 +158,8 @@ static int sp804_set_next_event(unsigned long next,
 }

 static struct clock_event_device sp804_clockevent = {
-       .features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+       .features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+               CLOCK_EVT_FEAT_DYNIRQ,
        .set_mode       = sp804_set_mode,
        .set_next_event = sp804_set_next_event,
        .rating         = 300,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-timer-sp-Set-dynamic-irq-affinity.patch
Type: application/octet-stream
Size: 1493 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130226/78fd6ceb/attachment.obj>
