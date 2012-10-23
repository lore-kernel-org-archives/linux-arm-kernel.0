From: nbowler@elliptictech.com (Nick Bowler)
Date: Tue, 23 Oct 2012 16:27:03 -0400
Subject: [PATCH v2 2/4] zynq: move static peripheral mappings
In-Reply-To: <20121023162641.GG20593@beefymiracle.amer.corp.natinst.com>
References: <20121022211219.GC31538@beefymiracle.amer.corp.natinst.com>
 <201210231450.11540.arnd@arndb.de>
 <20121023162641.GG20593@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121023202703.GA16912@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-10-23 11:26 -0500, Josh Cartwright wrote:
> On Tue, Oct 23, 2012 at 02:50:11PM +0000, Arnd Bergmann wrote:
> > On Monday 22 October 2012, Josh Cartwright wrote:
> > > Shifting them up into the vmalloc region prevents the following warning,
> > > when booting a zynq qemu target with more than 512mb of RAM:
> > > 
> > >   BUG: mapping for 0xe0000000 at 0xe0000000 out of vmalloc space
> > > 
> > > In addition, it allows for reuse of these mappings when the proper
> > > drivers issue requests via ioremap().
> > > 
> > > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > 
> > This looks like a bug fix that should be backported to older kernels,
> > so it would be good to add 'Cc: stable at vger.kernel.org' below your
> > Signed-off-by.
> 
> Will-do, thanks.

Just FYI, I sent a patch to fix the same bug a while back

  https://patchwork.kernel.org/patch/1156361/

together with other patches to fix early printk on the ZC702 serial
console.  Admittedly, I dropped the ball on these as other issues
came up so I was away from the Zynq for a while.

However, I'm now getting back on the Zynq and have a bunch of patches to
make it all work on the ZC702 board.  I've respun the ZC702 early boot
fixes against newer git but they're obviously going to conflict with
this series.  Should I resend them anyway?

> > > -#define TTC0_PHYS			0xF8001000
> > > -#define TTC0_VIRT			TTC0_PHYS
> > > +#define TTC0_PHYS		0xF8001000
> > > +#define TTC0_SIZE		SZ_4K
> > > +#define TTC0_VIRT		(UART0_VIRT - TTC0_SIZE)
> > 
> > It's quite likely that this does not have to be a fixed mapping
> > any more. Just have a look at how drivers/clocksource/dw_apb_timer_of.c
> > calls of_iomap() to get the address.
> 
> Yes, this is already on my list of plans.  The in-tree TTC driver
> unfortunately doesn't yet support device tree bindings.  Are you
> comfortable waiting on the DT-ification of the TTC in a follow-up
> patchset?

I also have a DT binding for the TTC driver, I can send that.

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
