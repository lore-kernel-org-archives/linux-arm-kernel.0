From: w@1wt.eu (Willy Tarreau)
Date: Wed, 3 Jul 2013 22:35:41 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130703202105.GE27003@titan.lakedaemon.net>
References: <20130702124639.GI19937@titan.lakedaemon.net>
 <20130702151407.01680d21@skate> <20130702133337.GA17110@titan.lakedaemon.net>
 <20130702153825.139a93a5@skate> <20130702134421.GC17110@titan.lakedaemon.net>
 <87obakho6d.fsf@natisbad.org> <20130702174111.GF17110@titan.lakedaemon.net>
 <87y59ows4n.fsf@natisbad.org> <20130702220936.GC10215@1wt.eu>
 <20130703202105.GE27003@titan.lakedaemon.net>
Message-ID: <20130703203541.GI16785@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 04:21:05PM -0400, Jason Cooper wrote:
> On Wed, Jul 03, 2013 at 12:09:36AM +0200, Willy Tarreau wrote:
> > Hi,
> > 
> > On Tue, Jul 02, 2013 at 11:48:08PM +0200, Arnaud Ebalard wrote:
> > > > more bummer.  Willy, mind posting what you have?
> > 
> > Attached. Usual warning "this will destroy your device etc..." comes
> > with it.
> 
> Thanks Willy!
> 
> How much effort would it be to put this pig in drivers/staging?  iirc,
> the only rule is that it has to compile...

I think we should at least get it to work again. Otherwise it's pointless
to pollute the kernel. No way to get any tester if all you get when you
load it is :

  calling drivers/mtd/nand/armada_nand.c:3227 orion_nfc_probe
  armada-nand nand.3: Initialize HAL based NFC in 8bit mode with DMA Disabled using BCH 4bit ECC
  drivers/mtd/nand/armada_nand.c:3318:orion_nfc_probe irq=105
  armada-nand: probe of nand.3 failed with error -12

Oh damn, I'm back in the code again trying to fix it now...

Also we must not put it into staging in its current shape as it
patches drivers/mtd. We must first apply Ezequiel's explanation
about the READID command to detect the ONFI flash. I don't know
how long this could take. I remember having noticed this difference
in later drivers that was not there without knowing what it was
about.

What makes me uncomfortable is that we have guys who have started
some clean work and in parallel we're doing some crap which will
discourage Marvell from reprioritizing their work. I'd rather keep
that as an out of tree patch so that nobody there claims that the
NAND driver already exists in the kernel.

Best regards,
Willy
