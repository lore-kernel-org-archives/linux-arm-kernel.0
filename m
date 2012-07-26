From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jul 2012 13:54:33 +0100
Subject: [PATCH] ARM: vfp: only advertise VFPv4 in hwcaps if CONFIG_VFPv3 is
 enabled
Message-ID: <1343307273-7149-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VFPv4 support depends on the VFPv3 context save/restore code, so only
advertise support in the hwcaps if the kernel can actually handle it.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
Pretty boring, but I guess a candidate for -stable.

 arch/arm/vfp/vfpmodule.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 58696192..06137c7 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -713,8 +713,10 @@ static int __init vfp_init(void)
 			if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
 				elf_hwcap |= HWCAP_NEON;
 #endif
+#ifdef CONFIG_VFPv3
 			if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
 				elf_hwcap |= HWCAP_VFPv4;
+#endif
 		}
 	}
 	return 0;
-- 
1.7.4.1
