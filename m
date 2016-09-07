From: yuanzhichang@hisilicon.com (Zhichang Yuan)
Date: Wed, 7 Sep 2016 21:33:50 +0800
Subject: [PATCH V2 1/4] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <1473255233-154297-2-git-send-email-yuanzhichang@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

For arm64, there is no I/O space as other architectural platforms, such as
X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
such as Hip06, when accessing some legacy ISA devices connected to LPC, those
known port addresses are explicitly used to control the corresponding target
devices, for example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different
from the normal MMIO mode in using.

To drive these devices, this patch introduces a method named indirect-IO.
In this method the in/out pair in arch/arm64/include/asm/io.h will be
redefined. When upper layer drivers call in/out with those known legacy port
addresses to access the peripherals, the hooking functions corrresponding to
those target peripherals will be called. Through this way, those upper layer
drivers which depend on in/out can run on Hip06 without any changes.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
---
 arch/arm64/Kconfig           |   6 +++
 arch/arm64/include/asm/io.h  | 109 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pci.h |   1 -
 drivers/of/address.c         |   3 +-
 drivers/pci/pci.c            |   6 +--
 5 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..9579479 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -161,6 +161,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
 config ARCH_MMAP_RND_COMPAT_BITS_MAX
        default 16
 
+config ARM64_INDIRECT_PIO
+	def_bool n
+	help
+	  Support to access the ISA I/O devices with the legacy X86 I/O port
+	  addresses in some SoCs, such as Hisilicon Hip06.
+
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 9b6e408..0e0c4db 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -142,6 +142,38 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c)); })
 #define writeq(v,c)		({ __iowmb(); writeq_relaxed((v),(c)); })
 
+
+#define BUILDS_RW(bwl, type)						\
+static inline void reads##bwl(const volatile void __iomem *addr,	\
+				void *buffer, unsigned int count)	\
+{									\
+	if (count) {							\
+		type *buf = buffer;					\
+									\
+		do {							\
+			type x = __raw_read##bwl(addr);			\
+			*buf++ = x;					\
+		} while (--count);					\
+	}								\
+}									\
+									\
+static inline void writes##bwl(volatile void __iomem *addr,		\
+				const void *buffer, unsigned int count)	\
+{									\
+	if (count) {							\
+		const type *buf = buffer;				\
+									\
+		do {							\
+			__raw_write##bwl(*buf++, addr);			\
+		} while (--count);					\
+	}								\
+}
+
+BUILDS_RW(b, u8)
+#define readsb readsb
+#define writesb writesb
+
+
 /*
  *  I/O port access primitives.
  */
@@ -149,6 +181,83 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
+#define PCIBIOS_MIN_IO		0x1000
+
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+
+typedef u64 (*inhook)(void *devobj, unsigned long ptaddr, void *inbuf,
+				size_t dlen, unsigned int count);
+typedef void (*outhook)(void *devobj, unsigned long ptaddr,
+				const void *outbuf, size_t dlen,
+				unsigned int count);
+
+struct extio_ops {
+	inhook	pfin;
+	outhook	pfout;
+	void *devpara;
+};
+
+extern struct extio_ops *arm64_simops __refdata;
+
+/*Up to now, only applied to Hip06 LPC. Define as static here.*/
+static inline void arm64_set_simops(struct extio_ops *ops)
+{
+	if (ops)
+		WRITE_ONCE(arm64_simops, ops);
+}
+
+
+#define BUILDIO(bw, type)						\
+static inline type in##bw(unsigned long addr)				\
+{									\
+	if (addr >= PCIBIOS_MIN_IO)					\
+		return read##bw(PCI_IOBASE + addr);			\
+	return (arm64_simops && arm64_simops->pfin) ?			\
+		arm64_simops->pfin(arm64_simops->devpara, addr, NULL,	\
+					sizeof(type), 1) : -1;		\
+}							\
+									\
+static inline void out##bw(type value, unsigned long addr)		\
+{									\
+	if (addr >= PCIBIOS_MIN_IO)					\
+		write##bw(value, PCI_IOBASE + addr);			\
+	else								\
+		if (arm64_simops && arm64_simops->pfout)		\
+			arm64_simops->pfout(arm64_simops->devpara, addr,\
+					&value, sizeof(type), 1);	\
+}									\
+									\
+static inline void ins##bw(unsigned long addr, void *buffer, unsigned int count)	\
+{									\
+	if (addr >= PCIBIOS_MIN_IO)					\
+		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+	else								\
+		if (arm64_simops && arm64_simops->pfin)			\
+			arm64_simops->pfin(arm64_simops->devpara, addr,\
+					buffer, sizeof(type), count);	\
+}									\
+									\
+static inline void outs##bw(unsigned long addr, const void *buffer,	\
+				unsigned int count)			\
+{									\
+	if (addr >= PCIBIOS_MIN_IO)					\
+		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+	else								\
+		if (arm64_simops && arm64_simops->pfin)			\
+			arm64_simops->pfout(arm64_simops->devpara, addr,\
+					buffer, sizeof(type), count);	\
+}
+
+
+BUILDIO(b, u8)
+#define inb inb
+#define outb outb
+#define insb insb
+#define outsb outsb
+
+#endif
+
+
 /*
  * String version of I/O memory access operations.
  */
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b9a7ba9..5cd3738a 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -8,7 +8,6 @@
 
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0
 
 /*
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903..4092a99 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -688,8 +688,9 @@ static int __of_address_to_resource(struct device_node *dev,
 	if (taddr == OF_BAD_ADDR)
 		return -EINVAL;
 	memset(r, 0, sizeof(struct resource));
-	if (flags & IORESOURCE_IO) {
+	if (flags & IORESOURCE_IO && of_bus_pci_match(dev)) {
 		unsigned long port;
+
 		port = pci_address_to_pio(taddr);
 		if (port == (unsigned long)-1)
 			return -EINVAL;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..ac2e569 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3221,7 +3221,7 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
 
 #ifdef PCI_IOBASE
 	struct io_range *range;
-	resource_size_t allocated_size = 0;
+	resource_size_t allocated_size = PCIBIOS_MIN_IO;
 
 	/* check if the range hasn't been previously recorded */
 	spin_lock(&io_range_lock);
@@ -3270,7 +3270,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 
 #ifdef PCI_IOBASE
 	struct io_range *range;
-	resource_size_t allocated_size = 0;
+	resource_size_t allocated_size = PCIBIOS_MIN_IO;
 
 	if (pio > IO_SPACE_LIMIT)
 		return address;
@@ -3293,7 +3293,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
 {
 #ifdef PCI_IOBASE
 	struct io_range *res;
-	resource_size_t offset = 0;
+	resource_size_t offset = PCIBIOS_MIN_IO;
 	unsigned long addr = -1;
 
 	spin_lock(&io_range_lock);
-- 
1.9.1
