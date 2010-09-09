From: js@sig21.net (Johannes Stezenbach)
Date: Thu, 9 Sep 2010 15:14:03 +0200
Subject: [PATCH/RFC] ARM: CONFIG_MTD_XIP vs. __aeabi_idiv
Message-ID: <20100909131403.GA28399@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For testing purposes I needed to build a kernel which
executes in-place in NOR flash.  It crashes when probing
physmap flash because the MTD code which runs from RAM with
CONFIG_MTD_XIP calls __aeabi_idiv.

Signed-off-by: Johannes Stezenbach <js@sig21.net>


diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index 6dc0648..b2c0105 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -204,6 +204,10 @@ Boston, MA 02111-1307, USA.  */
 5:
 .endm
 
+#ifdef CONFIG_MTD_XIP
+	@ MTD code need to have these functions in RAM
+	.section ".data"
+#endif
 
 ENTRY(__udivsi3)
 ENTRY(__aeabi_uidiv)
