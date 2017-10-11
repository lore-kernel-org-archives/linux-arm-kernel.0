From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 11 Oct 2017 09:46:49 +0200
Subject: [PATCH 1/1] ARM: shmobile: rcar-gen2: fix non-SMP build
In-Reply-To: <cover.1507707869.git.horms+renesas@verge.net.au>
References: <cover.1507707869.git.horms+renesas@verge.net.au>
Message-ID: <703ef76b8fd5169d5cff30de5b958d6728b9a147.1507707869.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

A bugfix for the SMP case broke the build for the UP case:

arch/arm/mach-shmobile/headsmp-apmu.o: In function `shmobile_boot_apmu':
(.text+0x34): undefined reference to `secondary_startup'

The assembler file mixes code that is used for SMP with code
that we also need on a single-CPU build, so I'm leaving it
always enabled in the Makefile, but enclose the SMP code
in an #ifdef.

Fixes: fd45a136ff6 ("ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp-apmu.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
index db4743d2bf91..5672b5849401 100644
--- a/arch/arm/mach-shmobile/headsmp-apmu.S
+++ b/arch/arm/mach-shmobile/headsmp-apmu.S
@@ -31,7 +31,9 @@ ENTRY(shmobile_init_cntvoff)
 	ret	lr
 ENDPROC(shmobile_init_cntvoff)
 
+#ifdef CONFIG_SMP
 ENTRY(shmobile_boot_apmu)
 	bl	shmobile_init_cntvoff
 	b	secondary_startup
 ENDPROC(shmobile_boot_apmu)
+#endif
-- 
2.11.0
