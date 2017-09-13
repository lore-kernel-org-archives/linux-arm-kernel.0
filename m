From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Wed, 13 Sep 2017 11:31:16 +0900
Subject: [PATCH v1 1/3] dt-bindings: nvmem: add description for UniPhier
 eFuse
In-Reply-To: <20170912161546.q5xr5pfdxin3qujf@rob-hp-laptop>
References: <1504221620-358-1-git-send-email-hayashibara.keiji@socionext.com>
 <1504221620-358-2-git-send-email-hayashibara.keiji@socionext.com>
 <CAK7LNASLh4vYqZhM9g2AL1uUtieviAmmWOp_Mzoj0zG=Ejz0cA@mail.gmail.com>
 <000001d32615$38e1b0c0$aaa51240$@socionext.com>
 <20170912161546.q5xr5pfdxin3qujf@rob-hp-laptop>
Message-ID: <000301d32c38$5fe8a830$1fb9f890$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

Thank you for your comment.

> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Wednesday, September 13, 2017 1:16 AM
> 
> On Tue, Sep 05, 2017 at 04:04:31PM +0900, Keiji Hayashibara wrote:
> > Hello Yamada-san,
> >
> > Thank you for your comment.
> >
> > > From: Masahiro Yamada [mailto:yamada.masahiro at socionext.com]
> > > Sent: Monday, September 4, 2017 9:56 PM
> > >
> > > 2017-09-01 8:20 GMT+09:00 Keiji Hayashibara
> > > <hayashibara.keiji@socionext.com>:
> > > > Add uniphier-efuse dt-bindings documentation.
> > > >
> > > > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> > > > ---
> > > >  .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 45
> > > ++++++++++++++++++++++
> > > >  1 file changed, 45 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> 
> > > > +Example:
> > > > +
> > > > +       soc-glue at 5f900000 {
> > > > +               compatible =
> "socionext,uniphier-ld20-soc-glue-debug",
> > > > +                            "simple-mfd";
> > > > +               #address-cells = <1>;
> > > > +               #size-cells = <1>;
> > > > +               ranges = <0x0 0x5f900000 0x2000>;
> > >
> > >
> > > IMHO, I think an empty "ranges;" will clarify the code, but it is up
> > > to your taste.
> > >
> > >
> > > > +
> > > > +               efuse {
> > > > +                       compatible = "socionext,uniphier-efuse",
> > > > +                                    "syscon";
> > >
> > >
> > > You are adding a dedicated driver for "socionext,uniphier-efuse".
> > >
> > > Then, "syscon" as well?
> > >
> >
> > Since I was using the syscon interface to implement the driver, I
> > specified "syscon". It's interface is syscon_node_to_regmap().
> >
> > I will rethink this in v2.
> >
> > >
> > >
> > > > +                       reg = <0x100 0xf00>;
> > >
> > >
> > > Not so many efuse registers exist on the SoC.
> > >
> > > reg = <0x100 0x200>; will be enough.
> > >
> > >
> > > Or if you want to be strict to the hw spec, you can write as follows:
> > >
> > >         soc-glue at 5f900000 {
> > >                compatible =
> "socionext,uniphier-ld20-soc-glue-debug";
> > >                             "simple-mfd";
> > >                #address-cells = <1>;
> > >                #size-cells = <1>;
> > >                ranges = <0x0 0x5f900000 0x2000>;
> > >
> > >                efuse at 100 {
> > >                            compatible = "socionext,uniphier-efuse";
> > >                            reg = <0x100 0x28>;
> > >                };
> > >
> > >                efuse at 200 {
> > >                            compatible = "socionext,uniphier-efuse";
> > >                            reg = <0x200 0x68>;
> > >                };
> > >        };
> > >
> > >
> > >
> > >
> > > > +                       #address-cells = <1>;
> > > > +                       #size-cells = <1>;
> > > > +
> > > > +                       /* Data cells */
> > > > +                       usb_mon: usb_mon {
> > > > +                               reg = <0x154 0xc>;
> > > > +                       };
> > >
> > >
> > > This <0x154 0xc> represents 0x5f900254 in CPU address view.
> > > (0x5f900000 + 0x100 + 0x154)
> > >
> > > So many ranges conversion, and how error-prone..
> > >
> >
> > Yes, indeed...
> > I will modify as below.
> 
> Please don't. A non-empty ranges is preferred. It limits the scope and
chance
> for errors (smaller range allows fewer possible values and limits the
> chances of having address ranges duplicated in multiple nodes). But yes,
> it does add the requirement of doing addition and/or OR operations. I
can't
> review whether the address ends up being correct either way, but having
> non-empty ranges helps enforce the other things.

I see. 
I will proceed with implementation by non-empty ranges.

Best Regards,
Keiji Hayashibara
