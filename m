From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 17 Jan 2014 17:13:18 +0900
Subject: [PATCH v2 5/6] arm64: audit: Add makefile rule to create unistd_32.h
 for compat syscalls
In-Reply-To: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1389946399-4525-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

generic compat sycall audit (lib/compat_audit.c) requires unistd_32.h
for __NR_xyx compat syscall numbers. This is a different file from unistd32.h
on arm64 and so it must be generated from unistd32.h.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Makefile                 |    4 ++++
 arch/arm64/kernel/syscalls/Makefile |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 arch/arm64/kernel/syscalls/Makefile

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2fceb71..6d24f92 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -72,6 +72,10 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
 
+# Compat syscall header generation
+archheaders:
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/syscalls $@
+
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/arm64/kernel/syscalls/Makefile b/arch/arm64/kernel/syscalls/Makefile
new file mode 100644
index 0000000..7661113
--- /dev/null
+++ b/arch/arm64/kernel/syscalls/Makefile
@@ -0,0 +1,20 @@
+out := $(obj)/../../include/generated/asm
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+syshdr-$(CONFIG_COMPAT)		+= unistd_32.h
+
+targets	+= $(syshdr-y)
+
+quiet_cmd_syshdr = SYSHDR $@
+	cmd_syshdr = cat $< | sed -r \
+	-e 's/compat_//' \
+	-e 's/_wrapper//' \
+	-e 's/^__SYSCALL\((.*),[ ]*sys_([^)].*)\).*/\#define __NR_\2 \1/p;d' \
+	| grep -v __NR_ni_syscall > $@
+
+archheaders: $(addprefix $(out)/,$(syshdr-y))
+
+$(out)/unistd_32.h: $(src)/../../include/asm/unistd32.h
+	$(call if_changed,syshdr)
-- 
1.7.9.5
