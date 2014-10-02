From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 02 Oct 2014 16:41:29 +0200
Subject: [PATCH v2 3/4] dt-bindings: Add pinctrl bindings for
 mt65xx/mt81xx.
In-Reply-To: <CACRpkdbiKSvX2dipnq3oyc6YSGWFgCk69onzF=-B9UWLjAYNWQ@mail.gmail.com>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-4-git-send-email-srv_hongzhou.yang@mediatek.com>
 <CACRpkdbiKSvX2dipnq3oyc6YSGWFgCk69onzF=-B9UWLjAYNWQ@mail.gmail.com>
Message-ID: <1412260889.4875.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 02.10.2014, 16:00 +0200 schrieb Linus Walleij:
> On Tue, Sep 23, 2014 at 5:39 AM, Hongzhou.Yang
> <srv_hongzhou.yang@mediatek.com> wrote:
> 
> > From: Hongzhou Yang <hongzhou.yang@mediatek.com>
> >
> > Add devicetree bindings for Mediatek SoC pinctrl driver.
> >
> > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> 
> I have worked on generic pin control bindings a bit because it
> is getting out of hand with all these custom bindings.
> 
> See:
> http://marc.info/?l=devicetree&m=141223584006648&w=2
> 
> Especially.
> 
> > +- mediatek,pinfunc: List of gpio number and function to mux.
> 
> A "GPIO number" and a "pin number" is not the same thing at all,
> this is very confusing. Those are two separate number spaces.
> This is likely about the pin numbers.
> 
> > +The mediatek,pinfunc can use defines directly,
> > +which are already defind in boot/dts/mt8135-pinfunc.h.
> > +
> > +Optional subnode-properties:
> > +- generic pin configuration option to use, bias-disable, bias-pull-down,
> > +  bias-pull,up, output-low and output-high are valid.
> > +  Example :
> > +       i2c0_pins_a {
> > +               mediatek,pinfunc = <MT8135_PIN_195_SDA1__FUNC_SDA1>;
> > +               bias-disable;
> > +       };
> 
> I don't like this approach at all.
> 
> I prefer that pins are put into groups named by strings, like "i2c0-pos0"
> inside the driver and then connected to function with a certain
> device-related name, such as "i2c0".
> 
So we should create artificial software groups where there are none in
hardware? This sounds really backward to me. Almost every new SoC out
there has the ability to mux every pin on it's own.

By defining artificial software groups in the driver we are pushing
constraints in the binding that don't really exist in hardware. So if
someone comes up with a pin usage that isn't covered by the existing
groups we need to change the binding. Experience from working with lots
of hardware engineers tells us that if something can be done (if there
are no constraints in HW) it will be done sooner or later.
If the hardware allows this much freedom we should also allow it in the
pinctrl binding.

> Then put the pin configuration (bias etc) in a separate node in the same
> state definition like that:
> 
> i2c0_pins_a {
>          function = "i2c0";
>          groups = "i2c0-pos0";
> };
> i2c0_pins_b {
>          bias-disable;
> };

The problem with that is that different pins might need different
configuration for the same muxed function. To properly reflect this we
would need to duplicate the pin definitions. One popular example is the
MMC interface where part of the pins need to have a pull-up, while
others don't. How would you reflect this with the DT description above?

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
