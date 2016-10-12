From: panand@redhat.com (Pratyush Anand)
Date: Wed, 12 Oct 2016 11:28:05 +0530
Subject: [PATCH 3/4] arm64: Allow hw watchpoint of length 3,5,6 and 7
In-Reply-To: <cover.1476251587.git.panand@redhat.com>
References: <cover.1476251587.git.panand@redhat.com>
Message-ID: <d6ebb3e9776154da4c1a41f17446e9e31c891a7d.1476251587.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since, arm64 can support all offset within a double word limit. Therefore,
now support other lengths within that range as well.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/include/asm/hw_breakpoint.h |  4 ++++
 arch/arm64/kernel/hw_breakpoint.c      | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 4f4e58bee9bc..7a18c8520588 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -76,7 +76,11 @@ static inline void decode_ctrl_reg(u32 reg,
 /* Lengths */
 #define ARM_BREAKPOINT_LEN_1	0x1
 #define ARM_BREAKPOINT_LEN_2	0x3
+#define ARM_BREAKPOINT_LEN_3	0x7
 #define ARM_BREAKPOINT_LEN_4	0xf
+#define ARM_BREAKPOINT_LEN_5	0x1f
+#define ARM_BREAKPOINT_LEN_6	0x3f
+#define ARM_BREAKPOINT_LEN_7	0x7f
 #define ARM_BREAKPOINT_LEN_8	0xff
 
 /* Kernel stepping */
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index c888c23149ad..7ff2c3cfeb46 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -317,9 +317,21 @@ static int get_hbp_len(u8 hbp_len)
 	case ARM_BREAKPOINT_LEN_2:
 		len_in_bytes = 2;
 		break;
+	case ARM_BREAKPOINT_LEN_3:
+		len_in_bytes = 3;
+		break;
 	case ARM_BREAKPOINT_LEN_4:
 		len_in_bytes = 4;
 		break;
+	case ARM_BREAKPOINT_LEN_5:
+		len_in_bytes = 5;
+		break;
+	case ARM_BREAKPOINT_LEN_6:
+		len_in_bytes = 6;
+		break;
+	case ARM_BREAKPOINT_LEN_7:
+		len_in_bytes = 7;
+		break;
 	case ARM_BREAKPOINT_LEN_8:
 		len_in_bytes = 8;
 		break;
@@ -379,9 +391,21 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 	case ARM_BREAKPOINT_LEN_2:
 		*gen_len = HW_BREAKPOINT_LEN_2;
 		break;
+	case ARM_BREAKPOINT_LEN_3:
+		*gen_len = HW_BREAKPOINT_LEN_3;
+		break;
 	case ARM_BREAKPOINT_LEN_4:
 		*gen_len = HW_BREAKPOINT_LEN_4;
 		break;
+	case ARM_BREAKPOINT_LEN_5:
+		*gen_len = HW_BREAKPOINT_LEN_5;
+		break;
+	case ARM_BREAKPOINT_LEN_6:
+		*gen_len = HW_BREAKPOINT_LEN_6;
+		break;
+	case ARM_BREAKPOINT_LEN_7:
+		*gen_len = HW_BREAKPOINT_LEN_7;
+		break;
 	case ARM_BREAKPOINT_LEN_8:
 		*gen_len = HW_BREAKPOINT_LEN_8;
 		break;
@@ -425,9 +449,21 @@ static int arch_build_bp_info(struct perf_event *bp)
 	case HW_BREAKPOINT_LEN_2:
 		info->ctrl.len = ARM_BREAKPOINT_LEN_2;
 		break;
+	case HW_BREAKPOINT_LEN_3:
+		info->ctrl.len = ARM_BREAKPOINT_LEN_3;
+		break;
 	case HW_BREAKPOINT_LEN_4:
 		info->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		break;
+	case HW_BREAKPOINT_LEN_5:
+		info->ctrl.len = ARM_BREAKPOINT_LEN_5;
+		break;
+	case HW_BREAKPOINT_LEN_6:
+		info->ctrl.len = ARM_BREAKPOINT_LEN_6;
+		break;
+	case HW_BREAKPOINT_LEN_7:
+		info->ctrl.len = ARM_BREAKPOINT_LEN_7;
+		break;
 	case HW_BREAKPOINT_LEN_8:
 		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
 		break;
-- 
2.7.4
