From: yogesh.tillu@linaro.org (Yogesh Tillu)
Date: Mon,  3 Nov 2014 20:34:05 +0530
Subject: [RFC PATCH 5/5] Application: to read PMU counter through vdso
In-Reply-To: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
References: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Message-ID: <1415027045-6573-6-git-send-email-yogesh.tillu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test application to read PMU cycle counter through vDSO path. 

Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>

---
 vdso_userspace_perf.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 vdso_userspace_perf.c

diff --git a/vdso_userspace_perf.c b/vdso_userspace_perf.c
new file mode 100644
index 0000000..42d2682
--- /dev/null
+++ b/vdso_userspace_perf.c
@@ -0,0 +1,58 @@
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/time.h>
+/* Simple loop body to keep things interested. Make sure it gets inlined. */
+static inline int
+loop(int* __restrict__ a, int* __restrict__ b, int n)
+{
+	unsigned sum = 0;
+	for (int i = 0; i < n; ++i)
+		if(a[i] > b[i])
+			sum += a[i] + 5;
+	return sum;
+}
+
+int
+main(int ac, char **av)
+{
+	uint32_t time_start = 0;
+	uint32_t time_end   = 0;
+	int result=0;
+	int *a  = NULL;
+	int *b  = NULL;
+	int len = 0;
+	int sum = 0;
+	int i;
+	struct timeval tv;
+
+	if (ac != 2) return -1;
+	len = atoi(av[1]);
+
+	a = malloc(len*sizeof(*a));
+	b = malloc(len*sizeof(*b));
+
+	for (int i = 0; i < len; ++i) {
+		a[i] = i+128;
+		b[i] = i+64;
+	}
+/* Read Counter  with Busy loop */
+	perf_open_counter();
+	time_start = perf_read_counter();
+	sum = loop(a, b, len);
+	time_end   = perf_read_counter();
+	printf("**********************************************************************\n");
+	printf("Busyloop sum = %d\nTime delta Including Busyloop = %lu [clockcycle]\n", sum, time_end - time_start);
+
+/* Read Counter with profiling read_counter */
+	time_start = perf_read_counter();
+	perf_read_counter();
+	time_end   = perf_read_counter();
+	printf("\nTime delta Without Busyloop   = %lu   [clockcycle]\n", time_end - time_start);
+	printf("**********************************************************************\n");
+
+	free(a); free(b);
+	return 0;
+cleanup: 
+	return -1;
+}
-- 
1.7.9.5
