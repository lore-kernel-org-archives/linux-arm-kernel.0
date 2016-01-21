From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Jan 2016 16:26:46 +0000
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
In-Reply-To: <20160121123311.5346e40d@ipc1.ka-ro>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
 <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
 <20160121123311.5346e40d@ipc1.ka-ro>
Message-ID: <20160121162646.GK6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 12:33:11PM +0100, Lothar Wa?mann wrote:
> > On Thu, Jan 21, 2016 at 11:26:11AM +0100, Lothar Wa?mann wrote:
> > > > On Thu, Jan 21, 2016 at 08:05:24AM +0100, Lothar Wa?mann wrote:
> > > > > > On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa?mann wrote:

> > > > > > > This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> > > > > > > electronics TX48 module. Make the IRQ optional in the driver and use a
> > > > > > > polling routine instead if no IRQ is specified in DT.
> > > > > > > Otherwise the driver will continuously generate interrupts and make
> > > > > > > the system unusable.

> It won't. That's the whole purpose of this patch.
> I'm afraid, I don't quite understand what you want to say...

Your commit message (quoted above) claims that without this patch if no
interrupt is supplied then the unsupplied interrupt will somehow be left
screaming and make the system unusable.  This doesn't make sense, if
there is no interrupt there is nothing to scream.

> Without this patch there will be a constantly active interrupt, which
> will stall the system because the nNMI interrupt (on the EXTINTn pin) is
> level triggered.
> Since the polarity of the interrupt input is fixed, there is no way to
> use it in our HW.

So, contrary to what you've been saying, the interrupt is actually
connected (and worse, connected to a NMI) but apparently not described
in DT.  Why is it sensible to make the driver poll (which will affect
all systems using this device, even those that don't care) and not just
describe the interrupt in DT so it can be handled promptly in the normal
fashion?  Presumably this will run into serious problems if the
interrupt actually fires at runtime since the NMI will scream, it's not
clear to me how the poll will manage to run successfully in that case.

This really feels like a very system specific workaround which is
attempting to address things in the wrong place and coming up with
something very non-obvious as a result.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/1fd8fa11/attachment-0001.sig>
