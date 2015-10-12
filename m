From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 12 Oct 2015 04:22:43 +0200
Subject: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 Zynq 7000
In-Reply-To: <alpine.DEB.2.10.1510091903240.2257@atull-730U3E-740U3E>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-4-git-send-email-moritz.fischer@ettus.com>
 <alpine.DEB.2.10.1510091903240.2257@atull-730U3E-740U3E>
Message-ID: <CAAtXAHc97N4jnvz=op81AcQ=9pKgPdRJ-1TngYkM+1fWVTG8bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

thanks for your feedback!

On Fri, Oct 9, 2015 at 8:09 PM, atull <atull@opensource.altera.com> wrote:
> On Thu, 8 Oct 2015, Moritz Fischer wrote:
>
>> --- /dev/null
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -0,0 +1,478 @@
>> +/*
>> + * Copyright (c) 2011-2015 Xilinx Inc.
>> + * Copyright (c) 2015, National Instruments Corp.
>> + *
>> + * FPGA Manager Driver for Xilinx Zynq, heavily based on xdevcfg driver
>> + * in their vendor tree.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/pm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/string.h>
>
> Hi Moritz,
>
> That was fast!  I just have a couple of very minor comments...
>
> Please alphabetize the #includes.
>
>> +
>> +/* Offsets into SLCR regmap */
>> +#define SLCR_FPGA_RST_CTRL_OFFSET    0x240 /* FPGA Software Reset Control */
>> +#define SLCR_LVL_SHFTR_EN_OFFSET     0x900 /* Level Shifters Enable */
>> +
>> +/* Constant Definitions */
>> +#define CTRL_OFFSET          0x00 /* Control Register */
>> +#define LOCK_OFFSET          0x04 /* Lock Register */
>> +#define INT_STS_OFFSET               0x0c /* Interrupt Status Register */
>> +#define INT_MASK_OFFSET              0x10 /* Interrupt Mask Register */
>> +#define STATUS_OFFSET                0x14 /* Status Register */
>> +#define DMA_SRC_ADDR_OFFSET  0x18 /* DMA Source Address Register */
>> +#define DMA_DEST_ADDR_OFFSET 0x1c /* DMA Destination Address Reg */
>> +#define DMA_SRC_LEN_OFFSET   0x20 /* DMA Source Transfer Length */
>> +#define DMA_DEST_LEN_OFFSET  0x24 /* DMA Destination Transfer */
>> +#define UNLOCK_OFFSET                0x34 /* Unlock Register */
>> +#define MCTRL_OFFSET         0x80 /* Misc. Control Register */
>
> Please fix up the indenting.

Will do.
>
>> +
>> +/* Control Register Bit definitions */
>> +#define CTRL_PCFG_PROG_B_MASK        BIT(30) /* Program signal to reset FPGA */
>> +#define CTRL_PCAP_PR_MASK    BIT(27) /* Enable PCAP for PR */
>> +#define CTRL_PCAP_MODE_MASK  BIT(26) /* Enable PCAP */
>> +
>> +/* Miscellaneous Control Register bit definitions */
>> +#define MCTRL_PCAP_LPBK_MASK BIT(4) /* Internal PCAP loopback */
>> +
>> +/* Status register bit definitions */
>> +#define STATUS_PCFG_INIT_MASK        BIT(4) /* FPGA init status */
>> +
>> +/* Interrupt Status/Mask Register Bit definitions */
>> +#define IXR_DMA_DONE_MASK    BIT(13) /* DMA command done */
>> +#define IXR_D_P_DONE_MASK    BIT(12) /* DMA and PCAP cmd done */
>> +#define IXR_PCFG_DONE_MASK   BIT(2)  /* FPGA programmed */
>> +#define IXR_ERROR_FLAGS_MASK 0x00F0F860
>> +#define IXR_ALL_MASK         0xF8F7F87F
>> +
>> +/* Miscellaneous constant values */
>> +#define DMA_INVALID_ADDRESS  GENMASK(31, 0)  /* Invalid DMA address */
>> +#define UNLOCK_MASK          0x757bdf0d /* Used to unlock the device */
>> +
>> +/* Masks for controlling stuff in SLCR */
>> +#define LVL_SHFTR_DISABLE_ALL_MASK   0x0 /* Disable all Level shifters */
>> +#define LVL_SHFTR_ENABLE_PS_TO_PL    0xa /* Enable all Level shifters */
>> +#define LVL_SHFTR_ENABLE_PL_TO_PS    0xf /* Enable all Level shifters */
>> +#define FPGA_RST_ALL_MASK            0xf /* Enable global resets */
>> +#define FPGA_RST_NONE_MASK           0x0 /* Disable global resets */
>> +
>
>> +static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>> +                                 const char *buf, size_t count)
>> +{
>> +     struct zynq_fpga_priv *priv;
>> +     u32 ctrl, status;
>> +     int err;
>> +
>> +     priv = mgr->priv;
>> +
>> +     err = clk_enable(priv->clk);
>> +     if (err)
>> +             return err;
>
> You might not even need to enable/disable the clock if not doing PR.

Yeah, you're probably right.
>
>> +
>> +     /* only reset if we're not doing partial reconfig */
>> +     if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
>> +             /* assert AXI interface resets */
>> +             regmap_write(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET,
>> +                          FPGA_RST_ALL_MASK);
>> +
>> +             /* disable level shifters */
>> +             regmap_write(priv->slcr, SLCR_LVL_SHFTR_EN_OFFSET,
>> +                          LVL_SHFTR_DISABLE_ALL_MASK);
>> +             /* enable output level shifters */
>> +             regmap_write(priv->slcr, SLCR_LVL_SHFTR_EN_OFFSET,
>> +                          LVL_SHFTR_ENABLE_PS_TO_PL);
>> +
>> +             /* create a rising edge on PCFG_INIT. PCFG_INIT follows
>> +              * PCFG_PROG_B, so we need to poll it after setting PCFG_PROG_B
>> +              * to make sure the rising edge actually happens
>> +              */
>> +             ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>> +             ctrl |= CTRL_PCFG_PROG_B_MASK;
>> +
>> +             zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>> +
>> +             zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status, status &
>> +                                    STATUS_PCFG_INIT_MASK, 20, 0);
>> +
>> +             ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>> +             ctrl &= ~CTRL_PCFG_PROG_B_MASK;
>> +
>> +             zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>> +
>> +             zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status, !(status &
>> +                                    STATUS_PCFG_INIT_MASK), 20, 0);
>> +
>> +             ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>> +             ctrl |= CTRL_PCFG_PROG_B_MASK;
>> +
>> +             zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>> +
>> +             zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status, status &
>> +                                    STATUS_PCFG_INIT_MASK, 20, 0);
>> +     }
>> +
>> +     clk_disable(priv->clk);
>> +
>> +     return 0;
>> +}
>> +

Cheers & enjoy your vacation

Moritz
