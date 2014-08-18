From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 18 Aug 2014 12:31:49 +0200
Subject: [PATCH/RFC V8 1/1] clk: Support for clock parents and rates
 assigned from device tree
In-Reply-To: <20140813203406.GU17528@sirena.org.uk>
References: <1403105372-30403-1-git-send-email-s.nawrocki@samsung.com>
 <1403105372-30403-2-git-send-email-s.nawrocki@samsung.com>
 <53B59221.5080100@samsung.com> <20140725214231.5177.86866@quantum>
 <20140813203406.GU17528@sirena.org.uk>
Message-ID: <53F1D615.8070707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/14 22:34, Mark Brown wrote:
> On Fri, Jul 25, 2014 at 02:42:31PM -0700, Mike Turquette wrote:
>> Quoting Sylwester Nawrocki (2014-07-03 10:25:53)
> 
>>> I would appreciate a DT, SPI or the I2C maintainer opinions.
> 
>> Yes, Acks from SPI and I2C maintainers would be good. I might need to
>> drop those parts of this patch if they don't come through :-(
> 
> So, I just noticed this.  The reason I didn't see this earlier is that
> it was buried at the end of a large clock API patch rather than a split
> out patch for the SPI subsystem so it fell towards the bottom of
> my review queue.  There seems to be no dependency on adding the feature
> as part of one commit so it should really have been split out.
> 
> Please don't assume that people are going to look in detail at patches
> that aren't obviously for them - I know I end up ignoring a lot of what
> I get sent since I get CCed on a lot of random things for no apparent
> reason (or get tediously large numbers of resends of things that are
> tangentially related), I imagine others do the same.  If you're doing
> that please draw attention to it, splitting out per subsystem is the
> best way of doing that.

OK, will try to remember and improve things in future.

> This is particularly unfortunate since I am actually a bit confused as
> to why we need to open code this for every bus rather than doing it in
> the driver core, there doesn't seem to be anything at all bus specific
> going on here.  Why can't we just call this from the driver core?

I had it done in the driver core in first versions of this patch, but
then I learnt it is not something Greg would be fond of, so I went for
this method. In fact, clocks configuration is not something which
applies to each and every device, thus putting it in the bus code might
not be that bad after all.

> Having the feature work for some buses and not others is going to get
> old fast.
> 
> It's also not clear to me why we're passing false to of_clk_set_defaults()
> when we do call it - it's quite common for I2C and SPI devices to be
> clock providers and have clock trees.  As far as I can tell the
> reasoning is that what's actually going on here is that this is actually
> a mechanism to defer the initialisation to adding of the clock providers
> in which case contrary to the documentation for the function it's
> actually about device registration.  Is that right?

The flag is there to tell if clocks supplied by a particular device should
also be configured. The function is being called with the flag set right
after a clock provider registration in the clock core, this is where the
take care of things when an (I2C, SPI, etc.) device is a clock provider.
Obviously attempting to configure clocks which were not yet registered
before a device's driver probe() call would fail. The flag is there to
defer configuration of clocks after they are actually registered with
the clk core, not only parsable from the device tree.

Documentation of the function might be indeed a bit confusing :/
I'll consider changing the sentence:

"The @clk_supplier argument
 should be set to true if @node may be also a clock supplier of any clock
 listed in its 'assigned-clocks' or 'assigned-clock-parents' properties."

to

 "The @clk_supplier argument
  should be set to true if @node is or may be a clock supplier of any
  clock listed in its 'assigned-clocks' or 'assigned-clock-parents'
  properties and such clocks are also to be configured."

--
Regards,
Sylwester
