From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Tue, 14 Nov 2017 12:10:46 +0100
Subject: [v11,1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <DB6PR0501MB219753AC43515148F39CC2D0B1280@DB6PR0501MB2197.eurprd05.prod.outlook.com>
References: <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
 <8760aoz78q.fsf@bilbrey.org>
 <DB6PR0501MB219753AC43515148F39CC2D0B1280@DB6PR0501MB2197.eurprd05.prod.outlook.com>
Message-ID: <20171114111046.GA23820@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 10:34:49AM +0000, Oleksandr Shamray wrote:
> > -----Original Message-----
> > From: Chip Bilbrey [mailto:chip at bilbrey.org]
> > Sent: Monday, November 6, 2017 12:33 AM
> > To: Oleksandr Shamray <oleksandrs@mellanox.com>
> > Cc: gregkh at linuxfoundation.org; arnd at arndb.de; linux-
> > kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > devicetree at vger.kernel.org; openbmc at lists.ozlabs.org; joel at jms.id.au;
> > jiri at resnulli.us; tklauser at distanz.ch; linux-serial at vger.kernel.org;
> > mec at shout.net; Vadim Pasternak <vadimp@mellanox.com>; system-sw-low-
> > level <system-sw-low-level@mellanox.com>; robh+dt at kernel.org; openocd-
> > devel-owner at lists.sourceforge.net; linux-api at vger.kernel.org;
> > davem at davemloft.net; mchehab at kernel.org; Jiri Pirko <jiri@mellanox.com>
> > Subject: Re: [v11,1/4] drivers: jtag: Add JTAG core driver
> > 
> > 
> > Oleksandr Shamray writes:
> 
> [..]
> 
> > I notice the single-open()-per-device lock was dropped by request in an earlier
> > revision of your patches, but multiple processes trying to drive a single JTAG
> > master could wreak serious havoc if transactions get interleaved. Would
> > something like an added JTAG_LOCKCHAIN/UNLOCKCHAIN
> > ioctl() for exclusive client access be reasonable to prevent this?
> > 
> 
> Yes, it dropped by recommendation of Greg KH <gregkh@linuxfoundation.org>. 

I asked to drop it as you didn't even implement it to work correctly :)

> Greg, what you can suggest about it. May be better to add again single-open()-per-device lock with right locking way like:
> 
> >if (mutex_lock_interruptible(&jtag->open_lock)) {

You would stall an open?  Why not just return saying you can't do that?

Anyway, if you want to only have one access to the device at a time,
great, but do it in a way that works properly.

thanks,

greg k-h
