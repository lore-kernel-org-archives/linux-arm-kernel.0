From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Jun 2018 12:30:03 -0600
Subject: [PATCH 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
In-Reply-To: <CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com>
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
 <20180613161314.14894-2-yixun.lan@amlogic.com>
 <CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com>
Message-ID: <20180626183003.GA3019@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2018 at 12:46:59AM +0200, Martin Blumenstingl wrote:
> Hello Yixun, Hello Liang,
> 
> I have a few small comments inline below
> additionally I tried to explain the reason behind
> "amlogic,mmc-syscon", clkin0 and clkin1 so Rob (or the devicetree
> maintainers in general) can give feedback. feel free to correct me
> wherever I'm wrong or provide additional notes in case I missed
> something!
> 
> On Wed, Jun 13, 2018 at 10:17 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
> >
> > From: Liang Yang <liang.yang@amlogic.com>
> >
> > Add Amlogic NAND controller dt-bindings for Meson SoC,
> > Current this driver support GXBB/GXL/AXG platform.
> >
> > Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >  .../bindings/mtd/amlogic,meson-nand.txt       | 118 ++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> > new file mode 100644
> > index 000000000000..eac9f9433d5d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> > @@ -0,0 +1,118 @@
> > +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> > +
> > +This file documents the properties in addition to those available in
> > +the MTD NAND bindings.
> > +
> > +Required properties:
> > +- compatible : contains one of:
> > +  - "amlogic,meson-gxl-nfc"
> > +  - "amlogic,meson-axg-nfc"
> the patch description states that GXBB/GXL/AXG are supported
> shouldn't you add a compatible string for GXBB as well?
> 
> > +- clocks     :
> > +       A list of phandle + clock-specifier pairs for the clocks listed
> > +       in clock-names.
> > +
> > +- clock-names: Should contain the following:
> > +       "core" - NFC module gate clock
> > +       "clkin0" - Parent clock of internal mux
> > +       "clkin1" - Other parent clock of internal mux
> to give the devicetree maintainers some context on clkin0 and clkin1:
> 
> older SoCs (Meson8, Meson8b - not supported by this binding/driver
> yet) had a dedicated NAND clock. there neither clkin0 or clkin1 would
> be used, instead we just had a "nand" or "interface" clock (I'm not
> aware of the actual naming in Amlogic's internal datasheets)
> 
> newer SoCs do NOT have a dedicated NAND "interface" clock anymore.
> instead they are sharing the clock with the "sd_emmc_c" controller (I
> *believe* the reason for this is because sd_emmc_c and the NAND
> controller use the same pads on the SoC, pinctrl muxing controls where
> these pads are routed -> NAND and sd_emmc_c cannot be used at the same
> time, so SoC designers probably decided to re-use the clock)
> 
> unfortunately the sd_emmc_c clock is not provided by the "main" clock
> controller on these newer SoCs
> instead the clock is part of the MMC controller's register space (see
> the SD_EMMC_CLOCK register in drivers/mmc/host/meson-gx-mmc.c)
> even worse: the SD_EMMC_CLOCK contains more than just clock settings
> (bit 25 enables the SDIO interrupt, which is currently not supported
> by the meson-gx-mmc driver though)
> 
> the SD_EMMC_CLOCK register has a mux (CLK_SRC_MASK) to choose from
> clkin0 and clkin1 which are passed here
> the "amlogic,mmc-syscon" property is used to get a phandle to the
> sd_emmc_c syscon register space
> thus there is a bit of code duplication in the MMC and NAND drivers
> with this binding (because both need to configure the SD_EMMC_CLOCK
> register)

Well, that's ugly. Really, the SD controller should be modeled as a 
clock provider. But then you would have to always have a driver 
instantiated for it. Maybe you need that anyway if accessing this 
register is dependent on some other clock or reset to the module being 
enabled (which you may not hit if you only access the reg during boot)?

But if you really want to do it this way, I guess that is fine.

> > +
> > +- pins     : Select pins which NFC need.
> > +- nand_pins: Detail NAND pins information.
> > +               nand_pins: nand {
> > +                       mux {
> > +                               groups = "emmc_nand_d0",
> > +                                       "emmc_nand_d1",
> > +                                       "emmc_nand_d2",
> > +                                       "emmc_nand_d3",
> > +                                       "emmc_nand_d4",
> > +                                       "emmc_nand_d5",
> > +                                       "emmc_nand_d6",
> > +                                       "emmc_nand_d7",
> > +                                       "nand_ce0",
> > +                                       "nand_rb0",
> > +                                       "nand_ale",
> > +                                       "nand_cle",
> > +                                       "nand_wen_clk",
> > +                                       "nand_ren_wr";
> > +                               function = "nand";
> > +                       };
> > +               };
> > +
> > +- amlogic,mmc-syscon   : Required for NAND clocks, it's shared with SD/eMMC
> > +                               controller port C
> > +
> > +Optional children nodes:
> > +Children nodes represent the available nand chips.
> > +
> > +Optional properties:
> > +- meson-nand-user-mode :
> > +       only set 2 or 16 which mean the way of reading OOB bytes by NFC.
> as far as I know vendor specific properties should follow the naming
> schema "vendor,purpose"
> in this case this would be "amlogic,nand-user-mode"
> 
> maybe Rob can comment on this?

Yes.

> 
> > +- meson-nand-ran-mode :
> > +       setting 0 or 1, means disable/enable scrambler which keeps the balence
> > +       of 0 and 1
> I assume 0 and 1 are the only possible values.
> to use of_property_read_bool in the driver the property would be either:
> - (absent) = scrambler is disabled
> - amlogic,nand-enable-scrambler (without any value - also same comment
> as above for the value) = scrambler is enabled
> 
> 
> Regards
> Martin
