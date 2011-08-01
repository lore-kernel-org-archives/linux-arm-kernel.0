From: leoy@marvell.com (Leo Yan)
Date: Mon,  1 Aug 2011 10:59:06 +0800
Subject: [PATCH 1/2] ARM: mmp: register audio sram device
In-Reply-To: <1312167547-26740-1-git-send-email-leoy@marvell.com>
References: <1312167547-26740-1-git-send-email-leoy@marvell.com>
Message-ID: <1312167547-26740-2-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMP platform has sram for the audio island;
Add the device structure for the audio sram,
and register the audio sram device at init phase.

Signed-off-by: Leo Yan <leoy@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c        |    1 +
 arch/arm/mach-mmp/include/mach/mmp2.h |    6 ++++++
 arch/arm/mach-mmp/mmp2.c              |    1 +
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 7bb78fd..c172910 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -189,6 +189,7 @@ static void __init brownstone_init(void)
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmp2_add_audio_sram();
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index 2cbf6df..bd1bbb4 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -28,6 +28,7 @@ extern struct pxa_device_desc mmp2_device_sdh0;
 extern struct pxa_device_desc mmp2_device_sdh1;
 extern struct pxa_device_desc mmp2_device_sdh2;
 extern struct pxa_device_desc mmp2_device_sdh3;
+extern struct pxa_device_desc mmp2_device_audio_sram;
 
 static inline int mmp2_add_uart(int id)
 {
@@ -85,5 +86,10 @@ static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
 	return pxa_register_device(d, data, sizeof(*data));
 }
 
+static inline int mmp2_add_audio_sram(void)
+{
+	return pxa_register_device(&mmp2_device_audio_sram, NULL, 0);
+}
+
 #endif /* __ASM_MACH_MMP2_H */
 
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 8e6c3ac..885dced 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -226,4 +226,5 @@ MMP2_DEVICE(sdh0, "sdhci-pxa", 0, MMC, 0xd4280000, 0x120);
 MMP2_DEVICE(sdh1, "sdhci-pxa", 1, MMC2, 0xd4280800, 0x120);
 MMP2_DEVICE(sdh2, "sdhci-pxa", 2, MMC3, 0xd4281000, 0x120);
 MMP2_DEVICE(sdh3, "sdhci-pxa", 3, MMC4, 0xd4281800, 0x120);
+MMP2_DEVICE(audio_sram, "mmp-audio-sram", -1, NONE, 0xe0000000, 0x4000);
 
-- 
1.7.4.1
