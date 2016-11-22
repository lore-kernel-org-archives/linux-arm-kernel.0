From: panand@redhat.com (Pratyush Anand)
Date: Tue, 22 Nov 2016 10:02:44 +0530
Subject: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
In-Reply-To: <cover.1479788404.git.panand@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
Message-ID: <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When "enable-dcache" is passed to the kexec() command line, kexec-tools
passes this information to purgatory, which in turn enables cache during
sha-256 verification.

RAM boundary which includes all the sections is needed for creating
identity page mapping and to enable d-cache for those areas. Therefore
these informations are passed to purgatory as well.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/include/arch/options.h |  6 +++++-
 kexec/arch/arm64/include/types.h        | 16 ++++++++++++++++
 kexec/arch/arm64/kexec-arm64.c          | 25 ++++++++++++++++++++++++-
 purgatory/arch/arm64/purgatory-arm64.c  | 11 +++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 kexec/arch/arm64/include/types.h

diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
index a17d933e396b..3e76ff04d6c1 100644
--- a/kexec/arch/arm64/include/arch/options.h
+++ b/kexec/arch/arm64/include/arch/options.h
@@ -5,13 +5,15 @@
 #define OPT_DTB			((OPT_MAX)+1)
 #define OPT_INITRD		((OPT_MAX)+2)
 #define OPT_REUSE_CMDLINE	((OPT_MAX)+3)
-#define OPT_ARCH_MAX		((OPT_MAX)+4)
+#define OPT_ENABLE_DCACHE	((OPT_MAX)+4)
+#define OPT_ARCH_MAX		((OPT_MAX)+5)
 
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 	{ "append",        1, NULL, OPT_APPEND }, \
 	{ "command-line",  1, NULL, OPT_APPEND }, \
 	{ "dtb",           1, NULL, OPT_DTB }, \
+	{ "enable-dcache", 0, NULL, OPT_ENABLE_DCACHE }, \
 	{ "initrd",        1, NULL, OPT_INITRD }, \
 	{ "ramdisk",       1, NULL, OPT_INITRD }, \
 	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
@@ -24,6 +26,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
 "     --append=STRING       Set the kernel command line to STRING.\n"
 "     --command-line=STRING Set the kernel command line to STRING.\n"
 "     --dtb=FILE            Use FILE as the device tree blob.\n"
+"     --enable-dcache       Enable D-Cache in Purgatory for faster SHA verification.\n"
 "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
 "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
 "     --reuse-cmdline       Use kernel command line from running system.\n";
@@ -32,6 +35,7 @@ struct arm64_opts {
 	const char *command_line;
 	const char *dtb;
 	const char *initrd;
+	uint8_t enable_dcache;
 };
 
 extern struct arm64_opts arm64_opts;
diff --git a/kexec/arch/arm64/include/types.h b/kexec/arch/arm64/include/types.h
new file mode 100644
index 000000000000..08f833a6d585
--- /dev/null
+++ b/kexec/arch/arm64/include/types.h
@@ -0,0 +1,16 @@
+#ifndef _TYPES_H_
+#define _TYPES_H_
+
+#define min(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x < _y ? _x : _y; })
+
+#define max(x,y) ({ \
+	typeof(x) _x = (x);	\
+	typeof(y) _y = (y);	\
+	(void) (&_x == &_y);	\
+	_x > _y ? _x : _y; })
+
+#endif /* _TYPES_H_ */
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 288548f49304..b54d1b5304f6 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -23,6 +23,7 @@
 #include "fs2dt.h"
 #include "kexec-syscall.h"
 #include "arch/options.h"
+#include "types.h"
 
 /* Global varables the core kexec routines expect. */
 
@@ -130,6 +131,9 @@ int arch_process_options(int argc, char **argv)
 		case OPT_PANIC:
 			die("load-panic (-p) not supported");
 			break;
+		case OPT_ENABLE_DCACHE:
+			arm64_opts.enable_dcache = 1;
+			break;
 		default:
 			break; /* Ignore core and unknown options. */
 		}
@@ -323,10 +327,13 @@ unsigned long arm64_locate_kernel_segment(struct kexec_info *info)
 int arm64_load_other_segments(struct kexec_info *info,
 	unsigned long image_base)
 {
-	int result;
+	int result, i;
 	unsigned long dtb_base;
 	unsigned long hole_min;
 	unsigned long hole_max;
+	unsigned long arm64_ram_start = -1;
+	unsigned long arm64_ram_end = 0;
+	uint8_t purgatory_enable_dcache;
 	char *initrd_buf = NULL;
 	struct dtb dtb;
 	char command_line[COMMAND_LINE_SIZE] = "";
@@ -337,6 +344,8 @@ int arm64_load_other_segments(struct kexec_info *info,
 		command_line[sizeof(command_line) - 1] = 0;
 	}
 
+	purgatory_enable_dcache = arm64_opts.enable_dcache;
+
 	if (arm64_opts.dtb) {
 		dtb.name = "dtb_user";
 		dtb.buf = slurp_file(arm64_opts.dtb, &dtb.size);
@@ -419,8 +428,22 @@ int arm64_load_other_segments(struct kexec_info *info,
 	elf_rel_set_symbol(&info->rhdr, "arm64_kernel_entry", &image_base,
 		sizeof(image_base));
 
+	elf_rel_set_symbol(&info->rhdr, "arm64_enable_dcache",
+		&purgatory_enable_dcache, sizeof(purgatory_enable_dcache));
+
 	elf_rel_set_symbol(&info->rhdr, "arm64_dtb_addr", &dtb_base,
 		sizeof(dtb_base));
+	for (i = 0; i < info->nr_segments; i++) {
+		arm64_ram_start = min(arm64_ram_start,
+				(unsigned long)info->segment[i].mem);
+		arm64_ram_end = max(arm64_ram_end,
+				((unsigned long)info->segment[i].mem +
+				 info->segment[i].memsz));
+	}
+	elf_rel_set_symbol(&info->rhdr, "arm64_ram_start",
+			&arm64_ram_start, sizeof(arm64_ram_start));
+	elf_rel_set_symbol(&info->rhdr, "arm64_ram_end",
+			&arm64_ram_end, sizeof(arm64_ram_end));
 
 	return 0;
 }
diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
index fe50fcf8ebc3..6d61dcbce9ac 100644
--- a/purgatory/arch/arm64/purgatory-arm64.c
+++ b/purgatory/arch/arm64/purgatory-arm64.c
@@ -4,6 +4,13 @@
 
 #include <stdint.h>
 #include <purgatory.h>
+#include "cache.h"
+
+/* Symbols set by kexec. */
+
+uint8_t arm64_enable_dcache __attribute__ ((section ("data")));
+uint64_t arm64_ram_start __attribute__ ((section ("data")));
+uint64_t arm64_ram_end __attribute__ ((section ("data")));
 
 void putchar(int ch)
 {
@@ -12,8 +19,12 @@ void putchar(int ch)
 
 void post_verification_setup_arch(void)
 {
+	if (arm64_enable_dcache)
+		disable_dcache(arm64_ram_start, arm64_ram_end);
 }
 
 void setup_arch(void)
 {
+	if (arm64_enable_dcache)
+		enable_dcache(arm64_ram_start, arm64_ram_end, 0);
 }
-- 
2.7.4
