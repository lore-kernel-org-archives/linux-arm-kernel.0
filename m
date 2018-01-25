From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 25 Jan 2018 11:09:30 +0900
Subject: [PATCH 2/4] usb: dwc3: add dwc3 glue layer for UniPhier SoCs
In-Reply-To: <87a7x3l8gr.fsf@linux.intel.com>
References: <20180124215228.ED43.4A936039@socionext.com>
 <87a7x3l8gr.fsf@linux.intel.com>
Message-ID: <20180125110929.C609.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Felipe,

On Wed, 24 Jan 2018 14:58:12 +0200 <balbi@kernel.org> wrote:

> 
> Hi,
> 
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> writes:
> > Hello Felipe,
> >
> > Thank you for your comments.
> >
> > On Tue, 23 Jan 2018 15:12:36 +0200 <balbi@kernel.org> wrote:
> >
> >> 
> >> Hi,
> >> 
> >> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> writes:
> >> > Add a specific glue layer for UniPhier SoC platform to support
> >> > USB host mode. It manages hardware operating sequences to enable multiple
> >> > clock gates and assert resets, and to prepare to use dwc3 controller
> >> > on the SoC.
> >> >
> >> > This patch also handles the physical layer that has same register space
> >> > as the glue layer, because it needs to integrate initialziation sequence
> >> > between glue and phy.
> >> >
> >> > In case of some SoCs, since some initialization values for PHY are
> >> > included in nvmem, this patch includes the way to get the values from nvmem.
> >> >
> >> > It supports PXs2 and LD20 SoCs.
> >> >
> >> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> > Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> >> > Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> >> > ---
> >> >  drivers/usb/dwc3/Kconfig         |   9 +
> >> >  drivers/usb/dwc3/Makefile        |   1 +
> >> >  drivers/usb/dwc3/dwc3-uniphier.c | 554 +++++++++++++++++++++++++++++++++++++++
> >> >  3 files changed, 564 insertions(+)
> >> >  create mode 100644 drivers/usb/dwc3/dwc3-uniphier.c
> >
> > ...snip...
> >
> >> > +
> >> > +static void dwc3u_ssphy_testio_write(struct dwc3u_priv *priv, int port,
> >> > +				     u32 data)
> >> 
> >> anything with sshphy or hsphy in the name should probably be part of a
> >> PHY driver using drivers/phy/ framework.
> >
> > I can try to separate phy control from this driver.
> > However, phy registers belongs to "dwc3-glue" IO map area (65b00000),
> > and this area also contains a reset bit for "dwc3-core" hardware.
> >
> > Although the phy driver is called from dwc3-core driver,
> > we need to deassert the reset bit before probing dwc3-core driver.
> >
> > As shown later, I think that it's difficut to determine the order of
> > initializing the registers in this area.
> >
> >> > +static void dwc3u_vbus_disable(struct dwc3u_priv *priv)
> >> > +{
> >> > +	int i;
> >> > +
> >> > +	for (i = 0; i < priv->nvbus; i++) {
> >> > +		dwc3u_maskwrite(priv, VBUS_CONTROL(i),
> >> > +				DRVVBUS_REG_EN | DRVVBUS_REG,
> >> > +				DRVVBUS_REG_EN | 0);
> >> > +	}
> >> > +}
> >> 
> >> drivers/regulator maybe?
> >
> > VBUS_CONTROL register is used for determing whether "dwc3-glue" hardware
> > enables vbus connected with "regulator" hardware.
> >
> > The regulator driver should manage "regulator" hardware, and
> > I don't think that the driver should manage this register.
> >
> >> > +static void dwc3u_reset_init(struct dwc3u_priv *priv)
> >> > +{
> >> > +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
> >> > +	usleep_range(1000, 2000);
> >> > +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, LINK_RESET);
> >> > +}
> >> > +
> >> > +static void dwc3u_reset_clear(struct dwc3u_priv *priv)
> >> > +{
> >> > +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
> >> > +}
> >> 
> >> drivers/reset ?
> >
> > The reset driver manages "sysctrl" IO map area in our SoC.
> >
> > RESET_CTL register belongs to "dwc3-glue" IO map area,
> > and the kernel can't access this area until enabling usb clocks and
> > deasserting usb resets in "sysctrl".
> >
> > I think that "dwc3-glue" register control should be separated from
> > "sysctrl".
> 
> Just split your address space and treat your glue as a device with
> several children:
> 
> glue at 65b00000 {
> 	compatible = "foo"

Just to confirm, instead of SoC-specific glue driver, dwc3-of-simple.c
should handle compatible "foo", right?

> 
> 	phy at bar {
>         	...
> 	};
> 
> 	sysctrl at baz {
>         	...
> 	};
> 
> 	dwc3 at foo {
>         	compatible = "snps, dwc3";
>                 ...
> 	};
> };
> 
> Then you know that you can let dwc3/core.c handle the PHY for you. If we
> need to teach dwc3/core.c about regulators, we can do that. But we don't
> need SoC-specific hacks ;-)

I also don't think that dwc3/core.c should have any SoC-specific controls.
I've thought the SoC-specific glue driver (dwc3-***.c) calls "clocks",
"resets", and "regulators".

However, although dwc3-of-simple.c can handle "clocks", it can't handle
"resets" and "regulators". Who should call them?

Thank you,

---
Best Regards,
Kunihiko Hayashi
