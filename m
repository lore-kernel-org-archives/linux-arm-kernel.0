From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 14:06:22 -0300
Subject: [PATCH v3 08/15] watchdog: orion: Introduce per-compatible
 of_device_id data
In-Reply-To: <20140121163547.GB3311@roeck-us.net>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-9-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121163547.GB3311@roeck-us.net>
Message-ID: <20140122170621.GC27273@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 08:35:47AM -0800, Guenter Roeck wrote:
> On Tue, Jan 21, 2014 at 10:26:07AM -0300, Ezequiel Garcia wrote:
> > This commit adds an orion_watchdog_data structure to holda compatible-data
> 
> 	s/holda/hold/
> 

Yup.

> > information. This allows to remove the driver-wide definition and to
> > future add support for multiple compatible-strings.
> 
> Maybe "and to be able to add support for multiple compatible-strings in the
> future" ?
> 

Yes, sounds better.

[..]
> >  
> >  #define WDT_MAX_CYCLE_COUNT	0xffffffff
> >  #define WDT_IN_USE		0
> >  #define WDT_OK_TO_CLOSE		1
> >  
> While looking at the new defines below, I noticed that WDT_IN_USE and
> WDT_OK_TO_CLOSE are not used (anymore ?) and thus should be removed
> (separate patch, though).
> 

OK, let's clean this.

> > -#define WDT_RESET_OUT_EN	BIT(1)
> > +#define WDT_A370_RATIO_MASK(v)	((v) << 16)
> > +#define WDT_A370_RATIO_SHIFT	5
> > +#define WDT_A370_RATIO		(1 << WDT_A370_RATIO_SHIFT)
> > +
> > +#define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
> >  
> Those new defines are not used. They should be introduced if and when used.
> 

Hm... maybe after dozens and dozens of rebases these macros sneaked here?

[..]
> >  
> > +	match = of_match_device(orion_wdt_of_match_table, &pdev->dev);
> > +	if (!match)
> > +		/* Default legacy match */
> > +		match = &orion_wdt_of_match_table[0];
> > +
> >  	dev->wdt.info = &orion_wdt_info;
> >  	dev->wdt.ops = &orion_wdt_ops;
> >  	dev->wdt.min_timeout = 1;
> > +	dev->data = (struct orion_watchdog_data *)match->data;
> 
> match->data is a void *, so the typecast should not be needed here.
> You might want to declare 'data' to be of type
> 'const struct orion_watchdog_data *' because otherwise you loose the
> 'const' attribute of match->data (which may be the reason for the typecast ?).
> 

Done.

Thanks a lot for reviewing!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
