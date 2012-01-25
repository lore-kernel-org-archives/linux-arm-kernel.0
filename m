From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:31:26 +0000
Subject: [PATCH 04/33] MFD: mcp-core: fix mcp_priv() to be more type safe
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3sk-0000Xp-8c@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mcp_priv() does unexpected things when passed a void pointer.  Make it
a typed inline function, which ensures that it works correctly in
these cases.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/mfd/mcp.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
index ee496708..f88c1cc 100644
--- a/include/linux/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -64,6 +64,9 @@ void mcp_driver_unregister(struct mcp_driver *);
 #define mcp_get_drvdata(mcp)	dev_get_drvdata(&(mcp)->attached_device)
 #define mcp_set_drvdata(mcp,d)	dev_set_drvdata(&(mcp)->attached_device, d)
 
-#define mcp_priv(mcp)		((void *)((mcp)+1))
+static inline void *mcp_priv(struct mcp *mcp)
+{
+	return mcp + 1;
+}
 
 #endif
-- 
1.7.4.4
