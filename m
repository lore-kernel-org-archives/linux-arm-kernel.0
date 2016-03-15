From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Mar 2016 22:34:45 +0100
Subject: [PATCH] ARM: davinci: only use NVMEM when available
Message-ID: <1458077705-408437-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci platform contains code that calls into the nvmem
subsystem, but that might be a loadable module, causing a
link error:

arch/arm/mach-davinci/built-in.o: In function `davinci_get_mac_addr':
:(.text+0x1088): undefined reference to `nvmem_device_read'
arch/arm/mach-davinci/built-in.o: In function `read_factory_config':
:(.text+0x214c): undefined reference to `nvmem_device_read'

Also, when NVMEM is completely disabled, the functions fail with
nonobvious error messages.

This ensures we only call the API functions when the code is actually
reachable from the board file, and otherwise prints a unique log
message.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: bec3c11bad0e ("misc: at24: replace memory_accessor with nvmem_device_read")
---

Hi Greg,

The commit that introduced this is currently in the char-misc tree,
please apply this fixup on top if you haven't already sent it to Linus.

 arch/arm/mach-davinci/board-mityomapl138.c | 5 +++++
 arch/arm/mach-davinci/common.c             | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index d97c588550ad..bc4e63fa9808 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -121,6 +121,11 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	const char *partnum = NULL;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	if (!IS_BUILTIN(CONFIG_NVMEM)) {
+		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
+		goto bad_config;
+	}
+
 	ret = nvmem_device_read(nvmem, 0, sizeof(factory_config),
 				&factory_config);
 	if (ret != sizeof(struct factory_config)) {
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index f55ef2ef2f92..742133b7266a 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -33,6 +33,11 @@ void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
 	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
 	off_t offset = (off_t)context;
 
+	if (!IS_BUILTIN(CONFIG_NVMEM)) {
+		pr_warn("Cannot read MAC addr from EEPROM without CONFIG_NVMEM\n");
+		return;
+	}
+
 	/* Read MAC addr from EEPROM */
 	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
 		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
-- 
2.7.0
