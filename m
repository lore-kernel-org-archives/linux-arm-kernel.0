From: nschichan@freebox.fr (Nicolas Schichan)
Date: Thu,  6 Jun 2013 19:00:46 +0200
Subject: [PATCH] ARM: Kirkwood: handle mv88f6282 cpu in __kirkwood_variant().
Message-ID: <1370538046-1186-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPP_F6281_MASK would be previously be returned when on mv88f6282,
which would disallow some valid MPP configurations.

Commit 830f8b91 (arm: plat-orion: fix printing of "MPP config
unavailable on this hardware") made this problem visible as an invalid
MPP configuration is now correctly detected and not applied.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/arm/mach-kirkwood/mpp.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 827cde4..e96fd71 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -22,9 +22,10 @@ static unsigned int __init kirkwood_variant(void)
 
 	kirkwood_pcie_id(&dev, &rev);
 
-	if ((dev == MV88F6281_DEV_ID && rev >= MV88F6281_REV_A0) ||
-	    (dev == MV88F6282_DEV_ID))
+	if (dev == MV88F6281_DEV_ID && rev >= MV88F6281_REV_A0)
 		return MPP_F6281_MASK;
+	if (dev == MV88F6282_DEV_ID)
+		return MPP_F6282_MASK;
 	if (dev == MV88F6192_DEV_ID && rev >= MV88F6192_REV_A0)
 		return MPP_F6192_MASK;
 	if (dev == MV88F6180_DEV_ID)
-- 
1.7.10.4
