From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 12:18:18 -0600
Subject: [PATCH v2 6/7] clk: Add initial WM831x clock driver
In-Reply-To: <20110926093858.GD2946@opensource.wolfsonmicro.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-7-git-send-email-mturquette@ti.com>
	<20110925040836.GP24631@ponder.secretlab.ca>
	<20110926093858.GD2946@opensource.wolfsonmicro.com>
Message-ID: <20111004181818.GD2870@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 10:38:58AM +0100, Mark Brown wrote:
> On Sat, Sep 24, 2011 at 10:08:36PM -0600, Grant Likely wrote:
> > On Thu, Sep 22, 2011 at 03:27:01PM -0700, Mike Turquette wrote:
> 
> > > +	ret = platform_driver_register(&wm831x_clk_driver);
> > > +	if (ret != 0)
> > > +		pr_err("Failed to register WM831x clock driver: %d\n", ret);
> > > +
> > > +	return ret;
> 
> > No need for this song-and-dance.  The driver core is pretty well
> > debugged.  Just use "return platform_driver_register(...);"
> 
> No, that's not helpful.  The issue isn't the device probe code itself,
> the issue is things like module unload not doing what they're supposed
> to do and leaving the device lying around or something - there's rather
> more going on than just the plain API call.

Then lets fix the core code.  I see this pattern show up again and
again of extra boilerplate going around
platform_driver_{register,unregister}().  That says to me that there
either needs to be a new helper, or the core code needs to be made
more verbose.

In fact, I've been considering adding a macro for
{platform,i2c,spi,...}_drivers that does all the module boilerplate
for the common case of only registering a driver at init time.
Something like:

#define module_platform_driver(__driver) \
int __driver##_init(void) \
{ \
	return platform_driver_register(&(__driver)); \
} \
module_init(__driver##_init); \
void ##__driver##_exit(void) \
{ \
	platform_driver_unregister(&(__driver)); \
} \
module_exit(##__driver##_exit);

It's not a lot of code, but I dislike how much boilerplate every
single driver has to use if it doesn't do anything special.

g.
