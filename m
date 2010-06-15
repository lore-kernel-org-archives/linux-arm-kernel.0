From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 15 Jun 2010 13:12:55 +0200
Subject: [PATCH 2/2] ehci-mxc: bail out on transceiver problems
In-Reply-To: <20100615110333.GC2478@pengutronix.de>
References: <1276598063-3956-1-git-send-email-w.sang@pengutronix.de>
	<1276598063-3956-2-git-send-email-w.sang@pengutronix.de>
	<20100615104342.GE17833@buzzloop.caiaq.de>
	<20100615110333.GC2478@pengutronix.de>
Message-ID: <20100615111255.GG17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 01:03:33PM +0200, Wolfram Sang wrote:
> On Tue, Jun 15, 2010 at 12:43:42PM +0200, Daniel Mack wrote:
> > On Tue, Jun 15, 2010 at 12:34:23PM +0200, Wolfram Sang wrote:
> > > The old code registered the hcd even if there were no transceivers
> > > detected, leading to oopses like this if we try to probe a non-existant
> > > ULPI:
> > 
> > Hmm. I'm aware that there was a missing bail in this function, but
> > actually, I had hardware which didn't properly detect the ULPI chip but
> > still worked fine. There has been quite some discussion here about that,
> > and eventually I decided to not make this a hard error as it didn't
> > really harm.
> 
> My use case is that we have two very similar boards, one uses just the second
> host controller, the other one uses also OTG. Of course, we'd like to have just
> one kernel, so we wanted to check if probing for OTG fails gracefully enough,
> if the ULPI is not present. It did not, so this is what my patch intends to
> fix. I think, checking why your boards fail to do the init, is the cleaner way
> to go in the long run.

There's a design flaw in Freescale's MX31 reference designs which lets
the nCS pin float. And many board designers blindly copied that flaw
over to their own designs.

See

  http://marc.info/?l=linux-usb&m=125985151110906&w=4

So we might need quirks handling here.


Daniel
