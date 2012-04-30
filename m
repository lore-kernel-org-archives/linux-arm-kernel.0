From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Mon, 30 Apr 2012 11:57:19 +0200
Subject: [PATCH 1/2] cs89x0_platform : Use ioread16/iowrite16 instead of
 inw/outw
Message-ID: <1335779839-30420-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of the inw/outw functions by the cs89x0 platform driver
results in NULL pointer references.

Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 drivers/net/ethernet/cirrus/cs89x0.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index b9406cb..95737e9 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -369,6 +369,18 @@ writeword(unsigned long base_addr, int portno, u16 value)
 {
 	__raw_writel(value, base_addr + (portno << 1));
 }
+#elif defined(CONFIG_CS89x0_PLATFORM)
+static u16
+readword(unsigned long base_addr, int portno)
+{
+	return ioread16(base_addr + portno);
+}
+
+static void
+writeword(unsigned long base_addr, int portno, u16 value)
+{
+	iowrite16(value, base_addr + portno);
+}
 #else
 static u16
 readword(unsigned long base_addr, int portno)
-- 
1.7.1
