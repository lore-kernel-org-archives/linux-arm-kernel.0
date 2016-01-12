From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 22:49:57 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160112180223.GA6588@sirena.org.uk>
References: <1440159857.19360.50.camel@debian.org>
 <4004455.tVDpSpUXxo@wuerfel> <20160112180223.GA6588@sirena.org.uk>
Message-ID: <4468027.N4Q71mzei0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 18:02:23 Mark Brown wrote:
> On Tue, Jan 12, 2016 at 05:29:40PM +0100, Arnd Bergmann wrote:
> > On Tuesday 12 January 2016 02:19:04 Andrew Lunn wrote:
> 
> > > When i played with this, i added a reschedule point at the end of the
> > > drivers transfer_one_message() function, to see if that would help. It
> > > did not, which is why i made a guess it has something to do with a
> > > lock.
> 
> > Can you try using usleep_range() instead of udelay()? It might also
> 
> Oh, indeed - should've thought of that!
> 
> > be worth trying what the actual delay is for each byte to see if a
> > longer sleep time would help, but I guess that time is highly
> > device specific.
> 
> I expect that the delay will depend on the clock speed of the SPI bus
> which is system dependant.  Might actually be worth checking if the bus
> is clocked excessively slowly.

Definitely worth checking, bug if we are transferring large enough amounts
of data, we will always incur a long delay even if the SPI bus is
clocked relatively fast. Doing a usleep_range() will likely make the
throughput much lower, as we will have longer times during which we
are not transferring any data here.

I see in the Armada 370 datasheet that the controller actually supports an
interrupt driven mode, which should be much better in principle than blocking
the CPU during the entire transfer. There may of course be a good reason
why the driver has never used interrupts, but it was originally introduced
in Orion5x, so maybe there was a bug that has been fixed in the meantime.

	Arnd
