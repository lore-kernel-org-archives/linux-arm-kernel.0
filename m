From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 29 Jun 2017 16:35:29 +0200
Subject: [PATCH v2] arm64: fix endianness annotation in get_kaslr_seed()
In-Reply-To: <20170629095929.GB14607@arm.com>
References: <20170628145805.24587-1-luc.vanoostenryck@gmail.com>
 <20170629095929.GB14607@arm.com>
Message-ID: <20170629143528.feomz4qwwdytpclx@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the flattened device tree format, all integer properties are
in big-endian order.
Here the property "kaslr-seed" is read from the fdt and then
correctly converted to native order (via fdt64_to_cpu()) but the
pointer used for this is not annotated as being for big-endian.

Fix this by declaring the pointer as fdt64_t instead of u64
(fdt64_t being itself typedefed to __be64).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
Change since v1:
- use 'fdt64_t' instead of a plain '__be64'.

 arch/arm64/kernel/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index d7e90d97f..a9710efb8 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -27,7 +27,7 @@ u16 __initdata memstart_offset_seed;
 static __init u64 get_kaslr_seed(void *fdt)
 {
 	int node, len;
-	u64 *prop;
+	fdt64_t *prop;
 	u64 ret;
 
 	node = fdt_path_offset(fdt, "/chosen");
-- 
2.13.0
