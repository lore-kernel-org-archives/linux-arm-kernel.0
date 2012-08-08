From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 23:27:55 +0200
Subject: [PATCH 07/10] ARM: rpc: check device_register return code in
 ecard_probe
In-Reply-To: <1344461278-28245-1-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
Message-ID: <1344461278-28245-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

device_register is marked __must_check, so we better propagate the error
value by returning it from ecard_probe.

Without this patch, building rpc_defconfig results in:

arch/arm/mach-rpc/ecard.c: In function 'ecard_probe':
arch/arm/mach-rpc/ecard.c:963:17: warning: ignoring return value of 'device_register', declared with attribute warn_unused_result [-Wunused-result]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-rpc/ecard.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index b91bc87..fcb1d59 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -960,7 +960,9 @@ static int __init ecard_probe(int slot, unsigned irq, card_type_t type)
 	*ecp = ec;
 	slot_to_expcard[slot] = ec;
 
-	device_register(&ec->dev);
+	rc = device_register(&ec->dev);
+	if (rc)
+		goto nodev;
 
 	return 0;
 
-- 
1.7.10
