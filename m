From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 13 Feb 2017 12:04:18 +0100
Subject: [PATCH/RESEND] arm64: defconfig: Enlarge CMA alignment to 2 MiB
Message-ID: <1486983858-11362-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some IOMMUs (e.g. Renesas IPMMU/VMSA) support only page sizes of 4 KiB,
2 MiB, and 1 GiB.

With the default setting of CONFIG_CMA_ALIGNMENT = 8, allocations larger
than 1 MiB are aligned to a 1 MiB boundary only.  Hence a 2 MiB
allocation may not be aligned, leading to a mapping of 512 4 KiB pages.

Increase CONFIG_CMA_ALIGNMENT to allow mapping a 2 MiB buffer using a
single PTE, decreasing memory usage and TLB pressure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Is this useful?

Should there instead be different defaults in Kconfig, depending on
enabled platform support?
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7735cfba01c8e650..7af449f3f41435bc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -144,6 +144,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
+CONFIG_CMA_ALIGNMENT=9
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-- 
1.9.1
