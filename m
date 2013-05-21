From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 21 May 2013 19:41:48 +0200
Subject: [PATCH] ARM: Kirkwood: TS219: Fix crash by double PCIe instantiation
Message-ID: <1369158108-5603-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating the DT based boards-ts219.c the none DT ts219-setup.c
was used as a template. This includes a lateinit() call to initialize
the PCIe bus. The code makes use of machine_is_ts219() which is never
true on DT, so a FIXME was added and the code left as is. This was
unproblematic until b73690c8f8b5d: "ARM: Kirkwood: Support basic
hotplug for PCI-E" which changes the way the PCIe bus is
initialized. The non-DT ts219-setup.c now crashes during boot.  The
lateinit() call in the DT boards-ts219.c is being called,
machine_is_ts219() is true and so the PCIe is initialized a second
time.

This patch removes the useless, and now clearly dangerous, code from
boards-ts219.c, making ts219-setup.c work again.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
This can also be tagged for stable 3.9

 arch/arm/mach-kirkwood/board-ts219.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index acb0187..4695d5f 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -41,13 +41,3 @@ void __init qnap_dt_ts219_init(void)
 
 	pm_power_off = qnap_tsx1x_power_off;
 }
-
-/* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
-static int __init ts219_pci_init(void)
-{
-	if (machine_is_ts219())
-		kirkwood_pcie_init(KW_PCIE0);
-
-	return 0;
-}
-subsys_initcall(ts219_pci_init);
-- 
1.7.10.4
