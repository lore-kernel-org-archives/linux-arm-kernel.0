From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 15:06:39 +0100
Subject: [PATCH 3/3] ARM: mvebu: mark mvebu_hwcc_pci_nb as __maybe_unused
In-Reply-To: <1456236403-115511-1-git-send-email-arnd@arndb.de>
References: <1456236403-115511-1-git-send-email-arnd@arndb.de>
Message-ID: <1456236403-115511-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coherency notifier block is only used when CONFIG_PCI
is enabled, otherwise we get a warning:

arch/arm/mach-mvebu/coherency.c:110:30: warning: 'mvebu_hwcc_pci_nb' defined but not used [-Wunused-variable]

There is no nice way to use an if(IS_ENABLED()) check here to
let the compiler know that it might be used, so let's mark
the structure as __maybe_unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mvebu/coherency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 55348ee5a352..7e989d61159c 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -107,7 +107,7 @@ static struct notifier_block mvebu_hwcc_nb = {
 	.notifier_call = mvebu_hwcc_notifier,
 };
 
-static struct notifier_block mvebu_hwcc_pci_nb = {
+static struct notifier_block mvebu_hwcc_pci_nb __maybe_unused = {
 	.notifier_call = mvebu_hwcc_notifier,
 };
 
-- 
2.7.0
