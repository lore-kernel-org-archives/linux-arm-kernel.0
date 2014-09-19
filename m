From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 19 Sep 2014 12:44:39 -0700
Subject: [PATCH 1/2] bus: brcmstb_gisb: register the fault code hook
In-Reply-To: <1411155880-23447-1-git-send-email-f.fainelli@gmail.com>
References: <1411155880-23447-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1411155880-23447-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 44127b771d9c31 ("bus: add Broadcom GISB bus arbiter timeout/error
handler") added everything that is required to register an ARM fault
handler for imprecise external aborts, except that there is nothing
calling this currently.

We do not need to export that specific function and have to update
arch/arm/mach-bcm/brcmstb.c to call it, simply, register the fault
handler with an arch_initcall.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f2cd6a2d40b4..daae4f77f34a 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -48,6 +48,7 @@ struct brcmstb_gisb_arb_device {
 	struct list_head next;
 	u32 valid_mask;
 	const char *master_names[sizeof(u32) * BITS_PER_BYTE];
+	u32 saved_timeout;
 };
 
 static LIST_HEAD(brcmstb_gisb_arb_device_list);
@@ -160,11 +161,13 @@ static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 	return ret;
 }
 
-void __init brcmstb_hook_fault_code(void)
+static int __init brcmstb_hook_fault_code(void)
 {
 	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
 			"imprecise external abort");
+	return 0;
 }
+arch_initcall(brcmstb_hook_fault_code)
 
 static irqreturn_t brcmstb_gisb_timeout_handler(int irq, void *dev_id)
 {
-- 
1.9.1
