From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 25 Apr 2013 16:53:57 +0200
Subject: RFC: [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <alpine.LFD.2.02.1304251618590.21884@ionos>
References: <517687AB.1040309@pengutronix.de>
 <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
 <alpine.LFD.2.02.1304251618590.21884@ionos>
Message-ID: <51794385.1030308@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2013 04:21 PM, Thomas Gleixner wrote:
> On Tue, 23 Apr 2013, Marc Kleine-Budde wrote:
>> The commit
>>
>>     77cc982 clocksource: use clockevents_config_and_register() where possible
>>
>> switches from manually calculating min_delta_ns (and others) and
>> clockevents_register_device() to automatic calculation via
>> clockevents_config_and_register(). During this conversation the "+ 1" in
>>
>>     min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;
>>
>> was lost. This leads to problems with schedule_delayed_work() with a delay of
>> "1". Resulting in the work not scheduled in time.
> 
> Errm. How is schedule_delayed_work() related to this?

Let me explain:
For other reasons [1], we reverted:

    f23eb2b tty: stop using "delayed_work" in the tty layer

(for reference find the patch below [2]). Which basically means
tty_schedule_flip() uses schedule_delayed_work(&buf->work, 1) instead
of schedule_work(&buf->work) as mainline does.

This works pretty well until v3.8. With v3.9-rc kernel the serial
console gets sluggish. It takes several seconds to abort a "find /" on
a serial console with Ctrl+c. I've bisected the problem down to:

    77cc982 clocksource: use clockevents_config_and_register() where
            possible

A printk shows the subtile difference in the min_delta_ns:

good: setup_clkevents: shift=32 mult=140737 min=30518 max=1999976422
bad:  setup_clkevents: shift=32 mult=140737 min=30517 max=1999976422

Restoring min_delta_ns to the original value, with this hackish patch,
"fixes" the serial problem, too:

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 8a61872..30e0a68 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -198,6 +198,7 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
        clkevt.clkevt.cpumask = cpumask_of(0);

        clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+       clkevt.clkevt.min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;

        setup_irq(irq, &tc_irqaction);
 }

> schedule_delayed_work() is jiffies based and has absolutely nothing to
> do with clockevents.

I'm puzzled, too.

>> This patch fixes the problem by increasing the min_delta to "2" ticks.
> 
> This changelog sucks.
> 
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/clocksource/tcb_clksrc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
>> index 8a61872..7cf6dc7 100644
>> --- a/drivers/clocksource/tcb_clksrc.c
>> +++ b/drivers/clocksource/tcb_clksrc.c
>> @@ -197,7 +197,7 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
>>  
>>  	clkevt.clkevt.cpumask = cpumask_of(0);
>>  
>> -	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
>> +	clockevents_config_and_register(&clkevt.clkevt, 32768, 2, 0xffff);
>>  
>>  	setup_irq(irq, &tc_irqaction);
>>  }

[1] http://permalink.gmane.org/gmane.linux.kernel/1479280

[2]
>From e4d43afca06724c6a59b8caac1f5dc07a9974aaa Mon Sep 17 00:00:00 2001
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 5 Apr 2013 16:38:55 +0200
Subject: [PATCH] HACK: tty: Revert stop using "delayed_work" in the tty layer

This patch reverts:

    f23eb2b tty: stop using "delayed_work" in the tty layer

That patch changed the tty buffer flip from beeing handled in a "delayed_work"
to an immediately scheduled "work". The original motivation was to decrease the
latency, this however leads to 15-25 %-points of more load on certain
workloads.

Here, less load is more desired than low latency, thus the patch is reverted
until a mainline accepted solution is found.

See for a detailed discussion see:
http://permalink.gmane.org/gmane.linux.kernel/1479280

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/tty/n_tty.c      |  2 +-
 drivers/tty/tty_buffer.c | 12 ++++++------
 drivers/tty/tty_ldisc.c  | 10 +++++-----
 include/linux/tty.h      |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 05e72be..ead46da 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -153,7 +153,7 @@ static void n_tty_set_room(struct tty_struct *tty)
 	if (left && !old_left) {
 		WARN_RATELIMIT(tty->port->itty == NULL,
 				"scheduling with invalid itty\n");
-		schedule_work(&tty->port->buf.work);
+		schedule_delayed_work(&tty->port->buf.work, 1);
 	}
 }
 
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 578aa75..187b874 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -339,7 +339,7 @@ void tty_schedule_flip(struct tty_port *port)
 	if (buf->tail != NULL)
 		buf->tail->commit = buf->tail->used;
 	spin_unlock_irqrestore(&buf->lock, flags);
-	schedule_work(&buf->work);
+	schedule_delayed_work(&buf->work, 1);
 }
 EXPORT_SYMBOL(tty_schedule_flip);
 
@@ -418,7 +418,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string_flags);
 
 static void flush_to_ldisc(struct work_struct *work)
 {
-	struct tty_port *port = container_of(work, struct tty_port, buf.work);
+	struct tty_port *port = container_of(work, struct tty_port, buf.work.work);
 	struct tty_bufhead *buf = &port->buf;
 	struct tty_struct *tty;
 	unsigned long 	flags;
@@ -492,7 +492,7 @@ static void flush_to_ldisc(struct work_struct *work)
 void tty_flush_to_ldisc(struct tty_struct *tty)
 {
 	if (!tty->port->low_latency)
-		flush_work(&tty->port->buf.work);
+		flush_delayed_work(&tty->port->buf.work);
 }
 
 /**
@@ -520,9 +520,9 @@ void tty_flip_buffer_push(struct tty_port *port)
 	spin_unlock_irqrestore(&buf->lock, flags);
 
 	if (port->low_latency)
-		flush_to_ldisc(&buf->work);
+		flush_to_ldisc(&buf->work.work);
 	else
-		schedule_work(&buf->work);
+		schedule_delayed_work(&port->buf.work, 1);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -545,6 +545,6 @@ void tty_buffer_init(struct tty_port *port)
 	buf->tail = NULL;
 	buf->free = NULL;
 	buf->memory_used = 0;
-	INIT_WORK(&buf->work, flush_to_ldisc);
+	INIT_DELAYED_WORK(&port->buf.work, flush_to_ldisc);
 }
 
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index d794087..1cb63f1 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -514,7 +514,7 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 static int tty_ldisc_halt(struct tty_struct *tty)
 {
 	clear_bit(TTY_LDISC, &tty->flags);
-	return cancel_work_sync(&tty->port->buf.work);
+	return cancel_delayed_work(&tty->port->buf.work);
 }
 
 /**
@@ -527,7 +527,7 @@ static void tty_ldisc_flush_works(struct tty_struct *tty)
 {
 	flush_work(&tty->hangup_work);
 	flush_work(&tty->SAK_work);
-	flush_work(&tty->port->buf.work);
+	flush_delayed_work(&tty->port->buf.work);
 }
 
 /**
@@ -706,9 +706,9 @@ enable:
 	/* Restart the work queue in case no characters kick it off. Safe if
 	   already running */
 	if (work)
-		schedule_work(&tty->port->buf.work);
+		schedule_delayed_work(&tty->port->buf.work, 1);
 	if (o_work)
-		schedule_work(&o_tty->port->buf.work);
+		schedule_delayed_work(&o_tty->port->buf.work, 1);
 	mutex_unlock(&tty->ldisc_mutex);
 	tty_unlock(tty);
 	return retval;
@@ -819,7 +819,7 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	 */
 	clear_bit(TTY_LDISC, &tty->flags);
 	tty_unlock(tty);
-	cancel_work_sync(&tty->port->buf.work);
+	cancel_delayed_work(&tty->port->buf.work);
 	mutex_unlock(&tty->ldisc_mutex);
 retry:
 	tty_lock(tty);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index c75d886..f7f6836 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -52,7 +52,7 @@ struct tty_buffer {
 
 
 struct tty_bufhead {
-	struct work_struct work;
+	struct delayed_work work;
 	spinlock_t lock;
 	struct tty_buffer *head;	/* Queue head */
 	struct tty_buffer *tail;	/* Active buffer */
-- 
1.8.2.rc2

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130425/a8de572c/attachment.sig>
