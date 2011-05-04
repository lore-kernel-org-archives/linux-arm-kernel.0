From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 May 2011 15:05:21 -0600 (MDT)
Subject: [PATCH v2 04/12] Serial: OMAP: Add runtime pm support for
	omap-serial driver
In-Reply-To: <87hb9aqk53.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-5-git-send-email-govindraj.raja@ti.com>
	<87hb9aqk53.fsf@ti.com>
Message-ID: <alpine.DEB.2.00.1105041503260.30136@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

On Wed, 4 May 2011, Kevin Hilman wrote:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -189,6 +189,21 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
> >  	}
> >  }
> >  
> > +static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
> > +{
> > +	struct omap_uart_port_info *up = pdev->dev.platform_data;
> > +
> > +	/* Set or clear wake-enable bit */
> > +	if (up->wk_en && up->wk_mask) {
> > +		u32 v = __raw_readl(up->wk_en);
> > +		if (enable)
> > +			v |= up->wk_mask;
> > +		else
> > +			v &= ~up->wk_mask;
> > +		__raw_writel(v, up->wk_en);
> > +	}
> > +}

To be a little more direct: there should be no PRCM register interactions 
in the driver, absolutely none.  This stuff needs to go through 
omap_device/omap_hwmod functions if it's really needed.


- Paul
