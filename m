From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 21:37:42 +0000
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <Pine.LNX.4.44L0.1301211459550.24224-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1301211459550.24224-100000@netrider.rowland.org>
Message-ID: <201301212137.42611.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Alan Stern wrote:
> On Mon, 21 Jan 2013, Felipe Balbi wrote:
> 
> > On Mon, Jan 21, 2013 at 05:16:06PM +0000, Arnd Bergmann wrote:
> > > In linux-3.8-rc1 it became possible to build the imx and
> > > mvebu platforms together in a single kernel, which clashes
> > > in the ehci driver.
> > > 
> > > Manjunath Goudar is already working on a patch to convert
> > > both the imx and the mvebu glue drivers (along with all
> > > the other ARM specific ones) to the new probing method,
> > > but that will be too late to fix v3.8. This patch instead
> > > adds yet another hack like the existing ones to allow
> > > the ehci driver to load both back-ends.
> 
> Pardon me for being confused.  Is this about imx and mvebu (as 
> mentioned here) or about orion and mxc (as described in the patch 
> title, the error messages below, and the patch itself)?

mxc is the old name for imx: the platform got removed, but some
of the drivers still carry the old name. Similarly, orion was
used before as the name for the superset of various Marvell platforms,
and mvebu is the superset of that and some of the newer ones.

Sorry for the confusion.

> > > Without this patch, building allyesconfig results in:
> > > 
> > > drivers/usb/host/ehci-hcd.c:1285:0: error: "PLATFORM_DRIVER" redefined
> > > drivers/usb/host/ehci-hcd.c:1255:0: note: this is the location of the previous definition
> > > In file included from drivers/usb/host/ehci-hcd.c:1254:0:
> > > drivers/usb/host/ehci-mxc.c:280:31: warning: 'ehci_mxc_driver' defined but not used
> 
> Was the point here to fix the build error or to allow the two drivers
> to coexist?  The first would be eaiser than the second.

Fixing the build error is probably the more important part here, but
we also really want this to work, since people are migrating towards
multiplatform kernels now, and mvebu/orion and imx/mxc are two of the
more important ones.

> > NAK, should be converted to the new usage of ehci library driver. Alan
> > Stern already implemented for a few drivers, help is very welcome.
> 
> Arnd, please take a look at
> 
>         http://marc.info/?l=linux-usb&amp;m=135843716515529&amp;w=2
> 
> I can't test it easily, not being set up for cross compilation.  I'm 
> waiting to hear from anybody whether it works before submitting it.
> (There's also a report of memory corruption involving a similar patch 
> for ehci-omap; it hasn't been tracked down yet.)

Your patch looks good to me, but it also seems to do some other
changes that are not required to fix the problem but could wait
for 3.9 instead. You definitely have my Ack if you are willing
to take it for 3.8 though.

Shawn or Sascha should be able to test it.

	Arnd
