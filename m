From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 2 Nov 2009 15:52:31 +0000
Subject: Using statically allocated memory for platform_data.
In-Reply-To: <20091102152500.GD23772@trinity.fluff.org>
References: <20091102112316.16163f6a.ospite@studenti.unina.it>
	<20091102150011.GB20341@fluff.org.uk>
	<20091102150525.GB5785@n2100.arm.linux.org.uk>
	<20091102152500.GD23772@trinity.fluff.org>
Message-ID: <20091102155231.GC20341@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 03:25:00PM +0000, Ben Dooks wrote:
> On Mon, Nov 02, 2009 at 03:05:25PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 02, 2009 at 03:00:11PM +0000, Ben Dooks wrote:
> > > This looks like something is freeing stuff that it did not allocate in
> > > the first place, which is IMHO bad. The call platform_device_alloc()
> > > is setting platform_device_release() as the default release function
> > > but platform_device_release() releases more than platform_device_alloc()
> > > actually created.
> > > 
> > > My view is that platform_device_alloc()'s default release shouldn't
> > > be freeing the platform data, and that using platform_device_add_data()
> > > or platform_device_add_resources() should change either the behvaiour 
> > > of platform_device_release() or it should change the pointer to a new
> > > release function.
> > 
> > That doesn't work - how do those other functions (adding) know what data
> > has also been added by other functions?  That can't work reliably.
> 
> You could wrapper platform device, and each of the add functions could
> update it, but that would assume the platform device had been allocated
> with platform_device_alloc().

Having had a look, all the current users of platform_device_add_data()
are from a platform_alloc_device() created device. 

The number of calls to platform_device_add_resources() are many, but
the ones I checked are from platform_alloc_device().

However your point being that these add calls may not be used on a
device that has been created from platform_device_alloc() is one I
overlooked.

Having a state machine that changed the release call from
platform_device_release() to say platform_device_release_resources()
or platform_device_release_all() and then platform_device_release_all()
may be another way to do it.

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
