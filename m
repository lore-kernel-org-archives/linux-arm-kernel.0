From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Feb 2012 18:20:20 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120227132908.GA3191@opensource.wolfsonmicro.com>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120227090453.GE26642@pengutronix.de>
 <20120227132908.GA3191@opensource.wolfsonmicro.com>
Message-ID: <20120227172020.GC3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 01:29:08PM +0000, Mark Brown wrote:
> On Mon, Feb 27, 2012 at 10:04:53AM +0100, Sascha Hauer wrote:
> 
> > If I drop the microvolts parameter what microvolts should I assume? I
> > tried 0 but the regulator core does not like it:
> 
> > machine_constraints_voltage: dummy: unsupportable voltage constraints
> 
> > (with max: -2147483648 min: 2147483647)
> 
> I'd expect zero to work, unless something wants a particular voltage in
> which case you really should be filling things in properly.  The fact
> that the fixed voltage regulator supports get_voltage() might be
> confusing things.
> 
> Like I say if people can be bothered filling voltages in I suspect
> they're not your target audience for this.

The culprit is in machine_constraints_voltage:

> 
> 	int     min_uV = INT_MAX;
>         int     max_uV = INT_MIN;
> 
> 	...
> 
> 	/* initial: [cmin..cmax] valid, [min_uV..max_uV] not */
> 	for (i = 0; i < count; i++) {
> 		int     value;
> 
> 		value = ops->list_voltage(rdev, i);
> 		if (value <= 0)
> 			continue;

list_voltage returns 0 if the fixed regulator is initialized to 0
microvolts, so...

> 
> 		/* maybe adjust [min_uV..max_uV] */
> 		if (value >= cmin && value < min_uV)
> 			min_uV = value;
> 		if (value <= cmax && value > max_uV)
> 			max_uV = value;

max_uV/min_uV are not initialized...

> 	}
> 
> 	/* final: [min_uV..max_uV] valid iff constraints valid */
> 	if (max_uV < min_uV) {
> 		rdev_err(rdev, "unsupportable voltage constraints\n");
> 		return -EINVAL;
> 	}

And we end here.

I don't know what to do here. Probably the check for value <= 0 should
be removed, but then again the description shows:

 * @list_voltage: Return one of the supported voltages, in microvolts; zero
 *      if the selector indicates a voltage that is unusable on this system;
 *      or negative errno.  Selectors range from zero to one less than
 *      regulator_desc.n_voltages.  Voltages may be reported in any order.

(I wonder if negative voltages are intentionally not supported)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
