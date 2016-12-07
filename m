From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 07 Dec 2016 16:23:16 +0200
Subject: [PATCH v5 2/4] drm: bridge: add support for TI ths8135
In-Reply-To: <CAMpxmJX9b3UqNz_nERH-N58Yw3jkSZ1P+PjjA51x3wTC0So7mQ@mail.gmail.com>
References: <1481107365-24839-1-git-send-email-bgolaszewski@baylibre.com>
 <1481107365-24839-3-git-send-email-bgolaszewski@baylibre.com>
 <CAMpxmJX9b3UqNz_nERH-N58Yw3jkSZ1P+PjjA51x3wTC0So7mQ@mail.gmail.com>
Message-ID: <2593175.GXXQ1USl1T@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

Thank you for the patch.

On Wednesday 07 Dec 2016 11:45:11 Bartosz Golaszewski wrote:
> 2016-12-07 11:42 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> > THS8135 is a configurable video DAC. Add DT bindings for this chip and
> > use the dumb-vga-dac driver for now as no configuration is required to
> > make it work.
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> > 
> >  .../bindings/display/bridge/ti,ths8135.txt         | 52 +++++++++++++++++
> >  drivers/gpu/drm/bridge/dumb-vga-dac.c              |  1 +

You might be asked by DT maintainers to split this in two, but regardless of 
whether it's one patch or two, you can add my

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >  2 files changed, 53 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt> 
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> > b/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt new
> > file mode 100644
> > index 0000000..23cd8ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> > @@ -0,0 +1,52 @@
> > +THS8135 Video DAC
> > +-----------------
> > +
> > +This is the binding for Texas Instruments THS8135 Video DAC bridge.
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "ti,ths8135"
> > +
> > +Required nodes:
> > +
> > +This device has two video ports. Their connections are modelled using the
> > OF +graph bindings specified in
> > Documentation/devicetree/bindings/graph.txt. +
> > +- Video port 0 for RGB input
> > +- Video port 1 for VGA output
> > +
> > +Example
> > +-------
> > +
> > +vga-bridge {
> > +       compatible = "ti,ths8135";
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +
> > +       ports {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               port at 0 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0>;
> > +
> > +                       vga_bridge_in: endpoint at 0 {
> > +                               reg = <0>;
> > +                               remote-endpoint = <&lcdc_out_vga>;
> > +                       };
> > +               };
> > +
> > +               port at 1 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <1>;
> > +
> > +                       vga_bridge_out: endpoint at 0 {
> > +                               reg = <0>;
> > +                               remote-endpoint = <&vga_con_in>;
> > +                       };
> > +               };
> > +       };
> > +};
> > diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > b/drivers/gpu/drm/bridge/dumb-vga-dac.c index afec232..498fa75 100644
> > --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > @@ -204,6 +204,7 @@ static int dumb_vga_remove(struct platform_device
> > *pdev)> 
> >  static const struct of_device_id dumb_vga_match[] = {
> >  
> >         { .compatible = "dumb-vga-dac" },
> > 
> > +       { .compatible = "ti,ths8135" },
> > 
> >         {},
> >  
> >  };
> >  MODULE_DEVICE_TABLE(of, dumb_vga_match);
> > 
> > --
> > 2.9.3
> 
> + Maxime
> 
> Sorry, I forgot to include your e-mail.
> 
> Bartosz

-- 
Regards,

Laurent Pinchart
