From: jeanmarie.lemetayer@altran.com (Jean-Marie Lemetayer)
Date: Wed, 31 Mar 2010 15:19:50 +0200
Subject: [PATCH] Arm nomadik : Vendor tool compatibility
Message-ID: <mailman.287.1270074748.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds a compatibility with the vendor toolset which use
a different convention for the ECC bytes in the flash memory.

Acked-by: Alessandro Rubini <rubini@gnudd.com>
Signed-off-by: Jean-Marie Lemetayer <jeanmarie.lemetayer@altran.com>
---
 arch/arm/mach-nomadik/Kconfig   |   11 +++++++++++
 drivers/mtd/nand/nomadik_nand.c |   12 ++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/Kconfig =
b/arch/arm/mach-nomadik/Kconfig
index 2a02b49..af9bcca 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -18,4 +18,15 @@ config I2C_BITBANG_8815NHK
 	select I2C_ALGOBIT
 	default y
=20
+config VENDOR_TOOL_COMPATIBILITY
+	bool "Compatibility for vendor tool"
+	default n
+	help
+	  Some flash programmers can use a different placement of
+	  ECC bytes of the convention. Using two different placements
+	  causes errors and makes the memory unreadable.
+	  The use of the vendor toolset to program the memory, can
+	  leads to this problem.
+	  say N if not sure
+
 endif
diff --git a/drivers/mtd/nand/nomadik_nand.c =
b/drivers/mtd/nand/nomadik_nand.c
index 7c302d5..9ebe681 100644
--- a/drivers/mtd/nand/nomadik_nand.c
+++ b/drivers/mtd/nand/nomadik_nand.c
@@ -44,6 +44,17 @@ struct nomadik_nand_host {
 	struct nand_bbt_descr *bbt_desc;
 };
=20
+#ifdef CONFIG_VENDOR_TOOL_COMPATIBILITY
+static struct nand_ecclayout nomadik_ecc_layout =3D {
+	.eccbytes =3D 3 * 4,
+	.eccpos =3D {
+		0x28, 0x29, 0x2A,
+		0x2B, 0x2C, 0x2D,
+		0x2E, 0x2F, 0x30,
+		0x31, 0x32, 0x33},
+	.oobfree =3D {{0x02, 0x26}, {0x34, 0x0C} },
+};
+#else
 static struct nand_ecclayout nomadik_ecc_layout =3D {
 	.eccbytes =3D 3 * 4,
 	.eccpos =3D { /* each subpage has 16 bytes: pos 2,3,4 hosts ECC */
@@ -54,6 +65,7 @@ static struct nand_ecclayout nomadik_ecc_layout =3D {
 	/* let's keep bytes 5,6,7 for us, just in case we change ECC algo */
 	.oobfree =3D { {0x08, 0x08}, {0x18, 0x08}, {0x28, 0x08}, {0x38, 0x08} =
},
 };
+#endif
=20
 static void nomadik_ecc_control(struct mtd_info *mtd, int mode)
 {
--=20
1.6.0.4




------_=_NextPart_001_01CAD0E3.E8424BB7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>[PATCH] Arm nomadik : Vendor tool compatibility</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From a2e31cef5783b8123c10df7a32d4f3a1c08a3803 Mon Sep =
17 00:00:00 2001<BR>
From: Jean-Marie Lemetayer &lt;jeanmarie.lemetayer at altran.com&gt;<BR>
Date: Wed, 31 Mar 2010 15:19:50 +0200<BR>
Subject: [PATCH] Arm nomadik : Vendor tool compatibility<BR>
<BR>
The patch adds a compatibility with the vendor toolset which use<BR>
a different convention for the ECC bytes in the flash memory.<BR>
<BR>
Acked-by: Alessandro Rubini &lt;rubini at gnudd.com&gt;<BR>
Signed-off-by: Jean-Marie Lemetayer =
&lt;jeanmarie.lemetayer at altran.com&gt;<BR>
---<BR>
&nbsp;arch/arm/mach-nomadik/Kconfig&nbsp;&nbsp; |&nbsp;&nbsp; 11 =
+++++++++++<BR>
&nbsp;drivers/mtd/nand/nomadik_nand.c |&nbsp;&nbsp; 12 ++++++++++++<BR>
&nbsp;2 files changed, 23 insertions(+), 0 deletions(-)<BR>
<BR>
diff --git a/arch/arm/mach-nomadik/Kconfig =
b/arch/arm/mach-nomadik/Kconfig<BR>
index 2a02b49..af9bcca 100644<BR>
--- a/arch/arm/mach-nomadik/Kconfig<BR>
+++ b/arch/arm/mach-nomadik/Kconfig<BR>
@@ -18,4 +18,15 @@ config I2C_BITBANG_8815NHK<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select I2C_ALGOBIT<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
<BR>
+config VENDOR_TOOL_COMPATIBILITY<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Compatibility for =
vendor tool&quot;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Some flash programmers can =
use a different placement of<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; ECC bytes of the =
convention. Using two different placements<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; causes errors and makes the =
memory unreadable.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; The use of the vendor =
toolset to program the memory, can<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; leads to this problem.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; say N if not sure<BR>
+<BR>
&nbsp;endif<BR>
diff --git a/drivers/mtd/nand/nomadik_nand.c =
b/drivers/mtd/nand/nomadik_nand.c<BR>
index 7c302d5..9ebe681 100644<BR>
--- a/drivers/mtd/nand/nomadik_nand.c<BR>
+++ b/drivers/mtd/nand/nomadik_nand.c<BR>
@@ -44,6 +44,17 @@ struct nomadik_nand_host {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct nand_bbt_descr =
*bbt_desc;<BR>
&nbsp;};<BR>
<BR>
+#ifdef CONFIG_VENDOR_TOOL_COMPATIBILITY<BR>
+static struct nand_ecclayout nomadik_ecc_layout =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .eccbytes =3D 3 * 4,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .eccpos =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x28, 0x29, 0x2A,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2B, 0x2C, 0x2D,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2E, 0x2F, 0x30,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x31, 0x32, 0x33},<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .oobfree =3D {{0x02, 0x26}, {0x34, =
0x0C} },<BR>
+};<BR>
+#else<BR>
&nbsp;static struct nand_ecclayout nomadik_ecc_layout =3D {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .eccbytes =3D 3 * 4,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .eccpos =3D { /* each subpage =
has 16 bytes: pos 2,3,4 hosts ECC */<BR>
@@ -54,6 +65,7 @@ static struct nand_ecclayout nomadik_ecc_layout =3D =
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* let's keep bytes 5,6,7 for =
us, just in case we change ECC algo */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .oobfree =3D { {0x08, 0x08}, =
{0x18, 0x08}, {0x28, 0x08}, {0x38, 0x08} },<BR>
&nbsp;};<BR>
+#endif<BR>
<BR>
&nbsp;static void nomadik_ecc_control(struct mtd_info *mtd, int =
mode)<BR>
&nbsp;{<BR>
--<BR>
1.6.0.4<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CAD0E3.E8424BB7--
