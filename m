From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 14 Jan 2011 21:48:24 +0000
Subject: [PATCHv2] hwrng: add support for picoxcell TRNG
In-Reply-To: <v7p608-mqv.ln1@chipmunk.wormnet.eu>
References: <20110114181609.GN2822@pulham.picochip.com>
	<1295030661-16364-1-git-send-email-jamie@jamieiles.com>
	<v7p608-mqv.ln1@chipmunk.wormnet.eu>
Message-ID: <20110114214824.GO2822@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 08:45:19PM +0000, Alexander Clouter wrote:
> In gmane.linux.ports.arm.kernel Jamie Iles <jamie@jamieiles.com> wrote:
> >
> > This driver adds support for the True Random Number Generator in
> > the Picochip PC3X3 and later devices.
> > 
> > [snipped]
> >
> > +/*
> > + * Take the random number generator out of reset and make sure the interrupts
> > + * are masked. We shouldn't need to get large amounts of random bytes so just
> > + * poll the status register. The hardware generates 32 bits every 320ns so we
> > + * shouldn't have to wait long enough to warrant waiting for an IRQ.
> > + */
> >
> timeriomem-rng?  Example of usage in 
> arch/arm/mach-orion5x/ts78xx-setup.c.

No, that's not quite suitable for our hardware.  Although the hardware 
generates the data every 320ns, it also performs self test of the data 
in hardware to make sure it satisfies certain random qualities.  If the 
data doesn't pass the tests then it's rejected and not placed into the 
FIFO so we'd have the possibility of an underflow with the 
timeriomem-rng driver.

Jamie
