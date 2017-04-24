From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Apr 2017 19:59:31 +0100
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <1058502523.15283.1493055747531@email.1und1.de>
References: <331235003.222371.1491934205807@email.1und1.de>
 <685482264.60263.1492105308873@email.1und1.de>
 <20170413222915.GF17774@n2100.armlinux.org.uk>
 <20170414074104.GA8704@laptop> <87pog7x7c5.fsf@eliezer.anholt.net>
 <20170420195822.GA22677@laptop>
 <696fb1c1-7751-caf0-e0d9-9c67b059b4cc@i2se.com>
 <20170424164015.GP17774@n2100.armlinux.org.uk>
 <1058502523.15283.1493055747531@email.1und1.de>
Message-ID: <20170424185931.GQ17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 07:42:27PM +0200, Stefan Wahren wrote:
> > What I can't see is how changing flush_dcache_page() has possibly broken
> > this: it seems to imply that you're getting flush_dcache_page() somehow
> > called inbetween mapping it for DMA, using it for DMA and CPU accesses
> > occuring.  However, the driver doesn't call flush_dcache_page() other
> > than through get_user_pages() - and since dma_map_sg() is used in that
> > path, it should be fine.
> > 
> > So, I don't have much to offer.
> > 
> > However, flush_dcache_page() is probably still a tad heavy - it currently
> > flushes to the point of coherency, but it's really about making sure that
> > the user vs kernel mappings are coherent, not about device coherency.
> > That's the role of the DMA API.
> 
> Currently i don't care too much about performance. More important is to
> fix this regression, because i'm not able to verify the function of this
> driver efficiently.

This is a driver in staging, and the reason its in staging is because it
has problems.  This is just another example of another problem it has...
Yes, the regression is regrettable, but I don't think it's something to
get hung up on.

> I'm thinking about 2 options:
> 
> 1) add a force parameter to flush_dcache_page() which make it possible
>    to override the new logic
> 2) create a second version of flush_dcache_page() with the old behavior

Neither, really, because, as I've already explained, flush_dcache_page()
has nothing what so ever to do with DMA coherence - and if a driver
breaks because we change its semantic slightly (but still in a compliant
way) then it's uncovered a latent bug in _that_ driver.

Rather than trying to "fix" flush_dcache_page() to work how this driver
wants it to (which is a totally crazy thing to propose - we can't go
shoe-horning driver specific behaviour into these generic flushing
functions), it would be much better to work out why the driver has
broken.

I see the kernel driver has its own logging (using vchiq_log_info() etc?)
maybe a starting point would be to compare the output from a working
kernel with a non-working kernel to get more of an idea where the problem
actually is?

What I'm willing to do is to temporarily drop the offending patch for
the next merge window to give more time for this driver to be debugged,
but I will want to re-apply it after that merge window closes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
