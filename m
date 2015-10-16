From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Fri, 16 Oct 2015 08:38:40 +0200
Subject: [PATCH v4] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
Message-ID: <4436b0dbf72aa409613ec4c7407b017d085e40ac.1444977518.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the host toolchain is not glibc based then the arm kernel build
fails with

  HOSTCC  arch/arm/vdso/vdsomunge
  arch/arm/vdso/vdsomunge.c:48:22: fatal error: byteswap.h: No such file or directory

Observed: with omap2plus_defconfig and compile on Mac OS X with arm ELF
cross-compiler.

Reason: byteswap.h is a glibc only header.

Solution: replace by private byte-swapping macros (taken from
arch/mips/boot/elf2ecoff.c and kindly improved by Russell King)

Tested to compile on Mac OS X 10.9.5 host.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/vdso/vdsomunge.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
index aedec81..0cebd98 100644
--- a/arch/arm/vdso/vdsomunge.c
+++ b/arch/arm/vdso/vdsomunge.c
@@ -45,7 +45,6 @@
  * it does.
  */
 
-#include <byteswap.h>
 #include <elf.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -59,6 +58,16 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#define swab16(x) \
+	((((x) & 0x00ff) << 8) | \
+	 (((x) & 0xff00) >> 8))
+
+#define swab32(x) \
+	((((x) & 0x000000ff) << 24) | \
+	 (((x) & 0x0000ff00) <<  8) | \
+	 (((x) & 0x00ff0000) >>  8) | \
+	 (((x) & 0xff000000) << 24))
+
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define HOST_ORDER ELFDATA2LSB
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
@@ -104,17 +113,17 @@ static void cleanup(void)
 
 static Elf32_Word read_elf_word(Elf32_Word word, bool swap)
 {
-	return swap ? bswap_32(word) : word;
+	return swap ? swab32(word) : word;
 }
 
 static Elf32_Half read_elf_half(Elf32_Half half, bool swap)
 {
-	return swap ? bswap_16(half) : half;
+	return swap ? swab16(half) : half;
 }
 
 static void write_elf_word(Elf32_Word val, Elf32_Word *dst, bool swap)
 {
-	*dst = swap ? bswap_32(val) : val;
+	*dst = swap ? swab32(val) : val;
 }
 
 int main(int argc, char **argv)
-- 
2.5.1
