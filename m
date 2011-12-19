From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:46 -0500
Subject: [PATCH 17/20] ARM: mach-s3c64xx: properly disable CPU idle call
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-18-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-s3c64xx/cpu.c                 |    2 ++
 arch/arm/mach-s3c64xx/include/mach/system.h |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
index de085b798a..90c26bbe6b 100644
--- a/arch/arm/mach-s3c64xx/cpu.c
+++ b/arch/arm/mach-s3c64xx/cpu.c
@@ -141,6 +141,8 @@ void __init s3c6400_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 {
+	disable_hlt();  /* idle WFI usage needs to be confirmed */
+
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 	iotable_init(mach_desc, size);
diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
index d8ca5786ba..0868f26c83 100644
--- a/arch/arm/mach-s3c64xx/include/mach/system.h
+++ b/arch/arm/mach-s3c64xx/include/mach/system.h
@@ -15,7 +15,7 @@
 
 static void arch_idle(void)
 {
-	/* nothing here yet */
+	cpu_do_idle();
 }
 
 static void arch_reset(char mode, const char *cmd)
-- 
1.7.7.1.431.g10b2a
