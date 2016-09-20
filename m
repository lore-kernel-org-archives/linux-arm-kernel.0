From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Sep 2016 19:03:21 +0900
Subject: [PATCH] arm64: kgdb: handle read-only text / modules
Message-ID: <20160920100321.17846-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle read-only cases (CONFIG_DEBUG_RODATA/CONFIG_DEBUG_SET_MODULE_RONX)
by using aarch64_insn_write() instead of probe_kernel_write().
See how this works:
    commit 2f896d586610 ("arm64: use fixmap for text patching")

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <stable@vger.kernel.org> # 4.0-
---
 arch/arm64/kernel/kgdb.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 6732a27..133cfe3 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -382,3 +382,23 @@ struct kgdb_arch arch_kgdb_ops = {
 		KGDB_DYN_BRK_INS_BYTE(3),
 	}
 };
+
+int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
+{
+	int err;
+
+	BUILD_BUG_ON(AARCH64_INSN_SIZE != BREAK_INSTR_SIZE);
+
+	err = aarch64_insn_read((void *)bpt->bpt_addr, (u32 *)bpt->saved_instr);
+	if (err)
+		return err;
+
+	return aarch64_insn_write((void *)bpt->bpt_addr,
+			(u32)AARCH64_BREAK_KGDB_DYN_DBG);
+}
+
+int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
+{
+	return aarch64_insn_write((void *)bpt->bpt_addr,
+			*(u32 *)bpt->saved_instr);
+}
-- 
2.10.0
