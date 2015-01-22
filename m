From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 21 Jan 2015 20:52:57 -0800
Subject: [PATCH V2 2/3] perf symbols: improve abi compliance in arm mapping
 symbols handling
In-Reply-To: <1421902378-3634-1-git-send-email-victor.kamensky@linaro.org>
References: <1421902378-3634-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1421902378-3634-3-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both Arm and Aarch64 ELF ABI allow mapping symbols be in from
either "$d" or "$d.<any>". But current code that handles mapping
symbols only deals with the first, dollar character and a single
letter, case.

The patch adds handling of the second case with period
followed by any characters.

Suggested-by: Russell King <linux@arm.linux.org.uk>
Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Avi Kivity <avi@cloudius-systems.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 tools/perf/util/symbol-elf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1e188dd..7fd35d6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -857,17 +857,16 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		 * don't identify functions, so will confuse the profile
 		 * output: */
 		if (ehdr.e_machine == EM_ARM) {
-			if (!strcmp(elf_name, "$a") ||
-			    !strcmp(elf_name, "$d") ||
-			    !strcmp(elf_name, "$t"))
+			if (elf_name[0] == '$' && strchr("adt", elf_name[1])
+			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
 				continue;
 		}
 		/* Reject Aarch64 ELF "mapping symbols": these aren't unique and
 		 * don't identify functions, so will confuse the profile
 		 * output: */
 		if (ehdr.e_machine == EM_AARCH64) {
-			if (!strcmp(elf_name, "$x") ||
-			    !strcmp(elf_name, "$d"))
+			if (elf_name[0] == '$' && strchr("dx", elf_name[1])
+			    && (elf_name[2] == '\0' || elf_name[2] == '.'))
 				continue;
 		}
 
-- 
1.9.3
