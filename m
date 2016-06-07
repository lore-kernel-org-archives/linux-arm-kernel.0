From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Jun 2016 09:37:24 +0100
Subject: [PATCH] ARM: dts: STi: stih407-family: Disable reserved-memory
 co-processor nodes
Message-ID: <20160607083724.18599-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a non-booting issue in Mainline.

When booting with a compressed kernel, we need to be careful how we
populate memory close to DDR start.  AUTO_ZRELADDR is enabled by default
in multi-arch enabled configurations, which place some restrictions on
where the kernel is placed and where it will be uncompressed to on boot.

AUTO_ZRELADDR takes the decompressor code's start address and masks out
the bottom 28 bits to obtain an address to uncompress the kernel to
(thus a load address of 0x42000000 means that the kernel will be
uncompressed to 0x40000000 i.e. DDR START on this platform).

Even changing the load address to after the co-processor's shared memory
won't render a booting platform, since the AUTO_ZRELADDR algorithm still
ensures the kernel is uncompressed into memory shared with the first
co-processor (0x40000000).

Another option would be to move loading to 0x4A000000, since this will
mean the decompressor will decompress the kernel to 0x48000000. However,
this would mean a large chunk (0x44000000 => 0x48000000 (64MB)) of
memory would essentially be wasted for no good reason.

Until we can work with ST to find a suitable memory location to
relocate co-processor shared memory, let's disable the shared memory
nodes.  This will ensure a working platform in the mean time.

NB: The more observant of you will notice that we're leaving the DMU
shared memory node enabled; this is because a) it is the only one in
active use at the time of this writing and b) it is not affected by
the current default behaviour which is causing issues.

Fixes: fe135c6 (ARM: dts: STiH407: Move over to using the 'reserved-memory' API for obtaining DMA memory)
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index ad8ba10..d294e824 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -24,18 +24,21 @@
 			compatible = "shared-dma-pool";
 			reg = <0x40000000 0x01000000>;
 			no-map;
+			status = "disabled";
 		};
 
 		gp1_reserved: rproc at 41000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x41000000 0x01000000>;
 			no-map;
+			status = "disabled";
 		};
 
 		audio_reserved: rproc at 42000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x42000000 0x01000000>;
 			no-map;
+			status = "disabled";
 		};
 
 		dmu_reserved: rproc at 43000000 {
-- 
2.8.3
