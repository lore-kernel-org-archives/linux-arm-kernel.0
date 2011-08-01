From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:06 +0100
Subject: [PATCH 5/9] kirkwood: make __arch_ioremap() with 0 size return NULL
In-Reply-To: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
References: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312201870-12921-5-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-kirkwood/include/mach/io.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-kirkwood/include/mach/io.h
index 1aaddc3..76345eb 100644
--- a/arch/arm/mach-kirkwood/include/mach/io.h
+++ b/arch/arm/mach-kirkwood/include/mach/io.h
@@ -24,6 +24,10 @@ __arch_ioremap(unsigned long paddr, size_t size, unsigned int mtype)
 {
 	void __iomem *retval;
 	unsigned long offs = paddr - KIRKWOOD_REGS_PHYS_BASE;
+
+	if (!size)
+		return NULL;
+
 	if (mtype == MT_DEVICE && size && offs < KIRKWOOD_REGS_SIZE &&
 	    size <= KIRKWOOD_REGS_SIZE && offs + size <= KIRKWOOD_REGS_SIZE) {
 		retval = (void __iomem *)KIRKWOOD_REGS_VIRT_BASE + offs;
-- 
1.7.4.1
