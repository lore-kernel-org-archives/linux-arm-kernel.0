From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 May 2016 11:01:09 +0100
Subject: [GIT PULL] irqchip updates for 4.7
Message-ID: <1462960869-27845-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

This is the pull request for the irqchip updates targeting 4.7: A
couple of new drivers, quite a few cleanups two bug fixes and a
workaround for a Broadcom erratum. Jon's PM support has uncovered
another bug nest, so I'm holding it until this is properly solved.

A word of warning: there is some other GIC stuff queued through the
KVM/ARM tree (ACPI support) and the arm64 tree (feature detection
code), which are already in -next. I'm including the resolution at the
end of this email.

Thanks,

	M.

The following changes since commit 287e9357abcc0ef079bf4e439e098a3bd6246a05:

  DT/arm,gic-v3: Documment PPI partition support (2016-05-02 13:42:51 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-for-4.7

for you to fetch changes up to a1dcbd11d09be1cb357b2f217c0eaa1461128da0:

  irqchip/bcm2836: Use a more generic memory barrier call (2016-05-11 10:13:00 +0100)

----------------------------------------------------------------
irqchip updates for Linux 4.7

- Layerscape SCFG MSI controller support
- LPC32xx interrupt controller support
- RPi irqchip support on arm64
- GICv2 cleanup
- GICv2 and GICv3 bug fixes

----------------------------------------------------------------
Christoph Hellwig (1):
      irqchip/irq-alpine-msi: Don't use <asm-generic/msi.h>

Dan Carpenter (1):
      irqchip/mbigen: Checking for IS_ERR() instead of NULL

Eric Anholt (3):
      irqchip/bcm2836: Drop smp_set_ops on arm64 builds
      irqchip/bcm2836: Fix compiler warning on 64-bit build
      irqchip/bcm2836: Use a more generic memory barrier call

Jon Hunter (10):
      genirq: Ensure IRQ descriptor is valid when setting-up the IRQ
      irqchip: Mask the non-type/sense bits when translating an IRQ
      irqchip/gic: Don't unnecessarily write the IRQ configuration
      irqchip/gic: WARN if setting the interrupt type for a PPI fails
      irqchip/gic: Don't initialise chip if mapping IO space fails
      irqchip/gic: Remove static irq_chip definition for eoimode1
      irqchip/gic: Return an error if GIC initialisation fails
      irqchip/gic: Pass GIC pointer to save/restore functions
      irqchip/gic: Store GIC configuration parameters
      irqchip/gic: Add helper functions for GIC setup and teardown

Marc Zyngier (2):
      irqchip/gic-v3: Remove inexistant register definition
      irqchip/gic-v3: Configure all interrupts as non-secure Group-1

Minghuan Lian (2):
      dt/bindings: Add bindings for Layerscape SCFG MSI
      irqchip: Add Layerscape SCFG MSI controller support

Ray Jui (1):
      irqchip/gic-v2m: Add workaround for Broadcom NS2 GICv2m erratum

Shanker Donthineni (1):
      irqchip/gicv3-its: Don't allow devices whose ID is outside range

Vladimir Zapolskiy (1):
      irqchip: Add LPC32xx interrupt controller driver

Will Deacon (1):
      irqchip/gic: Ensure ordering between read of INTACK and shared data

 .../interrupt-controller/fsl,ls-scfg-msi.txt       |  30 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/mach-lpc32xx/phy3250.c                    |   1 -
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-alpine-msi.c                   |   2 +-
 drivers/irqchip/irq-bcm2836.c                      |  10 +-
 drivers/irqchip/irq-crossbar.c                     |   2 +-
 drivers/irqchip/irq-gic-common.c                   |  20 +-
 drivers/irqchip/irq-gic-v2m.c                      |  19 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  42 ++-
 drivers/irqchip/irq-gic-v3.c                       |  19 ++
 drivers/irqchip/irq-gic.c                          | 322 +++++++++++++--------
 drivers/irqchip/irq-lpc32xx.c                      | 238 +++++++++++++++
 drivers/irqchip/irq-ls-scfg-msi.c                  | 240 +++++++++++++++
 drivers/irqchip/irq-mbigen.c                       |   4 +-
 drivers/irqchip/irq-tegra.c                        |   2 +-
 include/linux/irqchip/arm-gic-v3.h                 |   2 -
 kernel/irq/manage.c                                |   2 +-
 19 files changed, 827 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
 create mode 100644 drivers/irqchip/irq-lpc32xx.c
 create mode 100644 drivers/irqchip/irq-ls-scfg-msi.c

diff --cc drivers/irqchip/Kconfig
index 81f88ad,2f115be..0000000
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@@ -246,10 -246,11 +246,16 @@@ config MVEBU_ODM
  	bool
  	select GENERIC_MSI_IRQ_DOMAIN
  
 +config LS_SCFG_MSI
 +	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
 +	depends on PCI && PCI_MSI
 +	select PCI_MSI_IRQ_DOMAIN
 +
+ config EZNPS_GIC
+ 	bool "NPS400 Global Interrupt Manager (GIM)"
+ 	select IRQ_DOMAIN
+ 	help
+ 	  Support the EZchip NPS400 global interrupt controller
+ 
  config PARTITION_PERCPU
  	bool
diff --cc drivers/irqchip/Makefile
index f828244,f475986..0000000
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@@ -67,4 -66,4 +67,5 @@@ obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingen
  obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
  obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
  obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 +obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
+ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
diff --cc drivers/irqchip/irq-gic.c
index 113e2d0,30d05a4..0000000
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@@ -486,9 -491,8 +488,10 @@@ static int gic_cpu_init(struct gic_chip
  		/*
  		 * Get what the GIC says our CPU mask is.
  		 */
 -		BUG_ON(cpu >= NR_GIC_CPU_IF);
 +		if (WARN_ON(cpu >= NR_GIC_CPU_IF))
 +			return -EINVAL;
 +
+ 		gic_check_cpu_features();
  		cpu_mask = gic_get_cpumask(gic);
  		gic_cpu_map[cpu] = cpu_mask;
  
@@@ -1029,28 -1014,24 +1032,26 @@@ static const struct irq_domain_ops gic_
  	.unmap = gic_irq_domain_unmap,
  };
  
 -static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 -			   void __iomem *dist_base, void __iomem *cpu_base,
 -			   u32 percpu_offset, struct fwnode_handle *handle)
 +static int __init __gic_init_bases(struct gic_chip_data *gic, int irq_start,
 +				   struct fwnode_handle *handle)
  {
  	irq_hw_number_t hwirq_base;
 -	struct gic_chip_data *gic;
 -	int gic_irqs, irq_base, i;
 -
 -	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
 +	int gic_irqs, irq_base, i, ret;
  
 -	gic = &gic_data[gic_nr];
 +	if (WARN_ON(!gic || gic->domain))
 +		return -EINVAL;
  
- 	gic_check_cpu_features();
- 
  	/* Initialize irq_chip */
 -	if (static_key_true(&supports_deactivate) && gic_nr == 0) {
 -		gic->chip = gic_eoimode1_chip;
 +	gic->chip = gic_chip;
 +
 +	if (static_key_true(&supports_deactivate) && gic == &gic_data[0]) {
 +		gic->chip.irq_mask = gic_eoimode1_mask_irq;
 +		gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
 +		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
 +		gic->chip.name = kasprintf(GFP_KERNEL, "GICv2");
  	} else {
 -		gic->chip = gic_chip;
 -		gic->chip.name = kasprintf(GFP_KERNEL, "GIC-%d", gic_nr);
 +		gic->chip.name = kasprintf(GFP_KERNEL, "GIC-%d",
 +					   (int)(gic - &gic_data[0]));
  	}
  
  #ifdef CONFIG_SMP
@@@ -1249,30 -1190,29 +1250,53 @@@ static bool gic_check_eoimode(struct de
  	return true;
  }
  
 +static int gic_of_setup(struct gic_chip_data *gic, struct device_node *node)
 +{
 +	if (!gic || !node)
 +		return -EINVAL;
 +
 +	gic->raw_dist_base = of_iomap(node, 0);
 +	if (WARN(!gic->raw_dist_base, "unable to map gic dist registers\n"))
 +		goto error;
 +
 +	gic->raw_cpu_base = of_iomap(node, 1);
 +	if (WARN(!gic->raw_cpu_base, "unable to map gic cpu registers\n"))
 +		goto error;
 +
 +	if (of_property_read_u32(node, "cpu-offset", &gic->percpu_offset))
 +		gic->percpu_offset = 0;
 +
 +	return 0;
 +
 +error:
 +	gic_teardown(gic);
 +
 +	return -ENOMEM;
 +}
 +
+ static void __init gic_of_setup_kvm_info(struct device_node *node)
+ {
+ 	int ret;
+ 	struct resource *vctrl_res = &gic_v2_kvm_info.vctrl;
+ 	struct resource *vcpu_res = &gic_v2_kvm_info.vcpu;
+ 
+ 	gic_v2_kvm_info.type = GIC_V2;
+ 
+ 	gic_v2_kvm_info.maint_irq = irq_of_parse_and_map(node, 0);
+ 	if (!gic_v2_kvm_info.maint_irq)
+ 		return;
+ 
+ 	ret = of_address_to_resource(node, 2, vctrl_res);
+ 	if (ret)
+ 		return;
+ 
+ 	ret = of_address_to_resource(node, 3, vcpu_res);
+ 	if (ret)
+ 		return;
+ 
+ 	gic_set_kvm_info(&gic_v2_kvm_info);
+ }
+ 
  int __init
  gic_of_init(struct device_node *node, struct device_node *parent)
  {
@@@ -1295,17 -1234,18 +1319,19 @@@
  	 * Disable split EOI/Deactivate if either HYP is not available
  	 * or the CPU interface is too small.
  	 */
 -	if (gic_cnt == 0 && !gic_check_eoimode(node, &cpu_base))
 +	if (gic_cnt == 0 && !gic_check_eoimode(node, &gic->raw_cpu_base))
  		static_key_slow_dec(&supports_deactivate);
  
 -	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
 -		percpu_offset = 0;
 +	ret = __gic_init_bases(gic, -1, &node->fwnode);
 +	if (ret) {
 +		gic_teardown(gic);
 +		return ret;
 +	}
  
- 	if (!gic_cnt)
 -	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
 -			 &node->fwnode);
+ 	if (!gic_cnt) {
  		gic_init_physaddr(node);
+ 		gic_of_setup_kvm_info(node);
+ 	}
  
  	if (parent) {
  		irq = irq_of_parse_and_map(node, 0);
@@@ -1402,8 -1390,8 +1476,8 @@@ static int __init gic_v2_acpi_init(stru
  		return -EINVAL;
  	}
  
- 	gic->raw_cpu_base = ioremap(cpu_phy_base, ACPI_GIC_CPU_IF_MEM_SIZE);
 -	cpu_base = ioremap(acpi_data.cpu_phys_base, ACPI_GIC_CPU_IF_MEM_SIZE);
 -	if (!cpu_base) {
++	gic->raw_cpu_base = ioremap(acpi_data.cpu_phys_base, ACPI_GIC_CPU_IF_MEM_SIZE);
 +	if (!gic->raw_cpu_base) {
  		pr_err("Unable to map GICC registers\n");
  		return -ENOMEM;
  	}
