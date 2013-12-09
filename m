From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 09 Dec 2013 21:05:40 +0800
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131209115050.GA19163@arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052304.22302.arnd@arndb.de> <52A1E794.1040008@linaro.org>
 <201312061823.26481.arnd@arndb.de> <52A54328.3000709@linaro.org>
 <20131209115050.GA19163@arm.com>
Message-ID: <52A5C024.5050702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-9 19:50, Catalin Marinas wrote:
> On Mon, Dec 09, 2013 at 04:12:24AM +0000, Hanjun Guo wrote:
>> On 2013-12-7 1:23, Arnd Bergmann wrote:
>>> On Friday 06 December 2013, Tomasz Nowicki wrote:
>>>> On 05.12.2013 23:04, Arnd Bergmann wrote:
>>>>> On Wednesday 04 December 2013, Hanjun Guo wrote:
>>>>>> On 2013?12?04? 00:41, Matthew Garrett wrote:
>>>>>>> Given the number of #ifdefs you're adding, wouldn't it make more sense
>>>>>>> to just add stub functions to include/linux/pci.h?
>>>>>>
>>>>>> Thanks for the suggestion :)
>>>>>>
>>>>>> I can add stub functions in include/linux/pci.h for raw_pci_read()/
>>>>>> raw_pci_write(), then can remove #ifdefs for acpi_os_read/write_pci_configuration().
>>>>>
>>>>> Actually I wonder about the usefulness of this patch in either form: Since ACPI
>>>>> on ARM64 is only for servers, I would very much expect them to always come with
>>>>> PCI, either physical host bridges with attached devices, or logical PCI functions
>>>>> used to describe the on-SoC I/O devices. Even in case of virtual machines, you'd
>>>>> normally use PCI as the method to communicate data about the virtio channels.
>>>>>
>>>>> Can you name a realistic use-case where you'd want ACPI but not PCI?
>>>>
>>>> Yes you can describe SoC I/O devices using logical PCI functions only if 
>>>> they are on PCI, correct me if I am wrong. Also, devices can be placed 
>>>> only on IOMEM (like for ARM SoC) and it is hard to predict which way 
>>>> vendors chose. So way don't let it be configurable? ACPI spec says 
>>>> nothing like PCI is needed for ACPI, AFAIK.
>>>
>>> You are right that today's ARM SoCs basically never use PCI to describe
>>> internal devices (IIRC VIA VT8500 is an exception, but their PCI was
>>> just a software fabrication).
>>>
>>> However, when we're talking about ACPI on ARM64, that is nothing like classic
>>> ARM SoCs: As Jon Masters mentioned, this is about new server hardware following
>>> a (still secret, but hopefully not much longer) hardware specification that is
>>> explicitly designed to allow interoperability between vendors, so they
>>> must have put some thought into how to make the hardware discoverable. It
>>> seems that they are modeling things after how it's done on x86, and the
>>> only sensible way to have discoverable hardware there is PCI. This is
>>> also what all x86 SoCs do.
>>
>> I think the concern here is that ACPI is only for server platform or not.
>>
>> Since ACPI has lots of content related to power management, I think ACPI
>> can be used for mobile devices and other platform too, not only for ARM
>> servers, and with this patch, we can support both requirement.
> 
> 'Can be used' is one thing, will it really be used is another? I don't
> think so, it was (well, is) difficult enough to make the transition to
> FDT, I don't see how ACPI would solve the current issues.
> 
> I see ACPI as a server distro requirement and there are indeed benefits
> in abstracting the hardware behind standard description, AML. Of course,
> this would work even better with probe-able buses like PCIe and I'm
> pretty sure this would be the case on high-end servers. But even if a
> server distro like RHEL supports a SoC without PCIe, I would expect them
> to only provide a single binary Image with CONFIG_PCI enabled.
> 
> This patch is small enough and allows ACPI build with !CONFIG_PCI for
> the time being but longer term I would expect such SoCs without PCI to
> be able to run on a kernel with CONFIG_PCI enabled.

Yes, we will support PCI in ACPI in the long run, and we just make PCI
optional for ACPI in this patch.

Actually, I had reworked this patch and make the code with minimal
changes to ACPI code:


Not all the ARM64 targets that are using ACPI have PCI, so introduce
some stub functions to make ACPI core run without CONFIG_PCI on ARM64.

pcibios_penalize_isa_irq() is arch dependent, introduce asm/pci.h to
include it.

Since ACPI on X86 and IA64 depends on PCI, it will not break X86 and
IA64 with this patch.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/pci.h |   13 +++++++++++++
 drivers/acpi/Makefile        |    2 +-
 drivers/acpi/internal.h      |    5 +++++
 include/linux/pci.h          |   32 +++++++++++++++++++++++---------
 4 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/include/asm/pci.h

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
new file mode 100644
index 0000000..e682c25
--- /dev/null
+++ b/arch/arm64/include/asm/pci.h
@@ -0,0 +1,13 @@
+#ifndef ASMARM_PCI_H
+#define ASMARM_PCI_H
+
+#ifdef __KERNEL__
+
+static inline void pcibios_penalize_isa_irq(int irq, int active)
+{
+	/* We don't do dynamic PCI IRQ allocation */
+}
+
+#endif /* __KERNEL__ */
+
+#endif
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 0331f91..d8cebe3 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -38,7 +38,7 @@ acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
-acpi-y				+= pci_root.o pci_link.o pci_irq.o
+acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 acpi-$(CONFIG_X86_INTEL_LPSS)	+= acpi_lpss.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= power.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index b125fdb..b1ef8fa 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -26,8 +26,13 @@
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
+#ifdef CONFIG_PCI
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
+#else
+static inline void acpi_pci_root_init(void) {}
+static inline void acpi_pci_link_init(void) {}
+#endif /* CONFIG_PCI */
 void acpi_processor_init(void);
 void acpi_platform_init(void);
 int acpi_sysfs_init(void);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1084a15..28334dd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -541,15 +541,6 @@ struct pci_ops {
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
 };

-/*
- * ACPI needs to be able to access PCI config space before we've done a
- * PCI bus scan and created pci_bus structures.
- */
-int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
-		 int reg, int len, u32 *val);
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val);
-
 struct pci_bus_region {
 	resource_size_t start;
 	resource_size_t end;
@@ -1280,6 +1271,15 @@ typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 void pci_register_set_vga_state(arch_set_vga_state_t func);

+/*
+ * ACPI needs to be able to access PCI config space before we've done a
+ * PCI bus scan and created pci_bus structures.
+ */
+int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
+		 int reg, int len, u32 *val);
+int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
+		  int reg, int len, u32 val);
+
 #else /* CONFIG_PCI is not enabled */

 /*
@@ -1476,6 +1476,20 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
 { return NULL; }

+static inline struct pci_bus *pci_find_bus(int domain, int busnr)
+{ return NULL; }
+
+static inline int pci_bus_write_config_byte(struct pci_bus *bus,
+			unsigned int devfn, int where, u8 val);
+{ return -ENODEV; }
+
+static inline int raw_pci_read(unsigned int domain, unsigned int bus,
+		unsigned int devfn, int reg, int len, u32 *val);
+{ return -EINVAL; }
+static inline int raw_pci_write(unsigned int domain, unsigned int bus,
+		unsigned int devfn, int reg, int len, u32 val);
+{return -EINVAL; }
+
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
 #define dev_num_vf(d) (0)

--
Hanjun
