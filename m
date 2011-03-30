From: viktor.rosendahl@nokia.com (Viktor Rosendahl)
Date: Wed, 30 Mar 2011 16:42:30 +0300
Subject: [PATCH] Reject kprobes when Rn==15 and writeback is set
In-Reply-To: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>
References: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>
Message-ID: <1301492550-16747-1-git-send-email-viktor.rosendahl@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2011 09:44 PM, ext Nicolas Pitre wrote:
 > On Tue, 29 Mar 2011, Russell King - ARM Linux wrote:
 >
 >> On Tue, Mar 29, 2011 at 12:55:27PM -0400, Nicolas Pitre wrote:
 >>> Sorry, I meant r15-indexed with a write back.
 >>
 >> I believe that's unpredictable.  So actually you can make kprobes do
 >> anything you like with it - no one should ever generate an instruction
 >> which read-modify-writes the PC.
 >
 > Indeed.  Hence my suggestion to simply refuse and abort the placement of
 > a probe on such instructions and keep the actual emulation code free of
 > tests for those odd cases.  In practice this shouldn't affect anyone.
 >

Here is a patch for implementing the rejection of probes on those instructions,
with Rn == 15 and writeback enabled. Those previous patches are still
required, since they fix the emulation of the fully legal instructions where
Rn == 15 and writeback isn't enabled.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 arch/arm/kernel/kprobes-decode.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 3b0cf90..b5c89c8 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -868,6 +868,15 @@ static enum kprobe_insn __kprobes
 prep_emulate_ldr_str(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	int ibit = (insn & (1 << 26)) ? 25 : 22;
+	int is_preindexed = (insn >> 24) & 0x1;
+	int is_writeback = (insn >> 21) & 0x1;
+	int rn = (insn >> 16) & 0xf;
+
+	/* Writeback is always enabled in post-indexed mode. */
+	is_writeback = is_writeback || !is_preindexed;
+	/* writeback to PC is unpredictable, so reject it */
+	if (is_writeback && rn == 15)
+		return INSN_REJECTED;
 
 	insn &= 0xfff00fff;
 	insn |= 0x00001000;	/* Rn = r0, Rd = r1 */
@@ -1115,6 +1124,16 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 			return prep_emulate_rd12rn16rm0_wflags(insn, asi);
 		} else if ((insn & 0x0e1000d0) == 0x00000d0) {
 			/* STRD/LDRD */
+			int is_preindexed = (insn >> 24) & 0x1;
+			int is_writeback = (insn >> 21) & 0x1;
+			int rn = (insn >> 16) & 0xf;
+
+			/* Writeback is always enabled in post-indexed mode. */
+			is_writeback = is_writeback || !is_preindexed;
+			/* writeback to PC is unpredictable, so reject it */
+			if (is_writeback && rn == 15)
+				return INSN_REJECTED;
+
 			insn &= 0xfff00fff;
 			insn |= 0x00002000;	/* Rn = r0, Rd = r2 */
 			if (insn & (1 << 22)) {
-- 
1.7.2.5
