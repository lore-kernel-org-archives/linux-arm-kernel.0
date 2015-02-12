From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:40 +0100
Subject: [PATCH 08/11] ARM: ixp4xx: fix {in,out}s{bwl} data types
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most platforms use void pointer arguments in these functions, but
ixp4xx does not, which triggers lots of warnings in device drivers like:

net/ethernet/8390/ne2k-pci.c: In function 'ne2k_pci_get_8390_hdr':
net/ethernet/8390/ne2k-pci.c:503:3: warning: passing argument 2 of 'insw' from incompatible pointer type
   insw(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr)>>1);
   ^
In file included from include/asm/io.h:214:0,
                 from /git/arm-soc/include/linux/io.h:22,
                 from /git/arm-soc/include/linux/pci.h:31,
                 from net/ethernet/8390/ne2k-pci.c:48:
mach-ixp4xx/include/mach/io.h:316:91: note: expected 'u16 *' but argument is of type 'struct e8390_pkt_hdr *'
 static inline void insw(u32 io_addr, u16 *vaddr, u32 count)

Fixing the drivers seems hopeless, so this changes the ixp4xx code
to do the same as the others to avoid the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
---
 arch/arm/mach-ixp4xx/include/mach/io.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 6a722860e34d..b02439019963 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -245,8 +245,10 @@ static inline void outb(u8 value, u32 addr)
 }
 
 #define outsb outsb
-static inline void outsb(u32 io_addr, const u8 *vaddr, u32 count)
+static inline void outsb(u32 io_addr, const void *p, u32 count)
 {
+	const u8 *vaddr = p;
+
 	while (count--)
 		outb(*vaddr++, io_addr);
 }
@@ -262,8 +264,9 @@ static inline void outw(u16 value, u32 addr)
 }
 
 #define outsw outsw
-static inline void outsw(u32 io_addr, const u16 *vaddr, u32 count)
+static inline void outsw(u32 io_addr, const void *p, u32 count)
 {
+	const u16 *vaddr = p;
 	while (count--)
 		outw(cpu_to_le16(*vaddr++), io_addr);
 }
@@ -275,8 +278,9 @@ static inline void outl(u32 value, u32 addr)
 }
 
 #define outsl outsl
-static inline void outsl(u32 io_addr, const u32 *vaddr, u32 count)
+static inline void outsl(u32 io_addr, const void *p, u32 count)
 {
+	const u32 *vaddr = p;
 	while (count--)
 		outl(cpu_to_le32(*vaddr++), io_addr);
 }
@@ -294,8 +298,9 @@ static inline u8 inb(u32 addr)
 }
 
 #define insb insb
-static inline void insb(u32 io_addr, u8 *vaddr, u32 count)
+static inline void insb(u32 io_addr, void *p, u32 count)
 {
+	u8 *vaddr = p;
 	while (count--)
 		*vaddr++ = inb(io_addr);
 }
@@ -313,8 +318,9 @@ static inline u16 inw(u32 addr)
 }
 
 #define insw insw
-static inline void insw(u32 io_addr, u16 *vaddr, u32 count)
+static inline void insw(u32 io_addr, void *p, u32 count)
 {
+	u16 *vaddr = p;
 	while (count--)
 		*vaddr++ = le16_to_cpu(inw(io_addr));
 }
@@ -330,8 +336,9 @@ static inline u32 inl(u32 addr)
 }
 
 #define insl insl
-static inline void insl(u32 io_addr, u32 *vaddr, u32 count)
+static inline void insl(u32 io_addr, void *p, u32 count)
 {
+	u32 *vaddr = p;
 	while (count--)
 		*vaddr++ = le32_to_cpu(inl(io_addr));
 }
-- 
2.1.0.rc2
