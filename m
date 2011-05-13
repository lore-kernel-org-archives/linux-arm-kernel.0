From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 13 May 2011 12:02:13 +0200 (CEST)
Subject: [PATCH] ARM: twd: Adjust localtimer frequency withcpufreqnotifiers
In-Reply-To: <BANLkTi=-T6P0KrsQ8+Ot_inq1JabY62LvA@mail.gmail.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com>
	<AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com>
	<4D70BE9D.4000507@stericsson.com>
	<AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com>
	<4D714C17.7080102@gmail.com>
	<AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com>
	<eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
	<AANLkTi=KcmqmghVxhwGvv79heRU3C+TC-v2VnWSWt7bU@mail.gmail.com>
	<7e9fafa016bfe536ccc373fc2cc7ba61@mail.gmail.com>
	<AANLkTinRNG4nTjh15a2tuJt_iDboHUtomxemSjY+6DcD@mail.gmail.com>
	<AANLkTikkcYw66MiJO9Bpm+De=XD2-1MFxm-CUPp6sMqL@mail.gmail.com>
	<BANLkTi=-T6P0KrsQ8+Ot_inq1JabY62LvA@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1105131138460.2831@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 May 2011, Linus Walleij wrote:

> 2011/3/6 Linus Walleij <linus.walleij@linaro.org>:
> > On Sun, Mar 6, 2011 at 6:42 PM, Colin Cross <ccross@android.com> wrote:
> >
> >> Is there any way
> >> for a clockevent to invalidate the current event and ask for it to be
> >> reprogrammed?
> >
> > TGLX will know for sure... Thomas?
> >
> > (This is inside a CPUfreq hook for a localtimer for the record.)
> 
> I discussed this briefly with TGLX at the UDS here and he's confident
> we could add some nifty feature to reprogram an event. I dare not
> try to guess where the code would sit or how it'd look...

Does the following work for you ?

Thanks,

	tglx

---------->
Subject: clock-ev-reconf.patch
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 May 2011 10:53:13 +0200

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/clockchips.h |    2 ++
 kernel/time/clockevents.c  |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

Index: linux-2.6/include/linux/clockchips.h
===================================================================
--- linux-2.6.orig/include/linux/clockchips.h
+++ linux-2.6/include/linux/clockchips.h
@@ -132,6 +132,8 @@ extern int clockevents_program_event(str
 
 extern void clockevents_handle_noop(struct clock_event_device *dev);
 
+extern int clockevents_reconfigure(struct clock_event_device *ce, u32 freq, u32 minsec);
+
 static inline void
 clockevents_calc_mult_shift(struct clock_event_device *ce, u32 freq, u32 minsec)
 {
Index: linux-2.6/kernel/time/clockevents.c
===================================================================
--- linux-2.6.orig/kernel/time/clockevents.c
+++ linux-2.6/kernel/time/clockevents.c
@@ -133,6 +133,30 @@ int clockevents_program_event(struct clo
 }
 
 /**
+ * clockevents_reconfigure - Reconfigure and reprogram a clock event device.
+ * @dev:	device to modify
+ * @freq:	new device frequency
+ * @secr:	guaranteed runtime conversion range in seconds
+ *
+ * Reconfigure and reprogram a clock event device in oneshot
+ * mode. Must only be called from low level idle code where
+ * interaction with hrtimers/nohz code etc. is not possible and
+ * guaranteed not to conflict. Must be called with interrupts
+ * disabled!
+ * Returns 0 on success, -ETIME when the event is in the past or
+ * -EINVAL when called with invalid parameters.
+ */
+int clockevents_reconfigure(struct clock_event_device *dev, u32 freq, u32 secr)
+{
+	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
+		return -EINVAL;
+
+	clockevents_calc_mult_shift(dev, freq, secr ? secr : 1);
+
+	return clockevents_program_event(dev, dev->next_event, ktime_get());
+}
+
+/**
  * clockevents_register_notifier - register a clock events change listener
  */
 int clockevents_register_notifier(struct notifier_block *nb)
