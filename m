From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 16 Sep 2014 20:48:59 +0200
Subject: [PATCH/RFC v2 12/12] drivers: sh: Disable PM runtime for
 multi-platform r8a7740 with genpd
In-Reply-To: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
References: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1410893339-6361-13-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the default PM domain using PM_CLK is used for PM runtime, the real PM
domain(s) cannot be registered from DT later.

Hence do not enable it when running a multi-platform kernel with genpd
support on an r8a7740. The R-Mobile PM domain driver will take care of
PM runtime management of the module clocks.

The default PM domain is still needed for:
  - platforms without genpd support,
  - the legacy (non-DT) case, where real PM domains may take over later,
    except for the C5 "always on" PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New
---
 drivers/sh/pm_runtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index fe2c2d595f599b2f..85cc89fd3e7d7cb7 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -81,7 +81,9 @@ static int __init sh_pm_runtime_init(void)
 		if (!of_machine_is_compatible("renesas,emev2") &&
 		    !of_machine_is_compatible("renesas,r7s72100") &&
 		    !of_machine_is_compatible("renesas,r8a73a4") &&
+#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 		    !of_machine_is_compatible("renesas,r8a7740") &&
+#endif
 		    !of_machine_is_compatible("renesas,r8a7778") &&
 		    !of_machine_is_compatible("renesas,r8a7779") &&
 		    !of_machine_is_compatible("renesas,r8a7790") &&
-- 
1.9.1
