From: simon@sequanux.org (Simon Guinot)
Date: Thu, 21 Oct 2010 11:42:28 +0200
Subject: [PATCH v2 1/2] [ARM] Kirkwood: enhance TCLK detection
In-Reply-To: <20101020085720.GA12979@mail.wantstofly.org>
References: <20101020085720.GA12979@mail.wantstofly.org>
Message-ID: <1287654149-8743-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

According to the Marvell LSP, the Sample at Reset regiter bit 21 can be
used to detect TCLK on 6281 and 6282 devices.

This patch has only been tested on LaCie boards.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/common.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 1c82d42..ee99a5a 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -854,10 +854,9 @@ int __init kirkwood_find_tclk(void)
 
 	kirkwood_pcie_id(&dev, &rev);
 
-	if ((dev == MV88F6281_DEV_ID && (rev == MV88F6281_REV_A0 ||
-					rev == MV88F6281_REV_A1)) ||
-	    (dev == MV88F6282_DEV_ID))
-		return 200000000;
+	if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
+		if (((readl(SAMPLE_AT_RESET) >> 21) & 1) == 0)
+			return 200000000;
 
 	return 166666667;
 }
-- 
1.6.3.1
