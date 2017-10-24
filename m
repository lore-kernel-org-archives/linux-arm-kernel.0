From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 24 Oct 2017 03:04:08 -0500
Subject: [RFC 2/3] perf tool: stat: say more about why event is not
 supported by the kernel
Message-ID: <20171024030408.d29c81d6134bf63df18ae618@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call perf_evsel__open_strerror() to potentially expand upon why the
event was "not supported by the kernel."  See the enhanced '-v' example
output messages in the next patch.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/builtin-stat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 69523ed55894..8f0323db3c00 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -625,9 +625,13 @@ static int __run_perf_stat(int argc, const char **argv)
 			if (errno == EINVAL || errno == ENOSYS ||
 			    errno == ENOENT || errno == EOPNOTSUPP ||
 			    errno == ENXIO) {
-				if (verbose > 0)
+				if (verbose > 0) {
 					ui__warning("%s event is not supported by the kernel.\n",
 						    perf_evsel__name(counter));
+					perf_evsel__open_strerror(counter, &target,
+								  errno, msg, sizeof(msg));
+					ui__error("%s\n", msg);
+				}
 				counter->supported = false;
 
 				if ((counter->leader != counter) ||
-- 
2.14.2
