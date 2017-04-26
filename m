From: slash.tmp@free.fr (Mason)
Date: Thu, 27 Apr 2017 00:34:01 +0200
Subject: [PATCH v2] arm: bitops: Align prototypes to generic API
In-Reply-To: <20170424042033.GC6263@localhost>
References: <20170421084033.5c987e13@canb.auug.org.au>
 <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
 <20170421181230.05dcf937@canb.auug.org.au>
 <20170421234315.GO17774@n2100.armlinux.org.uk>
 <f89b6045-8c09-f6c4-3893-84f172260926@free.fr>
 <20170424042033.GC6263@localhost>
Message-ID: <f3eb1c46-a413-955a-0cfa-c297691e2b23@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

include/asm-generic/bitops/find.h declares:

extern unsigned long
find_first_zero_bit(const unsigned long *addr, unsigned long size);

while arch/arm/include/asm/bitops.h declares:

#define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
extern int _find_first_zero_bit_le(const void * p, unsigned size);

Align the arm prototypes to the generic API, to have gcc report
inadequate arguments, such as pointer to u32.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
The patch fixing drivers/dma/sun4i-dma.c
("dmaengine: sun4i: fix invalid argument")
has landed on linux-next (thanks Vinod)
as 57192245bc074710ea1a128d39ecc429455ac815
---
 arch/arm/include/asm/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index e943e6cee254..f308c8c40cb9 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -159,16 +159,16 @@ extern int _test_and_change_bit(int nr, volatile unsigned long * p);
 /*
  * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
  */
-extern int _find_first_zero_bit_le(const void * p, unsigned size);
-extern int _find_next_zero_bit_le(const void * p, int size, int offset);
+extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
+extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
 extern int _find_first_bit_le(const unsigned long *p, unsigned size);
 extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
 
 /*
  * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
  */
-extern int _find_first_zero_bit_be(const void * p, unsigned size);
-extern int _find_next_zero_bit_be(const void * p, int size, int offset);
+extern int _find_first_zero_bit_be(const unsigned long *p, unsigned size);
+extern int _find_next_zero_bit_be(const unsigned long *p, int size, int offset);
 extern int _find_first_bit_be(const unsigned long *p, unsigned size);
 extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 
-- 
2.11.0
