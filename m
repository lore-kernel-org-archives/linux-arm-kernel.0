From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 16 Jun 2017 16:03:52 +0200
Subject: [PATCH 2/3] tools: timer: add test to check y2038/2106 bug
In-Reply-To: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497621833-9942-3-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this test is to check if a RTC device correctly support
dates after years 2038 or 2106.
It set a date (1-1-2200) on RTC and read it back to be sure that the
driver is working well.
The same thing is done on alarm.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 tools/testing/selftests/timers/Makefile       |   4 +-
 tools/testing/selftests/timers/rtctest-2038.c | 135 ++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timers/rtctest-2038.c

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 54481f1..7791f79 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -9,7 +9,8 @@ TEST_GEN_PROGS = posix_timers nanosleep nsleep-lat set-timer-lat mqueue-lat \
 
 TEST_GEN_PROGS_EXTENDED = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 		      skew_consistency clocksource-switch leap-a-day \
-		      leapcrash set-tai set-2038 set-tz rtctest_setdate
+		      leapcrash set-tai set-2038 set-tz rtctest_setdate \
+		      rtctest-2038
 
 
 include ../lib.mk
@@ -29,4 +30,5 @@ run_destructive_tests: run_tests
 	./set-tz
 	./set-tai
 	./set-2038
+	./rtctest-2038
 
diff --git a/tools/testing/selftests/timers/rtctest-2038.c b/tools/testing/selftests/timers/rtctest-2038.c
new file mode 100644
index 0000000..213b7ee
--- /dev/null
+++ b/tools/testing/selftests/timers/rtctest-2038.c
@@ -0,0 +1,135 @@
+/* Real Time Clock Driver Test
+ *	by: Benjamin Gaignard (benjamin.gaignard at linaro.org)
+ *
+ * To build
+ *	gcc rtctest-2038.c -o rtctest-2038
+ *
+ *   This program is free software: you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <stdio.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+
+static const char default_rtc[] = "/dev/rtc0";
+
+int main(int argc, char **argv)
+{
+	int fd, retval;
+	struct rtc_time new, current;
+	const char *rtc = default_rtc;
+
+	switch (argc) {
+	case 2:
+		rtc = argv[1];
+		/* FALLTHROUGH */
+	case 1:
+		break;
+	default:
+		fprintf(stderr, "usage: rtctest-2038 [rtcdev]\n");
+		return 1;
+	}
+
+	fprintf(stderr, "\nTest if RTC is robust for date after y2038/2106\n\n");
+
+	fd = open(rtc, O_RDONLY);
+	if (fd == -1) {
+		perror(rtc);
+		exit(errno);
+	}
+
+	new.tm_year = 300; /* 2200 - 1900 */
+	new.tm_mon = 0;
+	new.tm_mday = 1;
+	new.tm_hour = 0;
+	new.tm_min = 0;
+	new.tm_sec = 0;
+
+	fprintf(stderr, "Test will set RTC date/time to %d-%d-%d, %02d:%02d:%02d.\n",
+		new.tm_mday, new.tm_mon + 1, new.tm_year + 1900,
+		new.tm_hour, new.tm_min, new.tm_sec);
+
+	/* Write the new date in RTC */
+	retval = ioctl(fd, RTC_SET_TIME, &new);
+	if (retval == -1) {
+		perror("RTC_SET_TIME ioctl");
+		close(fd);
+		exit(errno);
+	}
+
+	/* Read back */
+	retval = ioctl(fd, RTC_RD_TIME, &current);
+	if (retval == -1) {
+		perror("RTC_RD_TIME ioctl");
+		exit(errno);
+	}
+
+	fprintf(stderr, "RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
+		current.tm_mday, current.tm_mon + 1, current.tm_year + 1900,
+		current.tm_hour, current.tm_min, current.tm_sec);
+
+	if (new.tm_year != current.tm_year ||
+	    new.tm_mon != current.tm_mon ||
+	    new.tm_mday != current.tm_mday ||
+	    new.tm_hour != current.tm_hour ||
+	    new.tm_min != current.tm_min ||
+	    new.tm_sec != current.tm_sec) {
+		fprintf(stderr, "\n\nSet Time test failed\n");
+		close(fd);
+		return 1;
+	}
+
+	new.tm_sec += 5;
+
+	fprintf(stderr, "\nTest will set RTC alarm to %d-%d-%d, %02d:%02d:%02d.\n",
+		new.tm_mday, new.tm_mon + 1, new.tm_year + 1900,
+		new.tm_hour, new.tm_min, new.tm_sec);
+
+	/* Write the new alarm in RTC */
+	retval = ioctl(fd, RTC_ALM_SET, &new);
+	if (retval == -1) {
+		perror("RTC_ALM_SET ioctl");
+		close(fd);
+		exit(errno);
+	}
+
+	/* Read back */
+	retval = ioctl(fd, RTC_ALM_READ, &current);
+	if (retval == -1) {
+		perror("RTC_ALM_READ ioctl");
+		exit(errno);
+	}
+
+	fprintf(stderr, "RTC alarm is %d-%d-%d, %02d:%02d:%02d.\n",
+		current.tm_mday, current.tm_mon + 1, current.tm_year + 1900,
+		current.tm_hour, current.tm_min, current.tm_sec);
+
+	if (new.tm_year != current.tm_year ||
+	    new.tm_mon != current.tm_mon ||
+	    new.tm_mday != current.tm_mday ||
+	    new.tm_hour != current.tm_hour ||
+	    new.tm_min != current.tm_min ||
+	    new.tm_sec != current.tm_sec) {
+		fprintf(stderr, "\n\nSet alarm test failed\n");
+		close(fd);
+		return 1;
+	}
+
+	fprintf(stderr, "\nTest complete\n");
+	close(fd);
+	return 0;
+}
-- 
1.9.1
