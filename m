From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Oct 2013 11:46:25 +0200
Subject: [PATCH 3/9] ARM: etm: Remove unnecessary amba_set_drvdata()
In-Reply-To: <27e289763bbcb7d10f84081543cfc3a4dc770398.1380793579.git.michal.simek@xilinx.com>
References: <27e289763bbcb7d10f84081543cfc3a4dc770398.1380793579.git.michal.simek@xilinx.com>
Message-ID: <19b5da63fa3f75504d330c3fc8ead21cc88bd563.1380793579.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver core clears the driver data to NULL after device_release
or on probe failure, so just remove it from here.

Driver core change:
"device-core: Ensure drvdata = NULL when no driver is bound"
(sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/kernel/etm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 8ff0ecd..131a6ab 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -385,7 +385,6 @@ out:
 	return ret;

 out_unmap:
-	amba_set_drvdata(dev, NULL);
 	iounmap(t->etb_regs);

 out_release:
@@ -398,8 +397,6 @@ static int etb_remove(struct amba_device *dev)
 {
 	struct tracectx *t = amba_get_drvdata(dev);

-	amba_set_drvdata(dev, NULL);
-
 	iounmap(t->etb_regs);
 	t->etb_regs = NULL;

@@ -588,7 +585,6 @@ out:
 	return ret;

 out_unmap:
-	amba_set_drvdata(dev, NULL);
 	iounmap(t->etm_regs);

 out_release:
@@ -601,8 +597,6 @@ static int etm_remove(struct amba_device *dev)
 {
 	struct tracectx *t = amba_get_drvdata(dev);

-	amba_set_drvdata(dev, NULL);
-
 	iounmap(t->etm_regs);
 	t->etm_regs = NULL;

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131003/64fd5c4e/attachment.sig>
