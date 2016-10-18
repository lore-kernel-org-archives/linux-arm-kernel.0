From: daniel@makrotopia.org (Daniel Golle)
Date: Tue, 18 Oct 2016 13:51:15 +0200
Subject: [RFC PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <c377cb60-a359-62c1-dc6b-7b0be8b8e228@baylibre.com>
References: <20161018090927.1990-1-narmstrong@baylibre.com>
 <20161018110807.GD1641@makrotopia.org>
 <c377cb60-a359-62c1-dc6b-7b0be8b8e228@baylibre.com>
Message-ID: <20161018115115.GF1641@makrotopia.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Tue, Oct 18, 2016 at 01:24:22PM +0200, Neil Armstrong wrote:
> On 10/18/2016 01:08 PM, Daniel Golle wrote:
> > Hi Neil,
> > 
> > great to see progress towards supporting OX820!
> > The NAND driver I hacked up for Kernel 4.1 and 4.4 in OpenWrt/LEDE
> > looks very similar, see
> > 
> > https://git.lede-project.org/?p=lede/dangole/staging.git;a=blob;f=target/linux/oxnas/files/drivers/mtd/nand/oxnas_nand.c;h=f5a142950e32227fee304de731e619278350a91b;hb=refs/heads/oxnas-nand
> > 
> > To me therefore this looks quite good, just one small question below.
> 
> Hi Daniel,
> 
> Yes, I work step by step, I hope to have something booting for 4.10 !
> 
> Indeed, they look identical except the part_probes[] stuff, are they necessary ?

Nah, this was dropped around kernel 4.7 from most drivers in favour of
using the default partition probes (ie. cmdline and dt) afaik.

> 
> My primary source of code was Ma Haiju's tree and OPenWRT's tree, but would some people like to push some of the openwrt driver upstream somehow ?

I was planning this somehow, but lack the resources to seriously move
forward. I've mostly been focussing on cleaning up Ma Haiju's code and
improving support for the SATA driver (ie. adding support for both
ports) and re-factoring the stmmac-based Ethernet driver to match the
current kernel driver's style.
However, I'm still using platform-specific includes (hardware.h) and
thus look forward to rebase SATA and Ethernet support on top of your
tree, as that would unluck ox820 support in multi-v6 instead of having
a platform-specific kernel.

Currently there are problems with the NAND driver failing to detect the
chip on non-PCIe platform like the PogoPlug V3 (non-Pro), MitraStar
STG-212 and probably other non-PCIe boards which I didn't check yet.
This magically happened when switching from kernel 4.1 to 4.4, I'm
bisecting this since, but the problem seems to be hidden somewhere
between the lines (ie. probe-order-related or such)...
Did you test your NAND driver on any non-PCIe boards and did it work?


For a more or less complete history of the changes I made since
branching of Ma Haijun's tree, see

https://git.lede-project.org/?p=lede/dangole/staging.git;a=history;f=target/linux/oxnas;hb=refs/heads/oxnas-nand

and for the very early history, prior to the merge into the official
OpenWrt tree, see

http://gitorious.org/openwrt-oxnas/openwrt-oxnas.git


Cheers


Daniel

> 
> Thanks,
> Neil
> 
> > 
> > Cheers
> > 
> > Daniel
> > 
> > 
> > On Tue, Oct 18, 2016 at 11:09:27AM +0200, Neil Armstrong wrote:
> >> Add NAND driver to support the Oxford Semiconductor OX820 NAND Controller.
> >> This is a simple memory mapped NAND controller with single chip select and
> >> software ECC.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  .../devicetree/bindings/mtd/oxnas-nand.txt         |  24 ++++
> >>  drivers/mtd/nand/Kconfig                           |   5 +
> >>  drivers/mtd/nand/Makefile                          |   1 +
> >>  drivers/mtd/nand/oxnas_nand.c                      | 144 +++++++++++++++++++++
> >>  4 files changed, 174 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> >>  create mode 100644 drivers/mtd/nand/oxnas_nand.c
> >>
> 
> [...]
> 
> >> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
> >> new file mode 100644
> >> index 0000000..ee402ab
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/oxnas_nand.c
> >> @@ -0,0 +1,144 @@
> >> +/*
> >> + * Oxford Semiconductor OXNAS NAND driver
> >> + *
> >> + * Heavily based on plat_nand.c :
> >> + * Author: Vitaly Wool <vitalywool@gmail.com>
> 
> Hmm, I forgot the OpenWRT and Ma Haijun copyrights here...
> 
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + */
> >> +
> >> +#include <linux/err.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/reset.h>
> >> +#include <linux/mtd/mtd.h>
> >> +#include <linux/mtd/nand.h>
> >> +#include <linux/mtd/partitions.h>
> >> +
> >> +/* nand commands */
> >> +#define NAND_CMD_ALE		BIT(18)
> >> +#define NAND_CMD_CLE		BIT(19)
> >> +#define NAND_CMD_CS		0
> >> +#define NAND_CMD_RESET		0xff
> >> +#define NAND_CMD		(NAND_CMD_CS | NAND_CMD_CLE)
> >> +#define NAND_ADDR		(NAND_CMD_CS | NAND_CMD_ALE)
> >> +#define NAND_DATA		(NAND_CMD_CS)
> >> +
> >> +struct oxnas_nand_data {
> >> +	struct nand_chip	chip;
> >> +	void __iomem		*io_base;
> > 
> > Why do you redundantly keep io_base in platform data rather than
> > just using chip.IO_ADDR_R and >chip.IO_ADDR_W?
> 
> For no reason since it's not used in oxnas_nand_cmd_ctrl...
> Will remove !
> 
> > 
> > 
> >> +	struct clk		*clk;
> >> +};
> >> +
> >> +static void oxnas_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> >> +				unsigned int ctrl)
> >> +{
> >> +	struct nand_chip *this = mtd->priv;
> >> +	unsigned long nandaddr = (unsigned long) this->IO_ADDR_W;
> >> +
> >> +	if (ctrl & NAND_CTRL_CHANGE) {
> >> +		nandaddr &= ~(NAND_CMD | NAND_ADDR);
> >> +		if (ctrl & NAND_CLE)
> >> +			nandaddr |= NAND_CMD;
> >> +		else if (ctrl & NAND_ALE)
> >> +			nandaddr |= NAND_ADDR;
> >> +		this->IO_ADDR_W = (void __iomem *) nandaddr;
> >> +	}
> >> +
> >> +	if (cmd != NAND_CMD_NONE)
> >> +		writeb(cmd, (void __iomem *) nandaddr);
> >> +}
> [...]
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
