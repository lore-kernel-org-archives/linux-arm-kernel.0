From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 May 2017 11:07:28 +0200 (CEST)
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <1381182989.263636.1493062504676@email.1und1.de>
References: <331235003.222371.1491934205807@email.1und1.de>
 <685482264.60263.1492105308873@email.1und1.de>
 <20170413222915.GF17774@n2100.armlinux.org.uk>
 <20170414074104.GA8704@laptop> <87pog7x7c5.fsf@eliezer.anholt.net>
 <20170420195822.GA22677@laptop>
 <696fb1c1-7751-caf0-e0d9-9c67b059b4cc@i2se.com>
 <20170424164015.GP17774@n2100.armlinux.org.uk>
 <1058502523.15283.1493055747531@email.1und1.de>
 <20170424185931.GQ17774@n2100.armlinux.org.uk>
 <1381182989.263636.1493062504676@email.1und1.de>
Message-ID: <952745481.440383.1494666448727@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 24. April 2017 um 21:35 geschrieben:
> 
> 
> 
> > Russell King - ARM Linux <linux@armlinux.org.uk> hat am 24. April 2017 um 20:59 geschrieben:
> > 
> > 
> > On Mon, Apr 24, 2017 at 07:42:27PM +0200, Stefan Wahren wrote:
> > > > What I can't see is how changing flush_dcache_page() has possibly broken
> > > > this: it seems to imply that you're getting flush_dcache_page() somehow
> > > > called inbetween mapping it for DMA, using it for DMA and CPU accesses
> > > > occuring.  However, the driver doesn't call flush_dcache_page() other
> > > > than through get_user_pages() - and since dma_map_sg() is used in that
> > > > path, it should be fine.
> > > > 
> > > > So, I don't have much to offer.
> > > > 
> > > > However, flush_dcache_page() is probably still a tad heavy - it currently
> > > > flushes to the point of coherency, but it's really about making sure that
> > > > the user vs kernel mappings are coherent, not about device coherency.
> > > > That's the role of the DMA API.
> > > 
> > > Currently i don't care too much about performance. More important is to
> > > fix this regression, because i'm not able to verify the function of this
> > > driver efficiently.
> > 
> > This is a driver in staging, and the reason its in staging is because it
> > has problems.  This is just another example of another problem it has...
> > Yes, the regression is regrettable, but I don't think it's something to
> > get hung up on.
> > 
> > > I'm thinking about 2 options:
> > > 
> > > 1) add a force parameter to flush_dcache_page() which make it possible
> > >    to override the new logic
> > > 2) create a second version of flush_dcache_page() with the old behavior
> > 
> > Neither, really, because, as I've already explained, flush_dcache_page()
> > has nothing what so ever to do with DMA coherence - and if a driver
> > breaks because we change its semantic slightly (but still in a compliant
> > way) then it's uncovered a latent bug in _that_ driver.
> > 
> > Rather than trying to "fix" flush_dcache_page() to work how this driver
> > wants it to (which is a totally crazy thing to propose - we can't go
> > shoe-horning driver specific behaviour into these generic flushing
> > functions), it would be much better to work out why the driver has
> > broken.
> 
> I totally agree. I had the hope we could make a workaround within the driver until we found the real issue.
> 
> > 
> > I see the kernel driver has its own logging (using vchiq_log_info() etc?)
> > maybe a starting point would be to compare the output from a working
> > kernel with a non-working kernel to get more of an idea where the problem
> > actually is?
> 
> I will try ...
> 
> > 
> > What I'm willing to do is to temporarily drop the offending patch for
> > the next merge window to give more time for this driver to be debugged,
> > but I will want to re-apply it after that merge window closes.
> 
> Since this is already in 4.11, please keep it. At least this makes it easier to reproduce. No need for more confusion and effort.
> 

In the meantime this issue has been fixed by Phil [1].

Unfortunately i found another issue. If i enable CONFIG_HIGHMEM in the kernel config, the data during functional test gets corrupted. Phil said it's caused by the usage of get_user_pages() [2]. That makes me wonder, because there are a lot of gup users and it's hard to believe that they are also affected.

Would that be hard to fix?

In that case i tend to fix at least the dependency:

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_servic
index 9e27636..6572903 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -2,7 +2,7 @@ menuconfig BCM_VIDEOCORE
        tristate "Broadcom VideoCore support"
        depends on HAS_DMA
        depends on OF
-       depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWAR
+       depends on (RASPBERRYPI_FIRMWARE && !HIGHMEM) || (COMPILE_TEST && !RASPB
        default y
        help
                Support for Broadcom VideoCore services including

Thanks
Stefan

[1] - http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2017-May/105443.html
[2] - https://github.com/raspberrypi/linux/issues/1996
