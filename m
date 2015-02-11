From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Wed, 11 Feb 2015 18:09:01 -0300
Subject: [PATCH 07/21] perf symbols: debuglink should take symfs option into
 account
In-Reply-To: <1423688955-8094-1-git-send-email-acme@kernel.org>
References: <1423688955-8094-1-git-send-email-acme@kernel.org>
Message-ID: <1423688955-8094-8-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

Currently code that tries to read corresponding debug symbol file from
.gnu_debuglink section (DSO_BINARY_TYPE__DEBUGLINK) does not take in
account symfs option, so filename__read_debuglink function cannot open
ELF file, if symfs option is used.

Fix is to add proper handling of symfs as it is done in other places:
use __symbol__join_symfs function to get real file name of target ELF
file.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Tested-by: David Ahern <dsahern@gmail.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Avi Kivity <avi@cloudius-systems.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Waiman Long <Waiman.Long@hp.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1422340442-4673-3-git-send-email-victor.kamensky at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a8b3f18db1a5..814554d1b857 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -45,13 +45,13 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__DEBUGLINK: {
 		char *debuglink;
 
-		strncpy(filename, dso->long_name, size);
-		debuglink = filename + dso->long_name_len;
+		len = __symbol__join_symfs(filename, size, dso->long_name);
+		debuglink = filename + len;
 		while (debuglink != filename && *debuglink != '/')
 			debuglink--;
 		if (*debuglink == '/')
 			debuglink++;
-		ret = filename__read_debuglink(dso->long_name, debuglink,
+		ret = filename__read_debuglink(filename, debuglink,
 					       size - (debuglink - filename));
 		}
 		break;
-- 
1.9.3
