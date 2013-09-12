From: joe@perches.com (Joe Perches)
Date: Thu, 12 Sep 2013 10:29:46 -0700
Subject: [PATCH] dma: use %pa to print dma_addr_t
In-Reply-To: <5231F45C.3020500@infradead.org>
References: <1378960710-15648-1-git-send-email-olof@lixom.net>
 <5231F45C.3020500@infradead.org>
Message-ID: <1379006986.1944.3.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 10:05 -0700, Randy Dunlap wrote:
> On 09/11/13 21:38, Olof Johansson wrote:
> > This resolves some warnings seen when building with CONFIG_ARM_LPAE=y, since
> > dma_addr_t might then be 64-bit:
> > 
> >   drivers/dma/imx-sdma.c:1092:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-sdma.c:1166:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:579:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:579:3: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:593:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:603:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:930:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:930:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:960:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/imx-dma.c:960:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
> >   drivers/dma/ipu/ipu_idmac.c:1235:2: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
> 
> 
> I've been tempted to make similar patches, but CONFIG_PHYS_ADDR_T_64BIT
> and CONFIG_ARCH_DMA_ADDR_T_64BIT are independent AFAICT,
> and %pa is for physical addresses, not necessarily DMA addresses.
> 
> Am I confused?

No.

https://lkml.org/lkml/2013/6/1/202

No.  If a dma_addr_t is really needed, then maybe
something like this:

---

 Documentation/printk-formats.txt | 11 +++++++++--
 lib/vsprintf.c                   | 33 +++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index 445ad74..6f4eb32 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -55,14 +55,21 @@ Struct Resources:
 	For printing struct resources. The 'R' and 'r' specifiers result in a
 	printed resource with ('R') or without ('r') a decoded flags member.
 
-Physical addresses:
+Physical addresses types phys_addr_t:
 
-	%pa	0x01234567 or 0x0123456789abcdef
+	%pa[p]	0x01234567 or 0x0123456789abcdef
 
 	For printing a phys_addr_t type (and its derivatives, such as
 	resource_size_t) which can vary based on build options, regardless of
 	the width of the CPU data path. Passed by reference.
 
+DMA addresses types dma_addr_t:
+
+	%pad	0x01234567 or 0x0123456789abcdef
+
+	For printing a dma_addr_t type which can vary based on build options,
+	regardless of the width of the CPU data path. Passed by reference.
+
 Raw buffer as a hex string:
 	%*ph	00 01 02  ...  3f
 	%*phC	00:01:02: ... :3f
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 43c2ea0..4df18bc 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1154,6 +1154,30 @@ char *netdev_feature_string(char *buf, char *end, const u8 *addr,
 	return number(buf, end, *(const netdev_features_t *)addr, spec);
 }
 
+static noinline_for_stack
+char *address_val(char *buf, char *end, const void *addr,
+		  struct printf_spec spec, const char *fmt)
+{
+	unsigned long long num;
+
+	spec.flags |= SPECIAL | SMALL | ZEROPAD;
+	spec.base = 16;
+
+	switch (fmt[1]) {
+	case 'd':
+		num = *(const dma_addr_t *)addr;
+		spec.field_width = sizeof(dma_addr_t) * 2 + 2;
+		break;
+	case 'p':
+	default:
+		num = *(const phys_addr_t *)addr;
+		spec.field_width = sizeof(phys_addr_t) * 2 + 2;
+		break;
+	}
+
+	return number(buf, end, num, spec);
+}
+
 int kptr_restrict __read_mostly;
 
 /*
@@ -1217,7 +1241,8 @@ int kptr_restrict __read_mostly;
  *              N no separator
  *            The maximum supported length is 64 bytes of the input. Consider
  *            to use print_hex_dump() for the larger input.
- * - 'a' For a phys_addr_t type and its derivative types (passed by reference)
+ * - 'a[pd]' For address types phys_addr_t, dma_addr_t and derivatives
+ *           (default assumed to be phys_addr_t, passed by reference)
  *
  * Note: The difference between 'S' and 'F' is that on ia64 and ppc64
  * function pointers are really function descriptors, which contain a
@@ -1324,11 +1349,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		}
 		break;
 	case 'a':
-		spec.flags |= SPECIAL | SMALL | ZEROPAD;
-		spec.field_width = sizeof(phys_addr_t) * 2 + 2;
-		spec.base = 16;
-		return number(buf, end,
-			      (unsigned long long) *((phys_addr_t *)ptr), spec);
+		return address_val(buf, end, ptr, spec, fmt);
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
 	case 'D':
