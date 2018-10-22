From: navam@xilinx.com (Nava kishore Manne)
Date: Mon, 22 Oct 2018 09:51:30 +0000
Subject: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
In-Reply-To: <CAJYdmePxnkG=3iJC5Lewq3n3zFGTKASJX7ceUEufBvOJogCfdA@mail.gmail.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <20181020084805.29103-4-nava.manne@xilinx.com>
 <CAJYdmePxnkG=3iJC5Lewq3n3zFGTKASJX7ceUEufBvOJogCfdA@mail.gmail.com>
Message-ID: <BYAPR02MB47100B78AE98433201B66668C2F40@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

	Thanks for the quick response...
Please find my response inline...

> -----Original Message-----
> From: Moritz Fischer [mailto:moritz.fischer.private at gmail.com]
> Sent: Saturday, October 20, 2018 2:54 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Alan Tull <atull@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; Michal Simek <michals@xilinx.com>; Rajan
> Vaja <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-
> fpga at vger.kernel.org; Devicetree List <devicetree@vger.kernel.org>; linux-
> arm-kernel <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; chinnikishore369 at gmail.com
> Subject: Re: [PATCH 3/3] fpga manager: Adding FPGA Manager support for
> Xilinx zynqmp
> 
> Hi Nava,
> 
> Looks good to me, a couple of nits inline below.
> 
> On Fri, Oct 19, 2018 at 1:50 AM Nava kishore Manne
> <nava.manne@xilinx.com> wrote:
> >
> > This patch adds FPGA Manager support for the Xilinx ZynqMp chip.
> 
> Isn't it ZynqMP ?

Will fix in the next version.

> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v1:
> >                 -None.
> >
> > Changes for RFC-V2:
> >                 -Updated the Fpga Mgr registrations call's
> >                  to 4.18
> >
> >  drivers/fpga/Kconfig       |   9 +++
> >  drivers/fpga/Makefile      |   1 +
> >  drivers/fpga/zynqmp-fpga.c | 159
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 169 insertions(+)
> >  create mode 100644 drivers/fpga/zynqmp-fpga.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > 1ebcef4bab5b..26ebbcf3d3a3 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -56,6 +56,15 @@ config FPGA_MGR_ZYNQ_FPGA
> >         help
> >           FPGA manager driver support for Xilinx Zynq FPGAs.
> >
> > +config FPGA_MGR_ZYNQMP_FPGA
> > +       tristate "Xilinx Zynqmp FPGA"
> > +       depends on ARCH_ZYNQMP || COMPILE_TEST
> > +       help
> > +         FPGA manager driver support for Xilinx ZynqMP FPGAs.
> > +         This driver uses processor configuration port(PCAP)
> This driver uses *the* processor configuration port.
>

Will fix in the next version.
 
> > +         to configure the programmable logic(PL) through PS
> > +         on ZynqMP SoC.
> > +
> >  config FPGA_MGR_XILINX_SPI
> >         tristate "Xilinx Configuration over Slave Serial (SPI)"
> >         depends on SPI
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > 7a2d73ba7122..3488ebbaee46 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)    +=
> socfpga-a10.o
> >  obj-$(CONFIG_FPGA_MGR_TS73XX)          += ts73xx-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)      += xilinx-spi.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> > +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     += zynqmp-fpga.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > new file mode 100644 index 000000000000..2760d7e3872a
> > --- /dev/null
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018 Xilinx, Inc.
> > + */
> > +
> > +#include <linux/dma-mapping.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/string.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +
> > +/* Constant Definitions */
> > +#define IXR_FPGA_DONE_MASK     0X00000008U
> > +
> > +/**
> > + * struct zynqmp_fpga_priv - Private data structure
> > + * @dev:       Device data structure
> > + * @flags:     flags which is used to identify the bitfile type
> > + */
> > +struct zynqmp_fpga_priv {
> > +       struct device *dev;
> > +       u32 flags;
> > +};
> > +
> > +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
> > +                                     struct fpga_image_info *info,
> > +                                     const char *buf, size_t size) {
> > +       struct zynqmp_fpga_priv *priv;
> > +
> > +       priv = mgr->priv;
> > +       priv->flags = info->flags;
> > +
> > +       return 0;
> > +}
> > +
> > +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> > +                                const char *buf, size_t size) {
> > +       struct zynqmp_fpga_priv *priv;
> > +       char *kbuf;
> > +       dma_addr_t dma_addr;
> > +       int ret;
> > +       const struct zynqmp_eemi_ops *eemi_ops =
> > +zynqmp_pm_get_eemi_ops();
> 
> Reverse xmas-tree please, i.e. long lines first.
> 
Will fix in the next version.

> > +
> > +       if (!eemi_ops || !eemi_ops->fpga_load)
> > +               return -ENXIO;
> > +
> > +       priv = mgr->priv;
> > +
> > +       kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
> > +       if (!kbuf)
> > +               return -ENOMEM;
> > +
> > +       memcpy(kbuf, buf, size);
> > +
> > +       wmb(); /* ensure all writes are done before initiate FW call
> > + */
> > +
> > +       ret = eemi_ops->fpga_load(dma_addr, size, priv->flags);
> > +
> > +       dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> > +
> > +       return ret;
> > +}
> > +
> > +static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
> > +                                         struct fpga_image_info
> > +*info) {
> > +       return 0;
> > +}
> > +
> > +static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager
> > +*mgr) {
> > +       u32 status;
> > +       const struct zynqmp_eemi_ops *eemi_ops =
> > +zynqmp_pm_get_eemi_ops();
> 
> Same here, split it up if necessary.

Will fix in the next version

> > +
> > +       if (!eemi_ops || !eemi_ops->fpga_get_status)
> > +               return FPGA_MGR_STATE_UNKNOWN;
> > +
> > +       eemi_ops->fpga_get_status(&status);
> > +       if (status & IXR_FPGA_DONE_MASK)
> > +               return FPGA_MGR_STATE_OPERATING;
> > +
> > +       return FPGA_MGR_STATE_UNKNOWN; }
> > +
> > +static const struct fpga_manager_ops zynqmp_fpga_ops = {
> > +       .state = zynqmp_fpga_ops_state,
> > +       .write_init = zynqmp_fpga_ops_write_init,
> > +       .write = zynqmp_fpga_ops_write,
> > +       .write_complete = zynqmp_fpga_ops_write_complete, };
> > +
> > +static int zynqmp_fpga_probe(struct platform_device *pdev) {
> > +       struct device *dev = &pdev->dev;
> > +       struct zynqmp_fpga_priv *priv;
> > +       struct fpga_manager *mgr;
> > +       int err, ret;
> > +
> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->dev = dev;
> > +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
> > +       if (ret < 0)
> > +               dev_err(dev, "no usable DMA configuration");
> 
> Do you wanna do something about this error if it happens? Return 'ret' maybe?

Will fix in the next version.

> > +
> > +       mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> > +                             &zynqmp_fpga_ops, priv);
> > +       if (!mgr)
> > +               return -ENOMEM;
> > +
> > +       platform_set_drvdata(pdev, mgr);
> > +
> > +       err = fpga_mgr_register(mgr);
> > +       if (err) {
> > +               dev_err(dev, "unable to register FPGA manager");
> > +               fpga_mgr_free(mgr);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int zynqmp_fpga_remove(struct platform_device *pdev) {
> > +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> > +
> > +       fpga_mgr_unregister(mgr);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id zynqmp_fpga_of_match[] = {
> > +       { .compatible = "xlnx,zynqmp-pcap-fpga", },
> > +       {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
> > +
> > +static struct platform_driver zynqmp_fpga_driver = {
> > +       .probe = zynqmp_fpga_probe,
> > +       .remove = zynqmp_fpga_remove,
> > +       .driver = {
> > +               .name = "zynqmp_fpga_manager",
> > +               .of_match_table = of_match_ptr(zynqmp_fpga_of_match),
> > +       },
> > +};
> > +
> > +module_platform_driver(zynqmp_fpga_driver);
> > +
> > +MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
> > +MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.18.0
> >
> 
> Thanks,
> 
> Moritz
