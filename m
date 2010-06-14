From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 14 Jun 2010 07:40:11 +0200
Subject: s3c-hsotg fixes
In-Reply-To: <20100612033429.GJ3498@trinity.fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
	<006c01cb0950$6ced3630$46c7a290$%szyprowski@samsung.com>
	<20100612033429.GJ3498@trinity.fluff.org>
Message-ID: <008f01cb0b84$10f8a3b0$32e9eb10$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Saturday, June 12, 2010 5:34 AM Ben Dooks wrote:

> On Fri, Jun 11, 2010 at 12:25:26PM +0200, Marek Szyprowski wrote:
> > Hello,
> >
> > On Friday, June 11, 2010 10:21 AM Ben Dooks wrote:
> >
> > > Some further fixes for the s3c-hsotg block, as well as a repost of
> > > the missed USB phy clock setting patch which either got missed or
> > > passed over from last time.
> > >
> > > As a note, this series has a patch adding support for dedicated FIFO
> > > mode, this is in my view a fix, as when the hsotg block is compiled
> > > with dedicated fifos then each USB IN non-periodic pipe needs to be
> > > alloacted a unique TX FIFO. We have no actual data on how well the
> > > block performs when all IN TX NP FIFOs are all set to the same one,
> > > but it really should be fixed.
> >
> > This patch series improves the driver a lot. Now it is possible to get
> > CDC Ethernet gadget working on S5PV210 SoC (Samsung Aquila machine).
> > However there are still some issues left to be resolved. I've noticed
> > the following things:
> >
> > 1. CDC Ethernet gadget: there are problems after unplugging and
> > plugging the usb cable again while data is being transferred. To trigger
> > this it is enough to run 'ping host' command on the device and replug
> > the usb cable. After that no data packets are sent do the usb host
> > (checked with hardware usb analyser), although the ep0 control transfers
> > are performed correctly (device has been enumerated correctly).
> 
> Hmm, that is intereting. Maybe we broke non-ep0 fifos somehow
> 
> > 2. RNDIS Ethernet gadget: after some stress tests I get an error, which
> > causes RNDIS session to hang (what is probably a direct result of the
> > otg block reinit/reset). Here is an example log:
> 
> any particular kind of stress tests, or are you just telling it nasty
> things to upset it? will try and look into this too.

I've tested it with Windows XP SP3 host (Pentium4 2.8GHz, VIA USB 2.0 EHCI
controller) and the following script:

--->8--[killer.bat]---
:foo
ping 192.168.129.3
goto foo
--->8-----------------

192.168.129.3 is an IP address of the client system (Linux on S5PV210).

Four instances of this script was running simultaneously and a Task Manager
with Network Status tab was opened. Each time when Windows runs ping command
the RNDIS transaction is performed. So this test basically checked how the
driver would act on a flood of RNDIS transactions. Each NDIS transactions
consists of the following transfers: RNDIS Command (ep0-control in), RNDIS
notification (ep3-interrupt in) and RNDIS Response (ep0-control out). All 3
parts of RNDIS transaction must be performed correctly, otherwise Windows
host locks (it is quite easy to notice this, Network Status graph stops
scrolling). The test took about 5 minutes to trigger the issue.

The flood of RNDIS transactions happens also during normal usage, some
firewalls or anti-virus scanning tools also can cause it, so it shouldn't
be considered something really unusual.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
