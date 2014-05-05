From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 17:05:23 +0200
Subject: [PATCH v2 2/5] ARM: mvebu: initialize mvebu-soc-id earlier
In-Reply-To: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399302326-6917-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the mvebu-soc-id logic is initialized through a
core_initcall(). However, we will soon need to know the SoC revision
before booting secondary CPUs, because a workaround affects Armada 375
Z1 steppings, but should not be applied on Armada 375 A0 steppings.

Unfortunately, core_initcall() are called way too late compared to the
SMP initialization. Therefore, the mvebu-soc-id initialization is move
to an early_initcall(), which is called before the SMP initialization.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/mvebu-soc-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index 874a750..e9119a9 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -118,7 +118,7 @@ clk_err:
 
 	return ret;
 }
-core_initcall(mvebu_soc_id_init);
+early_initcall(mvebu_soc_id_init);
 
 static int __init mvebu_soc_device(void)
 {
-- 
1.9.2
