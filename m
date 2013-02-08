From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:42 +0000
Subject: [PATCH 12/17] ARM: fix magic for bootloader in BE8
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-13-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the boot-loader is running little endian and the kernel is compiled
big endian then it will not verify the magic number of the front of the
kernel.

Note, do we need to also reverse the two values after the magic, or are
they used later on in the kernel decompressor?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/compressed/head.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 39940a7..b6c7ec8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -129,7 +129,11 @@ start:
  THUMB(		adr	r12, BSYM(1f)	)
  THUMB(		bx	r12		)
 
+#ifdef CONFIG_CPU_BE8_BOOT_LE
+		.word	0x18286f01
+#else
 		.word	0x016f2818		@ Magic numbers to help the loader
+#endif
 		.word	start			@ absolute load/run zImage address
 		.word	_edata			@ zImage end address
  THUMB(		.thumb			)
-- 
1.7.10.4
