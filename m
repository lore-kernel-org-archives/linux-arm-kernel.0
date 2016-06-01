From: nm@ti.com (Nishanth Menon)
Date: Wed, 1 Jun 2016 16:31:54 -0500
Subject: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in typical
 Keystone features
Message-ID: <1464816714-3900-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce ARCH_KEYSTONE_TYPICAL which is common for all Keystone
platforms. This is particularly useful when custom optimized defconfig
builds are created for Keystone architecture platforms.

An example of the same would be a sample fragment ks_only.cfg:
http://pastebin.ubuntu.com/16904991/ - This prunes all arch other than
keystone and any options the other architectures may enable.

git clean -fdx && git reset --hard && \
 ./scripts/kconfig/merge_config.sh -m \
 	./arch/arm/configs/multi_v7_defconfig ~/tmp/ks_only.cfg &&\
 make olddefconfig

The above unfortunately will disable options necessary for KS2 boards
to boot to the bare minimum initramfs.

Hence the "KEYSTONE_TYPICAL" option is designed similar to commit 8d9166b519fd
("omap2/3/4: Add Kconfig option to compile in typical omap features")
that can be enabled for most boards keystone platforms
without needing to rediscover these in defconfig all over again -
examples include multi_v7_defconfig base and optimizations done on top
of them for keystone platform.

NOTE: the alternative is to select the configurations under
ARCH_KEYSTONE. However, that would fail multi_v7 builds on ARM
variants that dont work with LPAE.

Cc: Bill Mills <wmills@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on: next-20160601

Tested for basic initramfs boot for K2HK/K2G platforms with the
http://pastebin.ubuntu.com/16904991/ fragment + multi_v7_defconfig

Side note on LPAE:
For our current device tree and u-boot, LPAE is mandatory to bootup
for current Keystone boards - but this is not a SoC requirement,
booting without LPAE/HIGHMEM results in non-coherent DDR accesses.
Currently:
- U-Boot assumes that lpae is always enabled in kennel and updates the 
DT memory node with higher addresses. Because of which you are not 
detecting any memory without lpae and kernel crashed very early, hence 
no prints. So, make mem_lpae env setting as 0 in U-boot.

- DT also assumes that lpae is always enabled, and always asks for 
dma-address translation for higher addresses to lower addresses.
Just delete the "dma-ranges" property or create a one-on-one mapping 
like dma-ranges = <0x80000000 0x0 0x80000000 0x80000000>

These are probably the reasons for the kernel not booting without
LPAE enabled in .config. but then, the TI recommended operation for
Keystone platforms is with LPAE and HIGHMEM enabled for coherent
architecture behavior.

 arch/arm/mach-keystone/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index ea955f6db8b7..a151f878143f 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -14,3 +14,22 @@ config ARCH_KEYSTONE
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
+
+if ARCH_KEYSTONE
+
+menu "TI Keystone Specific Features"
+
+config ARCH_KEYSTONE_TYPICAL
+	bool "Typical Keystone configuration"
+	depends on ARM_LPAE
+	default y
+	select AEABI
+	select HIGHMEM
+	select NEON
+	select PM
+	select VFP
+	help
+	  Compile a kernel suitable for booting most boards on Keystone
+	  architecture to at least a simple initramfs
+endmenu
+endif
-- 
2.8.0
