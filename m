From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:58:11 +0200
Subject: [PATCH] arm64: fix endianness annotation for aarch64_insn_write()
Message-ID: <20170628145811.24719-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

aarch64_insn_write() is used to write an instruction.
As on ARM64 in-memory instructions are always stored
in little-endian order, this function, taking the instruction
opcode in native order, correctly convert it to little-endian
before sending it to an helper function __aarch64_insn_write()
which will do the effective write.

This is all good, but the variable and argument holding the
converted value are not annotated for a little-endian value
but left for native values.

Fix this by adjusting the prototype of the helper and
directly using the result of cpu_to_le32() without passing
by an intermediate variable (which was not a distinct one
but the same as the one holding the native value).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/kernel/insn.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index d4d80b32c..60a2f03d7 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -126,7 +126,7 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
 	return ret;
 }
 
-static int __kprobes __aarch64_insn_write(void *addr, u32 insn)
+static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
 {
 	void *waddr = addr;
 	unsigned long flags = 0;
@@ -145,8 +145,7 @@ static int __kprobes __aarch64_insn_write(void *addr, u32 insn)
 
 int __kprobes aarch64_insn_write(void *addr, u32 insn)
 {
-	insn = cpu_to_le32(insn);
-	return __aarch64_insn_write(addr, insn);
+	return __aarch64_insn_write(addr, cpu_to_le32(insn));
 }
 
 static bool __kprobes __aarch64_insn_hotpatch_safe(u32 insn)
-- 
2.13.0
