From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Sat, 3 Oct 2015 10:20:04 +0200
Subject: [PATCH] ARM: fix vdsomunge not to depend on glibc specific byteswap.h
In-Reply-To: <cover.1443791320.git.hns@goldelico.com>
References: <A323E65A-1631-4ADF-865D-04A5C38C6969@goldelico.com>
 <cover.1443791320.git.hns@goldelico.com>
Message-ID: <58DAB2B9-4068-4A11-8623-5A54195950E1@goldelico.com>
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
arch/mips/boot/elf2ecoff.c)

Tested to compile on Mac OS X 10.9.5 host.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
arch/arm/vdso/vdsomunge.c | 19 +++++++++++++++----
1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
index aedec81..27a9a0b 100644
--- a/arch/arm/vdso/vdsomunge.c
+++ b/arch/arm/vdso/vdsomunge.c
@@ -45,7 +45,18 @@
* it does.
*/

-#include <byteswap.h>
+#define swab16(x) \
+	((unsigned short)( \
+		(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) | \
+		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))
+
+#define swab32(x) \
+	((unsigned int)( \
+		(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) | \
+		(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) | \
+		(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) | \
+		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))
+
#include <elf.h>
#include <errno.h>
#include <fcntl.h>
@@ -104,17 +115,17 @@ static void cleanup(void)

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
