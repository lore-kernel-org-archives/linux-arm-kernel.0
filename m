From: coelho@ti.com (Luciano Coelho)
Date: Wed, 31 Jul 2013 02:04:26 +0300
Subject: [PATCH v4 6/8] wlcore: sdio: add wilink clock providers
In-Reply-To: <20130730223535.5270.39864@quantum>
References: <1375189476-21557-1-git-send-email-coelho@ti.com>
 <1375189476-21557-7-git-send-email-coelho@ti.com>
 <20130730223535.5270.39864@quantum>
Message-ID: <1375225466.30009.7.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-30 at 15:35 -0700, Mike Turquette wrote:
> Quoting Luciano Coelho (2013-07-30 06:04:34)
> > +static const struct of_device_id wlcore_sdio_of_clk_match_table[] = {
> > +       { .compatible = "ti,wilink-clock" },
> > +};
> > +
> >  static struct wl12xx_platform_data *wlcore_get_pdata_from_of(struct device *dev)
> >  {
> >         struct wl12xx_platform_data *pdata;
> >         struct device_node *np = dev->of_node;
> > +       struct device_node *clock_node;
> >  
> >         if (!np) {
> >                 np = of_find_matching_node(NULL, dev->driver->of_match_table);
> > @@ -241,6 +247,9 @@ static struct wl12xx_platform_data *wlcore_get_pdata_from_of(struct device *dev)
> >                 goto out_free;
> >         }
> >  
> > +       for_each_matching_node(clock_node, wlcore_sdio_of_clk_match_table)
> > +               of_fixed_clk_setup(clock_node);
> 
> Hi Luciano,

Hi Mike,


> Any reason for establishing your own compatible string if you just plan
> to use the fixed rate clock? You could just use "fixed-clock" compatible
> in your DTS.

The reason is that I can't call of_clk_init(), because this function is
not exported and my module can't use it.  I would have to link with the
clk code to be able to call it.

Also, I reckoned that, since these clock cannot be used by anyone else
than the WiLink module itself, it would make sense to have a different
compatible string.


> I will be posting patches this week which makes the fixed-rate clock a
> proper driver and matches that compatible string to instantiate those
> clocks. That means that your driver could probably remove the clock
> setup code completely.

Okay, if this is done, then I could probably use "fixed-clock" directly,
since the driver itself will take care of going through the DT and
initializing all the fixed-clocks.

--
Luca.
