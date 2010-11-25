From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Nov 2010 17:08:18 +0000
Subject: [PATCH 3/4] ARM: hw_breakpoint: correct and simplify alignment fixup
	code
In-Reply-To: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
References: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
Message-ID: <1290704899-13051-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current hw_breakpoint code tries to fix up the alignment of
breakpoints so that we can make use of sparse byte-address-select
bits in the control register and give the illusion that we can
set breakpoints on unaligned addresses.

Although this works on v6 cores, v7 forbids this behaviour, instead
requiring breakpoints to be set on aligned addresses and have contiguous
byte-address-select ranges depending on the instruction set in use.
For ARM the only supported size is 4 bytes, whilst Thumb-2 also permits
2 byte breakpoints (watchpoints can be of 1, 2, 4 or 8 bytes long).

This patch simplifies the alignment fixup code so that we require
addresses to be aligned to the size of the corresponding breakpoint.
This allows us to handle the common case of breaking on a half-word
aligned Thumb-2 instruction and also allows us to set byte watchpoints
on arbitrary addresses.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   56 +++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 515a3c4..550d949 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -537,6 +537,17 @@ static int arch_build_bp_info(struct perf_event *bp)
 		return -EINVAL;
 	}
 
+	/*
+	 * Breakpoints must be of length 2 (thumb) or 4 (ARM) bytes.
+	 * Watchpoints can be of length 1, 2, 4 or 8 bytes if supported
+	 * by the hardware and must be aligned to the appropriate number of
+	 * bytes.
+	 */
+	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE &&
+	    info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
+	    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
+		return -EINVAL;
+
 	/* Address */
 	info->address = bp->attr.bp_addr;
 
@@ -561,7 +572,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	int ret = 0;
-	u32 bytelen, max_len, offset, alignment_mask = 0x3;
+	u32 offset, alignment_mask = 0x3;
 
 	/* Build the arch_hw_breakpoint. */
 	ret = arch_build_bp_info(bp);
@@ -571,32 +582,27 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	/* Check address alignment. */
 	if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 		alignment_mask = 0x7;
-	if (info->address & alignment_mask) {
-		/*
-		 * Try to fix the alignment. This may result in a length
-		 * that is too large, so we must check for that.
-		 */
-		bytelen = get_hbp_len(info->ctrl.len);
-		max_len = info->ctrl.type == ARM_BREAKPOINT_EXECUTE ? 4 :
-				max_watchpoint_len;
-
-		if (max_len >= 8)
-			offset = info->address & 0x7;
-		else
-			offset = info->address & 0x3;
-
-		if (bytelen > (1 << ((max_len - (offset + 1)) >> 1))) {
-			ret = -EFBIG;
-			goto out;
-		}
-
-		info->ctrl.len <<= offset;
-		info->address &= ~offset;
-
-		pr_debug("breakpoint alignment fixup: length = 0x%x, "
-			"address = 0x%x\n", info->ctrl.len, info->address);
+	offset = info->address & alignment_mask;
+	switch (offset) {
+	case 0:
+		/* Aligned */
+		break;
+	case 1:
+		/* Allow single byte watchpoint. */
+		if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
+			break;
+	case 2:
+		/* Allow halfword watchpoints and breakpoints. */
+		if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
+			break;
+	default:
+		ret = -EINVAL;
+		goto out;
 	}
 
+	info->address &= ~alignment_mask;
+	info->ctrl.len <<= offset;
+
 	/*
 	 * Currently we rely on an overflow handler to take
 	 * care of single-stepping the breakpoint when it fires.
-- 
1.7.0.4
