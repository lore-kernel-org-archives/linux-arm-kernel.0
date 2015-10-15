From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 22:53:16 +0200
Subject: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
In-Reply-To: <230CBA6E4B6B6B418E8730AC28E6FC7E04228DB8@DFLE11.ent.ti.com>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <5192855.p6QLDWTiVi@wuerfel>
 <230CBA6E4B6B6B418E8730AC28E6FC7E04228DB8@DFLE11.ent.ti.com>
Message-ID: <9008744.UmMoJzNEVK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 20:08:32 Kwok, WingMan wrote:
> 
> > > +#define reg_rmw(addr, value, mask) \
> > > +   __raw_writel(((__raw_readl(addr) & (~(mask))) | \
> > > +                   (value & (mask))), (addr))
> > 
> > not endian safe, and potentially racy.
> > 
> 
> will change to 
> 
> #define reg_rmw(addr, value, mask) \
>         writel(((readl(addr) & (~(mask))) | \
>                         (value & (mask))), (addr))

Ok, sounds good. Note that if any of this is performance critical,
better use readl_relaxed(), but as long as this is just for setup
code and not for data transfers, staying with readl() as you
suggest is better.

> > > +static inline void _kserdes_reset_cdr(void __iomem *sregs, int lane)
> > > +{
> > > +   /* toggle signal detect */
> > > +   _kserdes_force_signal_detect_low(sregs, lane);
> > > +   mdelay(1);
> > > +   _kserdes_force_signal_detect_high(sregs, lane);
> > > +}
> > 
> > Can you change the code so you can use msleep(1) here?
> > 
> 
> will replace delays with usleep_range()

Ok.

> > > +
> > > +   do {
> > > +           mdelay(10);
> > > +           memset(lane_down, 0, sizeof(lane_down));
> > > +
> > > +           link_up = _kserdes_check_link_status(dev, sregs,
> > > +                                                pcsr_regmap, lanes,
> > > +                                                lanes_enable,
> > > +                                                current_state, lane_down);
> > > +
> > > +           /* if we did not get link up then wait 100ms
> > > +            * before calling it again
> > > +            */
> > > +           if (link_up)
> > > +                   break;
> > > +
> > > +           for (i = 0; i < lanes; i++) {
> > > +                   if ((lanes_enable & (1 << i)) && lane_down[i])
> > > +                           dev_dbg(dev,
> > > +                                   "XGE: detected lane down on lane %d\n",
> > > +                                   i);
> > > +           }
> > > +
> > > +           if (++retries > 100)
> > > +                   return -ETIMEDOUT;
> > > +
> > > +   } while (!link_up);
> > 
> > an more importantly here. Blocking the CPU for over one second is not good.
> > 
> > Any use of mdelay() should have a comment explaining why you cannot use
> > msleep() in that instance.
> > 
> 
> will replace delays with usleep_range()

Here you have to be careful with the total runtime. Using usleep_range()
is a good idea, and you can have a particularly wide range, but then you
should changen the timeout condition from number of retries to total
elapsed time like

	unsigned long timeout = jiffies + HZ; /* 1 second maximum */
	do {
		...

		if (link_up)
			break;

		if (time_after(jiffies, timeout)
			return -ETIMEOUT;

		usleep_range(1000, 50000);
	} while (1);

	Arnd
