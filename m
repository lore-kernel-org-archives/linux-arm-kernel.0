From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Sat, 16 May 2015 15:58:22 +0800
Subject: [PATCH v2 1/9] ARM: correct secondary_startup_arm mode
In-Reply-To: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1431763110-443-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

secondary_startup_arm is used as ARM mode secondary start up function
when ther kernel is compiled in THUMB mode, however the label itself
is still in .thumb mode. readelf shows:

160979: c020a581   120 FUNC    GLOBAL DEFAULT    2 secondary_startup_arm

Make sure the label is in ARM mode as well.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 3637973..58ee8a2 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -346,8 +346,8 @@ __turn_mmu_on_loc:
 
 #if defined(CONFIG_SMP)
 	.text
-ENTRY(secondary_startup_arm)
 	.arm
+ENTRY(secondary_startup_arm)
  THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is entered in ARM.
  THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
  THUMB(	.thumb			)	@ switch to Thumb now.
-- 
1.8.1.1.dirty
