From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 25 Oct 2016 10:38:31 -0700
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <20161024164255.GN15620@leverpostej>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
 <20161024113131.GH15620@leverpostej> <1477326477.1984.2.camel@perches.com>
 <20161024164255.GN15620@leverpostej>
Message-ID: <CA+55aFwFQSass91gdGsjo4BkkAYmoFSn-Cpm6yF+SygF_tRp1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 9:42 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> That does not appear to be the case; as fr as I can tell the core prints a
> timestamp per line as required. If I run:
>
>         printk("TEST\nLINE1\nLINE2\nLINE3\nLINE4\n");

Please don't do this.

It has historically not worked well, and it still doesn't actually
work reliably. In particular, it currently works in the *logs* (ie
dmesg), but not necessarily on screen (because "msg_print_text()" does
do the "look for newlines in the middle", but console_cont_flush()
does not).

It so happens that the patch I've been sending people probably fixes
that odd case too, almost entirely by mistake (if "by mistake" you
mean "it gets rid of the insane special cases that cause problems like
this").

So you can try the attached patch. It likely fixes your issues simply
because it removes all the crazy code.

              Linus
-------------- next part --------------
 kernel/printk/printk.c | 255 +++++++++++--------------------------------------
 1 file changed, 58 insertions(+), 197 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index de08fc90baaf..e63aa679614e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -367,7 +367,6 @@ DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
 static u32 syslog_idx;
-static enum log_flags syslog_prev;
 static size_t syslog_partial;
 
 /* index and sequence number of the first record stored in the buffer */
@@ -381,7 +380,6 @@ static u32 log_next_idx;
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u32 console_idx;
-static enum log_flags console_prev;
 
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
@@ -650,27 +648,15 @@ static void append_char(char **pp, char *e, char c)
 }
 
 static ssize_t msg_print_ext_header(char *buf, size_t size,
-				    struct printk_log *msg, u64 seq,
-				    enum log_flags prev_flags)
+				    struct printk_log *msg, u64 seq)
 {
 	u64 ts_usec = msg->ts_nsec;
-	char cont = '-';
 
 	do_div(ts_usec, 1000);
 
-	/*
-	 * If we couldn't merge continuation line fragments during the print,
-	 * export the stored flags to allow an optional external merge of the
-	 * records. Merging the records isn't always neccessarily correct, like
-	 * when we hit a race during printing. In most cases though, it produces
-	 * better readable output. 'c' in the record flags mark the first
-	 * fragment of a line, '+' the following.
-	 */
-	if (msg->flags & LOG_CONT)
-		cont = (prev_flags & LOG_CONT) ? '+' : 'c';
-
 	return scnprintf(buf, size, "%u,%llu,%llu,%c;",
-		       (msg->facility << 3) | msg->level, seq, ts_usec, cont);
+		       (msg->facility << 3) | msg->level, seq, ts_usec,
+		       msg->flags & LOG_CONT ? 'c' : '-');
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
@@ -725,7 +711,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 struct devkmsg_user {
 	u64 seq;
 	u32 idx;
-	enum log_flags prev;
 	struct ratelimit_state rs;
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
@@ -794,7 +779,7 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
-static void cont_flush(void);
+static void deferred_cont_flush(void);
 
 static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
@@ -811,7 +796,6 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	raw_spin_lock_irq(&logbuf_lock);
-	cont_flush();
 	while (user->seq == log_next_seq) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
@@ -838,12 +822,11 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
 	msg = log_from_idx(user->idx);
 	len = msg_print_ext_header(user->buf, sizeof(user->buf),
-				   msg, user->seq, user->prev);
+				   msg, user->seq);
 	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
 				  log_dict(msg), msg->dict_len,
 				  log_text(msg), msg->text_len);
 
-	user->prev = msg->flags;
 	user->idx = log_next(user->idx);
 	user->seq++;
 	raw_spin_unlock_irq(&logbuf_lock);
@@ -860,6 +843,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	ret = len;
 out:
 	mutex_unlock(&user->lock);
+	deferred_cont_flush();
 	return ret;
 }
 
@@ -874,7 +858,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		return -ESPIPE;
 
 	raw_spin_lock_irq(&logbuf_lock);
-	cont_flush();
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
@@ -913,7 +896,6 @@ static unsigned int devkmsg_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &log_wait, wait);
 
 	raw_spin_lock_irq(&logbuf_lock);
-	cont_flush();
 	if (user->seq < log_next_seq) {
 		/* return error when data has vanished underneath us */
 		if (user->seq < log_first_seq)
@@ -922,6 +904,7 @@ static unsigned int devkmsg_poll(struct file *file, poll_table *wait)
 			ret = POLLIN|POLLRDNORM;
 	}
 	raw_spin_unlock_irq(&logbuf_lock);
+	deferred_cont_flush();
 
 	return ret;
 }
@@ -1226,26 +1209,12 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
 	return len;
 }
 
-static size_t msg_print_text(const struct printk_log *msg, enum log_flags prev,
-			     bool syslog, char *buf, size_t size)
+static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *buf, size_t size)
 {
 	const char *text = log_text(msg);
 	size_t text_size = msg->text_len;
-	bool prefix = true;
-	bool newline = true;
 	size_t len = 0;
 
-	if ((prev & LOG_CONT) && !(msg->flags & LOG_PREFIX))
-		prefix = false;
-
-	if (msg->flags & LOG_CONT) {
-		if ((prev & LOG_CONT) && !(prev & LOG_NEWLINE))
-			prefix = false;
-
-		if (!(msg->flags & LOG_NEWLINE))
-			newline = false;
-	}
-
 	do {
 		const char *next = memchr(text, '\n', text_size);
 		size_t text_len;
@@ -1263,22 +1232,17 @@ static size_t msg_print_text(const struct printk_log *msg, enum log_flags prev,
 			    text_len + 1 >= size - len)
 				break;
 
-			if (prefix)
-				len += print_prefix(msg, syslog, buf + len);
+			len += print_prefix(msg, syslog, buf + len);
 			memcpy(buf + len, text, text_len);
 			len += text_len;
-			if (next || newline)
-				buf[len++] = '\n';
+			buf[len++] = '\n';
 		} else {
 			/* SYSLOG_ACTION_* buffer size only calculation */
-			if (prefix)
-				len += print_prefix(msg, syslog, NULL);
+			len += print_prefix(msg, syslog, NULL);
 			len += text_len;
-			if (next || newline)
-				len++;
+			len++;
 		}
 
-		prefix = true;
 		text = next;
 	} while (text);
 
@@ -1300,12 +1264,10 @@ static int syslog_print(char __user *buf, int size)
 		size_t skip;
 
 		raw_spin_lock_irq(&logbuf_lock);
-		cont_flush();
 		if (syslog_seq < log_first_seq) {
 			/* messages are gone, move to first one */
 			syslog_seq = log_first_seq;
 			syslog_idx = log_first_idx;
-			syslog_prev = 0;
 			syslog_partial = 0;
 		}
 		if (syslog_seq == log_next_seq) {
@@ -1315,13 +1277,11 @@ static int syslog_print(char __user *buf, int size)
 
 		skip = syslog_partial;
 		msg = log_from_idx(syslog_idx);
-		n = msg_print_text(msg, syslog_prev, true, text,
-				   LOG_LINE_MAX + PREFIX_MAX);
+		n = msg_print_text(msg, true, text, LOG_LINE_MAX + PREFIX_MAX);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
 			syslog_idx = log_next(syslog_idx);
 			syslog_seq++;
-			syslog_prev = msg->flags;
 			n -= syslog_partial;
 			syslog_partial = 0;
 		} else if (!len){
@@ -1360,12 +1320,10 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		return -ENOMEM;
 
 	raw_spin_lock_irq(&logbuf_lock);
-	cont_flush();
 	if (buf) {
 		u64 next_seq;
 		u64 seq;
 		u32 idx;
-		enum log_flags prev;
 
 		/*
 		 * Find first record that fits, including all following records,
@@ -1373,12 +1331,10 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		 */
 		seq = clear_seq;
 		idx = clear_idx;
-		prev = 0;
 		while (seq < log_next_seq) {
 			struct printk_log *msg = log_from_idx(idx);
 
-			len += msg_print_text(msg, prev, true, NULL, 0);
-			prev = msg->flags;
+			len += msg_print_text(msg, true, NULL, 0);
 			idx = log_next(idx);
 			seq++;
 		}
@@ -1386,12 +1342,10 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		/* move first record forward until length fits into the buffer */
 		seq = clear_seq;
 		idx = clear_idx;
-		prev = 0;
 		while (len > size && seq < log_next_seq) {
 			struct printk_log *msg = log_from_idx(idx);
 
-			len -= msg_print_text(msg, prev, true, NULL, 0);
-			prev = msg->flags;
+			len -= msg_print_text(msg, true, NULL, 0);
 			idx = log_next(idx);
 			seq++;
 		}
@@ -1404,7 +1358,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			struct printk_log *msg = log_from_idx(idx);
 			int textlen;
 
-			textlen = msg_print_text(msg, prev, true, text,
+			textlen = msg_print_text(msg, true, text,
 						 LOG_LINE_MAX + PREFIX_MAX);
 			if (textlen < 0) {
 				len = textlen;
@@ -1412,7 +1366,6 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			}
 			idx = log_next(idx);
 			seq++;
-			prev = msg->flags;
 
 			raw_spin_unlock_irq(&logbuf_lock);
 			if (copy_to_user(buf + len, text, textlen))
@@ -1425,7 +1378,6 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 				/* messages are gone, move to next one */
 				seq = log_first_seq;
 				idx = log_first_idx;
-				prev = 0;
 			}
 		}
 	}
@@ -1522,12 +1474,10 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		raw_spin_lock_irq(&logbuf_lock);
-		cont_flush();
 		if (syslog_seq < log_first_seq) {
 			/* messages are gone, move to first one */
 			syslog_seq = log_first_seq;
 			syslog_idx = log_first_idx;
-			syslog_prev = 0;
 			syslog_partial = 0;
 		}
 		if (source == SYSLOG_FROM_PROC) {
@@ -1540,16 +1490,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		} else {
 			u64 seq = syslog_seq;
 			u32 idx = syslog_idx;
-			enum log_flags prev = syslog_prev;
 
 			error = 0;
 			while (seq < log_next_seq) {
 				struct printk_log *msg = log_from_idx(idx);
 
-				error += msg_print_text(msg, prev, true, NULL, 0);
+				error += msg_print_text(msg, true, NULL, 0);
 				idx = log_next(idx);
 				seq++;
-				prev = msg->flags;
 			}
 			error -= syslog_partial;
 		}
@@ -1563,6 +1511,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		error = -EINVAL;
 		break;
 	}
+	deferred_cont_flush();
 out:
 	return error;
 }
@@ -1650,46 +1599,47 @@ static inline void printk_delay(void)
 static struct cont {
 	char buf[LOG_LINE_MAX];
 	size_t len;			/* length == 0 means unused buffer */
-	size_t cons;			/* bytes written to console */
 	struct task_struct *owner;	/* task of first print*/
 	u64 ts_nsec;			/* time of first print */
 	u8 level;			/* log level of first message */
 	u8 facility;			/* log facility of first message */
 	enum log_flags flags;		/* prefix, newline flags */
-	bool flushed:1;			/* buffer sealed and committed */
 } cont;
 
-static void cont_flush(void)
+static bool cont_flush(void)
 {
-	if (cont.flushed)
-		return;
-	if (cont.len == 0)
+	if (!cont.len)
+		return false;
+
+	log_store(cont.facility, cont.level, cont.flags, cont.ts_nsec,
+		  NULL, 0, cont.buf, cont.len);
+	cont.len = 0;
+	return true;
+}
+
+static void flush_timer(unsigned long data)
+{
+	unsigned long flags;
+	bool did_flush;
+
+	raw_spin_lock_irqsave(&logbuf_lock, flags);
+	did_flush = cont_flush();
+	raw_spin_unlock_irqrestore(&logbuf_lock, flags);
+	if (did_flush)
+		wake_up_klogd();
+}
+
+static void deferred_cont_flush(void)
+{
+	static DEFINE_TIMER(timer, flush_timer, 0, 0);
+
+	if (!cont.len)
 		return;
-	if (cont.cons) {
-		/*
-		 * If a fragment of this line was directly flushed to the
-		 * console; wait for the console to pick up the rest of the
-		 * line. LOG_NOCONS suppresses a duplicated output.
-		 */
-		log_store(cont.facility, cont.level, cont.flags | LOG_NOCONS,
-			  cont.ts_nsec, NULL, 0, cont.buf, cont.len);
-		cont.flushed = true;
-	} else {
-		/*
-		 * If no fragment of this line ever reached the console,
-		 * just submit it to the store and free the buffer.
-		 */
-		log_store(cont.facility, cont.level, cont.flags, 0,
-			  NULL, 0, cont.buf, cont.len);
-		cont.len = 0;
-	}
+	mod_timer(&timer, jiffies + HZ/10);
 }
 
 static bool cont_add(int facility, int level, enum log_flags flags, const char *text, size_t len)
 {
-	if (cont.len && cont.flushed)
-		return false;
-
 	/*
 	 * If ext consoles are present, flush and skip in-kernel
 	 * continuation.  See nr_ext_console_drivers definition.  Also, if
@@ -1706,8 +1656,6 @@ static bool cont_add(int facility, int level, enum log_flags flags, const char *
 		cont.owner = current;
 		cont.ts_nsec = local_clock();
 		cont.flags = flags;
-		cont.cons = 0;
-		cont.flushed = false;
 	}
 
 	memcpy(cont.buf + cont.len, text, len);
@@ -1726,34 +1674,6 @@ static bool cont_add(int facility, int level, enum log_flags flags, const char *
 	return true;
 }
 
-static size_t cont_print_text(char *text, size_t size)
-{
-	size_t textlen = 0;
-	size_t len;
-
-	if (cont.cons == 0 && (console_prev & LOG_NEWLINE)) {
-		textlen += print_time(cont.ts_nsec, text);
-		size -= textlen;
-	}
-
-	len = cont.len - cont.cons;
-	if (len > 0) {
-		if (len+1 > size)
-			len = size-1;
-		memcpy(text + textlen, cont.buf + cont.cons, len);
-		textlen += len;
-		cont.cons = cont.len;
-	}
-
-	if (cont.flushed) {
-		if (cont.flags & LOG_NEWLINE)
-			text[textlen++] = '\n';
-		/* got everything, release buffer */
-		cont.len = 0;
-	}
-	return textlen;
-}
-
 static size_t log_output(int facility, int level, enum log_flags lflags, const char *dict, size_t dictlen, char *text, size_t text_len)
 {
 	/*
@@ -1999,11 +1919,9 @@ static u64 syslog_seq;
 static u32 syslog_idx;
 static u64 console_seq;
 static u32 console_idx;
-static enum log_flags syslog_prev;
 static u64 log_first_seq;
 static u32 log_first_idx;
 static u64 log_next_seq;
-static enum log_flags console_prev;
 static struct cont {
 	size_t len;
 	size_t cons;
@@ -2015,17 +1933,16 @@ static char *log_dict(const struct printk_log *msg) { return NULL; }
 static struct printk_log *log_from_idx(u32 idx) { return NULL; }
 static u32 log_next(u32 idx) { return 0; }
 static ssize_t msg_print_ext_header(char *buf, size_t size,
-				    struct printk_log *msg, u64 seq,
-				    enum log_flags prev_flags) { return 0; }
+				    struct printk_log *msg,
+				    u64 seq) { return 0; }
 static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  char *dict, size_t dict_len,
 				  char *text, size_t text_len) { return 0; }
 static void call_console_drivers(int level,
 				 const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
-static size_t msg_print_text(const struct printk_log *msg, enum log_flags prev,
+static size_t msg_print_text(const struct printk_log *msg,
 			     bool syslog, char *buf, size_t size) { return 0; }
-static size_t cont_print_text(char *text, size_t size) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
 
 /* Still needs to be defined for users */
@@ -2296,42 +2213,6 @@ static inline int can_use_console(void)
 	return cpu_online(raw_smp_processor_id()) || have_callable_console();
 }
 
-static void console_cont_flush(char *text, size_t size)
-{
-	unsigned long flags;
-	size_t len;
-
-	raw_spin_lock_irqsave(&logbuf_lock, flags);
-
-	if (!cont.len)
-		goto out;
-
-	if (suppress_message_printing(cont.level)) {
-		cont.cons = cont.len;
-		if (cont.flushed)
-			cont.len = 0;
-		goto out;
-	}
-
-	/*
-	 * We still queue earlier records, likely because the console was
-	 * busy. The earlier ones need to be printed before this one, we
-	 * did not flush any fragment so far, so just let it queue up.
-	 */
-	if (console_seq < log_next_seq && !cont.cons)
-		goto out;
-
-	len = cont_print_text(text, size);
-	raw_spin_unlock(&logbuf_lock);
-	stop_critical_timings();
-	call_console_drivers(cont.level, NULL, 0, text, len);
-	start_critical_timings();
-	local_irq_restore(flags);
-	return;
-out:
-	raw_spin_unlock_irqrestore(&logbuf_lock, flags);
-}
-
 /**
  * console_unlock - unlock the console system
  *
@@ -2385,9 +2266,6 @@ void console_unlock(void)
 		return;
 	}
 
-	/* flush buffered message fragment immediately to console */
-	console_cont_flush(text, sizeof(text));
-
 	for (;;) {
 		struct printk_log *msg;
 		size_t ext_len = 0;
@@ -2407,7 +2285,6 @@ void console_unlock(void)
 			/* messages are gone, move to first one */
 			console_seq = log_first_seq;
 			console_idx = log_first_idx;
-			console_prev = 0;
 		} else {
 			len = 0;
 		}
@@ -2417,8 +2294,7 @@ void console_unlock(void)
 
 		msg = log_from_idx(console_idx);
 		level = msg->level;
-		if ((msg->flags & LOG_NOCONS) ||
-				suppress_message_printing(level)) {
+		if (suppress_message_printing(level)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
@@ -2426,22 +2302,14 @@ void console_unlock(void)
 			 */
 			console_idx = log_next(console_idx);
 			console_seq++;
-			/*
-			 * We will get here again when we register a new
-			 * CON_PRINTBUFFER console. Clear the flag so we
-			 * will properly dump everything later.
-			 */
-			msg->flags &= ~LOG_NOCONS;
-			console_prev = msg->flags;
 			goto skip;
 		}
 
-		len += msg_print_text(msg, console_prev, false,
-				      text + len, sizeof(text) - len);
+		len += msg_print_text(msg, false, text + len, sizeof(text) - len);
 		if (nr_ext_console_drivers) {
 			ext_len = msg_print_ext_header(ext_text,
 						sizeof(ext_text),
-						msg, console_seq, console_prev);
+						msg, console_seq);
 			ext_len += msg_print_ext_body(ext_text + ext_len,
 						sizeof(ext_text) - ext_len,
 						log_dict(msg), msg->dict_len,
@@ -2449,7 +2317,6 @@ void console_unlock(void)
 		}
 		console_idx = log_next(console_idx);
 		console_seq++;
-		console_prev = msg->flags;
 		raw_spin_unlock(&logbuf_lock);
 
 		stop_critical_timings();	/* don't trace print latency */
@@ -2483,7 +2350,7 @@ void console_unlock(void)
 	if (retry && console_trylock())
 		goto again;
 
-	if (wake_klogd)
+	if (wake_klogd || cont.len)
 		wake_up_klogd();
 }
 EXPORT_SYMBOL(console_unlock);
@@ -2744,7 +2611,6 @@ void register_console(struct console *newcon)
 		raw_spin_lock_irqsave(&logbuf_lock, flags);
 		console_seq = syslog_seq;
 		console_idx = syslog_idx;
-		console_prev = syslog_prev;
 		raw_spin_unlock_irqrestore(&logbuf_lock, flags);
 		/*
 		 * We're about to replay the log buffer.  Only do this to the
@@ -2883,6 +2749,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 
 	if (pending & PRINTK_PENDING_WAKEUP)
 		wake_up_interruptible(&log_wait);
+	deferred_cont_flush();
 }
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
@@ -3095,7 +2962,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	msg = log_from_idx(dumper->cur_idx);
-	l = msg_print_text(msg, 0, syslog, line, size);
+	l = msg_print_text(msg, syslog, line, size);
 
 	dumper->cur_idx = log_next(dumper->cur_idx);
 	dumper->cur_seq++;
@@ -3165,7 +3032,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	u32 idx;
 	u64 next_seq;
 	u32 next_idx;
-	enum log_flags prev;
 	size_t l = 0;
 	bool ret = false;
 
@@ -3189,27 +3055,23 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	/* calculate length of entire buffer */
 	seq = dumper->cur_seq;
 	idx = dumper->cur_idx;
-	prev = 0;
 	while (seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l += msg_print_text(msg, prev, true, NULL, 0);
+		l += msg_print_text(msg, true, NULL, 0);
 		idx = log_next(idx);
 		seq++;
-		prev = msg->flags;
 	}
 
 	/* move first record forward until length fits into the buffer */
 	seq = dumper->cur_seq;
 	idx = dumper->cur_idx;
-	prev = 0;
 	while (l > size && seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l -= msg_print_text(msg, prev, true, NULL, 0);
+		l -= msg_print_text(msg, true, NULL, 0);
 		idx = log_next(idx);
 		seq++;
-		prev = msg->flags;
 	}
 
 	/* last message in next interation */
@@ -3220,10 +3082,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l += msg_print_text(msg, prev, syslog, buf + l, size - l);
+		l += msg_print_text(msg, syslog, buf + l, size - l);
 		idx = log_next(idx);
 		seq++;
-		prev = msg->flags;
 	}
 
 	dumper->next_seq = next_seq;
