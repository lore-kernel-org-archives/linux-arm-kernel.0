From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Nov 2017 11:19:16 +0000
Subject: [v11,1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <20171114111046.GA23820@kroah.com>
References: <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
 <8760aoz78q.fsf@bilbrey.org>
 <DB6PR0501MB219753AC43515148F39CC2D0B1280@DB6PR0501MB2197.eurprd05.prod.outlook.com>
 <20171114111046.GA23820@kroah.com>
Message-ID: <20171114111916.GO12318@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 12:10:46PM +0100, gregkh at linuxfoundation.org wrote:
> On Tue, Nov 14, 2017 at 10:34:49AM +0000, Oleksandr Shamray wrote:
> > Greg, what you can suggest about it. May be better to add again single-open()-per-device lock with right locking way like:
> > 
> > >if (mutex_lock_interruptible(&jtag->open_lock)) {
> 
> You would stall an open?  Why not just return saying you can't do that?

Greg, I think you need to look at the code again.

>From the snippet in the email, this lock is not held while the device is
open, as you apparently think it is.  It's a short-term lock that is
held to ensure atomic access to the jtag->opened member, so that two
concurrent opens are unable to operate lock-step, resulting in
jtag->opened becoming 2.

The open function snippet in the email drops the lock as soon as it has
incremented jtag->opened, or encounters an error.

It seems entirely sensible, rather than using an atomic_t counter, as
it means that other openers are held off until the current opener has
either succeeded in opening the device or failed to open it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
