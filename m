From: will.deacon@arm.com (Will Deacon)
Date: Wed,  8 Jun 2011 13:30:29 +0100
Subject: [Patch v2 07/11] ARM: vfp: add VFPv4 capability detection and
	populate elf_hwcap
In-Reply-To: <1307536233-30089-1-git-send-email-will.deacon@arm.com>
References: <1307536233-30089-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307536233-30089-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The presence of VFPv4 cannot be detected simply by looking at the FPSID
subarchitecture field, as a value >= 2 signifies the architecture as
VFPv3 or later.

This patch reads from MVFR1 to check whether or not the fused multiple
accumulate instructions are supported. Since these are introduced with
VFPv4, this tells us what we need to know.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/vfp/vfpmodule.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f25e7ec..650d90b 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -582,7 +582,6 @@ static int __init vfp_init(void)
 				elf_hwcap |= HWCAP_VFPv3D16;
 		}
 #endif
-#ifdef CONFIG_NEON
 		/*
 		 * Check for the presence of the Advanced SIMD
 		 * load/store instructions, integer and single
@@ -590,10 +589,13 @@ static int __init vfp_init(void)
 		 * for NEON if the hardware has the MVFR registers.
 		 */
 		if ((read_cpuid_id() & 0x000f0000) == 0x000f0000) {
+#ifdef CONFIG_NEON
 			if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
 				elf_hwcap |= HWCAP_NEON;
-		}
 #endif
+			if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
+				elf_hwcap |= HWCAP_VFPv4;
+		}
 	}
 	return 0;
 }
-- 
1.7.0.4
