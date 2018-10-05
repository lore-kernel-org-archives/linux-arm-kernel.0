From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2018 18:15:49 +0200
Subject: [PATCH] ARM: orion: avoid VLA in orion_mpp_conf
Message-ID: <20181005161601.875388-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testing randconfig builds found an instance of a VLA that was
missed when determining that we have removed them all:

arch/arm/plat-orion/mpp.c: In function 'orion_mpp_conf':
arch/arm/plat-orion/mpp.c:31:2: error: ISO C90 forbids variable length array 'mpp_ctrl' [-Werror=vla]

This one is fairly straightforward: we know what all three
callers are, and the maximum length is not very long.

Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-orion/mpp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
index 5b4ff9373c89..8a6880d528b6 100644
--- a/arch/arm/plat-orion/mpp.c
+++ b/arch/arm/plat-orion/mpp.c
@@ -28,10 +28,15 @@ void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
 			   unsigned int mpp_max, void __iomem *dev_bus)
 {
 	unsigned int mpp_nr_regs = (1 + mpp_max/8);
-	u32 mpp_ctrl[mpp_nr_regs];
+	u32 mpp_ctrl[8];
 	int i;
 
 	printk(KERN_DEBUG "initial MPP regs:");
+	if (mpp_nr_regs > ARRAY_SIZE(mpp_ctrl)) {
+		printk(KERN_ERR "orion_mpp_conf: invalid mpp_max\n");
+		return;
+	}
+
 	for (i = 0; i < mpp_nr_regs; i++) {
 		mpp_ctrl[i] = readl(mpp_ctrl_addr(i, dev_bus));
 		printk(" %08x", mpp_ctrl[i]);
-- 
2.18.0
