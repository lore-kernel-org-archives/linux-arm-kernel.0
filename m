From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 12 Aug 2011 10:45:27 +0100
Subject: [PATCH kernel-3.0] arm:cache-l2x0: Fix L2 Cache size calculation.
Message-ID: <1313142327-18320-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch fixes L2 Cache size calculations for L2C-210, L2C-310 and
PL310, by changing the L2X0_AUX_CTRL_WAY_SIZE_MASK from 2 bits to 3
bits.

The Auxiliary Control Register for L2C-210, L2C-310 and PL310 has 3bits
[19:17] for Way size, however the existing code only uses 2 bits to
get this value. This results in incorrect cachesize calculations.

I should say this bug does not result in issue but, its just prints
incorrect values.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
Hi All,
I found an bug in L2 Cache size calculation in cache-l2x0 code.

According to ARM TRM for L2C-210, L2C-310 and PL310, the Auxiliary
Control Register has 3bits [19:17] allocated for Way size,however
the existing code only uses 2 bits to get this value from Aux 
control register. This results in incorrect cache size calculations.

thanks, 
srini


 arch/arm/include/asm/hardware/cache-l2x0.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 16bd480..bfa706f 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -64,7 +64,7 @@
 #define L2X0_AUX_CTRL_MASK			0xc0000fff
 #define L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT	16
 #define L2X0_AUX_CTRL_WAY_SIZE_SHIFT		17
-#define L2X0_AUX_CTRL_WAY_SIZE_MASK		(0x3 << 17)
+#define L2X0_AUX_CTRL_WAY_SIZE_MASK		(0x7 << 17)
 #define L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT	22
 #define L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT		26
 #define L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT		27
-- 
1.6.3.3
