From: rabin@rab.in (Rabin Vincent)
Date: Tue,  3 Apr 2012 23:19:04 +0530
Subject: [PATCH] ARM: jump_label: fixup for rename to static_key
Message-ID: <1333475344-18936-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

c5905afb0 ("static keys: Introduce 'struct static_key'...") renamed
struct jump_label_key to struct static_key.  Fixup ARM for this to
eliminate these build warnings:

  include/linux/jump_label.h:113:2:
  warning: passing argument 1 of 'arch_static_branch' from incompatible pointer type
  include/asm/jump_label.h:17:82:
  note: expected 'struct jump_label_key *' but argument is of type 'struct static_key *'

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/include/asm/jump_label.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index 5c5ca2e..bfc198c 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -14,7 +14,7 @@
 #define JUMP_LABEL_NOP	"nop"
 #endif
 
-static __always_inline bool arch_static_branch(struct jump_label_key *key)
+static __always_inline bool arch_static_branch(struct static_key *key)
 {
 	asm goto("1:\n\t"
 		 JUMP_LABEL_NOP "\n\t"
-- 
1.7.9.1
