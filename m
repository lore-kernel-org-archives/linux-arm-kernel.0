From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:58:09 +0200
Subject: [PATCH] arm64: fix endianness annotation in aarch64_insn_read()
Message-ID: <20170628145809.24675-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function arch64_insn_read() is used to read an instruction.
On AM64 instructions are always stored in little-endian order
and thus the function correctly do a little-to-native endian
conversion to the value just read.

However, the variable used to hold the value before the conversion
is not declared for a little-endian value but for a native one.

Fix this by using the correct type for the declaration: __le32

Note: This only works because the function reading the value,
      probe_kernel_read((), takes a void pointer and void pointers
      are endian-agnostic. Otherwise probe_kernel_read() should
      also be properly annotated (or worse, need to be specialized).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/kernel/insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index b884a926a..d4d80b32c 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -117,7 +117,7 @@ static void __kprobes patch_unmap(int fixmap)
 int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
 {
 	int ret;
-	u32 val;
+	__le32 val;
 
 	ret = probe_kernel_read(&val, addr, AARCH64_INSN_SIZE);
 	if (!ret)
-- 
2.13.0
