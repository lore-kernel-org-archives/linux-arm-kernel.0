From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 13 Jun 2016 16:12:51 +0200
Subject: [PATCH] ARM: V7M: Add dsb before jumping in handler mode
Message-ID: <1465827171-15847-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to ARM AN321 (section 4.12):

"If the vector table is in writable memory such as SRAM, either relocated
by VTOR or a device dependent memory remapping mechanism, then
architecturally a memory barrier instruction is required after the vector
table entry is updated, and if the exception is to be activated
immediately"

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 7229d8d..2ddc435 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -104,6 +104,7 @@ __v7m_setup:
 	badr	r1, 1f
 	ldr	r5, [r12, #11 * 4]	@ read the SVC vector entry
 	str	r1, [r12, #11 * 4]	@ write the temporary SVC vector entry
+	dsb
 	mov	r6, lr			@ save LR
 	ldr	sp, =init_thread_union + THREAD_START_SP
 	cpsie	i
-- 
1.9.1
