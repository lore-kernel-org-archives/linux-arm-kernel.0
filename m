From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:18 -0800
Subject: [PATCH v2 08/18] arm64: don't disable ADR_PREL_PG_HI21* with
 ARM64_ERRATUM_843419
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-9-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_LTO_CLANG depends on GNU gold, which can generate ADR_PREL_PG_HI21*
relocations even with --fix-cortex-a53-843419.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/module.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f469e0435903..fec9a578f122 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -336,14 +336,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 0, 21,
 					     AARCH64_INSN_IMM_ADR);
 			break;
-#ifndef CONFIG_ARM64_ERRATUM_843419
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 			overflow_check = false;
 		case R_AARCH64_ADR_PREL_PG_HI21:
 			ovf = reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
 					     AARCH64_INSN_IMM_ADR);
 			break;
-#endif
 		case R_AARCH64_ADD_ABS_LO12_NC:
 		case R_AARCH64_LDST8_ABS_LO12_NC:
 			overflow_check = false;
-- 
2.15.0.448.gf294e3d99a-goog
