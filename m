From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 May 2018 18:10:21 +0200
Subject: [PATCH 2/2] ARM: shmobile: only call secure_cntvoff_init on SMP builds
In-Reply-To: <20180525161051.187324-1-arnd@arndb.de>
References: <20180525161051.187324-1-arnd@arndb.de>
Message-ID: <20180525161051.187324-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The secure_cntvoff_init() function is not available without CONFIG_SMP,
leading to a link error on shmobile:

arch/arm/mach-shmobile/setup-rcar-gen2.o: In function `rcar_gen2_timer_init':
setup-rcar-gen2.c:(.init.text+0x18): undefined reference to `secure_cntvoff_init'

>From the description in commit 3fd45a136ff6 ("ARM: shmobile: rcar-gen2:
Make sure CNTVOFF is initialized on CA7/15"), I understand that we
don't need to call it on non-SMP builds because the boot CPU is always
initialized by common code, so we can simply avoid the reference by
checking for CONFIG_SMP.

Fixes: cad160ed0a94 ("ARM: shmobile: Convert file to use cntvoff")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 88fdc1801d90..39085d7a8f37 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -71,7 +71,8 @@ void __init rcar_gen2_timer_init(void)
 	void __iomem *base;
 	u32 freq;
 
-	secure_cntvoff_init();
+	if (IS_ENABLED(CONFIG_SMP))
+		secure_cntvoff_init();
 
 	if (of_machine_is_compatible("renesas,r8a7745") ||
 	    of_machine_is_compatible("renesas,r8a77470") ||
-- 
2.9.0
