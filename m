From: salyzyn@android.com (Mark Salyzyn)
Date: Thu, 12 Oct 2017 15:59:52 -0700
Subject: [PATCH v2 4/10] arm: vdso: enforce monotonic and realtime as inline
Message-ID: <20171012225956.86705-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure monotonic and realtime are inline, small price to pay for
high volume common request.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2: split first CL into 4 of 7 pieces
---
 arch/arm/vdso/vgettimeofday.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 5f596911bd53..71003a1997c4 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -99,7 +99,7 @@ static notrace int do_monotonic_coarse(const struct vdso_data *vd,
 
 #ifdef CONFIG_ARM_ARCH_TIMER
 
-static notrace u64 get_ns(const struct vdso_data *vd)
+static __always_inline notrace u64 get_ns(const struct vdso_data *vd)
 {
 	u64 cycle_delta;
 	u64 cycle_now;
@@ -115,7 +115,9 @@ static notrace u64 get_ns(const struct vdso_data *vd)
 	return nsec;
 }
 
-static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
+/* Code size doesn't matter (vdso is 4k/16k/64k anyway) and this is faster. */
+static __always_inline notrace int do_realtime(const struct vdso_data *vd,
+					       struct timespec *ts)
 {
 	u64 nsecs;
 	u32 seq;
@@ -137,7 +139,8 @@ static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 	return 0;
 }
 
-static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
+static __always_inline notrace int do_monotonic(const struct vdso_data *vd,
+						struct timespec *ts)
 {
 	struct timespec tomono;
 	u64 nsecs;
-- 
2.15.0.rc0.271.g36b669edcc-goog
