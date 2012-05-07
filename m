From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 May 2012 10:08:58 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507090127.GA2132@sirena.org.uk>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507075800.GL26481@n2100.arm.linux.org.uk>
 <20120507090127.GA2132@sirena.org.uk>
Message-ID: <20120507090858.GN26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 10:01:28AM +0100, Mark Brown wrote:
> On Mon, May 07, 2012 at 08:58:00AM +0100, Russell King - ARM Linux wrote:
> > On Mon, May 07, 2012 at 11:10:48AM +0800, Haojian Zhuang wrote:
> > > If resource region isn't requested, component devices will fail to request
> > > their resources.
> 
> > > Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> 
> > This looks wrong.
> 
> > This driver looks broken.  IO regions are for PC IO stuff, not for I2C
> > buses.  There is no resource reservation system in the kernel for
> > registers on I2C devices.
> 
> They've commonly been used for this, it's a fairly sane way for an MFD
> to communicate with its subdevices.  The fix in this series isn't good,
> though - providing a parent resource with a suitable range for all the
> device resources should do the job much more sensibly.  This isn't great
> but the infrastructure seems to do the right thing with it for now and
> it only requires a bit of reinterpretation of what IORESOURCE_IO means.

It's an abuse.  And it won't work unless PCMCIA, PCI or ISA is enabled.
This abuse must stop, and it must stop right now.  And I really don't
care about "it's commonly been used for XYZ" because it's a totally fucked
idea.

What if you have two devices both claiming IO regions at 0?  Hint: it
fails.

It's buggered beyond belief and it needs to die right now, no questions
about it.  And anyone who supports this idea needs to be...
