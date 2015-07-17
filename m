From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 17 Jul 2015 10:02:25 +0000
Subject: [PATCH v3 1/5] ARM/PCI: remove align_resource callback in
 pcibios_align_resource
In-Reply-To: <20150707092220.GA980@e106497-lin.cambridge.arm.com>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
 <1435743817-19083-2-git-send-email-wangzhou1@hisilicon.com>
 <20150702175056.GX944@e106497-lin.cambridge.arm.com>
 <559B6721.4080305@hisilicon.com>
 <20150707092220.GA980@e106497-lin.cambridge.arm.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D5F503@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch is maybe a better solution

Gab

-----------------------
This patch is needed in order to unify the PCIe designware
framework for ARM and ARM64 architectures.
In the PCIe designware unification process we are calling
pci_create_root_bus() passing a "sysdata" parameter
that is the same for both ARM and ARM64 and is of type
"struct pcie_port*". In the ARM case this will cause
a problem with the function pcibios_align_resource();
in fact this will cast "dev->sysdata" to "struct pci_sys_data*",
whereas designware had passed a "struct pcie_port*" pointer.

This patch solves the issue by removing "align_resource" from
"pci_sys_data" struct and defining a static global function pointer
in "bios32.c"

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 arch/arm/include/asm/mach/pci.h |  5 -----
 arch/arm/kernel/bios32.c        | 12 ++++++++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 28b9bb3..8a4e4de 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -58,11 +58,6 @@ struct pci_sys_data {
 					/* IRQ mapping				*/
 	int		(*map_irq)(const struct pci_dev *, u8, u8);
 					/* Resource alignement requirements	*/
-	resource_size_t (*align_resource)(struct pci_dev *dev,
-					  const struct resource *res,
-					  resource_size_t start,
-					  resource_size_t size,
-					  resource_size_t align);
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..4cdc64d 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -17,6 +17,11 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
+static resource_size_t (*align_resource)(struct pci_dev *dev,
+		  const struct resource *res,
+		  resource_size_t start,
+		  resource_size_t size,
+		  resource_size_t align) = NULL;
 
 #ifdef CONFIG_PCI_MSI
 struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
@@ -468,7 +473,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
-		sys->align_resource = hw->align_resource;
+		align_resource = hw->align_resource;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
@@ -589,7 +594,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
-	struct pci_sys_data *sys = dev->sysdata;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
@@ -597,8 +601,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (sys->align_resource)
-		return sys->align_resource(dev, res, start, size, align);
+	if (align_resource)
+		return align_resource(dev, res, start, size, align);
 
 	return start;
 }
-- 
1.9.1

> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-
> owner at vger.kernel.org] On Behalf Of Liviu Dudau
> Sent: Tuesday, July 07, 2015 10:22 AM
> To: Wangzhou (B)
> Cc: Bjorn Helgaas; Jingoo Han; Pratyush Anand; Arnd Bergmann; Gabriele
> Paoloni; James Morse; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org; Yuanzhichang;
> Zhudacai; zhangjukuo; qiuzhenfa; Liguozhu (Kenneth)
> Subject: Re: [PATCH v3 1/5] ARM/PCI: remove align_resource callback in
> pcibios_align_resource
> 
> On Tue, Jul 07, 2015 at 06:44:01AM +0100, Zhou Wang wrote:
> > On 2015/7/3 1:50, Liviu Dudau wrote:
> > > On Wed, Jul 01, 2015 at 10:43:33AM +0100, Zhou Wang wrote:
> > >> This patch had added by Arnd Bergmann during last reviewing of v1
> patchset[1].
> > >>
> > >> PCI core codes call pcibios_align_resource(). In ARM specific one,
> it will
> > >> dereference pci_sys_data and call sys->align_resource. If we try
> to unify ARM
> > >> and ARM64 PCIe API in pcie-designware. it will bring kernel crash
> when run into
> > >> this dereferencing.
> > >>
> > >> However, in ARM there is only pci-mvebu which implements
> align_resource. So
> > >> add align_resource call back in pci_host_bridge structure and
> override
> > >> pcibios_align_resource with it.
> > >>
> > >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > >> Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > >>
> > >> [1] http://www.spinics.net/lists/linux-pci/msg41671.html
> > >> ---
> > >>  arch/arm/kernel/bios32.c     |  6 ------
> > >>  drivers/pci/host/pci-mvebu.c | 47 ++++++++++++++++++++++++++++---
> -------------
> > >>  drivers/pci/setup-res.c      | 27 ++++++++++++++++++++-----
> > >>  include/linux/pci.h          |  3 +++
> > >>  4 files changed, 55 insertions(+), 28 deletions(-)
> > >>
> > >> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > >> index fcbbbb1..b01189f 100644
> > >> --- a/arch/arm/kernel/bios32.c
> > >> +++ b/arch/arm/kernel/bios32.c
> > >> @@ -468,7 +468,6 @@ static void pcibios_init_hw(struct device
> *parent, struct hw_pci *hw,
> > >>  		sys->busnr   = busnr;
> > >>  		sys->swizzle = hw->swizzle;
> > >>  		sys->map_irq = hw->map_irq;
> > >> -		sys->align_resource = hw->align_resource;
> > >>  		INIT_LIST_HEAD(&sys->resources);
> > >>
> > >>  		if (hw->private_data)
> > >> @@ -588,8 +587,6 @@ char * __init pcibios_setup(char *str)
> > >>  resource_size_t pcibios_align_resource(void *data, const struct
> resource *res,
> > >>  				resource_size_t size, resource_size_t
> align)
> > >>  {
> > >> -	struct pci_dev *dev = data;
> > >> -	struct pci_sys_data *sys = dev->sysdata;
> > >>  	resource_size_t start = res->start;
> > >>
> > >>  	if (res->flags & IORESOURCE_IO && start & 0x300)
> > >> @@ -597,9 +594,6 @@ resource_size_t pcibios_align_resource(void
> *data, const struct resource *res,
> > >>
> > >>  	start = (start + align - 1) & ~(align - 1);
> > >>
> > >> -	if (sys->align_resource)
> > >> -		return sys->align_resource(dev, res, start, size,
> align);
> > >> -
> > >>  	return start;
> > >>  }
> > >>
> > >> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-
> mvebu.c
> > >> index 1ab8635..155d05f 100644
> > >> --- a/drivers/pci/host/pci-mvebu.c
> > >> +++ b/drivers/pci/host/pci-mvebu.c
> > >> @@ -22,6 +22,8 @@
> > >>  #include <linux/of_pci.h>
> > >>  #include <linux/of_platform.h>
> > >>
> > >> +#include "../pci.h" /* HACK to see pci_find_host_bridge */
> > >> +
> > >>  /*
> > >>   * PCIe unit register offsets.
> > >>   */
> > >> @@ -751,27 +753,20 @@ static int mvebu_pcie_setup(int nr, struct
> pci_sys_data *sys)
> > >>  	return 1;
> > >>  }
> > >>
> > >> -static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct
> pci_sys_data *sys)
> > >> +static resource_size_t mvebu_pcie_align_resource(void *data,
> > >> +						 const struct resource *res,
> > >> +						 resource_size_t size,
> > >> +						 resource_size_t align)
> > >>  {
> > >> -	struct mvebu_pcie *pcie = sys_to_pcie(sys);
> > >> -	struct pci_bus *bus;
> > >> +	struct pci_dev *dev = data;
> > >>
> > >> -	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
> > >> -				  &mvebu_pcie_ops, sys, &sys->resources);
> > >> -	if (!bus)
> > >> -		return NULL;
> > >> +	resource_size_t start = res->start;
> > >>
> > >> -	pci_scan_child_bus(bus);
> > >> +	if (res->flags & IORESOURCE_IO && start & 0x300)
> > >> +		start = (start + 0x3ff) & ~0x3ff;
> > >>
> > >> -	return bus;
> > >> -}
> > >> +	start = (start + align - 1) & ~(align - 1);
> > >
> > > Honestly, I don't see here anything that is mvebu specific. Could
> you move
> >
> > What I mean is that there is only mvebu who implemented sys-
> >align_resource callback in ARM
> > arch.
> >
> > > this function in the generic pci/host area and have a flag in the
> pci_host_bridge
> > > structure whether the function should be called or not? I know that
> in a way
> > > that looks very close to the existing implementation which uses
> pcibios_align_resource,
> >
> > I am confused about "the existing implementation". Now
> pcibios_align_resource are
> > implemented by each arch code and are called directly. Did I miss
> anything about
> > pcibios_align_resource?
> 
> Sorry, I meant existing implementation_s_ and yes, I was reffering to
> the arch specific
> code. If you look at the cris, frv/mb93090-mb00, m68k, microblaze,
> powerpc, unicore32
> and x86 they all share the code with your version, plus or minus
> additional checks.
> I was thinking that for those arch versions that match your version you
> can create just
> one version and use it as the alignf function.
> 
> Best regards,
> Liviu
> 
> >
> > Best rgards,
> > Zhou
> >
> > > but the problem with pcibios_ version is that it is arch specific
> and not driver
> > > specific the way we want.
> > >
> > > Having this version as a generic implementation would also remove
> at least 2 more
> > > arch version, possibly more after testing by the arch maintainers.
> > >
> > > Best regards,
> > > Liviu
> > >
> > >>
> > >> -static resource_size_t mvebu_pcie_align_resource(struct pci_dev
> *dev,
> > >> -						 const struct resource *res,
> > >> -						 resource_size_t start,
> > >> -						 resource_size_t size,
> > >> -						 resource_size_t align)
> > >> -{
> > >>  	if (dev->bus->number != 0)
> > >>  		return start;
> > >>
> > >> @@ -796,6 +791,25 @@ static resource_size_t
> mvebu_pcie_align_resource(struct pci_dev *dev,
> > >>  		return start;
> > >>  }
> > >>
> > >> +static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct
> pci_sys_data *sys)
> > >> +{
> > >> +	struct mvebu_pcie *pcie = sys_to_pcie(sys);
> > >> +	struct pci_host_bridge *phb;
> > >> +	struct pci_bus *bus;
> > >> +
> > >> +	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
> > >> +				  &mvebu_pcie_ops, sys, &sys->resources);
> > >> +	if (!bus)
> > >> +		return NULL;
> > >> +
> > >> +	phb = pci_find_host_bridge(bus);
> > >> +	phb->align_resource = mvebu_pcie_align_resource;
> > >> +
> > >> +	pci_scan_child_bus(bus);
> > >> +
> > >> +	return bus;
> > >> +}
> > >> +
> > >>  static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
> > >>  {
> > >>  	struct hw_pci hw;
> > >> @@ -812,7 +826,6 @@ static void mvebu_pcie_enable(struct
> mvebu_pcie *pcie)
> > >>  	hw.scan           = mvebu_pcie_scan_bus;
> > >>  	hw.map_irq        = of_irq_parse_and_map_pci;
> > >>  	hw.ops            = &mvebu_pcie_ops;
> > >> -	hw.align_resource = mvebu_pcie_align_resource;
> > >>
> > >>  	pci_common_init(&hw);
> > >>  }
> > >> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > >> index 232f925..73abca7 100644
> > >> --- a/drivers/pci/setup-res.c
> > >> +++ b/drivers/pci/setup-res.c
> > >> @@ -200,7 +200,11 @@ static int pci_revert_fw_address(struct
> resource *res, struct pci_dev *dev,
> > >>  }
> > >>
> > >>  static int __pci_assign_resource(struct pci_bus *bus, struct
> pci_dev *dev,
> > >> -		int resno, resource_size_t size, resource_size_t
> align)
> > >> +		int resno, resource_size_t size, resource_size_t
> align,
> > >> +		resource_size_t (*alignf)(void *,
> > >> +					  const struct resource *,
> > >> +					  resource_size_t,
> > >> +					  resource_size_t))
> > >>  {
> > >>  	struct resource *res = dev->resource + resno;
> > >>  	resource_size_t min;
> > >> @@ -217,7 +221,7 @@ static int __pci_assign_resource(struct
> pci_bus *bus, struct pci_dev *dev,
> > >>  	 */
> > >>  	ret = pci_bus_alloc_resource(bus, res, size, align, min,
> > >>  				     IORESOURCE_PREFETCH |
> IORESOURCE_MEM_64,
> > >> -				     pcibios_align_resource, dev);
> > >> +				     alignf, dev);
> > >>  	if (ret == 0)
> > >>  		return 0;
> > >>
> > >> @@ -229,7 +233,7 @@ static int __pci_assign_resource(struct
> pci_bus *bus, struct pci_dev *dev,
> > >>  	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
> > >>  		ret = pci_bus_alloc_resource(bus, res, size, align,
> min,
> > >>  					     IORESOURCE_PREFETCH,
> > >> -					     pcibios_align_resource, dev);
> > >> +					     alignf, dev);
> > >>  		if (ret == 0)
> > >>  			return 0;
> > >>  	}
> > >> @@ -242,7 +246,7 @@ static int __pci_assign_resource(struct
> pci_bus *bus, struct pci_dev *dev,
> > >>  	 */
> > >>  	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
> > >>  		ret = pci_bus_alloc_resource(bus, res, size, align,
> min, 0,
> > >> -					     pcibios_align_resource, dev);
> > >> +					     alignf, dev);
> > >>
> > >>  	return ret;
> > >>  }
> > >> @@ -251,10 +255,23 @@ static int _pci_assign_resource(struct
> pci_dev *dev, int resno,
> > >>  				resource_size_t size, resource_size_t
> min_align)
> > >>  {
> > >>  	struct pci_bus *bus;
> > >> +	struct pci_host_bridge *phb;
> > >> +	resource_size_t (*alignf)(void *,
> > >> +				  const struct resource *,
> > >> +				  resource_size_t,
> > >> +				  resource_size_t);
> > >>  	int ret;
> > >>
> > >>  	bus = dev->bus;
> > >> -	while ((ret = __pci_assign_resource(bus, dev, resno, size,
> min_align))) {
> > >> +	phb = pci_find_host_bridge(bus);
> > >> +
> > >> +	if (phb->align_resource)
> > >> +		alignf = phb->align_resource;
> > >> +	else
> > >> +		alignf = pcibios_align_resource;
> > >> +
> > >> +	while ((ret = __pci_assign_resource(bus, dev, resno, size,
> > >> +					    min_align, alignf))) {
> > >>  		if (!bus->parent || !bus->self->transparent)
> > >>  			break;
> > >>  		bus = bus->parent;
> > >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> > >> index 353db8d..39e48fc 100644
> > >> --- a/include/linux/pci.h
> > >> +++ b/include/linux/pci.h
> > >> @@ -404,6 +404,9 @@ struct pci_host_bridge {
> > >>  	struct device dev;
> > >>  	struct pci_bus *bus;		/* root bus */
> > >>  	struct list_head windows;	/* resource_entry */
> > >> +	resource_size_t (*align_resource)(void *data,
> > >> +			 const struct resource *res,
> > >> +			 resource_size_t size, resource_size_t align);
> > >>  	void (*release_fn)(struct pci_host_bridge *);
> > >>  	void *release_data;
> > >>  	unsigned int ignore_reset_delay:1;	/* for entire hierarchy
> */
> > >> --
> > >> 1.9.1
> > >>
> > >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ?\_(?)_/?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
