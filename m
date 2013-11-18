From: marex@denx.de (Marek Vasut)
Date: Mon, 18 Nov 2013 21:23:00 +0100
Subject: [PATCH 1/5] ahci: imx: Pull out the clock enable/disable calls
In-Reply-To: <528A60BB.4010802@boundarydevices.com>
References: <1384651251-5548-1-git-send-email-marex@denx.de>
 <528A60BB.4010802@boundarydevices.com>
Message-ID: <201311182123.00169.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Hi Marek,
> 
> On 11/16/2013 06:20 PM, Marek Vasut wrote:
> > The same code for enabling and disabling SATA clock was found in multiple
> > places in the driver. Implement functions that enable/disable the SATA
> > clock and use them in such places instead of duplicating the code.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Linux-IDE <linux-ide@vger.kernel.org>
> > ---
> > 
> >   drivers/ata/ahci_imx.c | 133
> >   ++++++++++++++++++++++++++++--------------------- 1 file changed, 75
> >   insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> > index ae2d73f..c7ee505 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -47,6 +47,73 @@ static int ahci_imx_hotplug;
> > 
> >   module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
> >   MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't support,
> >   1=support)");
> > 
> > <snip>
> 
> I haven't traced through all of this, but if you're copying from
> the Freescale 3.0.35 kernel, note that there's a bug in it, and
> the 0x7FFFFFFD really wanted to be an 0x7FFFFFFF.

I'm not taking this from FSL 3.0.35, no, but thanks for pointing this out!

> The way I read this comment, the writes need to happen in two
> steps:
> 	- write everything with the PHY disabled
> 	- enable the PHY
> 
> We had reports of stalls waiting for SATA drives to be enumerated
> that were solved with this commit...
> 
> 	https://github.com/boundarydevices/linux-
imx6/commit/0186ea224ce6bd1cb4757
> a0f83b0090e26a021f4

[...]

> > +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> > +			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> > +			IMX6Q_GPR13_SATA_MPLL_CLK_EN);

Isn't this snippet doing exactly what your patch does ?
