From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 24 Oct 2017 20:23:00 -0500
Subject: [RFC 1/3] perf tool: Introduce arch-specific supplemental perf
 open strerror capability
In-Reply-To: <20171024142744.GE2512@redhat.com>
References: <20171024030404.ec366ec2d9c38910ccd84ba5@arm.com>
 <20171024142744.GE2512@redhat.com>
Message-ID: <20171024202300.de189fde683c939966a6646c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Oct 2017 12:27:44 -0200
Arnaldo Carvalho de Melo <acme@redhat.com> wrote:

> Em Tue, Oct 24, 2017 at 03:04:04AM -0500, Kim Phillips escreveu:
> > Introduce new tools/perf/arch/*/util/evsel.c:perf_evsel__suppl_strerror()
> 
> The naming... suppl for what? for the open operation? strerror() methods
> are associated with another method, one for which it can use context
> like who is the user asking for that operation, procfs/sysfs knobs,
> hardware, etc, so we need to have CLASS__METHOD_strerror()
> 
> In this case, CLASS == perf_evsel, METHOD = open, so, if you want to
> have something that is _arch_ specific, we could use something like:
> 
> int __weak perf_evsel__open_strerror_arch(struct perf_evsel *evsel __maybe_unused,
> 					  struct target *target __maybe_unused,
> 					  int err __maybe_unused,
> 					  char *msg __maybe_unused,
> 					  size_t size __maybe_unused)
> {
> 	return 0;
> }
> 
> But then you're calling it _before_ the existing switch (err), humm...
> I.e. it will add stuff before the string that will be formatted later...
> The messages may end up being conflicting, I wonder if the model
> wouldn't be better as: ask the arch specific if it wants to override
> that specific error with something, if not, fallback to the existing
> perf_evsel__open_strerror() code, that could be moved to be
> __perf_evsel__open_strerror() and called by the arch specific code.
> 
> Thoughts?

Thanks for your good feedback, yes, very good idea, fully agreed and
implemented - see below.

Thanks,

Kim

>From 6877c8703c0eb186370ed20eee0dfc4ba53980da Mon Sep 17 00:00:00 2001
From: Kim Phillips <kim.phillips@arm.com>
Date: Tue, 24 Oct 2017 03:04:04 -0500
Subject: [PATCH] perf tool: Introduce arch-specific perf open strerror
 capability

Introduce new tools/perf/arch/*/util/evsel.c:perf_evsel__strerror_arch()
so each arch can start to customize usability for its h/w PMU drivers.

v2:

Addressed ACME's comments:

- Renamed perf_evsel__suppl_strerror() perf_evsel__open_strerror_arch()
  ['suppl' was for supplementary, from D. Howell's prior submission:
   "[06/27] Provide supplementary error message facility [ver #5]"].

- Changed the logic such that if arch version - called first - doesn't put
  anything in the string, then call the existing, generic
  __perf_evsel__open_strerror() (renamed from perf_evsel__open_strerror()).
  Otherwise, only the string returned from the arch version is emitted.
  All references to 'supplemental' dropped as a consequence.

Also tried addressing Will's comments:

- Looked at possibly reducing the number of parameters, but since both evsel
  and target elements are used to evaluate the condition the error occurred in,
  and err, msg, and size are required for basic strerror functioning, they all
  got to stay.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/arch/x86/util/Build   |  1 +
 tools/perf/arch/x86/util/evsel.c | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.c          | 32 ++++++++++++++++++++++++--------
 tools/perf/util/evsel.h          |  2 ++
 4 files changed, 51 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/evsel.c

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index f95e6f46ef0d..90ae9358ec21 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -4,6 +4,7 @@ libperf-y += pmu.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
 libperf-y += group.o
+libperf-y += evsel.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
new file mode 100644
index 000000000000..20a8ebc83657
--- /dev/null
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -0,0 +1,24 @@
+#include <string.h>
+
+#include <linux/perf_event.h>
+#include <linux/err.h>
+
+#include "../../util/evsel.h"
+
+int perf_evsel__open_strerror_arch(struct perf_evsel *evsel,
+				   struct target *target __maybe_unused,
+				   int err, char *msg, size_t size)
+{
+	switch (err) {
+	case EOPNOTSUPP:
+		if (evsel->attr.type == PERF_TYPE_HARDWARE)
+			return scnprintf(msg, size, "%s",
+	"No hardware sampling interrupt available.\n"
+	"No APIC? If so then you can boot the kernel with the \"lapic\" boot parameter to force-enable it.");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3ec0aed0bdcb..0f53450cfc7b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2686,8 +2686,18 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
-int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
-			      int err, char *msg, size_t size)
+int __weak perf_evsel__open_strerror_arch(struct perf_evsel *evsel __maybe_unused,
+					  struct target *target __maybe_unused,
+					  int err __maybe_unused,
+					  char *msg __maybe_unused,
+					  size_t size __maybe_unused)
+{
+	return 0;
+}
+
+static int __perf_evsel__open_strerror(struct perf_evsel *evsel,
+				       struct target *target,
+				       int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0;
@@ -2745,12 +2755,6 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 		if (evsel->attr.precise_ip)
 			return scnprintf(msg, size, "%s",
 	"\'precise\' request may not be supported. Try removing 'p' modifier.");
-#if defined(__i386__) || defined(__x86_64__)
-		if (evsel->attr.type == PERF_TYPE_HARDWARE)
-			return scnprintf(msg, size, "%s",
-	"No hardware sampling interrupt available.\n"
-	"No APIC? If so then you can boot the kernel with the \"lapic\" boot parameter to force-enable it.");
-#endif
 		break;
 	case EBUSY:
 		if (find_process("oprofiled"))
@@ -2778,6 +2782,18 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			 perf_evsel__name(evsel));
 }
 
+int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
+			      int err, char *msg, size_t size)
+{
+	int printed;
+
+	printed = perf_evsel__open_strerror_arch(evsel, target, err, msg, size);
+	if (printed)
+		return printed;
+
+	return __perf_evsel__open_strerror(evsel, target, err, msg, size);
+}
+
 char *perf_evsel__env_arch(struct perf_evsel *evsel)
 {
 	if (evsel && evsel->evlist && evsel->evlist->env)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 77bd310eb0cb..a3822174ac0f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -416,6 +416,8 @@ bool perf_evsel__fallback(struct perf_evsel *evsel, int err,
 			  char *msg, size_t msgsize);
 int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size);
+int perf_evsel__open_strerror_arch(struct perf_evsel *evsel, struct target *target,
+			       int err, char *msg, size_t size);
 
 static inline int perf_evsel__group_idx(struct perf_evsel *evsel)
 {
-- 
2.14.2
