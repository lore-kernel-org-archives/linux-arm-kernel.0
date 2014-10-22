From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 22 Oct 2014 19:32:01 +0800
Subject: [PATCH v6 3/7] ARM: kprobes: introduces checker
In-Reply-To: <1413977525-51480-1-git-send-email-wangnan0@huawei.com>
References: <1413977525-51480-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1413977525-51480-4-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introdces a 'checker' field to decode_action, and calls
checkers when instruction decoding. This allows further analysis
for specific instructions.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/arm/kernel/probes.c | 10 ++++++++++
 arch/arm/kernel/probes.h | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/probes.c b/arch/arm/kernel/probes.c
index ec030b8..6164b4d 100644
--- a/arch/arm/kernel/probes.c
+++ b/arch/arm/kernel/probes.c
@@ -393,6 +393,7 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 	const struct decode_header *h = (struct decode_header *)table;
 	const struct decode_header *next;
 	bool matched = false;
+	probes_opcode_t origin_insn = insn;
 
 	if (emulate)
 		insn = prepare_emulated_insn(insn, asi, thumb);
@@ -423,17 +424,26 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 
 		case DECODE_TYPE_CUSTOM: {
 			struct decode_custom *d = (struct decode_custom *)h;
+			probes_check_t *checker = actions[d->decoder.action].checker;
+			if (checker && (checker(origin_insn, asi, h) == INSN_REJECTED))
+				return INSN_REJECTED;
 			return actions[d->decoder.action].decoder(insn, asi, h);
 		}
 
 		case DECODE_TYPE_SIMULATE: {
 			struct decode_simulate *d = (struct decode_simulate *)h;
+			probes_check_t *checker = actions[d->handler.action].checker;
+			if (checker && (checker(origin_insn, asi, h) == INSN_REJECTED))
+				return INSN_REJECTED;
 			asi->insn_handler = actions[d->handler.action].handler;
 			return INSN_GOOD_NO_SLOT;
 		}
 
 		case DECODE_TYPE_EMULATE: {
 			struct decode_emulate *d = (struct decode_emulate *)h;
+			probes_check_t *checker = actions[d->handler.action].checker;
+			if (checker && (checker(origin_insn, asi, h) == INSN_REJECTED))
+				return INSN_REJECTED;
 
 			if (!emulate)
 				return actions[d->handler.action].decoder(insn,
diff --git a/arch/arm/kernel/probes.h b/arch/arm/kernel/probes.h
index 739c2a2..c56dd3d 100644
--- a/arch/arm/kernel/probes.h
+++ b/arch/arm/kernel/probes.h
@@ -309,9 +309,15 @@ typedef enum probes_insn (probes_custom_decode_t)(probes_opcode_t,
 						  struct arch_probes_insn *,
 						  const struct decode_header *);
 
+typedef enum probes_insn (probes_check_t)(probes_opcode_t,
+					   struct arch_probes_insn *,
+					   const struct decode_header *);
 struct decode_action {
-	probes_insn_handler_t	*handler;
-	probes_custom_decode_t	*decoder;
+	probes_check_t *checker;
+	union {
+		probes_insn_handler_t	*handler;
+		probes_custom_decode_t	*decoder;
+	};
 };
 
 #define DECODE_END			\
-- 
1.8.4
