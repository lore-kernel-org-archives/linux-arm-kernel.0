From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 16:50:20 +0200
Subject: [PATCH v3 11/19] clocksource: sh_mtu2: Add DT support
In-Reply-To: <1494698.bV3kBZBSPf@avalon>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <539C7FA4.9000306@cogentembedded.com> <1494698.bV3kBZBSPf@avalon>
Message-ID: <1457541.byEE42ItbZ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Monday 16 June 2014 16:40:55 Laurent Pinchart wrote:
> On Saturday 14 June 2014 21:00:20 Sergei Shtylyov wrote:
> > On 06/14/2014 08:23 PM, Laurent Pinchart wrote:
> > > Document DT bindings and parse them in the MTU2 driver.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > Tested-by: Wolfram Sang <wsa@sang-engineering.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/timer/renesas,mtu2.txt     | 40 +++++++++++++++
> > >  drivers/clocksource/sh_mtu2.c                      |  8 +++++
> > >  
> > >   2 files changed, 48 insertions(+)
> > >   create mode 100644
> > >   Documentation/devicetree/bindings/timer/renesas,mtu2.txt

[snip]

> > > diff --git a/drivers/clocksource/sh_mtu2.c
> > > b/drivers/clocksource/sh_mtu2.c
> > > index ebdf9d1..79387af 100644
> > > --- a/drivers/clocksource/sh_mtu2.c
> > > +++ b/drivers/clocksource/sh_mtu2.c
> > 
> > [...]
> > 
> > > @@ -502,11 +503,18 @@ static const struct platform_device_id
> > > sh_mtu2_id_table[] = {
> > >   };
> > >   MODULE_DEVICE_TABLE(platform, sh_mtu2_id_table);
> > > 
> > > +static const struct of_device_id sh_mtu2_of_table[] = {
> > > +	{ .compatible = "renesas,mtu2" },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sh_mtu2_of_table);
> > > +
> > >   static struct platform_driver sh_mtu2_device_driver = {
> > >   	.probe		= sh_mtu2_probe,
> > >   	.remove		= sh_mtu2_remove,
> > >   	.driver		= {
> > >   		.name	= "sh_mtu2",
> > > +		.of_match_table = of_match_ptr(sh_mtu2_of_table),
> > 
> > No need for of_match_ptr() since the table us not protected by #ifdef
> > CONFIG_OF...
> 
> I'll fix that.

I spoke too fast. On non-OF platforms memory shouldn't be wasted by the OF 
match table. I'll mark the table as __maybe_unused and keep of_match_ptr().

-- 
Regards,

Laurent Pinchart
