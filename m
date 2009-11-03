From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue, 3 Nov 2009 18:31:54 +0100
Subject: Using statically allocated memory for platform_data.
In-Reply-To: <20091102164743.GE23772@trinity.fluff.org>
References: <20091102112316.16163f6a.ospite@studenti.unina.it>
	<20091102150011.GB20341@fluff.org.uk>
	<20091102150525.GB5785@n2100.arm.linux.org.uk>
	<20091102152500.GD23772@trinity.fluff.org>
	<20091102155231.GC20341@fluff.org.uk>
	<20091102155625.GC5785@n2100.arm.linux.org.uk>
	<20091102162839.GD20341@fluff.org.uk>
	<20091102163701.GD5785@n2100.arm.linux.org.uk>
	<20091102164743.GE23772@trinity.fluff.org>
Message-ID: <20091103183154.ee6b5676.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Nov 2009 16:47:44 +0000
Ben Dooks <ben-linux@fluff.org> wrote:

> On Mon, Nov 02, 2009 at 04:37:01PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 02, 2009 at 04:28:39PM +0000, Ben Dooks wrote:
> > > On Mon, Nov 02, 2009 at 03:56:25PM +0000, Russell King - ARM Linux wrote:
> > > > The reason we have platform_device_add_data() is that people think that
> > > > the device data needs to persist for the lifetime of the device.  I
> > > > personally disagree with that - once you unregister the device, it's
> > > > guaranteed that device drivers will have been unregistered, so who's
> > > > going to use the platform data?
> > > 
> > > That doesn't make any sense, in the current case of using the
> > > platform_device_alloc() and those calls the data is only living
> > > for the lifetime of the device, as the release call is tidying up
> > > the result.
> > 
> > What I'm saying is that the lifetime of the data finishes once
> > the _unregister() call has returned.  So:
> > 
> > 	data = pdev->dev.platform_data;
> > 	platform_device_unregister(pdev);
> > 	kfree(data);
> > 
> > is an entirely valid way of handling the "I allocated my platform
> > data" problem - it doesn't need to exist to the point where the
> > device itself is freed.
> 
> Unforutnately pretty much everyone now assumes that the act of
> unregistering the device will get rid of the data that the allocated
> by the add functions.
> 
> This would mean going around fixing a number of current drivers which
> all make that assumption.
> 

So those drivers (ezx-pcap.c, da903x.c) aren't doing anything manifestly
wrong by not calling platform_device_add_data(), and the issue will be
solved in ./drivers/base/platform.c someway eventually, right?

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091103/014c463b/attachment.sig>
