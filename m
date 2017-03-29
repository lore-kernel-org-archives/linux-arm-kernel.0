From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Mar 2017 14:28:29 +0200
Subject: [RFC PATCH 2/3] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
In-Reply-To: <20170329065717.D0AF37C1EFF@relay.mailchannels.net>
References: <20170329065717.D0AF37C1EFF@relay.mailchannels.net>
Message-ID: <20170329122829.23bezwgdywigxshh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 02:57:02PM +0800, Icenowy Zheng wrote:
> > > @@ -691,6 +777,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev) 
> > >? if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF)) 
> > >? iio_map_array_unregister(indio_dev); 
> > >? 
> > > + if (info->data->gen2_ths) { 
> > > + clk_disable_unprepare(info->ths_clk); 
> > > + clk_disable_unprepare(info->ths_bus_clk); 
> > > + reset_control_deassert(info->reset); 
> > > + } 
> > > + 
> >
> > I'm not really fond of using this boolean as I don't see it being 
> > possibly reused for any other SoCs that has a GPADC or THS. 
> 
> Because you didn't care new SoCs :-)
> 
> All SoCs after H3 (A64, H5, R40) uses the same THS architecture with
> H3.

That's not really Quentin's point. His point is that having things
like flags and/or variables to identify various behaviours that might
differ from one SoC to the other usually works better when you want to
support several of them.

For example, replacing the gen2_ths by one variable with the number of
clocks, one with the number of channels, a bool to say it has a reset,
etc. definitely works better for us when Allwinner does some mix and
match between each SoC. And this happen most of the time.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170329/253ec5b8/attachment.sig>
