From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 15:13:16 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205091243.13206.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205081444.30915.arnd@arndb.de>
 <20120508153155.GW15893@opensource.wolfsonmicro.com>
 <201205091243.13206.arnd@arndb.de>
Message-ID: <20120509141316.GS3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 12:43:13PM +0000, Arnd Bergmann wrote:
> On Tuesday 08 May 2012, Mark Brown wrote:

> > The trick is allocating a bit for that flag, though I was thinking
> > earlier on we might be able to get away with carving it out of the bus
> > specific bits since I think anything using this wouldn't normally be
> > using resources for anything else except interrupts.  It does mean that
> > the resource type doesn't do the right thing though.

> Right, or we could try to kill IORESOURCE_BUS, which is hardly used
> anywhere and the users either get it wrong (bfin net2272), use it
> only in one file (acpi, broadcom-pci) or only for printing the
> contents (pnp).

Yeah, I looked at that - PCMCIA seems to be the major sticking point and
the usage there appeared totally sane, though it's possible that if I
stare at it hard enough I might convince myself that it only needs seven
bits and we can steal one.

> > That feels complicated with the subtraction there, but modulo that this
> > is roughly what's happening now.  We would I think want this to work for
> > non-regmap users too, it's not yet clear that every device with
> > registers is going to fit into regmap (though it's looking more likely
> > as things go on).

> I think the subtraction in some form is needed if you want to register
> the resources, to guarantee that they are non-conflicting. Registering
> them has the advantage that we can print them in a similar way to what
> we do for /proc/{ioports,iomem}.

It does result in the really odd situation that the number that gets
stored in the resource is the register number plus an offset.  If
anything I'd expect that the resources would be defined so you had to
add the parent base address with the child resource being the offset
within the parent resource.  Though to be honest the parent resource is
almost always going to be numbered from zero so it's not going to make
much difference most of the time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/759ff3cc/attachment.sig>
