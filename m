From: levex@linux.com (Levente Kurusa)
Date: Thu, 19 Dec 2013 16:03:19 +0100
Subject: [PATCH 08/38] arm: mach-rpc: add missing put_device call
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Message-ID: <1387465429-3568-9-git-send-email-levex@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/arm/mach-rpc/ecard.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index fcb1d59..1c5f7cb 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -961,8 +961,10 @@ static int __init ecard_probe(int slot, unsigned irq, card_type_t type)
 	slot_to_expcard[slot] = ec;
 
 	rc = device_register(&ec->dev);
-	if (rc)
+	if (rc) {
+		put_device(&ec->dev);
 		goto nodev;
+	}
 
 	return 0;
 
-- 
1.8.3.1
