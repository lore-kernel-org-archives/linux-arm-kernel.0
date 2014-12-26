From: orca.chen@gmail.com (Min-Hua Chen)
Date: Sat, 27 Dec 2014 00:52:10 +0800
Subject: [PATCH] arm64: add ioremap physical address information
Message-ID: <CAHkaATSM=V+BNZvAXC+VG6NDjOK9m0ZP3Q=SUaoxtgDw4SKZog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In /proc/vmallocinfo, it's good to show the physical address
of each ioremap in vmallocinfo. Add physical address information
in arm64 ioremap.

0xffffc900047f2000-0xffffc900047f4000    8192 _nv013519rm+0x57/0xa0
[nvidia] phys=f8100000 ioremap
0xffffc900047f4000-0xffffc900047f6000    8192 _nv013519rm+0x57/0xa0
[nvidia] phys=f8008000 ioremap
0xffffc90004800000-0xffffc90004821000  135168 e1000_probe+0x22c/0xb95
[e1000e] phys=f4300000 ioremap
0xffffc900049c0000-0xffffc900049e1000  135168 _nv013521rm+0x4d/0xd0
[nvidia] phys=e0140000 ioremap

Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>
---
 arch/arm64/mm/ioremap.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index cbb99c8..01e88c8 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -62,6 +62,7 @@ static void __iomem *__ioremap_caller(phys_addr_t
phys_addr, size_t size,
     if (!area)
         return NULL;
     addr = (unsigned long)area->addr;
+    area->phys_addr = phys_addr;

     err = ioremap_page_range(addr, addr + size, phys_addr, prot);
     if (err) {
--
1.7.10.4
