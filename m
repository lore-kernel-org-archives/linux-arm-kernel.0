From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Wed, 11 Feb 2015 18:09:00 -0300
Subject: [PATCH 06/21] perf symbols: Ignore mapping symbols on aarch64
In-Reply-To: <1423688955-8094-1-git-send-email-acme@kernel.org>
References: <1423688955-8094-1-git-send-email-acme@kernel.org>
Message-ID: <1423688955-8094-7-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

Aarch64 ELF files use mapping symbols with special names $x, $d
to identify regions of Aarch64 code (see Aarch64 ELF ABI - "ARM
IHI 0056B", section "4.5.4 Mapping symbols").

The patch filters out these symbols at load time, similar to
"696b97a perf symbols: Ignore mapping symbols on ARM" changes
done for ARM before V8.

Also added handling of mapping symbols that has format
"$d.<any>" and similar for both cases.

Note we are not making difference between EM_ARM and
EM_AARCH64 mapping symbols instead code handles superset
of both.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Avi Kivity <avi@cloudius-systems.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Russell King <linux@arm.linux.org.uk>
Link: http://lkml.kernel.org/r/1422340442-4673-2-git-send-email-victor.kamensky at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b24f9d8727a8..225eb73ee78b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -859,10 +859,9 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		/* Reject ARM ELF "mapping symbols": these aren't unique and
 		 * don't identify functions, so will confuse the profile
 		 * output: */
-		if (ehdr.e_machine == EM_ARM) {
-			if (!strcmp(elf_name, "$a") ||
-			    !strcmp(elf_name, "$d") ||
-			    !strcmp(elf_name, "$t"))
+		if (ehdr.e_machine == EM_ARM || ehdr.e_machine == EM_AARCH64) {
+			if (elf_name[0] == '$' && strchr("adtx", elf_name[1])
+			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
 				continue;
 		}
 
-- 
1.9.3
