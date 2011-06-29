From: rob.herring@calxeda.com (Rob Herring)
Date: Wed, 29 Jun 2011 11:46:54 -0500
Subject: [PATCH] microblaze: move pci flag functions into asm-generic
Message-ID: <mailman.19.1310477950.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pci_set_flags, pci_add_flags, and pci_has_flag into
asm-generic/pci-bridge.h so other archs can use them.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Signed-off-by: Michal Simek <monstr@monstr.eu>

---
v2: Fix microblaze compilation problems
---
 arch/microblaze/include/asm/pci-bridge.h |   67 ++++-------------------------
 include/asm-generic/pci-bridge.h         |   62 +++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 57 deletions(-)
 create mode 100644 include/asm-generic/pci-bridge.h

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 746df91..4cae1d5 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -10,31 +10,19 @@
 #include <linux/pci.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
+#include <asm-generic/pci-bridge.h>
 
 struct device_node;
 
-enum {
-	/* Force re-assigning all resources (ignore firmware
-	 * setup completely)
-	 */
-	PCI_REASSIGN_ALL_RSRC	= 0x00000001,
-
-	/* Re-assign all bus numbers */
-	PCI_REASSIGN_ALL_BUS	= 0x00000002,
-
-	/* Do not try to assign, just use existing setup */
-	PCI_PROBE_ONLY		= 0x00000004,
-
-	/* Don't bother with ISA alignment unless the bridge has
-	 * ISA forwarding enabled
-	 */
-	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
-
-	/* Enable domain numbers in /proc */
-	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,
-	/* ... except for domain 0 */
-	PCI_COMPAT_DOMAIN_0		= 0x00000020,
-};
+#ifdef CONFIG_PCI
+extern struct list_head hose_list;
+extern int pcibios_vaddr_is_ioport(void __iomem *address);
+#else
+static inline int pcibios_vaddr_is_ioport(void __iomem *address)
+{
+	return 0;
+}
+#endif
 
 /*
  * Structure of a PCI controller (host bridge)
@@ -164,40 +152,5 @@ extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
 extern void pcibios_setup_phb_resources(struct pci_controller *hose);
 
-#ifdef CONFIG_PCI
-extern unsigned int pci_flags;
-
-static inline void pci_set_flags(int flags)
-{
-	pci_flags = flags;
-}
-
-static inline void pci_add_flags(int flags)
-{
-	pci_flags |= flags;
-}
-
-static inline int pci_has_flag(int flag)
-{
-	return pci_flags & flag;
-}
-
-extern struct list_head hose_list;
-
-extern int pcibios_vaddr_is_ioport(void __iomem *address);
-#else
-static inline int pcibios_vaddr_is_ioport(void __iomem *address)
-{
-	return 0;
-}
-
-static inline void pci_set_flags(int flags) { }
-static inline void pci_add_flags(int flags) { }
-static inline int pci_has_flag(int flag)
-{
-	return 0;
-}
-#endif	/* CONFIG_PCI */
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_MICROBLAZE_PCI_BRIDGE_H */
diff --git a/include/asm-generic/pci-bridge.h b/include/asm-generic/pci-bridge.h
new file mode 100644
index 0000000..4a5aca2
--- /dev/null
+++ b/include/asm-generic/pci-bridge.h
@@ -0,0 +1,62 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_GENERIC_PCI_BRIDGE_H
+#define _ASM_GENERIC_PCI_BRIDGE_H
+
+#ifdef __KERNEL__
+
+enum {
+	/* Force re-assigning all resources (ignore firmware
+	 * setup completely)
+	 */
+	PCI_REASSIGN_ALL_RSRC	= 0x00000001,
+
+	/* Re-assign all bus numbers */
+	PCI_REASSIGN_ALL_BUS	= 0x00000002,
+
+	/* Do not try to assign, just use existing setup */
+	PCI_PROBE_ONLY		= 0x00000004,
+
+	/* Don't bother with ISA alignment unless the bridge has
+	 * ISA forwarding enabled
+	 */
+	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
+
+	/* Enable domain numbers in /proc */
+	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,
+	/* ... except for domain 0 */
+	PCI_COMPAT_DOMAIN_0	= 0x00000020,
+};
+
+#ifdef CONFIG_PCI
+extern unsigned int pci_flags;
+
+static inline void pci_set_flags(int flags)
+{
+	pci_flags = flags;
+}
+
+static inline void pci_add_flags(int flags)
+{
+	pci_flags |= flags;
+}
+
+static inline int pci_has_flag(int flag)
+{
+	return pci_flags & flag;
+}
+#else
+static inline void pci_set_flags(int flags) { }
+static inline void pci_add_flags(int flags) { }
+static inline int pci_has_flag(int flag)
+{
+	return 0;
+}
+#endif	/* CONFIG_PCI */
+
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_GENERIC_PCI_BRIDGE_H */
-- 
1.5.5.6


--------------040100050403000405020907--


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.20.1310490297.20020.linux-arm-kernel@lists.infradead.org>

# ARCH_MX5/50/53 are left to mark places where prevent multi-soc in single
# image. So for most time, SOC_IMX50/51/53 should be used.


So, it would seem to me that the ARCH variant would be correct.
Troy


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.23.1310698567.20020.linux-arm-kernel@lists.infradead.org>

from dma-mapping.h:
	enum dma_data_direction {
		DMA_BIDIRECTIONAL = 0,
		DMA_TO_DEVICE = 1,
		DMA_FROM_DEVICE = 2,
		DMA_NONE = 3,
	};

/me thinks it would all look nicer if s3c2410 dma just replaced
s3c2410_dmasrc to dma_data_direction, and from what I can tell it
would just be a simple search and replace.  :-)

> +
> +	if (info->cap == DMA_CYCLIC)
> +		s3c2410_dma_setflags(dma_ch, S3C2410_DMAF_CIRCULAR);
> +
> +	s3c2410_dma_config(dma_ch, info->width);
> +
> +	return (unsigned)dma_ch;
> +}
> +
> +static int dma_release(unsigned ch, struct s3c2410_dma_client *client)

unsigned int

> +{
> +	struct cb_data *data;
> +
> +	list_for_each_entry(data, &dma_list, node)
> +	    if (data->ch == ch)
> +		break;

nit: incorrect indentation.  Use tab characters instead of spaces.
I've got "set list" and "set listchars=tab:\|-,trail:-" in my ~/.vimrc
so I can see the difference between tabs and spaces.

> +	list_del(&data->node);

What happens if the channel isn't found in the list?  Can that
situation happen?

What happens if two drivers call dma_release simultaneously?  It
looks like a mutex is needed to protext the dma_list.

> +
> +	s3c2410_dma_free((enum dma_ch)ch, client);

All the casting in this patch makes me nervous.  When a lot of casting
is required, I wonder if the API needs to be changed.

> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static int dma_prepare(unsigned ch, struct samsung_dma_prep_info *info)
> +{
> +	struct cb_data *data;
> +
> +	list_for_each_entry(data, &dma_list, node)
> +	    if (data->ch == ch)
> +		break;
> +
> +	if (!data->fp) {
> +		s3c2410_dma_set_buffdone_fn((enum dma_ch)ch, dma_cb);
> +		data->fp = info->fp;
> +		data->fp_param = info->fp_param;
> +	}
> +	s3c2410_dma_enqueue((enum dma_ch)ch, (void *)data, info->buf,
> +			    info->period);
> +
> +	return 0;
> +}
> +
> +static inline int dma_trigger(unsigned ch)
> +{
> +	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_START);
> +}
> +
> +static inline int dma_started(unsigned ch)
> +{
> +	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STARTED);
> +}
> +
> +static inline int dma_flush(unsigned ch)
> +{
> +	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_FLUSH);
> +}
> +
> +static inline int dma_stop(unsigned ch)
> +{
> +	return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STOP);
> +}
> +
> +static struct samsung_dma_ops s3c_dma_ops = {
> +	.request	= dma_request,
> +	.release	= dma_release,
> +	.prepare	= dma_prepare,
> +	.trigger	= dma_trigger,
> +	.started	= dma_started,
> +	.flush		= dma_flush,
> +	.stop		= dma_stop,
> +};
> +
> +void *samsung_dma_get_ops(void)
> +{
> +	return (void *)&s3c_dma_ops;
> +}
> +EXPORT_SYMBOL(samsung_dma_get_ops);

This is a problem.  This patch adds two implementations of
samsung_dma_get_ops(). New code needs to be multiplatform friendly.
That means that the code nees to handle both dma-ops.c and
s3c-dma-ops.c compiled into the kernel at the same time and select the
correct one at runtime.

g.

> -- 
> 1.7.1
> 


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.25.1311189996.20020.linux-arm-kernel@lists.infradead.org>

be a file handling only one of these.

> new file mode 100644
> index 0000000..9ca5236
> --- /dev/null
> +++ b/arch/arm/mach-mxs/usb_h1.c
> @@ -0,0 +1,230 @@
> +/*
> + * Copyright (C) 2009-2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/gpio.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/irqs.h>
> +#include <mach/mx28.h>
> +#include "regs-usbphy-mx28.h"
> +
> +/* EHCI registers: */
> +#define UOG_USBCMD		(0x140)/* USB command register */
> +#define UOG_PORTSC1		(0x184)/* port status and control */
> +/* x_PORTSCx */
> +#define PORTSC_PTS_MASK		(3 << 30)/* parallel xcvr mask */
> +#define PORTSC_PTS_UTMI		(0 << 30)/* UTMI/UTMI+ */
> +#define PORTSC_PTW		(1 << 28)/* UTMI width */
> +/* USBCMD */
> +#define UCMD_RUN_STOP           (1 << 0)/* controller run/stop */
> +#define UCMD_RESET		(1 << 1)/* controller reset */
> +
> +#define HOSTPHY_CONNECT_STATE	(1 << 3)
> +
> +static struct clk *usb_clk;
> +static struct clk *usb_phy_clk;
> +static int internal_phy_clk_already_on;

Please get rid fo these static variables. The i.MX28 has two USB phys
and two EHCI cores. All of these should be devices and the context
should be stored in data private to the driver.

> +
> +/* The dmamask must be set for EHCI to work */
> +static u64 ehci_dmamask = ~(u32) 0;
> +static int instance_id = ~(u32) 0;
> +
> +static int fsl_platform_get_usb_conn_status(void)
> +{
> +	u32 status;
> +
> +	status = __raw_readl(MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR) + \
> +			HW_USBPHY_STATUS);
> +	return ((status & HOSTPHY_CONNECT_STATE) == 0);
> +}

A function which takes absolutely no context looks suspicious.

> +
> +/* enable/disable high-speed disconnect detector of phy ctrl */
> +static void fsl_platform_set_usb_phy_dis(int enable)
> +{
> +	if (enable)
> +		__raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> +		MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR) + HW_USBPHY_CTRL_SET);
> +	else
> +		__raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> +		MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR) + HW_USBPHY_CTRL_CLR);
> +}
> +
> +static int usb_phy_enable(struct mxc_usbh_platform_data *pdata)
> +{
> +	u32 tmp;
> +	void __iomem *phy_reg = MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR);
> +	void __iomem *usb_reg = MX28_IO_ADDRESS(MX28_USBCTRL1_BASE_ADDR);

This function takes device specific context and still it uses hardcoded
usbphy1 registers.

> +	void __iomem *usbcmd, *phy_ctrl, *portsc;
> +	/* Reset USB IP */
> +	usbcmd = usb_reg + UOG_USBCMD;
> +	tmp = __raw_readl(usbcmd); /* usb command */
> +	tmp &= ~UCMD_RUN_STOP;
> +	__raw_writel(tmp, usbcmd);
> +	while (__raw_readl(usbcmd) & UCMD_RUN_STOP)
> +		;

No potentially endless loops please.

> +	tmp |= UCMD_RESET;
> +	__raw_writel(tmp, usbcmd);
> +	while (__raw_readl(usbcmd) & UCMD_RESET)
> +		;
> +	mdelay(10);
> +	/* Reset USBPHY module */
> +	phy_ctrl = phy_reg + HW_USBPHY_CTRL;
> +	tmp = __raw_readl(phy_ctrl);
> +	tmp |= BM_USBPHY_CTRL_SFTRST;
> +	__raw_writel(tmp, phy_ctrl);
> +	udelay(10);
> +	/* Remove CLKGATE and SFTRST */
> +	tmp = __raw_readl(phy_ctrl);
> +	tmp &= ~(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL_SFTRST);
> +	__raw_writel(tmp, phy_ctrl);
> +	udelay(10);
> +	/* set UTMI xcvr */
> +	/* Workaround an IC issue for ehci driver:
> +	 * when turn off root hub port power, EHCI set
> +	 * PORTSC reserved bits to be 0, but PTW with 0
> +	 * means 8 bits tranceiver width, here change
> +	 * it back to be 16 bits and do PHY diable and
> +	 * then enable.
> +	 */
> +	portsc = usb_reg + UOG_PORTSC1;
> +	tmp = __raw_readl(portsc);
> +	tmp &=  ~PORTSC_PTS_MASK;
> +	tmp |= (PORTSC_PTS_UTMI | PORTSC_PTW);
> +	__raw_writel(tmp, portsc);
> +	/* Power up the PHY */
> +	__raw_writel(0, phy_reg + HW_USBPHY_PWD);
> +	return 0;
> +}
> +
> +static int fsl_usb_host_init(struct platform_device *pdev)
> +{
> +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> +	void __iomem *phy_reg = MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR);
> +	u32 tmp;
> +
> +	usb_phy_enable(pdata);
> +	/* enable FS/LS device */
> +	tmp = __raw_readl(phy_reg + HW_USBPHY_CTRL);
> +	tmp |= (BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3);
> +	__raw_writel(tmp, phy_reg + HW_USBPHY_CTRL);
> +
> +	return 0;
> +}
> +
> +static void usbh1_internal_phy_clock_gate(bool on)
> +{
> +	u32 tmp;
> +	void __iomem *phy_reg = MX28_IO_ADDRESS(MX28_USBPHY1_BASE_ADDR);
> +
> +	if (on) {
> +		internal_phy_clk_already_on += 1;
> +		if (internal_phy_clk_already_on == 1) {
> +			tmp = BM_USBPHY_CTRL_SFTRST | BM_USBPHY_CTRL_CLKGATE;
> +			__raw_writel(tmp, phy_reg + HW_USBPHY_CTRL_CLR);
> +		}
> +	} else {
> +		internal_phy_clk_already_on -= 1;
> +		if (internal_phy_clk_already_on == 0) {
> +			tmp = BM_USBPHY_CTRL_CLKGATE;
> +			__raw_writel(tmp, phy_reg + HW_USBPHY_CTRL_SET);
> +		}
> +	}
> +	if (internal_phy_clk_already_on < 0)
> +		printk(KERN_ERR "please check phy clock ON/OFF sequence\n");
> +}
> +static int fsl_usb_host_init_ext(struct platform_device *pdev)
> +{
> +	usb_clk = clk_get(NULL, "usb1");
> +	clk_enable(usb_clk);
> +	clk_put(usb_clk);
> +	usb_phy_clk = clk_get(NULL, "usb1_phy");
> +	clk_enable(usb_phy_clk);
> +	clk_put(usb_phy_clk);
> +
> +	usbh1_internal_phy_clock_gate(true);
> +	return fsl_usb_host_init(pdev);
> +}
> +
> +static int fsl_usb_host_uninit_ext(struct platform_device *pdev)
> +{
> +	usbh1_internal_phy_clock_gate(false);
> +	clk_disable(usb_phy_clk);
> +	clk_disable(usb_clk);
> +	return 0;
> +}
> +
> +static struct mxc_usbh_platform_data usbh1_config = {
> +	.init = fsl_usb_host_init_ext,
> +	.exit = fsl_usb_host_uninit_ext,
> +	.portsc = MXC_EHCI_MODE_ULPI,
> +	.otg = NULL,
> +	.plt_get_usb_connect_status = fsl_platform_get_usb_conn_status,
> +	.plt_usb_disconnect_detect = fsl_platform_set_usb_phy_dis,
> +};
> +
> +/* The resources for kinds of usb devices */
> +static struct resource usbh1_resources[] = {
> +	[0] = {
> +	       .start = (u32) (MX28_USBCTRL1_BASE_ADDR),
> +	       .end = (u32) (MX28_USBCTRL1_BASE_ADDR + 0x1ff),
> +	       .flags = IORESOURCE_MEM,
> +	       },
> +	[1] = {
> +	       .start = MX28_INT_USB1,
> +	       .flags = IORESOURCE_IRQ,
> +	       },
> +};
> +
> +static int __init usbh1_init(void)
> +{
> +	struct platform_device *pdev;
> +	int rc;
> +
> +	if (!cpu_is_mx28())
> +		return 0;
> +
> +	pdev = platform_device_register_simple("mxc-ehci",
> +		instance_id, usbh1_resources, ARRAY_SIZE(usbh1_resources));

What is this global instance_id you use here? This function is clearly
called only once, yet it uses a variable which is incremented below
and then never used again.

> +	if (IS_ERR(pdev)) {
> +		pr_debug("can't register Host, %ld\n",
> +			 PTR_ERR(pdev));
> +		return -EFAULT;
> +	}
> +
> +	pdev->dev.coherent_dma_mask = 0xffffffff;
> +	pdev->dev.dma_mask = &ehci_dmamask;
> +
> +	rc = platform_device_add_data(pdev, &usbh1_config,
> +				      sizeof(struct mxc_usbh_platform_data));

I doubt it's allowed to add platform data after registering a device.
The driver could already be probed after register and bailed out
because of missing platform data.


Overall this needs major rework.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.30.1311366554.20020.linux-arm-kernel@lists.infradead.org>

naming scheme :

extern const struct imx_fec_data imx51_fec_data;
...
extern const struct imx_imx_i2c_data imx51_imx_i2c_data[];
...
extern const struct imx_mxc_nand_data imx51_mxc_nand_data;
...
extern const struct imx_spi_imx_data imx51_cspi_data;

So, I can use either imx_pata_data or keep imx_mxc_pata_data or
imx_imx_pata_data or imx_pata_imx_data. What do you both prefer ?

Thanks,
Arnaud


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.32.1311664036.20020.linux-arm-kernel@lists.infradead.org>

mx28 are the same.
Then it might be better to name the file regs-usbphy-mxs.h instead of
regs-usbphy-mx28.h.

Koen

On Mon, Jul 25, 2011 at 9:01 AM, Tony Lin <tony.lin@freescale.com> wrote:
> add usb phy register definitions and functions
> usb host driver will use these callback functions
> to initialize usb phy and change working mode
>
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
> =C2=A0arch/arm/mach-mxs/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-mxs/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A01 +
> =C2=A0arch/arm/mach-mxs/mxs_usb.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0286 ++++++++++++++++++++++++++++++++++
> =C2=A0arch/arm/mach-mxs/regs-usbphy-mx28.h | =C2=A0240 ++++++++++++++++++=
++++++++++
> =C2=A04 files changed, 528 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 4cd0231..1c4264f 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -49,6 +49,7 @@ config MACH_MX28EVK
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select MXS_HAVE_PLATFORM_MXS_MMC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select MXS_HAVE_PLATFORM_MXSFB
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select MXS_OCOTP
> + =C2=A0 =C2=A0 =C2=A0 select USB_ARCH_HAS_EHCI
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Include support for MX28EVK platform. T=
his includes specific
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0configurations for the board and its pe=
ripherals.
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> index 6c38262..726c49f 100644
> --- a/arch/arm/mach-mxs/Makefile
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -12,5 +12,6 @@ obj-$(CONFIG_MACH_MX23EVK) +=3D mach-mx23evk.o
> =C2=A0obj-$(CONFIG_MACH_MX28EVK) +=3D mach-mx28evk.o
> =C2=A0obj-$(CONFIG_MODULE_TX28) +=3D module-tx28.o
> =C2=A0obj-$(CONFIG_MACH_TX28) =C2=A0 =C2=A0+=3D mach-tx28.o
> +obj-$(CONFIG_USB_EHCI_MXC) =C2=A0 +=3D mxs_usb.o
>
> =C2=A0obj-y +=3D devices/
> diff --git a/arch/arm/mach-mxs/mxs_usb.c b/arch/arm/mach-mxs/mxs_usb.c
> new file mode 100644
> index 0000000..01753ea
> --- /dev/null
> +++ b/arch/arm/mach-mxs/mxs_usb.c
> @@ -0,0 +1,286 @@
> +/*
> + * Copyright (C) 2009-2011 Freescale Semiconductor, Inc. All Rights Rese=
rved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, write to the Free Software Foundation, Inc=
.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/gpio.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/irqs.h>
> +#include <mach/mx28.h>
> +#include "regs-usbphy-mx28.h"
> +
> +/* EHCI registers: */
> +#define UOG_USBCMD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x140) /* =
USB command register */
> +#define UOG_USBSTS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x144) /* =
USB status register */
> +#define UOG_PORTSC1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x184) /* =
port status and control */
> +/* x_PORTSCx */
> +#define PORTSC_PTS_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(3 << 30) /* parallel xcvr mask */
> +#define PORTSC_PTS_UTMI =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(0 << 30) /* UTMI/UTMI+ */
> +#define PORTSC_PTW =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 28) /=
* UTMI width */
> +/* USBCMD */
> +#define UCMD_RUN_STOP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 0) /* con=
troller run/stop */
> +#define UCMD_RESET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 1) /*=
 controller reset */
> +
> +#define HOSTPHY_CONNECT_STATE =C2=A0(1 << 3)
> +#define STS_PCD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 2) /* port change detect */
> +
> +struct mxs_usb_private_date {
> + =C2=A0 =C2=A0 =C2=A0 struct clk *usb_clk, *usb_phy_clk;
> + =C2=A0 =C2=A0 =C2=A0 int internal_phy_clk_already_on;
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *phy_regs; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* usb phy register base */
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *ctrl_regs; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* usb controller register base */
> +};
> +
> +static inline int fsl_platform_get_usb_connect_status
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (struct mxs_usb_private_date *ppriv)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 status;
> +
> + =C2=A0 =C2=A0 =C2=A0 status =3D __raw_readl(ppriv->phy_regs + HW_USBPHY=
_STATUS);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ((status & HOSTPHY_CONNECT_STATE) =3D=3D 0)=
;
> +}
> +
> +/* enable/disable high-speed disconnect detector of phy ctrl */
> +static inline void fsl_platform_disconnect_detect
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (struct mxs_usb_private_date *ppriv, int enable)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (enable) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(BM_USBPHY=
_CTRL_ENHOSTDISCONDETECT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppriv->phy_regs + HW_U=
SBPHY_CTRL_SET);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(BM_USBPHY=
_CTRL_ENHOSTDISCONDETECT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppriv->phy_regs + HW_U=
SBPHY_CTRL_CLR);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static void fsl_plt_usbh_irq_handler(struct mxc_usbh_platform_data *pdat=
a)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 status;
> + =C2=A0 =C2=A0 =C2=A0 struct mxs_usb_private_date *ppriv =3D pdata->ppri=
v;
> +
> + =C2=A0 =C2=A0 =C2=A0 status =3D __raw_readl(ppriv->ctrl_regs + UOG_USBS=
TS);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (status & STS_PCD)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fsl_platform_disconnec=
t_detect(ppriv,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fsl_platform_get_usb_connect_status(ppriv));
> +}
> +
> +static int usb_phy_enable(struct mxc_usbh_platform_data *pdata)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 tmp;
> + =C2=A0 =C2=A0 =C2=A0 u32 i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct mxs_usb_private_date *ppriv =3D pdata->ppri=
v;
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *usbcmd, *phy_ctrl, *portsc;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Reset USB IP */
> + =C2=A0 =C2=A0 =C2=A0 /* Set run stop bit */
> + =C2=A0 =C2=A0 =C2=A0 /* Send reset command */
> + =C2=A0 =C2=A0 =C2=A0 usbcmd =3D ppriv->ctrl_regs + UOG_USBCMD;
> + =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_readl(usbcmd); /* usb command */
> + =C2=A0 =C2=A0 =C2=A0 tmp &=3D ~UCMD_RUN_STOP;
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(tmp, usbcmd);
> + =C2=A0 =C2=A0 =C2=A0 while (__raw_readl(usbcmd) & UCMD_RUN_STOP) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 1000)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 tmp |=3D UCMD_RESET;
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(tmp, usbcmd);
> + =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 while (__raw_readl(usbcmd) & UCMD_RESET) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 1000)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 mdelay(10);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Reset USBPHY module, set soft reset bit */
> + =C2=A0 =C2=A0 =C2=A0 phy_ctrl =3D ppriv->phy_regs + HW_USBPHY_CTRL;
> + =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_readl(phy_ctrl);
> + =C2=A0 =C2=A0 =C2=A0 tmp |=3D BM_USBPHY_CTRL_SFTRST;
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(tmp, phy_ctrl);
> + =C2=A0 =C2=A0 =C2=A0 udelay(10);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* clear CLKGATE and SFTRST bits to be out of rese=
t mode*/
> + =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_readl(phy_ctrl);
> + =C2=A0 =C2=A0 =C2=A0 tmp &=3D ~(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL=
_SFTRST);
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(tmp, phy_ctrl);
> + =C2=A0 =C2=A0 =C2=A0 udelay(10);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* set UTMI xcvr */
> + =C2=A0 =C2=A0 =C2=A0 /* Workaround an IC issue for ehci driver:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* when turn off root hub port power, EHCI se=
t
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* PORTSC reserved bits to be 0, but PTW with=
 0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* means 8 bits tranceiver width, here change
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* it back to be 16 bits and do PHY diable an=
d
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* then enable.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 portsc =3D ppriv->ctrl_regs + UOG_PORTSC1;
> + =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_readl(portsc);
> + =C2=A0 =C2=A0 =C2=A0 tmp &=3D =C2=A0~PORTSC_PTS_MASK;
> + =C2=A0 =C2=A0 =C2=A0 tmp |=3D (PORTSC_PTS_UTMI | PORTSC_PTW);
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(tmp, portsc);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Power up the PHY */
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(0, ppriv->phy_regs + HW_USBPHY_PWD);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int fsl_usbh_init(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct mxc_usbh_platform_data *pdata =3D pdev->dev=
.platform_data;
> + =C2=A0 =C2=A0 =C2=A0 struct mxs_usb_private_date *ppriv =3D pdata->ppri=
v;
> + =C2=A0 =C2=A0 =C2=A0 u32 tmp;
> +
> + =C2=A0 =C2=A0 =C2=A0 usb_phy_enable(pdata);
> + =C2=A0 =C2=A0 =C2=A0 /* enable FS/LS device */
> + =C2=A0 =C2=A0 =C2=A0 tmp =3D __raw_readl(ppriv->phy_regs + HW_USBPHY_CT=
RL);
> + =C2=A0 =C2=A0 =C2=A0 tmp |=3D (BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_=
CTRL_ENUTMILEVEL3);
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(tmp, ppriv->phy_regs + HW_USBPHY_CTRL=
);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void phy_clock_gate(struct mxs_usb_private_date *ppriv, bool on)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 tmp;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (on) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppriv->internal_phy_cl=
k_already_on +=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ppriv->internal_ph=
y_clk_already_on =3D=3D 1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tmp =3D BM_USBPHY_CTRL_SFTRST | BM_USBPHY_CTRL_CLKGATE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __raw_writel(tmp, ppriv->phy_regs + HW_USBPHY_CTRL_CLR);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppriv->internal_phy_cl=
k_already_on -=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ppriv->internal_ph=
y_clk_already_on =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tmp =3D BM_USBPHY_CTRL_CLKGATE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __raw_writel(tmp, ppriv->phy_regs + HW_USBPHY_CTRL_SET);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (WARN_ON(ppriv->internal_phy_clk_already_on < 0=
))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "pleas=
e check phy clock ON/OFF sequence\n");
> +}
> +static int fsl_usb_host_init(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct mxc_usbh_platform_data *pdata =3D pdev->dev=
.platform_data;
> + =C2=A0 =C2=A0 =C2=A0 struct mxs_usb_private_date *ppriv =3D pdata->ppri=
v;
> +
> + =C2=A0 =C2=A0 =C2=A0 ppriv->phy_regs =3D ioremap(MX28_USBPHY1_BASE_ADDR=
, SZ_8K);
> + =C2=A0 =C2=A0 =C2=A0 if (ppriv->phy_regs =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 ppriv->ctrl_regs =3D ioremap(MX28_USBCTRL1_BASE_AD=
DR, SZ_8K);
> + =C2=A0 =C2=A0 =C2=A0 if (ppriv->ctrl_regs =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 ppriv->usb_clk =3D clk_get(&pdev->dev, "usb1");
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(ppriv->usb_clk))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(ppriv->=
usb_clk);
> + =C2=A0 =C2=A0 =C2=A0 clk_enable(ppriv->usb_clk);
> +
> + =C2=A0 =C2=A0 =C2=A0 ppriv->usb_phy_clk =3D clk_get(&pdev->dev, "usb1_p=
hy");
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(ppriv->usb_phy_clk))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(ppriv->=
usb_phy_clk);
> + =C2=A0 =C2=A0 =C2=A0 clk_enable(ppriv->usb_phy_clk);
> +
> + =C2=A0 =C2=A0 =C2=A0 phy_clock_gate(ppriv, true);
> + =C2=A0 =C2=A0 =C2=A0 return fsl_usbh_init(pdev);
> +}
> +
> +static int fsl_usb_host_uninit(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct mxc_usbh_platform_data *pdata =3D pdev->dev=
.platform_data;
> + =C2=A0 =C2=A0 =C2=A0 struct mxs_usb_private_date *ppriv =3D pdata->ppri=
v;
> +
> + =C2=A0 =C2=A0 =C2=A0 phy_clock_gate(ppriv, false);
> + =C2=A0 =C2=A0 =C2=A0 if (ppriv->usb_phy_clk) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(ppriv->usb=
_phy_clk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(ppriv->usb_phy=
_clk);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (ppriv->usb_clk) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(ppriv->usb=
_clk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_put(ppriv->usb_clk=
);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (ppriv->phy_regs)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(ppriv->phy_reg=
s);
> + =C2=A0 =C2=A0 =C2=A0 if (ppriv->ctrl_regs)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(ppriv->ctrl_re=
gs);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct mxs_usb_private_date usbh_private =3D {
> + =C2=A0 =C2=A0 =C2=A0 .internal_phy_clk_already_on =3D 0,
> +};
> +
> +static struct mxc_usbh_platform_data usbh_config =3D {
> + =C2=A0 =C2=A0 =C2=A0 .init =3D fsl_usb_host_init,
> + =C2=A0 =C2=A0 =C2=A0 .exit =3D fsl_usb_host_uninit,
> + =C2=A0 =C2=A0 =C2=A0 .portsc =3D MXC_EHCI_MODE_ULPI,
> + =C2=A0 =C2=A0 =C2=A0 .otg =3D NULL,
> + =C2=A0 =C2=A0 =C2=A0 .plt_irq_handler =3D fsl_plt_usbh_irq_handler,
> + =C2=A0 =C2=A0 =C2=A0 .ppriv =3D &usbh_private,
> +};
> +
> +/* The resources for kinds of usb devices */
> +static struct resource usbh_resources[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =3D MX28_USBCTR=
L1_BASE_ADDR,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =3D MX28_USBCTRL1=
_BASE_ADDR + 0x1ff,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D IORESOURCE_=
MEM,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =3D MX28_INT_US=
B1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D IORESOURCE_=
IRQ,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +static int __init usbh_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev;
> + =C2=A0 =C2=A0 =C2=A0 int instance_id =3D ~(u32) 0;
> + =C2=A0 =C2=A0 =C2=A0 u64 ehci_dmamask =3D ~(u32) 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_is_mx28())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 pdev =3D platform_device_register_resndata(NULL, "=
mxc-ehci", instance_id,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 usbh_resources, ARRAY_SIZE(usbh_resources),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &usbh_config, sizeof(struct mxc_usbh_platform_data));
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(pdev)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("can't regist=
er Host, %ld\n", PTR_ERR(pdev));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(pdev);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 pdev->dev.coherent_dma_mask =3D 0xffffffff;
> + =C2=A0 =C2=A0 =C2=A0 pdev->dev.dma_mask =3D &ehci_dmamask;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +module_init(usbh_init);
> diff --git a/arch/arm/mach-mxs/regs-usbphy-mx28.h b/arch/arm/mach-mxs/reg=
s-usbphy-mx28.h
> new file mode 100644
> index 0000000..2ec273b
> --- /dev/null
> +++ b/arch/arm/mach-mxs/regs-usbphy-mx28.h
> @@ -0,0 +1,240 @@
> +/*
> + * Freescale USBPHY Register Definitions
> + *
> + * Copyright 2008-2011 Freescale Semiconductor, Inc. All Rights Reserved=
.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =C2=A002111-=
1307 USA
> + *
> + *
> + * Xml Revision: 1.52
> + * Template revision: 26195
> + */
> +
> +#ifndef __ARCH_ARM___USBPHY_H
> +#define __ARCH_ARM___USBPHY_H
> +
> +
> +#define HW_USBPHY_PWD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000000
> +#define HW_USBPHY_PWD_SET =C2=A0 =C2=A0 =C2=A00x00000004
> +#define HW_USBPHY_PWD_CLR =C2=A0 =C2=A0 =C2=A00x00000008
> +#define HW_USBPHY_PWD_TOG =C2=A0 =C2=A0 =C2=A00x0000000c
> +
> +#define BM_USBPHY_PWD_RXPWDRX =C2=A00x00100000
> +#define BM_USBPHY_PWD_RXPWDDIFF =C2=A0 =C2=A0 =C2=A0 =C2=A00x00080000
> +#define BM_USBPHY_PWD_RXPWD1PT1 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00040000
> +#define BM_USBPHY_PWD_RXPWDENV 0x00020000
> +
> +#define BM_USBPHY_PWD_TXPWDV2I 0x00001000
> +#define BM_USBPHY_PWD_TXPWDIBIAS =C2=A0 =C2=A0 =C2=A0 0x00000800
> +#define BM_USBPHY_PWD_TXPWDFS =C2=A00x00000400
> +
> +#define HW_USBPHY_TX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000010
> +#define HW_USBPHY_TX_SET =C2=A0 =C2=A0 =C2=A0 0x00000014
> +#define HW_USBPHY_TX_CLR =C2=A0 =C2=A0 =C2=A0 0x00000018
> +#define HW_USBPHY_TX_TOG =C2=A0 =C2=A0 =C2=A0 0x0000001c
> +
> +#define BP_USBPHY_TX_USBPHY_TX_EDGECTRL =C2=A0 =C2=A0 =C2=A0 =C2=A026
> +#define BM_USBPHY_TX_USBPHY_TX_EDGECTRL =C2=A0 =C2=A0 =C2=A0 =C2=A00x1C0=
00000
> +#define BF_USBPHY_TX_USBPHY_TX_EDGECTRL(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 26) & BM_USBP=
HY_TX_USBPHY_TX_EDGECTRL)
> +#define BM_USBPHY_TX_USBPHY_TX_SYNC_INVERT =C2=A0 =C2=A0 0x02000000
> +#define BM_USBPHY_TX_USBPHY_TX_SYNC_MUX =C2=A0 =C2=A0 =C2=A0 =C2=A00x010=
00000
> +
> +#define BM_USBPHY_TX_TXENCAL45DP =C2=A0 =C2=A0 =C2=A0 0x00200000
> +#define BP_USBPHY_TX_TXCAL45DP 16
> +#define BM_USBPHY_TX_TXCAL45DP 0x000F0000
> +#define BF_USBPHY_TX_TXCAL45DP(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 16) & BM_USBP=
HY_TX_TXCAL45DP)
> +#define BM_USBPHY_TX_TXENCAL45DN =C2=A0 =C2=A0 =C2=A0 0x00002000
> +#define BP_USBPHY_TX_TXCAL45DN 8
> +#define BM_USBPHY_TX_TXCAL45DN 0x00000F00
> +#define BF_USBPHY_TX_TXCAL45DN(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 8) & BM_USBPH=
Y_TX_TXCAL45DN)
> +
> +#define BP_USBPHY_TX_D_CAL =C2=A0 =C2=A0 0
> +#define BM_USBPHY_TX_D_CAL =C2=A0 =C2=A0 0x0000000F
> +#define BF_USBPHY_TX_D_CAL(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 0) & BM_USBPH=
Y_TX_D_CAL)
> +
> +#define HW_USBPHY_RX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000020
> +#define HW_USBPHY_RX_SET =C2=A0 =C2=A0 =C2=A0 0x00000024
> +#define HW_USBPHY_RX_CLR =C2=A0 =C2=A0 =C2=A0 0x00000028
> +#define HW_USBPHY_RX_TOG =C2=A0 =C2=A0 =C2=A0 0x0000002c
> +
> +#define BM_USBPHY_RX_RXDBYPASS 0x00400000
> +#define BP_USBPHY_RX_DISCONADJ 4
> +#define BM_USBPHY_RX_DISCONADJ 0x00000070
> +#define BF_USBPHY_RX_DISCONADJ(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 4) & BM_USBPH=
Y_RX_DISCONADJ)
> +#define BP_USBPHY_RX_ENVADJ =C2=A0 =C2=A00
> +#define BM_USBPHY_RX_ENVADJ =C2=A0 =C2=A00x00000007
> +#define BF_USBPHY_RX_ENVADJ(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 0) & BM_USBPH=
Y_RX_ENVADJ)
> +
> +#define HW_USBPHY_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000030
> +#define HW_USBPHY_CTRL_SET =C2=A0 =C2=A0 0x00000034
> +#define HW_USBPHY_CTRL_CLR =C2=A0 =C2=A0 0x00000038
> +#define HW_USBPHY_CTRL_TOG =C2=A0 =C2=A0 0x0000003c
> +
> +#define BM_USBPHY_CTRL_SFTRST =C2=A00x80000000
> +#define BM_USBPHY_CTRL_CLKGATE 0x40000000
> +#define BM_USBPHY_CTRL_UTMI_SUSPENDM =C2=A0 0x20000000
> +#define BM_USBPHY_CTRL_HOST_FORCE_LS_SE0 =C2=A0 =C2=A0 =C2=A0 0x10000000
> +#define BM_USBPHY_CTRL_ENAUTOSET_USBCLKS =C2=A0 =C2=A0 =C2=A0 0x04000000
> +#define BM_USBPHY_CTRL_ENAUTOCLR_USBCLKGATE =C2=A0 =C2=A00x02000000
> +#define BM_USBPHY_CTRL_FSDLL_RST_EN =C2=A0 =C2=A00x01000000
> +#define BM_USBPHY_CTRL_ENVBUSCHG_WKUP =C2=A00x00800000
> +#define BM_USBPHY_CTRL_ENIDCHG_WKUP =C2=A0 =C2=A00x00400000
> +#define BM_USBPHY_CTRL_ENDPDMCHG_WKUP =C2=A00x00200000
> +#define BM_USBPHY_CTRL_ENAUTOCLR_PHY_PWD =C2=A0 =C2=A0 =C2=A0 0x00100000
> +#define BM_USBPHY_CTRL_ENAUTOCLR_CLKGATE =C2=A0 =C2=A0 =C2=A0 0x00080000
> +#define BM_USBPHY_CTRL_ENAUTO_PWRON_PLL =C2=A0 =C2=A0 =C2=A0 =C2=A00x000=
40000
> +#define BM_USBPHY_CTRL_WAKEUP_IRQ =C2=A0 =C2=A0 =C2=A00x00020000
> +#define BM_USBPHY_CTRL_ENIRQWAKEUP =C2=A0 =C2=A0 0x00010000
> +#define BM_USBPHY_CTRL_ENUTMILEVEL3 =C2=A0 =C2=A00x00008000
> +#define BM_USBPHY_CTRL_ENUTMILEVEL2 =C2=A0 =C2=A00x00004000
> +#define BM_USBPHY_CTRL_DATA_ON_LRADC =C2=A0 0x00002000
> +#define BM_USBPHY_CTRL_DEVPLUGIN_IRQ =C2=A0 0x00001000
> +#define BM_USBPHY_CTRL_ENIRQDEVPLUGIN =C2=A00x00000800
> +#define BM_USBPHY_CTRL_RESUME_IRQ =C2=A0 =C2=A0 =C2=A00x00000400
> +#define BM_USBPHY_CTRL_ENIRQRESUMEDETECT =C2=A0 =C2=A0 =C2=A0 0x00000200
> +#define BM_USBPHY_CTRL_RESUMEIRQSTICKY 0x00000100
> +#define BM_USBPHY_CTRL_ENOTGIDDETECT =C2=A0 0x00000080
> +#define BM_USBPHY_CTRL_DEVPLUGIN_POLARITY =C2=A0 =C2=A0 =C2=A00x00000020
> +#define BM_USBPHY_CTRL_ENDEVPLUGINDETECT =C2=A0 =C2=A0 =C2=A0 0x00000010
> +#define BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ =C2=A0 =C2=A00x00000008
> +#define BM_USBPHY_CTRL_ENIRQHOSTDISCON 0x00000004
> +#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT =C2=A0 =C2=A0 =C2=A00x00000002
> +
> +#define HW_USBPHY_STATUS =C2=A0 =C2=A0 =C2=A0 0x00000040
> +
> +#define BM_USBPHY_STATUS_RESUME_STATUS 0x00000400
> +#define BM_USBPHY_STATUS_OTGID_STATUS =C2=A00x00000100
> +#define BM_USBPHY_STATUS_DEVPLUGIN_STATUS =C2=A0 =C2=A0 =C2=A00x00000040
> +#define BM_USBPHY_STATUS_HOSTDISCONDETECT_STATUS =C2=A0 =C2=A0 =C2=A0 0x=
00000008
> +
> +#define HW_USBPHY_DEBUG =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x00000050
> +#define HW_USBPHY_DEBUG_SET =C2=A0 =C2=A00x00000054
> +#define HW_USBPHY_DEBUG_CLR =C2=A0 =C2=A00x00000058
> +#define HW_USBPHY_DEBUG_TOG =C2=A0 =C2=A00x0000005c
> +
> +#define BM_USBPHY_DEBUG_CLKGATE =C2=A0 =C2=A0 =C2=A0 =C2=A00x40000000
> +#define BM_USBPHY_DEBUG_HOST_RESUME_DEBUG =C2=A0 =C2=A0 =C2=A00x20000000
> +#define BP_USBPHY_DEBUG_SQUELCHRESETLENGTH =C2=A0 =C2=A0 25
> +#define BM_USBPHY_DEBUG_SQUELCHRESETLENGTH =C2=A0 =C2=A0 0x1E000000
> +#define BF_USBPHY_DEBUG_SQUELCHRESETLENGTH(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 25) & BM_USBP=
HY_DEBUG_SQUELCHRESETLENGTH)
> +#define BM_USBPHY_DEBUG_ENSQUELCHRESET 0x01000000
> +#define BP_USBPHY_DEBUG_SQUELCHRESETCOUNT =C2=A0 =C2=A0 =C2=A016
> +#define BM_USBPHY_DEBUG_SQUELCHRESETCOUNT =C2=A0 =C2=A0 =C2=A00x001F0000
> +#define BF_USBPHY_DEBUG_SQUELCHRESETCOUNT(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 16) & BM_USBP=
HY_DEBUG_SQUELCHRESETCOUNT)
> +#define BM_USBPHY_DEBUG_ENTX2RXCOUNT =C2=A0 0x00001000
> +#define BP_USBPHY_DEBUG_TX2RXCOUNT =C2=A0 =C2=A0 8
> +#define BM_USBPHY_DEBUG_TX2RXCOUNT =C2=A0 =C2=A0 0x00000F00
> +#define BF_USBPHY_DEBUG_TX2RXCOUNT(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 8) & BM_USBPH=
Y_DEBUG_TX2RXCOUNT)
> +#define BP_USBPHY_DEBUG_ENHSTPULLDOWN =C2=A04
> +#define BM_USBPHY_DEBUG_ENHSTPULLDOWN =C2=A00x00000030
> +#define BF_USBPHY_DEBUG_ENHSTPULLDOWN(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 4) & BM_USBPH=
Y_DEBUG_ENHSTPULLDOWN)
> +#define BP_USBPHY_DEBUG_HSTPULLDOWN =C2=A0 =C2=A02
> +#define BM_USBPHY_DEBUG_HSTPULLDOWN =C2=A0 =C2=A00x0000000C
> +#define BF_USBPHY_DEBUG_HSTPULLDOWN(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 2) & BM_USBPH=
Y_DEBUG_HSTPULLDOWN)
> +#define BM_USBPHY_DEBUG_DEBUG_INTERFACE_HOLD =C2=A0 0x00000002
> +#define BM_USBPHY_DEBUG_OTGIDPIOLOCK =C2=A0 0x00000001
> +
> +#define HW_USBPHY_DEBUG0_STATUS =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000060
> +
> +#define BP_USBPHY_DEBUG0_STATUS_SQUELCH_COUNT =C2=A026
> +#define BM_USBPHY_DEBUG0_STATUS_SQUELCH_COUNT =C2=A00xFC000000
> +#define BF_USBPHY_DEBUG0_STATUS_SQUELCH_COUNT(v) \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 26) & BM_USBP=
HY_DEBUG0_STATUS_SQUELCH_COUNT)
> +#define BP_USBPHY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT =C2=A0 =C2=A0 =
=C2=A0 =C2=A016
> +#define BM_USBPHY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x03FF0000
> +#define BF_USBPHY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 16) & BM_USBP=
HY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT)
> +#define BP_USBPHY_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT =C2=A0 0
> +#define BM_USBPHY_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT =C2=A0 0x0000FFFF
> +#define BF_USBPHY_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 0) & BM_USBPH=
Y_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT)
> +
> +#define HW_USBPHY_DEBUG1 =C2=A0 =C2=A0 =C2=A0 0x00000070
> +#define HW_USBPHY_DEBUG1_SET =C2=A0 0x00000074
> +#define HW_USBPHY_DEBUG1_CLR =C2=A0 0x00000078
> +#define HW_USBPHY_DEBUG1_TOG =C2=A0 0x0000007c
> +
> +#define BP_USBPHY_DEBUG1_ENTAILADJVD =C2=A0 13
> +#define BM_USBPHY_DEBUG1_ENTAILADJVD =C2=A0 0x00006000
> +#define BF_USBPHY_DEBUG1_ENTAILADJVD(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 13) & BM_USBP=
HY_DEBUG1_ENTAILADJVD)
> +#define BM_USBPHY_DEBUG1_ENTX2TX =C2=A0 =C2=A0 =C2=A0 0x00001000
> +#define BP_USBPHY_DEBUG1_DBG_ADDRESS =C2=A0 0
> +#define BM_USBPHY_DEBUG1_DBG_ADDRESS =C2=A0 0x0000000F
> +#define BF_USBPHY_DEBUG1_DBG_ADDRESS(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 0) & BM_USBPH=
Y_DEBUG1_DBG_ADDRESS)
> +
> +#define HW_USBPHY_VERSION =C2=A0 =C2=A0 =C2=A00x00000080
> +
> +#define BP_USBPHY_VERSION_MAJOR =C2=A0 =C2=A0 =C2=A0 =C2=A024
> +#define BM_USBPHY_VERSION_MAJOR =C2=A0 =C2=A0 =C2=A0 =C2=A00xFF000000
> +#define BF_USBPHY_VERSION_MAJOR(v) \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 24) & BM_USBP=
HY_VERSION_MAJOR)
> +#define BP_USBPHY_VERSION_MINOR =C2=A0 =C2=A0 =C2=A0 =C2=A016
> +#define BM_USBPHY_VERSION_MINOR =C2=A0 =C2=A0 =C2=A0 =C2=A00x00FF0000
> +#define BF_USBPHY_VERSION_MINOR(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 16) & BM_USBP=
HY_VERSION_MINOR)
> +#define BP_USBPHY_VERSION_STEP 0
> +#define BM_USBPHY_VERSION_STEP 0x0000FFFF
> +#define BF_USBPHY_VERSION_STEP(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 0) & BM_USBPH=
Y_VERSION_STEP)
> +
> +#define HW_USBPHY_IP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000090
> +#define HW_USBPHY_IP_SET =C2=A0 =C2=A0 =C2=A0 0x00000094
> +#define HW_USBPHY_IP_CLR =C2=A0 =C2=A0 =C2=A0 0x00000098
> +#define HW_USBPHY_IP_TOG =C2=A0 =C2=A0 =C2=A0 0x0000009c
> +
> +#define BP_USBPHY_IP_DIV_SEL =C2=A0 23
> +#define BM_USBPHY_IP_DIV_SEL =C2=A0 0x01800000
> +#define BF_USBPHY_IP_DIV_SEL(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 23) & BM_USBP=
HY_IP_DIV_SEL)
> +#define BV_USBPHY_IP_DIV_SEL__DEFAULT =C2=A0 0x0
> +#define BV_USBPHY_IP_DIV_SEL__LOWER =C2=A0 =C2=A0 0x1
> +#define BV_USBPHY_IP_DIV_SEL__LOWEST =C2=A0 =C2=A00x2
> +#define BV_USBPHY_IP_DIV_SEL__UNDEFINED 0x3
> +#define BP_USBPHY_IP_LFR_SEL =C2=A0 21
> +#define BM_USBPHY_IP_LFR_SEL =C2=A0 0x00600000
> +#define BF_USBPHY_IP_LFR_SEL(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 21) & BM_USBP=
HY_IP_LFR_SEL)
> +#define BV_USBPHY_IP_LFR_SEL__DEFAULT =C2=A0 0x0
> +#define BV_USBPHY_IP_LFR_SEL__TIMES_2 =C2=A0 0x1
> +#define BV_USBPHY_IP_LFR_SEL__TIMES_05 =C2=A00x2
> +#define BV_USBPHY_IP_LFR_SEL__UNDEFINED 0x3
> +#define BP_USBPHY_IP_CP_SEL =C2=A0 =C2=A019
> +#define BM_USBPHY_IP_CP_SEL =C2=A0 =C2=A00x00180000
> +#define BF_USBPHY_IP_CP_SEL(v) =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((v) << 19) & BM_USBP=
HY_IP_CP_SEL)
> +#define BV_USBPHY_IP_CP_SEL__DEFAULT =C2=A0 0x0
> +#define BV_USBPHY_IP_CP_SEL__TIMES_2 =C2=A0 0x1
> +#define BV_USBPHY_IP_CP_SEL__TIMES_05 =C2=A00x2
> +#define BV_USBPHY_IP_CP_SEL__UNDEFINED 0x3
> +#define BM_USBPHY_IP_TSTI_TX_DP =C2=A0 =C2=A0 =C2=A0 =C2=A00x00040000
> +#define BM_USBPHY_IP_TSTI_TX_DM =C2=A0 =C2=A0 =C2=A0 =C2=A00x00020000
> +#define BM_USBPHY_IP_ANALOG_TESTMODE =C2=A0 0x00010000
> +#define BM_USBPHY_IP_EN_USB_CLKS =C2=A0 =C2=A0 =C2=A0 0x00000004
> +#define BM_USBPHY_IP_PLL_LOCKED =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000002
> +#define BM_USBPHY_IP_PLL_POWER 0x00000001
> +#endif /* __ARCH_ARM___USBPHY_H */
> --
> 1.7.0.4
>
>
>


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.38.1311865307.20020.linux-arm-kernel@lists.infradead.org>

It's far simpler to debug a "my decompressor crashes with a CRC error"
report than "I'm not getting any output after loading the kernel".

The former normally causes an immediate "you have a problem with your
SDRAM connectivity".  The latter requires some thinking and
investigation, and probably several exchanges via email to debug.

So, for the sake of not having more problems to solve, I am opposed
to this idea.  IMHO debuggability for people working on the kernel
trumps the push by distros to have a single kernel image.

Well, actually, no it doesn't - provided they pick up the debugging of
those bug reports and provide the resources to manage that themselves
(allowing other people who don't want the additional workload this
imposes to purely ignore such reports.)

Or to put it another way: I'll ignore all "my kernel doesn't produce
anything" bug reports if this goes in.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.39.1311887756.20020.linux-arm-kernel@lists.infradead.org>

_________________________________________
static struct regulator_consumer_supply omap4_panda_vmmc5_supply = {
        .supply = "vmmc",
        .dev_name = "omap_hsmmc.4",
};

static struct regulator_init_data panda_vmmc5 = {
        .constraints = {
                .valid_ops_mask = REGULATOR_CHANGE_STATUS,
        },
        .num_consumer_supplies = 1,
        .consumer_supplies = &omap4_panda_vmmc5_supply,
};

static struct fixed_voltage_config panda_vwlan = {
        .supply_name = "vwl1271",
        .microvolts = 1800000, /* 1.8V */
        .gpio = GPIO_WIFI_PMENA,
        .startup_delay = 70000, /* 70msec */
        .enable_high = 1,
        .enabled_at_boot = 0,
        .init_data = &panda_vmmc5,
};

static struct platform_device omap_vwlan_device = {
        .name           = "reg-fixed-voltage",
        .id             = 1,
        .dev = {
                .platform_data = &panda_vwlan,
        },
};
_________________________________________

If this can't work for you, can you list why in the change log.

If your mmc controller doesn't yet support vmmc control. It should
be very easy to add it first.

Thanks.


> +	} else {
> +		gpio_set_value(DA850_WLAN_EN, 0);
> +	}
> +}
> +
> +static struct davinci_mmc_config da850_wl12xx_mmc_config = {
> +	.set_power	= wl12xx_set_power,
> +	.wires		= 4,
> +	.max_freq	= 25000000,
> +	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_NONREMOVABLE |
> +			  MMC_CAP_POWER_OFF_CARD,
> +	.version	= MMC_CTLR_VERSION_2,
> +};
> +
> +static const short da850_wl12xx_pins[] __initconst = {
> +	DA850_MMCSD1_DAT_0, DA850_MMCSD1_DAT_1, DA850_MMCSD1_DAT_2,
> +	DA850_MMCSD1_DAT_3, DA850_MMCSD1_CLK, DA850_MMCSD1_CMD,
> +	DA850_GPIO6_9, DA850_GPIO6_10,
> +	-1
> +};
> +
> +static struct wl12xx_platform_data da850_wl12xx_wlan_data __initdata = {
> +	.irq			= -1,
> +	.board_ref_clock	= WL12XX_REFCLOCK_38,
> +	.platform_quirks	= WL12XX_PLATFORM_QUIRK_EDGE_IRQ,
> +};
> +
> +static __init int da850_wl12xx_init(void)
> +{
> +	int ret;
> +
> +	ret = davinci_cfg_reg_list(da850_wl12xx_pins);
> +	if (ret) {
> +		pr_err("wl12xx/mmc mux setup failed: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = da850_register_mmcsd1(&da850_wl12xx_mmc_config);
> +	if (ret) {
> +		pr_err("wl12xx/mmc registration failed: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_LOW, "wl12xx_en");
> +	if (ret) {
> +		pr_err("Could not request wl12xx enable gpio: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, "wl12xx_irq");
> +	if (ret) {
> +		pr_err("Could not request wl12xx irq gpio: %d\n", ret);
> +		goto free_wlan_en;
> +	}
> +
> +	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
> +
> +	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
> +	if (ret) {
> +		pr_err("Could not set wl12xx data: %d\n", ret);
> +		goto free_wlan_irq;
> +	}
> +
> +	return 0;
> +
> +free_wlan_irq:
> +	gpio_free(DA850_WLAN_IRQ);
> +
> +free_wlan_en:
> +	gpio_free(DA850_WLAN_EN);
> +
> +exit:
> +	return ret;
> +}
> +
> +#else /* CONFIG_DA850_WL12XX */
> +
> +static __init int da850_wl12xx_init(void)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_DA850_WL12XX */
> +
>  #define DA850EVM_SATA_REFCLKPN_RATE	(100 * 1000 * 1000)
>  
>  static __init void da850_evm_init(void)
> @@ -1171,6 +1280,11 @@ static __init void da850_evm_init(void)
>  		if (ret)
>  			pr_warning("da850_evm_init: mmcsd0 registration failed:"
>  					" %d\n", ret);
> +
> +		ret = da850_wl12xx_init();
> +		if (ret)
> +			pr_warning("da850_evm_init: wl12xx initialization"
> +				   " failed: %d\n", ret);
>  	}
>  
>  	davinci_serial_init(&da850_evm_uart_config);



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.50.1312218368.20020.linux-arm-kernel@lists.infradead.org>

- Fixed PPI request in the MSM timer code
- Fixed UP/non-local-timer build
- Moved some bits and pieces from patch 1 to patch 2

Marc Zyngier (4):
  ARM: gic: consolidate PPI handling
  ARM: gic: Add PPI registration interface
  ARM: local timers: drop local_timer_ack()
  ARM: gic: add compute_irqnr macro for exynos4

 arch/arm/common/gic.c                             |  153 +++++++++++++++++=
++--
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   22 +---
 arch/arm/include/asm/hardware/gic.h               |    5 +-
 arch/arm/include/asm/localtimer.h                 |   14 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   33 +-----
 arch/arm/kernel/smp_twd.c                         |   32 +++--
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   61 +-------
 arch/arm/mach-exynos4/mct.c                       |    6 -
 arch/arm/mach-msm/board-msm8x60.c                 |   11 --
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +----------
 arch/arm/mach-msm/timer.c                         |   56 ++++----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 19 files changed, 215 insertions(+), 291 deletions(-)




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.57.1312873495.20020.linux-arm-kernel@lists.infradead.org>

The
only problem is the lack of documentation how to use it correctly in the
embedded
world.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.58.1312883811.20020.linux-arm-kernel@lists.infradead.org>

- Fixed exynos4 compilation


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.59.1312883812.20020.linux-arm-kernel@lists.infradead.org>

- Fixed PPI request in the MSM timer code
- Fixed UP/non-local-timer build
- Moved some bits and pieces from patch 1 to patch 2

Marc Zyngier (4):
  ARM: gic: consolidate PPI handling
  ARM: gic: Add PPI registration interface
  ARM: local timers: drop local_timer_ack()
  ARM: gic: add compute_irqnr macro for exynos4

 arch/arm/common/gic.c                             |  153 +++++++++++++++++=
++--
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   22 +---
 arch/arm/include/asm/hardware/gic.h               |    5 +-
 arch/arm/include/asm/localtimer.h                 |   19 ++--
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   33 +-----
 arch/arm/kernel/smp_twd.c                         |   30 +++--
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   67 +--------
 arch/arm/mach-exynos4/mct.c                       |    6 -
 arch/arm/mach-msm/board-msm8x60.c                 |   11 --
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +----------
 arch/arm/mach-msm/timer.c                         |   56 ++++----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 19 files changed, 214 insertions(+), 301 deletions(-)




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.63.1313078563.20020.linux-arm-kernel@lists.infradead.org>

- Added 'notrace' to all _read_sched_lock() functions, fixing
  the ftrace problem reported by Jamie Iles
- Removed useless #include <linux/sched.h> from touched files
- Made omap_32k_read_sched_clock() static

 arch/arm/include/asm/sched_clock.h       |  108 +-------------------------=
----
 arch/arm/kernel/sched_clock.c            |   97 +++++++++++++++++++++++++-=
-
 arch/arm/mach-ixp4xx/common.c            |   16 +----
 arch/arm/mach-mmp/time.c                 |   16 +----
 arch/arm/mach-omap1/time.c               |   58 +---------------
 arch/arm/mach-omap2/timer.c              |   20 +-----
 arch/arm/mach-pxa/time.c                 |   15 +---
 arch/arm/mach-sa1100/time.c              |   28 +-------
 arch/arm/mach-tegra/timer.c              |   24 +------
 arch/arm/mach-u300/timer.c               |   15 +---
 arch/arm/plat-iop/time.c                 |   16 +----
 arch/arm/plat-mxc/time.c                 |   15 +---
 arch/arm/plat-nomadik/timer.c            |   18 +----
 arch/arm/plat-omap/counter_32k.c         |   40 +----------
 arch/arm/plat-omap/include/plat/common.h |    1 -
 arch/arm/plat-orion/time.c               |   21 +-----
 arch/arm/plat-s5p/s5p-time.c             |   19 +-----
 arch/arm/plat-versatile/sched-clock.c    |   29 ++------
 18 files changed, 141 insertions(+), 415 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sche=
d_clock.h
index c8e6ddf..e3f7572 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -8,113 +8,7 @@
 #ifndef ASM_SCHED_CLOCK
 #define ASM_SCHED_CLOCK
=20
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-struct clock_data {
-=09u64 epoch_ns;
-=09u32 epoch_cyc;
-=09u32 epoch_cyc_copy;
-=09u32 mult;
-=09u32 shift;
-};
-
-#define DEFINE_CLOCK_DATA(name)=09struct clock_data name
-
-static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
-{
-=09return (cyc * mult) >> shift;
-}
-
-/*
- * Atomically update the sched_clock epoch.  Your update callback will
- * be called from a timer before the counter wraps - read the current
- * counter value, and call this function to safely move the epochs
- * forward.  Only use this from the update callback.
- */
-static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 =
mask)
-{
-=09unsigned long flags;
-=09u64 ns =3D cd->epoch_ns +
-=09=09cyc_to_ns((cyc - cd->epoch_cyc) & mask, cd->mult, cd->shift);
-
-=09/*
-=09 * Write epoch_cyc and epoch_ns in a way that the update is
-=09 * detectable in cyc_to_fixed_sched_clock().
-=09 */
-=09raw_local_irq_save(flags);
-=09cd->epoch_cyc =3D cyc;
-=09smp_wmb();
-=09cd->epoch_ns =3D ns;
-=09smp_wmb();
-=09cd->epoch_cyc_copy =3D cyc;
-=09raw_local_irq_restore(flags);
-}
-
-/*
- * If your clock rate is known at compile time, using this will allow
- * you to optimize the mult/shift loads away.  This is paired with
- * init_fixed_sched_clock() to ensure that your mult/shift are correct.
- */
-static inline unsigned long long cyc_to_fixed_sched_clock(struct clock_dat=
a *cd,
-=09u32 cyc, u32 mask, u32 mult, u32 shift)
-{
-=09u64 epoch_ns;
-=09u32 epoch_cyc;
-
-=09/*
-=09 * Load the epoch_cyc and epoch_ns atomically.  We do this by
-=09 * ensuring that we always write epoch_cyc, epoch_ns and
-=09 * epoch_cyc_copy in strict order, and read them in strict order.
-=09 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
-=09 * the middle of an update, and we should repeat the load.
-=09 */
-=09do {
-=09=09epoch_cyc =3D cd->epoch_cyc;
-=09=09smp_rmb();
-=09=09epoch_ns =3D cd->epoch_ns;
-=09=09smp_rmb();
-=09} while (epoch_cyc !=3D cd->epoch_cyc_copy);
-
-=09return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, mult, shift);
-}
-
-/*
- * Otherwise, you need to use this, which will obtain the mult/shift
- * from the clock_data structure.  Use init_sched_clock() with this.
- */
-static inline unsigned long long cyc_to_sched_clock(struct clock_data *cd,
-=09u32 cyc, u32 mask)
-{
-=09return cyc_to_fixed_sched_clock(cd, cyc, mask, cd->mult, cd->shift);
-}
-
-/*
- * Initialize the clock data - calculate the appropriate multiplier
- * and shift.  Also setup a timer to ensure that the epoch is refreshed
- * at the appropriate time interval, which will call your update
- * handler.
- */
-void init_sched_clock(struct clock_data *, void (*)(void),
-=09unsigned int, unsigned long);
-
-/*
- * Use this initialization function rather than init_sched_clock() if
- * you're using cyc_to_fixed_sched_clock, which will warn if your
- * constants are incorrect.
- */
-static inline void init_fixed_sched_clock(struct clock_data *cd,
-=09void (*update)(void), unsigned int bits, unsigned long rate,
-=09u32 mult, u32 shift)
-{
-=09init_sched_clock(cd, update, bits, rate);
-=09if (cd->mult !=3D mult || cd->shift !=3D shift) {
-=09=09pr_crit("sched_clock: wrong multiply/shift: %u>>%u vs calculated %u>=
>%u\n"
-=09=09=09"sched_clock: fix multiply/shift to avoid scheduler hiccups\n",
-=09=09=09mult, shift, cd->mult, cd->shift);
-=09}
-}
-
 extern void sched_clock_postinit(void);
+extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long r=
ate);
=20
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..3c0d93a 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -14,25 +14,88 @@
=20
 #include <asm/sched_clock.h>
=20
+struct clock_data {
+=09u64 epoch_ns;
+=09u32 epoch_cyc;
+=09u32 epoch_cyc_copy;
+=09u32 mult;
+=09u32 shift;
+};
+
 static void sched_clock_poll(unsigned long wrap_ticks);
 static DEFINE_TIMER(sched_clock_timer, sched_clock_poll, 0, 0);
-static void (*sched_clock_update_fn)(void);
+
+static struct clock_data cd;
+static u32 sched_clock_mask;
+static u32 __read_mostly (*read_sched_clock)(void);
+
+static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
+{
+=09return (cyc * mult) >> shift;
+}
+
+static unsigned long long cyc_to_sched_clock(struct clock_data *cd,
+=09=09=09=09=09     u32 cyc, u32 mask)
+{
+=09u64 epoch_ns;
+=09u32 epoch_cyc;
+
+=09/*
+=09 * Load the epoch_cyc and epoch_ns atomically.  We do this by
+=09 * ensuring that we always write epoch_cyc, epoch_ns and
+=09 * epoch_cyc_copy in strict order, and read them in strict order.
+=09 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
+=09 * the middle of an update, and we should repeat the load.
+=09 */
+=09do {
+=09=09epoch_cyc =3D cd->epoch_cyc;
+=09=09smp_rmb();
+=09=09epoch_ns =3D cd->epoch_ns;
+=09=09smp_rmb();
+=09} while (epoch_cyc !=3D cd->epoch_cyc_copy);
+
+=09return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, cd->mult, cd->shi=
ft);
+}
+
+/*
+ * Atomically update the sched_clock epoch.
+ */
+static void notrace update_sched_clock(void)
+{
+=09unsigned long flags;
+=09u32 cyc;
+=09u64 ns;
+
+=09cyc =3D read_sched_clock();
+=09ns =3D cd.epoch_ns +
+=09=09cyc_to_ns((cyc - cd.epoch_cyc) & sched_clock_mask,
+=09=09=09  cd.mult, cd.shift);
+=09/*
+=09 * Write epoch_cyc and epoch_ns in a way that the update is
+=09 * detectable in cyc_to_fixed_sched_clock().
+=09 */
+=09raw_local_irq_save(flags);
+=09cd.epoch_cyc =3D cyc;
+=09smp_wmb();
+=09cd.epoch_ns =3D ns;
+=09smp_wmb();
+=09cd.epoch_cyc_copy =3D cyc;
+=09raw_local_irq_restore(flags);
+}
=20
 static void sched_clock_poll(unsigned long wrap_ticks)
 {
 =09mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
-=09sched_clock_update_fn();
+=09update_sched_clock();
 }
=20
-void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
-=09unsigned int clock_bits, unsigned long rate)
+static void __init init_sched_clock(struct clock_data *cd,
+=09=09=09=09    unsigned int clock_bits, unsigned long rate)
 {
 =09unsigned long r, w;
 =09u64 res, wrap;
 =09char r_unit;
=20
-=09sched_clock_update_fn =3D update;
-
 =09/* calculate the mult/shift to convert counter ticks to ns. */
 =09clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC, 0);
=20
@@ -60,7 +123,7 @@ void __init init_sched_clock(struct clock_data *cd, void=
 (*update)(void),
 =09 * sets the initial epoch.
 =09 */
 =09sched_clock_timer.data =3D msecs_to_jiffies(w - (w / 10));
-=09update();
+=09update_sched_clock();
=20
 =09/*
 =09 * Ensure that sched_clock() starts off at 0ns
@@ -68,6 +131,26 @@ void __init init_sched_clock(struct clock_data *cd, voi=
d (*update)(void),
 =09cd->epoch_ns =3D 0;
 }
=20
+unsigned long long notrace sched_clock(void)
+{
+=09if (read_sched_clock) {
+=09=09u32 cyc =3D read_sched_clock();
+=09=09return cyc_to_sched_clock(&cd, cyc, sched_clock_mask);
+=09}
+
+=09return (unsigned long long)(jiffies - INITIAL_JIFFIES)
+=09=09=09=09=09* (NSEC_PER_SEC / HZ);
+}
+
+void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long r=
ate)
+{
+=09BUG_ON(bits > 32);
+=09read_sched_clock =3D read;
+=09sched_clock_mask =3D (1 << bits) - 1;
+=09init_sched_clock(&cd, bits, rate);
+=09pr_debug("Registered %pF as sched_clock source\n", read);
+}
+
 void __init sched_clock_postinit(void)
 {
 =09sched_clock_poll(sched_clock_timer.data);
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0777257..d10d838 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -17,7 +17,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/serial.h>
-#include <linux/sched.h>
 #include <linux/tty.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -402,18 +401,9 @@ void __init ixp4xx_sys_init(void)
 /*
  * sched_clock()
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace ixp4xx_read_sched_clock(void)
 {
-=09u32 cyc =3D *IXP4XX_OSTS;
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace ixp4xx_update_sched_clock(void)
-{
-=09u32 cyc =3D *IXP4XX_OSTS;
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return *IXP4XX_OSTS;
 }
=20
 /*
@@ -429,7 +419,7 @@ unsigned long ixp4xx_timer_freq =3D IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-=09init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq)=
;
+=09setup_sched_clock(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
=20
 =09clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
 =09=09=09ixp4xx_clocksource_read);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 99833b9..fb730f4 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -25,7 +25,6 @@
=20
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/sched.h>
=20
 #include <asm/sched_clock.h>
 #include <mach/addr-map.h>
@@ -42,8 +41,6 @@
 #define MAX_DELTA=09=09(0xfffffffe)
 #define MIN_DELTA=09=09(16)
=20
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
  */
@@ -59,16 +56,9 @@ static inline uint32_t timer_read(void)
 =09return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(0));
 }
=20
-unsigned long long notrace sched_clock(void)
+static u32 notrace mmp_read_sched_clock(void)
 {
-=09u32 cyc =3D timer_read();
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace mmp_update_sched_clock(void)
-{
-=09u32 cyc =3D timer_read();
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return timer_read();
 }
=20
 static irqreturn_t timer_interrupt(int irq, void *dev_id)
@@ -175,7 +165,7 @@ void __init timer_init(int irq)
 {
 =09timer_config();
=20
-=09init_sched_clock(&cd, mmp_update_sched_clock, 32, CLOCK_TICK_RATE);
+=09setup_sched_clock(mmp_read_sched_clock, 32, CLOCK_TICK_RATE);
=20
 =09ckevt.mult =3D div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt.shift);
 =09ckevt.max_delta_ns =3D clockevent_delta2ns(MAX_DELTA, &ckevt);
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a183777..92b5847 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -37,7 +37,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -190,30 +189,9 @@ static __init void omap_init_mpu_timer(unsigned long r=
ate)
  * -----------------------------------------------------------------------=
----
  */
=20
-static DEFINE_CLOCK_DATA(cd);
-
-static inline unsigned long long notrace _omap_mpu_sched_clock(void)
-{
-=09u32 cyc =3D ~omap_mpu_timer_read(1);
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-#ifndef CONFIG_OMAP_32K_TIMER
-unsigned long long notrace sched_clock(void)
-{
-=09return _omap_mpu_sched_clock();
-}
-#else
-static unsigned long long notrace omap_mpu_sched_clock(void)
-{
-=09return _omap_mpu_sched_clock();
-}
-#endif
-
-static void notrace mpu_update_sched_clock(void)
+static u32 notrace omap_mpu_read_sched_clock(void)
 {
-=09u32 cyc =3D ~omap_mpu_timer_read(1);
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return ~omap_mpu_timer_read(1);
 }
=20
 static void __init omap_init_clocksource(unsigned long rate)
@@ -223,7 +201,7 @@ static void __init omap_init_clocksource(unsigned long =
rate)
 =09=09=09"%s: can't register clocksource!\n";
=20
 =09omap_mpu_timer_start(1, ~0, 1);
-=09init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
+=09setup_sched_clock(omap_mpu_read_sched_clock, 32, rate);
=20
 =09if (clocksource_mmio_init(&timer->read_tim, "mpu_timer2", rate,
 =09=09=09300, 32, clocksource_mmio_readl_down))
@@ -254,30 +232,6 @@ static inline void omap_mpu_timer_init(void)
 }
 #endif=09/* CONFIG_OMAP_MPU_TIMER */
=20
-#if defined(CONFIG_OMAP_MPU_TIMER) && defined(CONFIG_OMAP_32K_TIMER)
-static unsigned long long (*preferred_sched_clock)(void);
-
-unsigned long long notrace sched_clock(void)
-{
-=09if (!preferred_sched_clock)
-=09=09return 0;
-
-=09return preferred_sched_clock();
-}
-
-static inline void preferred_sched_clock_init(bool use_32k_sched_clock)
-{
-=09if (use_32k_sched_clock)
-=09=09preferred_sched_clock =3D omap_32k_sched_clock;
-=09else
-=09=09preferred_sched_clock =3D omap_mpu_sched_clock;
-}
-#else
-static inline void preferred_sched_clock_init(bool use_32k_sched_clcok)
-{
-}
-#endif
-
 static inline int omap_32k_timer_usable(void)
 {
 =09int res =3D false;
@@ -299,12 +253,8 @@ static inline int omap_32k_timer_usable(void)
  */
 static void __init omap1_timer_init(void)
 {
-=09if (omap_32k_timer_usable()) {
-=09=09preferred_sched_clock_init(1);
-=09} else {
+=09if (!omap_32k_timer_usable())
 =09=09omap_mpu_timer_init();
-=09=09preferred_sched_clock_init(0);
-=09}
 }
=20
 struct sys_timer omap1_timer =3D {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e964072..24fb13d 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -248,7 +248,6 @@ static struct omap_dm_timer clksrc;
 /*
  * clocksource
  */
-static DEFINE_CLOCK_DATA(cd);
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
 =09return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
@@ -262,23 +261,12 @@ static struct clocksource clocksource_gpt =3D {
 =09.flags=09=09=3D CLOCK_SOURCE_IS_CONTINUOUS,
 };
=20
-static void notrace dmtimer_update_sched_clock(void)
+static u32 notrace dmtimer_read_sched_clock(void)
 {
-=09u32 cyc;
-
-=09cyc =3D __omap_dm_timer_read_counter(clksrc.io_base, 1);
-
-=09update_sched_clock(&cd, cyc, (u32)~0);
-}
-
-unsigned long long notrace sched_clock(void)
-{
-=09u32 cyc =3D 0;
-
 =09if (clksrc.reserved)
-=09=09cyc =3D __omap_dm_timer_read_counter(clksrc.io_base, 1);
+=09=09return __omap_dm_timer_read_counter(clksrc.io_base, 1);
=20
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+=09return 0;
 }
=20
 /* Setup free-running counter for clocksource */
@@ -294,7 +282,7 @@ static void __init omap2_gp_clocksource_init(int gptime=
r_id,
 =09=09gptimer_id, clksrc.rate);
=20
 =09__omap_dm_timer_load_start(clksrc.io_base, OMAP_TIMER_CTRL_ST, 0, 1);
-=09init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
+=09setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
=20
 =09if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 =09=09pr_err("Could not register clocksource %s\n",
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index de68470..b503049 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
-#include <linux/sched.h>
=20
 #include <asm/div64.h>
 #include <asm/mach/irq.h>
@@ -32,18 +31,10 @@
  * long as there is always less than 582 seconds between successive
  * calls to sched_clock() which should always be the case in practice.
  */
-static DEFINE_CLOCK_DATA(cd);
=20
-unsigned long long notrace sched_clock(void)
+static u32 notrace pxa_read_sched_clock(void)
 {
-=09u32 cyc =3D OSCR;
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace pxa_update_sched_clock(void)
-{
-=09u32 cyc =3D OSCR;
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return OSCR;
 }
=20
=20
@@ -119,7 +110,7 @@ static void __init pxa_timer_init(void)
 =09OIER =3D 0;
 =09OSSR =3D OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
=20
-=09init_sched_clock(&cd, pxa_update_sched_clock, 32, clock_tick_rate);
+=09setup_sched_clock(pxa_read_sched_clock, 32, clock_tick_rate);
=20
 =09clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
 =09ckevt_pxa_osmr0.max_delta_ns =3D
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index fa66024..1ee6d4c 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/sched.h>=09/* just for sched_clock() - funny that */
 #include <linux/timex.h>
 #include <linux/clockchips.h>
=20
@@ -20,29 +19,9 @@
 #include <asm/sched_clock.h>
 #include <mach/hardware.h>
=20
-/*
- * This is the SA11x0 sched_clock implementation.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 3.6864MHz,
- * NSEC_PER_SEC, 60).
- * This gives a resolution of about 271ns and a wrap period of about 19min=
.
- */
-#define SC_MULT=09=092275555556u
-#define SC_SHIFT=0923
-
-unsigned long long notrace sched_clock(void)
-{
-=09u32 cyc =3D OSCR;
-=09return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-static void notrace sa1100_update_sched_clock(void)
+static u32 notrace sa100_read_sched_clock(void)
 {
-=09u32 cyc =3D OSCR;
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return OSCR;
 }
=20
 #define MIN_OSCR_DELTA 2
@@ -109,8 +88,7 @@ static void __init sa1100_timer_init(void)
 =09OIER =3D 0;
 =09OSSR =3D OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
=20
-=09init_fixed_sched_clock(&cd, sa1100_update_sched_clock, 32,
-=09=09=09       3686400, SC_MULT, SC_SHIFT);
+=09setup_sched_clock(sa1100_read_sched_clock, 32, 3686400);
=20
 =09clockevents_calc_mult_shift(&ckevt_sa1100_osmr0, 3686400, 4);
 =09ckevt_sa1100_osmr0.max_delta_ns =3D
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 9035042..b5dc8d2 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -19,7 +19,6 @@
=20
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -106,25 +105,9 @@ static struct clock_event_device tegra_clockevent =3D =
{
 =09.set_mode=09=3D tegra_timer_set_mode,
 };
=20
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 1MHz, NSEC_PER_SEC,=
 60).
- * This gives a resolution of about 1us and a wrap period of about 1h11min=
.
- */
-#define SC_MULT=09=094194304000u
-#define SC_SHIFT=0922
-
-unsigned long long notrace sched_clock(void)
-{
-=09u32 cyc =3D timer_readl(TIMERUS_CNTR_1US);
-=09return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-static void notrace tegra_update_sched_clock(void)
+static u32 notrace tegra_read_sched_clock(void)
 {
-=09u32 cyc =3D timer_readl(TIMERUS_CNTR_1US);
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return timer_readl(TIMERUS_CNTR_1US);
 }
=20
 /*
@@ -218,8 +201,7 @@ static void __init tegra_init_timer(void)
 =09=09WARN(1, "Unknown clock rate");
 =09}
=20
-=09init_fixed_sched_clock(&cd, tegra_update_sched_clock, 32,
-=09=09=09       1000000, SC_MULT, SC_SHIFT);
+=09setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
=20
 =09if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 =09=09"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 5f51bde..bc1c789 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -9,7 +9,6 @@
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
 #include <linux/interrupt.h>
-#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/clockchips.h>
@@ -337,18 +336,10 @@ static struct irqaction u300_timer_irq =3D {
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by OMAP implementation.)
  */
-static DEFINE_CLOCK_DATA(cd);
=20
-unsigned long long notrace sched_clock(void)
+static u32 notrace u300_read_sched_clock(void)
 {
-=09u32 cyc =3D readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace u300_update_sched_clock(void)
-{
-=09u32 cyc =3D readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
 }
=20
=20
@@ -366,7 +357,7 @@ static void __init u300_timer_init(void)
 =09clk_enable(clk);
 =09rate =3D clk_get_rate(clk);
=20
-=09init_sched_clock(&cd, u300_update_sched_clock, 32, rate);
+=09setup_sched_clock(u300_read_sched_clock, 32, rate);
=20
 =09/*
 =09 * Disable the "OS" and "DD" timers - these are designed for Symbian!
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 7cdc516..fd94c55 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -18,7 +18,6 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/timex.h>
-#include <linux/sched.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -51,21 +50,12 @@ static struct clocksource iop_clocksource =3D {
 =09.flags=09=09=3D CLOCK_SOURCE_IS_CONTINUOUS,
 };
=20
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-unsigned long long notrace sched_clock(void)
+static u32 notrace iop_read_sched_clock(void)
 {
-=09u32 cyc =3D 0xffffffffu - read_tcr1();
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace iop_update_sched_clock(void)
-{
-=09u32 cyc =3D 0xffffffffu - read_tcr1();
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return 0xffffffffu - read_tcr1();
 }
=20
 /*
@@ -151,7 +141,7 @@ void __init iop_init_time(unsigned long tick_rate)
 {
 =09u32 timer_ctl;
=20
-=09init_sched_clock(&cd, iop_update_sched_clock, 32, tick_rate);
+=09setup_sched_clock(iop_read_sched_clock, 32, tick_rate);
=20
 =09ticks_per_jiffy =3D DIV_ROUND_CLOSEST(tick_rate, HZ);
 =09iop_tick_rate =3D tick_rate;
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..1c96cdb 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -108,18 +108,9 @@ static void gpt_irq_acknowledge(void)
=20
 static void __iomem *sched_clock_reg;
=20
-static DEFINE_CLOCK_DATA(cd);
-unsigned long long notrace sched_clock(void)
+static u32 notrace mxc_read_sched_clock(void)
 {
-=09cycle_t cyc =3D sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
-
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace mxc_update_sched_clock(void)
-{
-=09cycle_t cyc =3D sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
 }
=20
 static int __init mxc_clocksource_init(struct clk *timer_clk)
@@ -129,7 +120,7 @@ static int __init mxc_clocksource_init(struct clk *time=
r_clk)
=20
 =09sched_clock_reg =3D reg;
=20
-=09init_sched_clock(&cd, mxc_update_sched_clock, 32, c);
+=09setup_sched_clock(mxc_read_sched_clock, 32, c);
 =09return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
 =09=09=09clocksource_mmio_readl_up);
 }
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index ef74e15..7a0a9d7 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
-#include <linux/sched.h>
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
=20
@@ -30,23 +29,12 @@ void __iomem *mtu_base; /* Assigned by machine code */
  * local implementation which uses the clocksource to get some
  * better resolution when scheduling the kernel.
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace nomadik_read_sched_clock(void)
 {
-=09u32 cyc;
-
 =09if (unlikely(!mtu_base))
 =09=09return 0;
=20
-=09cyc =3D -readl(mtu_base + MTU_VAL(0));
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace nomadik_update_sched_clock(void)
-{
-=09u32 cyc =3D -readl(mtu_base + MTU_VAL(0));
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return -readl(mtu_base + MTU_VAL(0));
 }
=20
 /* Clockevent device: use one-shot mode */
@@ -154,7 +142,7 @@ void __init nmdk_timer_init(void)
 =09=09pr_err("timer: failed to initialize clock source %s\n",
 =09=09       "mtu_0");
=20
-=09init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
+=09setup_sched_clock(nomadik_setup_sched_clock, 32, rate);
=20
 =09/* Timer 1 is used for events */
=20
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_=
32k.c
index a6cbb71..5f0f229 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/sched.h>
 #include <linux/clocksource.h>
=20
 #include <asm/sched_clock.h>
@@ -37,41 +36,9 @@ static void __iomem *timer_32k_base;
=20
 #define OMAP16XX_TIMER_32K_SYNCHRONIZED=09=090xfffbc410
=20
-/*
- * Returns current time from boot in nsecs. It's OK for this to wrap
- * around for now, as it's just a relative time stamp.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 32768, NSEC_PER_SEC=
, 60).
- * This gives a resolution of about 30us and a wrap period of about 36hrs.
- */
-#define SC_MULT=09=094000000000u
-#define SC_SHIFT=0917
-
-static inline unsigned long long notrace _omap_32k_sched_clock(void)
-{
-=09u32 cyc =3D timer_32k_base ? __raw_readl(timer_32k_base) : 0;
-=09return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-#if defined(CONFIG_OMAP_32K_TIMER) && !defined(CONFIG_OMAP_MPU_TIMER)
-unsigned long long notrace sched_clock(void)
-{
-=09return _omap_32k_sched_clock();
-}
-#else
-unsigned long long notrace omap_32k_sched_clock(void)
-{
-=09return _omap_32k_sched_clock();
-}
-#endif
-
-static void notrace omap_update_sched_clock(void)
+static u32 notrace omap_32k_read_sched_clock(void)
 {
-=09u32 cyc =3D timer_32k_base ? __raw_readl(timer_32k_base) : 0;
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
 }
=20
 /**
@@ -147,8 +114,7 @@ int __init omap_init_clocksource_32k(void)
 =09=09=09=09=09  clocksource_mmio_readl_up))
 =09=09=09printk(err, "32k_counter");
=20
-=09=09init_fixed_sched_clock(&cd, omap_update_sched_clock, 32,
-=09=09=09=09       32768, SC_MULT, SC_SHIFT);
+=09=09setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
 =09}
 =09return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/=
include/plat/common.h
index 4564cc6..44e2e33 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -41,7 +41,6 @@ extern struct sys_timer omap3_secure_timer;
 extern struct sys_timer omap4_timer;
 extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
-extern unsigned long long notrace omap_32k_sched_clock(void);
=20
 extern void omap_reserve(void);
=20
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 69a6136..1ed8d13 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -12,7 +12,6 @@
  */
=20
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -60,24 +59,10 @@ static u32 ticks_per_jiffy;
  * Orion's sched_clock implementation. It has a resolution of
  * at least 7.5ns (133MHz TCLK).
  */
-static DEFINE_CLOCK_DATA(cd);
=20
-unsigned long long notrace sched_clock(void)
+static u32 notrace orion_read_sched_clock(void)
 {
-=09u32 cyc =3D ~readl(timer_base + TIMER0_VAL_OFF);
-=09return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-
-static void notrace orion_update_sched_clock(void)
-{
-=09u32 cyc =3D ~readl(timer_base + TIMER0_VAL_OFF);
-=09update_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void __init setup_sched_clock(unsigned long tclk)
-{
-=09init_sched_clock(&cd, orion_update_sched_clock, 32, tclk);
+=09return ~readl(timer_base + TIMER0_VAL_OFF);
 }
=20
 /*
@@ -217,7 +202,7 @@ orion_time_init(u32 _bridge_base, u32 _bridge_timer1_cl=
r_mask,
 =09/*
 =09 * Set scale and timer for sched_clock.
 =09 */
-=09setup_sched_clock(tclk);
+=09setup_sched_clock(orion_read_sched_clock, 32, tclk);
=20
 =09/*
 =09 * Setup free-running clocksource timer (interrupts
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index c833e7b..566341b 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
=20
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
@@ -321,26 +320,14 @@ static void __iomem *s5p_timer_reg(void)
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by U300 implementation.)
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
-{
-=09void __iomem *reg =3D s5p_timer_reg();
-
-=09if (!reg)
-=09=09return 0;
-
-=09return cyc_to_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
-}
-
-static void notrace s5p_update_sched_clock(void)
+static u32 notrace s5p_read_sched_clock(void)
 {
 =09void __iomem *reg =3D s5p_timer_reg();
=20
 =09if (!reg)
 =09=09return;
=20
-=09update_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
+=09return ~__raw_readl(reg);
 }
=20
 static void __init s5p_clocksource_init(void)
@@ -358,7 +345,7 @@ static void __init s5p_clocksource_init(void)
 =09s5p_time_setup(timer_source.source_id, TCNT_MAX);
 =09s5p_time_start(timer_source.source_id, PERIODIC);
=20
-=09init_sched_clock(&cd, s5p_update_sched_clock, 32, clock_rate);
+=09setup_sched_clock(s5p_read_sched_clock, 32, clock_rate);
=20
 =09if (clocksource_mmio_init(s5p_timer_reg(), "s5p_clocksource_timer",
 =09=09=09clock_rate, 250, 32, clocksource_mmio_readl_down))
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatil=
e/sched-clock.c
index 3d6a4c2..b33b74c 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -18,41 +18,24 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
  */
+#include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/sched.h>
=20
 #include <asm/sched_clock.h>
 #include <plat/sched_clock.h>
=20
-static DEFINE_CLOCK_DATA(cd);
 static void __iomem *ctr;
=20
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 24MHz, NSEC_PER_SEC=
, 60).
- * This gives a resolution of about 41ns and a wrap period of about 178s.
- */
-#define SC_MULT=09=092796202667u
-#define SC_SHIFT=0926
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace versatile_read_sched_clock(void)
 {
-=09if (ctr) {
-=09=09u32 cyc =3D readl(ctr);
-=09=09return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0,
-=09=09=09=09=09=09SC_MULT, SC_SHIFT);
-=09} else
-=09=09return 0;
-}
+=09if (ctr)
+=09=09return readl(ctr);
=20
-static void notrace versatile_update_sched_clock(void)
-{
-=09u32 cyc =3D readl(ctr);
-=09update_sched_clock(&cd, cyc, (u32)~0);
+=09return 0;
 }
=20
 void __init versatile_sched_clock_init(void __iomem *reg, unsigned long ra=
te)
 {
 =09ctr =3D reg;
-=09init_fixed_sched_clock(&cd, versatile_update_sched_clock,
-=09=09=09       32, rate, SC_MULT, SC_SHIFT);
+=09setup_sched_clock(versatile_read_sched_clock, 32, rate);
 }
--=20
1.7.0.4
