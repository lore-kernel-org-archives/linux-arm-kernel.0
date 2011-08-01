From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:09 +0100
Subject: [PATCH 8/9] iop: make __arch_ioremap() with 0 size return NULL
In-Reply-To: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
References: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312201870-12921-8-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/plat-iop/io.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-iop/io.c b/arch/arm/plat-iop/io.c
index e15bc17..9800b15 100644
--- a/arch/arm/plat-iop/io.c
+++ b/arch/arm/plat-iop/io.c
@@ -26,6 +26,9 @@ void * __iomem __iop3xx_ioremap(unsigned long cookie, size_t size,
 {
 	void __iomem * retval;
 
+	if (!size)
+		return NULL;
+
 	switch (cookie) {
 	case IOP3XX_PCI_LOWER_IO_PA ... IOP3XX_PCI_UPPER_IO_PA:
 		retval = (void *) IOP3XX_PCI_IO_PHYS_TO_VIRT(cookie);
-- 
1.7.4.1
