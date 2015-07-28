From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jul 2015 08:47:47 +0800
Subject: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <CY1PR0301MB084351380311261C292872AB838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
 <20150727134058.GL12927@tiger>
 <CY1PR0301MB084352861E63DA2DE286CC77838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150727143515.GQ12927@tiger>
 <CY1PR0301MB084351380311261C292872AB838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <20150728004746.GT12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 02:50:15PM +0000, Shenwei Wang wrote:
> The following structure is currently used in both drivers. The members "gpc_base/
> wakeup_sources/enabled_irqs" are now shared to PM driver. And the macro IMR_NUM
> will be referred by both drivers too.
>  
> struct imx_gpcv2_irq {
> 	spinlock_t lock;
> 	void __iomem *gpc_base;

So this is the virtual base used by both irqchip and pm driver, and the
lock is for register access protection, right?  If so, we can define gpc
as a syscon device, and access it from both drivers with regmap.

> 	u32 wakeup_sources[IMR_NUM];

This should be an irqchip internal data and exported to external users like
pm code with an interface like imx_gpcv2_get_wakeup_sources().

> 	u32 enabled_irqs[IMR_NUM];

I do not see how this is used in pm driver.

> 	u32 cpu2wakeup;

The only use of this in pm driver is to unmask interrupt #32 during
initialization.  Why cannot it be done in irqchip driver initialization?

Shawn

> };
