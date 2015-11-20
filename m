From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 20 Nov 2015 11:30:13 -0500
Subject: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter in
 start_tx
In-Reply-To: <20151120152849.GU32017@xsjsorenbubuntu>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
 <20151120152849.GU32017@xsjsorenbubuntu>
Message-ID: <564F4A95.3010303@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

On 11/20/2015 10:28 AM, S?ren Brinkmann wrote:
> On Fri, 2015-11-20 at 07:13AM -0500, Peter Hurley wrote:
>> On 11/19/2015 03:02 PM, Soren Brinkmann wrote:
>>> start_tx must start transmitting characters. Regardless of the state of
>>> the circular buffer, always enable the transmitter hardware.
>>
>> Why?
>>
>> Does cdns_uart_stop_tx() actually stop the transmitter so that
>> data remains in the transmitter?
> 
> Well, I saw my system freezing and the cause seemed to be that the UART
> receiver and/or transmitters were disabled while the system was trying
> to print. Hence, I started questioning all locations touching the
> transmitter/receiver enable. I read the docs in
> https://www.kernel.org/doc/Documentation/serial/driver, which simply
> says "Start transmitting characters." for start_tx(). Hence, I thought,
> this function is probably supposed to just do that and start the
> transmitter. I'll test whether this patch can be dropped.

I don't think that patch would fix any freeze problems, but restarting
the transmitter even if the circ buffer is empty may be necessary to
push out remaining data when the port is restarted after being stopped.

IOW, something like

	if (uart_tx_stopped(port))
		return;

	....


	if (uart_circ_empty(&port->state->xmit)
		return;


Below is a (work-in-progress) serial driver validation test for flow
control handling (it may need some tuning for slow line speeds).
Usual caveats apply. Takes ~40secs @ 115200.

--- >% ---
--- /dev/null	2015-11-20 07:19:13.265468435 -0500
+++ flow.c	2015-11-20 11:21:44.254139192 -0500
@@ -0,0 +1,343 @@
+/*
+ * flow control unit test for tty/serial core
+ *
+ * Copyright (c) 2014 Peter Hurley
+ * __fls() by  Alexander van Heukelum <heukelum@mailshack.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This test creates two additional threads, a writer which continuously
+ * transmits a pattern and a reader which reads and verifies the pattern
+ * received matches, while the leader thread cycles sends START_CHAR/STOP_CHAR
+ * (via ioctl(TCIOFF)/ioctl(TCION).
+ *
+ *                           I/O path
+ *     Target (running this test)                Reflector
+ *
+ *     writer  ----------| |------------------------>
+ *                        ^                          \
+ *                   tty->stopped                     |
+ *                        ^                          /
+ *     reader  <-- (    input   ) ------------------
+ *                 ( processing )
+ *
+ * Expected: PASS
+ *
+ * Build:  gcc -Wall -o flow flow.c -pthread
+ *
+ * Use:
+ *   1. Connect a null-modem cable between test tty and reflector tty.
+ *
+ *   2. Confirm the test tty and reflector tty are using the same line
+ *      settings; eg., 115200n81.
+ *
+ *   3. Make sure both test and reflector serial ports are not in use;
+ *      eg., `sudo lsof /dev/ttyS0`. getty will mess up the test :)
+ *
+ *   4. Start the reflector. For example,
+ *	   stty raw -echo -iexten < /dev/ttyS1
+ *	   cat < /dev/ttyS1 > /dev/ttyS1
+ *
+ *   5. Start the test. For example,
+ *         ./flow /dev/ttyS0
+ *
+ *   6. Test terminates with EXIT_SUCCESS if tests pass. Otherwise, test
+ *      terminates with EXIT_FAILURE and diagnostic message(s).
+ *
+ * Diagnostics:
+ *     No output after 'Test flow control on /dev/ttyXXX'
+ *					Check if tty is already in use
+ *
+ *     main: opening tty: Permission denied (code: 13)
+ *					Check tty permissions or run as su
+ *
+ *     reader: FAILED, i/o stalled
+ *					Make sure line settings are same;
+ *					otherwise core or driver bug
+ */
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <termios.h>
+#include <stdint.h>
+#include <pthread.h>
+#include <time.h>		/* nanosleep */
+#include <limits.h>		/* UINT_* */
+#include <signal.h>
+
+#include "common.h"
+
+#if UINT_MAX == UINT64_MAX
+#define BITS_PER_LONG 64
+#elif UINT_MAX == UINT32_MAX
+#define BITS_PER_LONG 32
+#else
+#error BITS_PER_LONG not 32 or 64
+#endif
+
+int tty;
+struct termios *saved_termios;
+struct termios termios, orig_termios;
+int total_writes, total_reads;
+int read_distribution[10];
+static char pattern[] = ASCII_PRINTABLE;
+static size_t pattern_length = sizeof(pattern) - 1;
+
+static void restore_termios(void)
+{
+	if (saved_termios) {
+		int saved_errno = errno;
+		if (tcsetattr(tty, TCSANOW, saved_termios) < 0)
+			error_msg("tcsetattr");
+		errno = saved_errno;
+		saved_termios = NULL;
+	}
+}
+
+static void sig_handler(int sig)
+{
+	restore_termios();
+	_exit(EXIT_FAILURE);
+}
+
+static unsigned long __fls(unsigned long word)
+{
+	int num = BITS_PER_LONG - 1;
+
+#if BITS_PER_LONG == 64
+	if (!(word & (~0ul << 32))) {
+		num -= 32;
+		word <<= 32;
+	}
+#endif
+	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
+		num -= 16;
+		word <<= 16;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
+		num -= 8;
+		word <<= 8;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
+		num -= 4;
+		word <<= 4;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
+		num -= 2;
+		word <<= 2;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-1))))
+		num -= 1;
+	return num;
+}
+
+static int ilog2(size_t n) {
+	return __fls(n);
+}
+
+#define NSEC_IN_SEC	1000000000L
+static int uwait(long usec) {
+	struct timespec wait = { .tv_sec  = (usec * 1000) / NSEC_IN_SEC,
+				 .tv_nsec = (usec * 1000) % NSEC_IN_SEC };
+
+	while (nanosleep(&wait, &wait) == -1) {
+		if (errno == EINTR)
+			continue;
+		return -1;
+	}
+	return 0;
+}
+
+static void *reader(void *arg)
+{
+	size_t n = 0;
+	char buf[8192];
+
+	while (1) {
+		ssize_t c;
+		int r;
+
+		c = read(tty, buf, sizeof(buf));
+		if (c < 0)
+			error_exit("read");
+		if (c == 0)
+			msg_exit("FAILED, i/o stalled\n");
+
+		r = ilog2((size_t)c);
+		r = min(r, ARRAYSIZE(read_distribution) - 1);
+		read_distribution[r]++;
+
+		check_pattern(buf, c, pattern, n, pattern_length);
+
+		n += c;
+		total_reads = n / pattern_length;
+	}
+
+	return NULL;
+}
+
+static void *writer(void *arg)
+{
+	while (1) {
+		ssize_t c;
+		size_t sz = pattern_length;
+
+		c = write(tty, pattern, sz);
+		if (c < 0)
+			error_exit("write");
+		if (c != sz)
+			msg_exit("bad write: wrote:%zd (expected:%zu)\n", c, sz);
+		total_writes++;
+	}
+
+	return NULL;
+}
+
+/*
+ * test1 - start reader and writer threads
+ *
+ * Start 1 reader and 1 writer thread and trigger output flow control
+ * by sending START/STOP to the reflector.
+ *
+ * Expected: Uncorrupted i/o
+ *           tty does not become wedged
+ */
+static void test1()
+{
+ 	pthread_t id_writer;
+	pthread_t id_reader;
+	void *retval;
+	int i;
+
+	if (pthread_create(&id_reader, NULL, &reader, NULL))
+		error_exit("creating reader thread");
+	if (pthread_create(&id_writer, NULL, &writer, NULL))
+		error_exit("creating writer thread");
+
+#if 0
+	sleep(10);
+#else
+	/* TODO: Condition the loop count and timers based on baud rate */
+	for (i = 0; i < 100000; i++) {
+
+		/* TODO: These waits are too short for slow (9600) links */
+		if (uwait(100))
+			error_exit("uwait 1");
+		if (tcflow(tty, TCIOFF))
+			error_exit("tcflow(TCIOFF)");
+
+		if (uwait(100))
+			error_exit("uwait 2");
+		if (tcflow(tty, TCION))
+			error_exit("tcflow(TCION)");
+	}
+#endif
+
+	if (pthread_cancel(id_writer))
+		error_exit("cancelling writer thread");
+	if (pthread_cancel(id_reader))
+		error_exit("cancelling reader thread");
+
+	if (pthread_join(id_writer, &retval))
+		error_exit("waiting for writer thread");
+	if (retval != PTHREAD_CANCELED)
+		msg_exit("writer thread returned %p\n", retval);
+
+	if (pthread_join(id_reader, &retval))
+		error_exit("waiting for reader thread");
+	if (retval != PTHREAD_CANCELED)
+		msg_exit("reader thread returned %p\n", retval);
+}
+
+static void test(char *fname)
+{
+	printf("Test flow control on %s\n", fname);
+
+	tty = open(fname, O_RDWR);
+	if (tty < 0)
+		error_exit("opening %s", fname);
+
+	if (tcgetattr(tty, &termios) < 0)
+		error_exit("tcgetattr");
+
+	orig_termios = termios;
+	saved_termios = &orig_termios;
+
+	termios.c_lflag &= ~(ICANON | ISIG | IEXTEN | ECHO);
+	termios.c_iflag |= IXON;
+	termios.c_oflag &= ~OPOST;
+	termios.c_cc[VMIN] = 0;
+	termios.c_cc[VTIME] = 5;	/* 1/2 sec. */
+
+	if (tcsetattr(tty, TCSAFLUSH, &termios))
+		error_exit("tcsetattr");
+
+	printf("begin test1\n");
+	test1();
+
+	printf("patterns sent: %d  recvd: %d\n", total_writes, total_reads);
+	printf("read distribution: 1   = %d\n"
+	       "                   2+  = %d\n"
+	       "                   4+  = %d\n"
+	       "                   8+  = %d\n"
+	       "                  16+  = %d\n"
+	       "                  32+  = %d\n"
+	       "                  64+  = %d\n"
+	       "                 128+  = %d\n"
+	       "                 256+  = %d\n"
+	       "                 512+  = %d\n"
+	       ,
+	       read_distribution[0],
+	       read_distribution[1],
+	       read_distribution[2],
+	       read_distribution[3],
+	       read_distribution[4],
+	       read_distribution[5],
+	       read_distribution[6],
+	       read_distribution[7],
+	       read_distribution[8],
+	       read_distribution[9]);
+}
+
+static void usage(char *argv[]) {
+	msg_exit("Usage: %s tty\n"
+		 "\ttty   device filename (eg., /dev/ttyS0)\n",
+		 argv[0]);
+}
+
+int main(int argc, char* argv[])
+{
+	struct sigaction sa = { .sa_handler = sig_handler, .sa_flags = 0, };
+
+	setbuf(stdout, NULL);
+
+	if (argc < 2)
+		usage(argv);
+
+	if (atexit(restore_termios) < 0)
+		error_exit("atexit");
+
+	if (sigemptyset(&sa.sa_mask) < 0)
+		error_exit("sigemptyset");
+	if (sigaction(SIGINT, &sa, NULL) < 0)
+		error_exit("sigaction(SIGINT)");
+	if (sigaction(SIGTERM, &sa, NULL) < 0)
+		error_exit("sigaction(SIGTERM)");
+
+	test(argv[1]);
+
+	printf("PASSED\n");
+	return EXIT_SUCCESS;
+}
--- /dev/null	2015-11-20 07:19:13.265468435 -0500
+++ common.h	2015-11-20 10:58:05.514073298 -0500
@@ -0,0 +1,67 @@
+#ifndef _COMMON_H_
+#define _COMMON_H_
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/wait.h>
+#include <termios.h>
+#include <unistd.h>
+#include <stdarg.h>
+
+#define ARRAYSIZE(a)	(sizeof(a) / sizeof((a)[0]))
+#define max(a,b) \
+   ({ __typeof__ (a) _a = (a); \
+       __typeof__ (b) _b = (b); \
+     _a > _b ? _a : _b; })
+#define min(a,b) \
+   ({ __typeof__ (a) _a = (a); \
+       __typeof__ (b) _b = (b); \
+     _a < _b ? _a : _b; })
+
+#define ASCII_PRINTABLE							       \
+	/*          1         2         3         4         5		       \
+	 * 12345678901234567890123456789012345678901234567890 */	       \
+	"+_)(*&^%$#@!~=-0987654321`|}{POIUYTREWQ][poiuytrew"	  /*  50 */    \
+	"q:LKJHGFDSA;lkjhgfdsa?><MNBVCXZ/.,mnbvcxz"		  /* +41 */    \
+	"\"\'\\"						  /* + 3 */    \
+	"+_)(*&^%$#@!~=-0987654321`|}{POIUYTREWQ][poiuytrew"	  /*  50 */    \
+	"q:LKJHGFDSA;lkjhgfdsa?><MNBV\n"			  /* +29 */    \
+								  /* 173 */
+
+#define error_msg(f, ...)						\
+	fprintf(stderr, "%s: " f ": %s (code: %d)\n", __func__, ##__VA_ARGS__, \
+		strerror(errno), errno)
+
+#define msg_exit(f, ...) ({					 \
+	fprintf(stderr, "%s: " f "\n", __func__, ##__VA_ARGS__); \
+	exit(EXIT_FAILURE);					 \
+})
+
+#define error_exit(f, ...) ({		\
+	error_msg(f, ##__VA_ARGS__);	\
+	exit(EXIT_FAILURE);		\
+})
+
+/* validate buffer[0..c-1] == pattern[n..n+c-1] */
+static inline void check_pattern(const void *buf, size_t c,
+				 const void *pattern, size_t n, size_t sz)
+{
+	size_t i, j, t, len;
+
+	for (i = 0, j = n, len = c; len; i += t, j+= t, len -= t) {
+		j %= sz;
+		t = min(sz - j, len);
+		if (memcmp(buf + i, pattern + j, t) != 0)
+			msg_exit("\n\tcorrupted data: '%.*s'"
+				 "\n\t      expected: '%.*s'\n",
+				 (int)t, (char *)buf + i, (int)t,
+				 (char *)pattern + j);
+	}
+}
+
+#endif /* _COMMON_H_ */
