From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:28 +0200
Subject: [PATCH 16/16] phy: phy-core: fix initcall level
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-17-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy-core has to be initialized before other dependent usb-drivers,
otherwise a crash might occur.

Currently phy_core_init() is called in the initcall-level device, which is
the same level where most usb-drivers will end up. By luck this seemed to
have been called most of the time before other usb-drivers without having
been explicitly enforced. But if phy_core_init() is not called before a
dependent driver, a null-pointer exception might occur (e.g. because the
phy device class isn't registered).

To fix this, phy_core_init() is moved to the initcall-level fs (right
before the standard initcall level device).

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index fc48fac..4945029 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -930,7 +930,7 @@ static int __init phy_core_init(void)
 
 	return 0;
 }
-module_init(phy_core_init);
+fs_initcall_sync(phy_core_init);
 
 static void __exit phy_core_exit(void)
 {
-- 
2.1.0
