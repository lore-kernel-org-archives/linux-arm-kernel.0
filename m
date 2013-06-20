From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Jun 2013 10:07:37 +0200
Subject: [PATCH v2 7/7] drivers: bus: imx-weim: Change compatible string
 for i.MX6Q
In-Reply-To: <20130620070959.GE19896@S2101-09.ap.freescale.net>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
 <1371671678-6345-7-git-send-email-shc_work@mail.ru>
 <20130620070959.GE19896@S2101-09.ap.freescale.net>
Message-ID: <20130620080737.GO32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 03:10:01PM +0800, Shawn Guo wrote:
> On Wed, Jun 19, 2013 at 11:54:38PM +0400, Alexander Shiyan wrote:
> > This patch changes compatible string for i.MX6Q to "fsl,imx50-weim"
> > since this is a lowest CPU type with same bus.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  Documentation/devicetree/bindings/bus/imx-weim.txt | 2 +-
> >  drivers/bus/imx-weim.c                             | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> I think patches #4, #6 and #7 can just be one patch.
> 
> > diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> > index 99406e4..b134811 100644
> > --- a/Documentation/devicetree/bindings/bus/imx-weim.txt
> > +++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
> > @@ -33,7 +33,7 @@ Timing property for child nodes. It is mandatory, not optional.
> >  Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
> >  
> >  	weim: weim at 021b8000 {
> > -		compatible = "fsl,imx6q-weim";
> > +		compatible = "fsl,imx6q-weim", "fsl,imx50-weim";
> >  		reg = <0x021b8000 0x4000>;
> >  		clocks = <&clks 196>;
> >  		#address-cells = <2>;
> > diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> > index 77fa1d4..3f665f8 100644
> > --- a/drivers/bus/imx-weim.c
> > +++ b/drivers/bus/imx-weim.c
> > @@ -47,7 +47,7 @@ static const struct of_device_id weim_id_table[] = {
> >  	/* i.MX25/27/31/35 */
> >  	{ .compatible = "fsl,imx25-weim", .data = &imx25_weim_devtype, },
> >  	/* i.MX50/53/6Q */
> > -	{ .compatible = "fsl,imx6q-weim", .data = &imx50_weim_devtype, },
> > +	{ .compatible = "fsl,imx50-weim", .data = &imx50_weim_devtype, },
> 
> The compatible "fsl,imx6q-weim" already has a user on the way to 3.11.
> Changing the match table without updating the user will break it right
> away.  Also, since the series will be 3.12 material, doing this will
> result in an incompatible device tree between 3.11 and 3.12.  For this
> reason, I suggest we keep using "fsl,imx6q-weim" for matching
> imx6q/50/53 type of weim device.

How about:

+	{ .compatible = "fsl,imx6q-weim", .data = &imx50_weim_devtype, },
+	{ .compatible = "fsl,imx50-weim", .data = &imx50_weim_devtype, },

We could then change the in-kernel devicetrees how we need it without
breaking existing devicetrees.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
