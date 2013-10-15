From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 15 Oct 2013 13:51:11 -0600
Subject: [PATCH RESEND] PCI: mvebu - Support a bridge with no IO port
 window
In-Reply-To: <20131003140648.52734cfc@skate>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1380650281-16175-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131003140648.52734cfc@skate>
Message-ID: <20131015195111.GB30106@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 02:06:48PM +0200, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Tue,  1 Oct 2013 11:58:01 -0600, Jason Gunthorpe wrote:
> > Make pcie-io-aperture and the IO port MBUS ID in ranges optional.
> > If not provided the bridge reports to Linux that IO space mapping is
> > not supported and refuses to configure an IO mbus window.
> > 
> > This allows both complete disable (do not specify pcie-io-aperture) and
> > per-port disable (do not specify a IO target ranges entry for the port)
> > 
> > Most PCIE devices these days do not require IO support to function,
> > so having an option to disable it in the driver is useful.
> > 
> > This depends on 'bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties'
> > to work properly.
> 
> This doesn't work here, I get multiple warnings "Attempt to set IO when
> IO is disabled" :

Okay, I looked into this.

The warnings are caused by the bogus mvebu_has_ioport you noted, 
and this is also required:

        /* Are the new iobase/iolimit values invalid? */
-       if (port->bridge.iolimit < port->bridge.iobase ||
+       if (port->bridge.iolimit <= port->bridge.iobase ||
            port->bridge.iolimitupper < port->bridge.iobaseupper) {

> >  	case PCI_IO_BASE:
> > -		*value = (bridge->secondary_status << 16 |
> > -			  bridge->iolimit          <<  8 |
> > -			  bridge->iobase);
> > +		if (!mvebu_has_ioport(port))
> > +			*value = 0;
> > +		else
> > +			*value = (bridge->secondary_status << 16 |
> > +				  bridge->iolimit          <<  8 |
> > +				  bridge->iobase);
> 
> While I do understand that you're returning 0 for iolimit and iobase,
> I'm not sure why the secondary status is affected by the value of
> mvebu_has_ioport().

This is an error, of sorts. 0 is actually the correct value for 
secondary status with the current capabilities of the driver.. I'll
fix it here as you noted and send a patch to fix that up separately.

New patches in a sec..

Thanks,
Jason
