From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 24 May 2010 17:44:29 +0200
Subject: [PATCH 01/20] mtd: pxa3xx_nand: refuse the flash definition
	get from platform
In-Reply-To: <AANLkTil1mq5FBePSexz80DyT80DGqshqyJEi6Pfp0kV7@mail.gmail.com>
References: <AANLkTinVBXhT77Zd-LNpufgJAl7WZdic0oxDFwvNkvJg@mail.gmail.com>
	<4BFA2B5B.4080105@compulab.co.il>
	<AANLkTilLYFVPcel-rE8RbuTWEir4RJOBqmyxirb6Vozn@mail.gmail.com>
	<4BFA5C58.7050109@compulab.co.il>
	<AANLkTimYwQa5aJ2wuuBvPQ6O6hgYKaQcCcb3jwTcgFcD@mail.gmail.com>
	<4BFA7D60.6020703@compulab.co.il>
	<AANLkTil1mq5FBePSexz80DyT80DGqshqyJEi6Pfp0kV7@mail.gmail.com>
Message-ID: <20100524154429.GM30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 09:40:57PM +0800, Lei Wen wrote:
> On Mon, May 24, 2010 at 9:21 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> > Currently pxa3xx-nand has three operational modes:
> > - use NAND parameters supplied by the platform
> > - use presets configured by the bootloader chain
> > - use built-in NAND parameters, marked as deprecated in favor of the first
> > two
> > You remove the first two modes completely and require that each and every
> > NAND chip used on pxa3xx based platform will be added to the driver. This
> > way you make the driver less robust and harder to use for platform
> > developers, not mentioning you're breaking the existing platforms.
> > In my opinion, the driver *may* support built-in definitions for certain
> > NAND flashes and *must* support configuration of the NAND parameters by the
> > platform code and bootloader.
> >
> 
> Hi Mike,
> 
> Well... I would submit another patch set which would reserve a way
> that platform could pass its parameter setting.
> Like specify the certain type of nand chip parameter for each chip
> select. Is that ok for you?
> 
> For bootloader pass parameter method, I think this way should be
> dropped... For there is attributed which we could not tell from
> registers...

No, please don't drop this, as critical procedures in production lines
depend on this. Think about replacing a certain type of NAND chip in the
middle of a production. You would probably need to update the bootloader
for that in order to make the PXA boot from NAND. That's bad enough.

In the current system, you're done by just providing a bootloader which
sets up the NAND correctly. If you deprecate that way, the kernel would
also need an update, for actually no good reason, as all necessary
settings have already been cared for earlier. While that's not the end
of the world, it's still extra work that can be avoided.

I still haven't got your point for removing this feature. Why not leave
it in?

Daniel
