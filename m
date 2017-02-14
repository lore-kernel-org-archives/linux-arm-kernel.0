From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 14 Feb 2017 17:31:59 +0100
Subject: [PATCH v2] reset: Add i.MX7 SRC reset driver
In-Reply-To: <CAHQ1cqFXiu03902jWLkg8X6jdQ3+TiLj02dSDFBAVH98ABo70A@mail.gmail.com>
References: <20170213153338.13518-1-andrew.smirnov@gmail.com>
 <1487004643.2873.97.camel@pengutronix.de>
 <CAHQ1cqFXiu03902jWLkg8X6jdQ3+TiLj02dSDFBAVH98ABo70A@mail.gmail.com>
Message-ID: <1487089919.2305.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-02-14 at 07:46 -0800, Andrey Smirnov wrote:
[...]
> >> +enum imx7_src_registers {
> >> +     SRC_PCIEPHY_RCR = 0x002c,
> >> +     SRC_PCIEPHY_RCR_PCIEPHY_G_RST     = BIT(1),
> >
> > What about the others resets? There's at least HSICPHY, MIPIPHY and
> > USBOPHY registers before the PCIEPHY register.
> 
> I don't really have any code using anything but PCI reset related
> functionality, so I can't test any of the resets you mention. In light
> of that I didn't want to add any of the definitions that are not going
> to be used anywhere in the code.

Since the device tree bindings are supposed to be descriptive of the
hardware, not of the development history of the linux driver, I'd like
the reset controls to be in a sensible order. From a quick scan of the
chapter in the reference manual, this is the complete list of resets:

A7_CORE_POR_RESET0
A7_CORE_POR_RESET1
A7_CORE_RESET0
A7_CORE_RESET1
A7_DBG_RESET0
A7_DBG_RESET1
A7_ETM_RESET0
A7_ETM_RESET1
A7_SOC_DBG_RESET
A7_L2RESET
SW_M4C_RST
SW_M4P_RST
EIM_RST
HSICPHY_PORT_RST
HSIC_PHY_POR (or Reserved, the manual is conflicted about this)
USBPHY1_POR
USBPHY1_PORT_RST
USBPHY2_POR
USBPHY2_PORT_RST
MIPI_PHY_MRST
MIPI_PHY_SRST
PCIEPHY_G_RST
PCIEPHY_BTN
PCIEPHY_PERST
PCIE_CTRL_APPS_RST/EN

Arguably, the A7 resets should not be handled by the peripheral reset
controller, but at least for the others I see no reason not to leave
space for them in the index table. In fact, since unused reset controls
don't use space, why not number them all?

> >
> >> +     SRC_PCIEPHY_RCR_PCIEPHY_BTN       = BIT(2),
> >> +     SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN = BIT(6),
> >
> > Are those really resets? At least the PCIE_CTRL_APPS_EN has a bit called
> > PCIE_CTRL_APPS_RST right next to it, so this warrants some explanation.
>
> Public documentation for that aspect of i.MX7 is nonexistent and,
> unfortunately, that is my only source of information. Given that, I
> can't really tell you what the difference between PCIE_CTRL_APPS_EN
> and PCIE_CTRL_APPS_RST besides that the former is what downstream PCIe
> driver uses to inhibit LTSSM and the latter is not referenced or used
> by any code (as far as I am aware).

Ok. That's unfortunate, but nothing we can do about that.
After discussing with Lucas, I've come to the belief that APPS_EN stops
the LTSSM, whereas APPS_RST might reset it into the initial state. Since
the latter doesn't exist at all on i.MX6, and we can obviously live
without it, I'm fine with just calling the enable bit an active low
reset to hold it in place. It doesn't fit perfectly, but probably better
to put it here than building i.MX7 specific fabric code around the DW
PCIe driver.

[...]
> >> +             regmap_update_bits(imx7src->regmap,
> >> +                                SRC_PCIEPHY_RCR,
> >> +                                SRC_PCIEPHY_RCR_PCIEPHY_BTN,
> >> +                                SRC_PCIEPHY_RCR_PCIEPHY_BTN);
> >
> > What is the PCIE PHY button, and why does it have to be set with the
> > reset bit?
> 
> I am sorry, but just as above, I wouldn't be able to enlighten you any
> more about the subject. I have no knowledge about the details of G_RST
> and BTN signal (or even if BTN stands for "button") behavior beyond
> the fact that that is how downstream driver performs PCIEPHY reset.

The SRC_PCIEPHY_RCR register documentation in the i.MX 7Dual
Applications Processor Reference Manual v0.1 describes this bit as "PCIE
PHY button".

[...]
> >> +#define IMX7_RESET_PCIE_CTRL_APPS    0
> >> +#define IMX7_RESET_PCIEPHY           1
> >
> > It would expect these to be numbered in the order they appear in the
> > register map, not starting from the end. Could you add all available
> > peripheral resets to this list, in the correct order?
> 
> The numbering is just a consequence of me adding only resets I could
> exercise with my code and numbering then starting from zero. I also
> was hesitant adding more sources since it seemed to me that some of
> less trivial registers in that IP block might be best represented as a
> single reset source doing something more sophisticated that just
> setting a bit under the hood.

Any in particular?

regards
Philipp
