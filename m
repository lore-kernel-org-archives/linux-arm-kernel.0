From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 17:11:02 +0000
Subject: [PATCH 1/2] ARM: sa11x0: Implement autoloading of codec and
 codec pdata for mcp bus.
In-Reply-To: <20120118152149.GI1068@n2100.arm.linux.org.uk>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
 <20120118152149.GI1068@n2100.arm.linux.org.uk>
Message-ID: <20120120171102.GA11845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 03:21:49PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 27, 2011 at 10:00:54PM +0100, Jochen Friedrich wrote:
> > +	if (mid && mid->driver_data) {
> > +		if (id != mid->driver_data) {
> > +			printk(KERN_WARNING "%s wrong ID %04x found: %04x\n",
> > +				mid->name, (unsigned int) mid->driver_data, id);
> > +			goto err_disable;
> > +		}
> > +	} else {
> > +		mid = &ucb1x00_id[1];
> > +		while (mid->driver_data) {
> > +			if (id == mid->driver_data)
> > +				break;
> > +			mid++;
> > +		}
> > +		printk(KERN_WARNING "%s ID not found: %04x\n",
> > +			ucb1x00_id[0].name, id);
> 
> Why do we need this complexity when we can detect the device from its
> ID in hardware?  This, to me, is just code for the sake of code.
> 
> I'm far from impressed by this patch, and had it not already gone in,
> I'd be NAKing it.

Right, I'm even more convinced that the above is over the top.  What
it's doing is requiring either:

(a) the autodetect option to be given, in which case we will match
    using the ID from the device
(b) use a specific option, in which case the ID must match

which is absolutely silly and completely unnecessary.  If we require the
ID to be correct from the hardware, there's absolutely no point what so
ever passing some kind of identifier in to the driver.  It just creates
an additional unnecessary reason for things to fail - in other words,
the only thing it adds is _fragility_.

And to prove the point that it's fragile, on the Assabet I get this:

ucb1x00 ID not found: 1005

and it fails to initialize - 0x1005 is a valid id for a UCB1300 device.

So clearly this code hasn't even been tested either.

Samuel, please revert this change.  It's broken and does more than what
it says in the change log.
