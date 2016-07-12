From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Jul 2016 19:46:13 +0530
Subject: [PATCH] ARM: davinci: fix build break because of undeclared
 dm365_evm_snd_data
Message-ID: <20160712141613.29325-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 6bce5efd4424 ("ARM: davinci: remove unused davinci-i2s pdata")
removed all instances of davinci-i2s pdata. However, on DM365 EVM,
the same platform data is passed to the voicecodec present on that
device.

This causes build breakage when voicecodec support is enabled:

arch/arm/mach-davinci/board-dm365-evm.c:764:17: error: 'dm365_evm_snd_data' undeclared (first use in this function)

voicecodec driver does not use the platform data as well, and
it is safe to remove it.

Fixes: 6bce5efd4424 ("ARM: davinci: remove unused davinci-i2s pdata")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Hi Arnd, this applies to latest linux-next. Can you please pick it
directly? This should go into v4.8-rc1

 arch/arm/mach-davinci/board-dm365-evm.c | 2 +-
 arch/arm/mach-davinci/davinci.h         | 2 +-
 arch/arm/mach-davinci/dm365.c           | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e832949bc767..0464999b7137 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -761,7 +761,7 @@ static __init void dm365_evm_init(void)
 #ifdef CONFIG_SND_DM365_AIC3X_CODEC
 	dm365_init_asp();
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
-	dm365_init_vc(&dm365_evm_snd_data);
+	dm365_init_vc();
 #endif
 	dm365_init_rtc();
 	dm365_init_ks(&dm365evm_ks_data);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index d1f8e29f1e30..c62b90c6118a 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -92,7 +92,7 @@ int dm355_gpio_register(void);
 /* DM365 function declarations */
 void dm365_init(void);
 void dm365_init_asp(void);
-void dm365_init_vc(struct snd_platform_data *pdata);
+void dm365_init_vc(void);
 void dm365_init_ks(struct davinci_ks_platform_data *pdata);
 void dm365_init_rtc(void);
 void dm365_init_spi0(unsigned chipselect_mask,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 95fbfd962c79..ef3add999263 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1151,11 +1151,10 @@ void __init dm365_init_asp(void)
 	platform_device_register(&dm365_asp_device);
 }
 
-void __init dm365_init_vc(struct snd_platform_data *pdata)
+void __init dm365_init_vc(void)
 {
 	davinci_cfg_reg(DM365_EVT2_VC_TX);
 	davinci_cfg_reg(DM365_EVT3_VC_RX);
-	dm365_vc_device.dev.platform_data = pdata;
 	platform_device_register(&dm365_vc_device);
 }
 
-- 
2.9.0
