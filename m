From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Jan 2013 12:21:19 +0000
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <20130126134012.GE29973@lunn.ch>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126123827.GA5786@lunn.ch> <5103D103.5040409@gmail.com>
 <20130126134012.GE29973@lunn.ch>
Message-ID: <20130127122119.GF23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 02:40:12PM +0100, Andrew Lunn wrote:
> On Sat, Jan 26, 2013 at 01:50:11PM +0100, Sebastian Hesselbarth wrote:
> The code here is based on dove_legacy_clk_init(). However the change
> made by Jason is in order to make a DT device work, not an non-DT
> device.
> 
> The problem is the way the driver is getting the clock.
> 
> 	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
> 
> clk_get() then calls
> 
>                 clk = of_clk_get_by_name(dev->of_node, con_id);
> 
>  * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
>  * @np: pointer to clock consumer node
>  * @name: name of consumer's clock input, or NULL for the first clock reference
> 
> So it is looking for a clock called "0" or "1" in the node. This does
> not exist, and so it falls. Jason's change then comes into affect and
> it finds the clkdev entries added above.

This is just bollocks.  Sorry, but it is.  Yet again, people misunderstand
the clk API...

Look, the clk API is very simple, as it also is when using clkdev or OF.
Stop naming your bloody clocks individually - whenever anyone does that
it all breaks.

The API is designed to work as follows:

FIRST argument to clk_get() is the struct device.  This _SHOULD_ be used
to determine the clock or set of clocks which the device is going to use.
In other words, it is the PRIMARY key in the lookup.

SECOND argument to clk_get() identifies the CONNECTION ON THE DEVICE
passed as the first argument.  To make this point, if the device only
ever has one clock connection, convention is to pass NULL to ensure that
people do _not_ think that they can use global clock names.

So, the whole:

	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));

is absolutely ludicrous.  You already know which device it is by means of
the first argument.  You don't need to pass a "0" or a "1".  So that should
be NULL, so:

	mp->clk = clk_get(&pdev->dev, NULL);

That will get a clock from clkdev which is setup in the _matching_ tables
to correlate with the device (and a NULL connection ID _there_ too).  With
OF, I believe it will get the first clock.
