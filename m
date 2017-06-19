From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 19 Jun 2017 11:36:21 +0200
Subject: [PATCH v2 2/3] tool: timer: rtctest add check for problematic dates
In-Reply-To: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497864982-29284-3-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some dates could be problematic because they reach the limits of
RTC hardware capabilities.
This patch add various of them but since it will change RTC date
it will be activated only when 'd' args is set.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 tools/testing/selftests/timers/rtctest.c | 121 ++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
index 4230d30..715a016 100644
--- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -21,6 +21,9 @@
 #include <stdlib.h>
 #include <errno.h>
 
+#ifndef ARRAY_SIZE
+# define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
 
 /*
  * This expects the new RTC class driver framework, working with
@@ -29,23 +32,77 @@
  */
 static const char default_rtc[] = "/dev/rtc0";
 
+static struct rtc_time cutoff_dates[] = {
+	{
+		.tm_year = 70, /* 1970 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 137, /* 2037 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 138, /* 2038 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 199, /* 2099 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 200, /* 2100 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 205, /* 2105 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 206, /* 2106 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 361, /* 2261 -1900 */
+		.tm_mday = 1,
+	},
+	{
+		.tm_year = 362, /* 2262 -1900 */
+		.tm_mday = 1,
+	},
+};
+
+static int compare_dates(struct rtc_time *a, struct rtc_time *b)
+{
+	if (a->tm_year != b->tm_year ||
+	    a->tm_mon != b->tm_mon ||
+	    a->tm_mday != b->tm_mday ||
+	    a->tm_hour != b->tm_hour ||
+	    a->tm_min != b->tm_min ||
+	    ((b->tm_sec - a->tm_sec) > 1))
+		return 1;
+
+	return 0;
+}
 
 int main(int argc, char **argv)
 {
-	int i, fd, retval, irqcount = 0;
+	int i, fd, retval, irqcount = 0, dangerous = 0;
 	unsigned long tmp, data;
 	struct rtc_time rtc_tm;
 	const char *rtc = default_rtc;
 	struct timeval start, end, diff;
 
 	switch (argc) {
+	case 3:
+		if (*argv[2] == 'd')
+			dangerous = 1;
 	case 2:
 		rtc = argv[1];
 		/* FALLTHROUGH */
 	case 1:
 		break;
 	default:
-		fprintf(stderr, "usage:  rtctest [rtcdev]\n");
+		fprintf(stderr, "usage:  rtctest [rtcdev] [d]\n");
 		return 1;
 	}
 
@@ -202,7 +259,7 @@ int main(int argc, char **argv)
 		/* not all RTCs support periodic IRQs */
 		if (errno == EINVAL) {
 			fprintf(stderr, "\nNo periodic IRQ support\n");
-			goto done;
+			goto test_DATE;
 		}
 		perror("RTC_IRQP_READ ioctl");
 		exit(errno);
@@ -221,7 +278,7 @@ int main(int argc, char **argv)
 			if (errno == EINVAL) {
 				fprintf(stderr,
 					"\n...Periodic IRQ rate is fixed\n");
-				goto done;
+				goto test_DATE;
 			}
 			perror("RTC_IRQP_SET ioctl");
 			exit(errno);
@@ -269,6 +326,62 @@ int main(int argc, char **argv)
 		}
 	}
 
+test_DATE:
+	if (!dangerous)
+		goto done;
+
+	fprintf(stderr, "\nTesting problematic dates\n");
+
+	for (i = 0; i < ARRAY_SIZE(cutoff_dates); i++) {
+		struct rtc_time current;
+
+		/* Write the new date in RTC */
+		retval = ioctl(fd, RTC_SET_TIME, &cutoff_dates[i]);
+		if (retval == -1) {
+			perror("RTC_SET_TIME ioctl");
+			close(fd);
+			exit(errno);
+		}
+
+		/* Read back */
+		retval = ioctl(fd, RTC_RD_TIME, &current);
+		if (retval == -1) {
+			perror("RTC_RD_TIME ioctl");
+			exit(errno);
+		}
+
+		if(compare_dates(&cutoff_dates[i], &current)) {
+			fprintf(stderr,"Setting date %d failed\n",
+			        cutoff_dates[i].tm_year + 1900);
+			goto done;
+		}
+
+		cutoff_dates[i].tm_sec += 5;
+
+		/* Write the new alarm in RTC */
+		retval = ioctl(fd, RTC_ALM_SET, &cutoff_dates[i]);
+		if (retval == -1) {
+			perror("RTC_ALM_SET ioctl");
+			close(fd);
+			exit(errno);
+		}
+
+		/* Read back */
+		retval = ioctl(fd, RTC_ALM_READ, &current);
+		if (retval == -1) {
+			perror("RTC_ALM_READ ioctl");
+			exit(errno);
+		}
+
+		if(compare_dates(&cutoff_dates[i], &current)) {
+			fprintf(stderr,"Setting alarm %d failed\n",
+			        cutoff_dates[i].tm_year + 1900);
+			goto done;
+		}
+
+		fprintf(stderr, "Setting year %d is OK \n",
+			cutoff_dates[i].tm_year + 1900);
+	}
 done:
 	fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");
 
-- 
1.9.1
