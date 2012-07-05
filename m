From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Jul 2012 17:32:56 -0300
Subject: MX28 poweroff issue
In-Reply-To: <201207051823.26243.marex@denx.de>
References: <201207040030.36713.marex@denx.de>
 <20120704151944.GB18739@n2100.arm.linux.org.uk>
 <20120705160855.GA20175@S2101-09.ap.freescale.net>
 <201207051823.26243.marex@denx.de>
Message-ID: <CAOMZO5DDhhZ4WV9Gweb+rYASE8D-KyX7Q6FCQyKbqcVzfOcBMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Jul 5, 2012 at 1:23 PM, Marek Vasut <marex@denx.de> wrote:

> Won't mdelay() be better?
>
> It removes the warning, but can't some other stray interrupt trigger it again?

Could you please try the change below? I do not have access to my mx28
right now.

diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
index 02d36de..6c7f81e 100644
--- a/arch/arm/mach-mxs/timer.c
+++ b/arch/arm/mach-mxs/timer.c
@@ -149,6 +149,9 @@ static const char *clock_event_mode_label[] const = {
 static void mxs_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	/* Disable interrupt in timer module */
 	timrot_irq_disable();

@@ -173,13 +176,16 @@ static void mxs_set_mode(enum clock_event_mode mode,

 	/* Remember timer mode */
 	mxs_clockevent_mode = mode;
+	local_irq_restore(flags);

 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		pr_err("%s: Periodic mode is not implemented\n", __func__);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
+		local_irq_save(flags);
 		timrot_irq_enable();
+		local_irq_restore(flags);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
--
