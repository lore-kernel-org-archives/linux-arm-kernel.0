From: dilinger@queued.net (Andres Salomon)
Date: Fri, 18 Feb 2011 09:50:29 -0800
Subject: [PATCH 16/17] mc13xxx: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110218083928.GU22310@pengutronix.de>
References: <20110211181921.3d561568@queued.net>
	<20110216094154.GV13279@pengutronix.de>
	<20110216090036.6fffed34@debxo>
	<20110218083928.GU22310@pengutronix.de>
Message-ID: <20110218095029.462e6ef3@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Feb 2011 09:39:28 +0100
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> On Wed, Feb 16, 2011 at 09:00:36AM -0800, Andres Salomon wrote:
> > On Wed, 16 Feb 2011 10:41:54 +0100
> > Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > 
> > > On Fri, Feb 11, 2011 at 06:19:21PM -0800, Andres Salomon wrote:
> > > > 
> > > > The cell's platform_data is now accessed with a helper function;
> > > > change clients to use that, and remove the now-unused data_size.
> > > > 
> > > > Note that mfd-core no longer makes a copy of platform_data, but
> > > > the
> > > why was this changed and where?  I'm not able to find your
> > > complete series via gmane.
> > 
> > http://permalink.gmane.org/gmane.linux.kernel/1099164
> I still don't get the motivation of your patch set.  For drivers that
> don't need the mfd_cells you introduce another level of indirection.
> And drivers that want to use mfd_cells as platform_data, they can
> already now.
> 
> Best regards
> Uwe
> 

The main motivation for making mfd_cell available to all was to be able
to provide functions within mfd-core (introduced in later
patches/patchsets) that accept platform devices and operate on their
mfd_cells.  The mfd_cell used to be automatically carried by the pdevs,
and I'm not entirely sure the reason for getting rid of that.  It also
(imo) cleans up a lot of things.  For example, the mfd_cell API
platform_data/driver_data stuff was unclear when I first
encountered it, as various drivers were doing things completely
differently (some incorrectly, as witnessed by some of the drivers
that I modified that were using driver_data and had clients later
calling set_drvdata on the same pdev).   This is clearer, and provides
a uniform way to do things that, afaict, sacrifices absolutely no
flexibility or functionality.  Yes, it adds some overhead by having a
copy of the mfd_cell around in memory, but if that's really an issue it
could be optimized further by not making a full copy of the mfd_cell.
With the new wrappers (mfd_get_data/mfd_get_cell), this could be done
without having to mess with drivers.
