From: pza@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Jun 2014 23:16:03 +0200
Subject: [PATCH 4/4] ARM: dts: imx6qdl: Enable CODA960 VPU
In-Reply-To: <CAL_JsqL+o+CCRUzXaAmBJBGSxt60k_858S7wQT4TLY0kZC9jgw@mail.gmail.com>
References: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
 <1402679641-868-4-git-send-email-p.zabel@pengutronix.de>
 <CAL_JsqL+o+CCRUzXaAmBJBGSxt60k_858S7wQT4TLY0kZC9jgw@mail.gmail.com>
Message-ID: <20140613211603.GB29487@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 03:46:43PM -0500, Rob Herring wrote:
> On Fri, Jun 13, 2014 at 12:14 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > This patch adds links to the on-chip SRAM and reset controller nodes
> > and switches the interrupts. Make the BIT processor interrupt, which exists on
> > all variants, the first one. The JPEG unit interrupt, which does not exist on
> > i.MX27 and i.MX5 thus is an optional second interrupt.
> > Use different compatible strings for i.MX6Q/D and i.MX6S/DL, as they have to
> > load separate firmware images for some reason.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6dl.dtsi  |  4 ++++
> >  arch/arm/boot/dts/imx6q.dtsi   |  4 ++++
> >  arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++--
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> > index 5c5f574..fbbdfca 100644
> > --- a/arch/arm/boot/dts/imx6dl.dtsi
> > +++ b/arch/arm/boot/dts/imx6dl.dtsi
> > @@ -110,3 +110,7 @@
> >                       "di0_sel", "di1_sel",
> >                       "di0", "di1";
> >  };
> > +
> > +&vpu {
> > +       compatible = "fsl,imx6dl-vpu", "cnm,coda960";
> > +};
> > diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> > index addd3f8..2c1dbf8 100644
> > --- a/arch/arm/boot/dts/imx6q.dtsi
> > +++ b/arch/arm/boot/dts/imx6q.dtsi
> > @@ -291,3 +291,7 @@
> >                 };
> >         };
> >  };
> > +
> > +&vpu {
> > +       compatible = "fsl,imx6q-vpu", "cnm,coda960";
> > +};
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index eca0971..2052303 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -315,9 +315,15 @@
> >                         };
> >
> >                         vpu: vpu at 02040000 {
> > +                               compatible = "cnm,coda960";
> >                                 reg = <0x02040000 0x3c000>;
> > -                               interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>,
> > -                                            <0 12 IRQ_TYPE_LEVEL_HIGH>;
> > +                               interrupts = <0 12 IRQ_TYPE_LEVEL_HIGH>,
> > +                                            <0 3 IRQ_TYPE_LEVEL_HIGH>;
> 
> Is there an existing user? This would break things if so.

Not that I know of, there wasn't even a compatible value in this node.

There is an existing driver for coda7 that expects the first interrupt to be
the BIT processor interrupt (<0 12 ...> in this case). Today I have submitted
patches to linux-media that add support for coda9, which only works with this
change.

regards
Philipp
