From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jul 2012 00:38:29 +0100
Subject: [RFC v2] ARM: sched_clock: update epoch_cyc on resume
In-Reply-To: <CACRpkdZv4p+QT3Y+=-xh5iJ=sr1_aahroxQ535QpzVD9e_ESJA@mail.gmail.com>
References: <1343184588-20239-1-git-send-email-ccross@android.com>
 <CACRpkdZv4p+QT3Y+=-xh5iJ=sr1_aahroxQ535QpzVD9e_ESJA@mail.gmail.com>
Message-ID: <20120727233829.GB14835@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 01:32:50AM +0200, Linus Walleij wrote:
> On Wed, Jul 25, 2012 at 4:49 AM, Colin Cross <ccross@android.com> wrote:
> 
> > Many clocks that are used to provide sched_clock will reset during
> > suspend.  If read_sched_clock returns 0 after suspend, sched_clock will
> > appear to jump forward.  This patch resets cd.epoch_cyc to the current
> > value of read_sched_clock during resume, which causes sched_clock() just
> > after suspend to return the same value as sched_clock() just before
> > suspend.
> >
> > In addition, during the window where epoch_ns has been updated before
> > suspend, but epoch_cyc has not been updated after suspend, it is unknown
> > whether the clock has reset or not, and sched_clock() could return a
> > bogus value.  Add a suspended flag, and return the pre-suspend epoch_ns
> > value during this period.
> >
> > The new behavior is triggered by calling setup_sched_clock_needs_suspend
> > instead of setup_sched_clock.
> >
> > Signed-off-by: Colin Cross <ccross@android.com>
> 
> Sweet!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Have any of you looked at the patch I originally posted for doing this?
It needs updating but shows the overall principle - which is to ensure
that the epoch is up to date before suspending.

It doesn't deal with resume, because different timers behave differently,
and there's no real way to deal with that properly.  The important thing
that this patch does is to ensure sched_clock() doesn't ever go backwards.

 arch/arm/kernel/sched_clock.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..4be4019 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -10,6 +10,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/syscore_ops.h>
 #include <linux/timer.h>
 
 #include <asm/sched_clock.h>
@@ -72,3 +73,20 @@ void __init sched_clock_postinit(void)
 {
 	sched_clock_poll(sched_clock_timer.data);
 }
+
+static int sched_clock_suspend(void)
+{
+	sched_clock_poll(sched_clock_timer.data);
+	return 0;
+}
+
+static struct syscore_ops sched_clock_ops = {
+	.suspend	= sched_clock_suspend,
+};
+
+static int __init sched_clock_syscore_init(void)
+{
+	register_syscore_ops(&sched_clock_ops);
+	return 0;
+}
+device_initcall(sched_clock_syscore_init);
