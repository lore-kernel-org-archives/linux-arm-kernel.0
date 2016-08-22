From: matija.glavinic-pecotic.ext@nokia.com (Matija Glavinic Pecotic)
Date: Mon, 22 Aug 2016 07:37:55 +0200
Subject: [PATCH RFC] Perf: lookup dwarf unwind stack info in debug file
 pointed by .gnu_debuglink
Message-ID: <10e54587-8feb-fc25-616d-3c489a2856a5@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using perf with call graph method dwarf fails to provide backtrace support with
stripped binary even though .gnu_debuglink points to *.dbg flavor with properly
populated debug symbols.

Problem is reproduced on ARM (v7), kernels 3.14.y, 4.4.y and 4.8.0-rc2. Perf is
configured with libunwind and unwind dwarf support:
https://wiki.linaro.org/LEG/Engineering/TOOLS/perf-callstack-unwinding

Test code (stress_bt.c) can be found here:
https://wiki.linaro.org/LEG/Engineering/TOOLS/perf-callstack-unwinding#Backtrace_stress_application

Executing (explicitly disable other unwinding methods, disable caching):

$ gcc -g -o stress_bt -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables stress_bt.c
$ perf record -N --call-graph dwarf ./stress_bt
$ perf report

results in properly generated call graph. Stripping the binary and rerunning it
results with missing callgraph. Expected result is that callgraph is generated:

$ gcc -g -o stress_bt -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables stress_bt.c
$ objcopy --only-keep-debug stress_bt stress_bt.dbg
$ objcopy --strip-debug stress_bt
$ objcopy --add-gnu-debuglink=stress_bt.dbg stress_bt
$ perf record -N --call-graph dwarf ./stress_bt
$ perf report

The patch itself is for the sake of discussion and it is not proposed solution.
I understood the problem as perf not even trying to lookup into debug version,
but only in the original dso. Patch tries to read unwinding info from the same
directory where stripped version resides. What is missing is lookup in other
standard locations, and of course proper integration, I'm sure debug package
should be treated like the rest of dsos.

Interesting to note, I could not reproduce on x86_64 with above given compiler
flags, call graph was not generated, regardless of stripping the binary. I had
to define asynchronous-unwind-tables:

$ gcc -g -o stress_bt -fomit-frame-pointer -fno-unwind-tables -fasynchronous-unwind-tables stress_bt.c
$ perf record -N --call-graph dwarf ./stress_bt
$ perf report

which makes me wonder about dwarf on x86. Since our target is arm, I have not
delved into this, but problem should not be arch specific.

Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
---
 tools/perf/util/unwind-libunwind-local.c | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 97c0f8f..5d40acd 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -35,6 +35,7 @@
 #include "util.h"
 #include "debug.h"
 #include "asm/bug.h"
+#include "dso.h"
 
 extern int
 UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
@@ -292,10 +293,13 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct machine *machine,
 
 #ifndef NO_LIBUNWIND_DEBUG_FRAME
 static int read_unwind_spec_debug_frame(struct dso *dso,
-					struct machine *machine, u64 *offset)
+					struct machine *machine, u64 *offset,
+					char **symfile)
 {
 	int fd;
 	u64 ofs = dso->data.debug_frame_offset;
+	char *debuglink = malloc(PATH_MAX);
+	int ret = 0;
 
 	if (ofs == 0) {
 		fd = dso__data_get_fd(dso, machine);
@@ -312,6 +316,26 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 	if (*offset)
 		return 0;
 
+	/* If not found, try to lookup in debuglink */
+	ret = dso__read_binary_type_filename(
+			dso, DSO_BINARY_TYPE__DEBUGLINK,
+			machine->root_dir, debuglink, PATH_MAX);
+	if (!ret) {
+		pr_debug("%s: dso: %s, ret: %d, debuglink: <%s>\n",
+			__func__, dso->short_name, ret, debuglink);
+
+		fd = open(debuglink, O_RDONLY);
+		if (fd >= 0) {
+			ofs = elf_section_offset(fd, ".debug_frame");
+			close(fd);
+
+			if (ofs) {
+				*symfile = debuglink;
+				return 0;
+			}
+		}
+	}
+
 	return -EINVAL;
 }
 #endif
@@ -343,6 +367,7 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 	unw_dyn_info_t di;
 	u64 table_data, segbase, fde_count;
 	int ret = -EINVAL;
+	char *symfile = NULL;
 
 	map = find_map(ip, ui);
 	if (!map || !map->dso)
@@ -368,16 +393,19 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 #ifndef NO_LIBUNWIND_DEBUG_FRAME
 	/* Check the .debug_frame section for unwinding info */
 	if (ret < 0 &&
-	    !read_unwind_spec_debug_frame(map->dso, ui->machine, &segbase)) {
+	    !read_unwind_spec_debug_frame(
+		    map->dso, ui->machine, &segbase, &symfile)) {
 		int fd = dso__data_get_fd(map->dso, ui->machine);
 		int is_exec = elf_is_exec(fd, map->dso->name);
 		unw_word_t base = is_exec ? 0 : map->start;
-		const char *symfile;
 
 		if (fd >= 0)
 			dso__data_put_fd(map->dso);
 
-		symfile = map->dso->symsrc_filename ?: map->dso->name;
+		if (!symfile)
+			symfile = map->dso->symsrc_filename ?: map->dso->name;
+
+		pr_debug("%s: using symfile %s\n", __func__, symfile);
 
 		memset(&di, 0, sizeof(di));
 		if (dwarf_find_debug_frame(0, &di, ip, base, symfile,
-- 
2.1.4
