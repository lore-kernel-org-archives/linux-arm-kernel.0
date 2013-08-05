From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  5 Aug 2013 11:32:23 +0100
Subject: [PATCH] ARM: fix is_gate_vma() when CONFIG_KUSER_HELPERS is enabled
Message-ID: <1375698743-2738-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a5463cd34354 (ARM: make vectors page inaccessible from
userspace) introduced the is_gate_vma() facility to identify the
vectors page, but a typo broke the /proc/<pid>/maps output:

[...]
b6ef4000-b6f0b000 r-xp 00000000 00:0c 3953760    /lib/arm-linux-gnueabi/ld-2.15.so
b6f0d000-b6f11000 rw-p 00000000 00:00 0          [vectors]
b6f11000-b6f12000 r-xp 00000000 00:00 0          [vectors]
b6f12000-b6f13000 r--p 00016000 00:0c 3953760    /lib/arm-linux-gnueabi/ld-2.15.so
b6f13000-b6f14000 rw-p 00017000 00:0c 3953760    /lib/arm-linux-gnueabi/ld-2.15.so
be886000-be8a7000 rw-p 00000000 00:00 0          [vectors]
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]
[...]

With the fix in place, it now reads (different run, hence the
slightly different output):

[...]
b6fb1000-b6fc8000 r-xp 00000000 00:0c 3953760    /lib/arm-linux-gnueabi/ld-2.15.so
b6fca000-b6fce000 rw-p 00000000 00:00 0
b6fce000-b6fcf000 r-xp 00000000 00:00 0          [sigpage]
b6fcf000-b6fd0000 r--p 00016000 00:0c 3953760    /lib/arm-linux-gnueabi/ld-2.15.so
b6fd0000-b6fd1000 rw-p 00017000 00:0c 3953760    /lib/arm-linux-gnueabi/ld-2.15.so
bea41000-bea62000 rw-p 00000000 00:00 0          [stack]
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]
[...]

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 536c85f..94f6b05 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -462,7 +462,7 @@ int in_gate_area_no_mm(unsigned long addr)
 {
 	return in_gate_area(NULL, addr);
 }
-#define is_gate_vma(vma)	((vma) = &gate_vma)
+#define is_gate_vma(vma)	((vma) == &gate_vma)
 #else
 #define is_gate_vma(vma)	0
 #endif
-- 
1.8.2.3
