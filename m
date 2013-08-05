From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 6 Aug 2013 00:42:23 +0400
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <201308052126.08078.arnd@arndb.de>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <201308042257.58707.arnd@arndb.de>
 <20130805221631.f740b0d39de0e14e641f477c@mail.ru>
 <201308052126.08078.arnd@arndb.de>
Message-ID: <20130806004223.2764bb83ce5f254b5e4fc170@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Aug 2013 21:26:07 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 05 August 2013, Alexander Shiyan wrote:

> > > Handling them in the irqchip driver probably seemed like a logical solution
> > > when the code was initially written, but if you move that access into the
> > > device drivers, you can probably remove the irqchip driver entirely and just
> > > use the generic irqchip implementation.
> > 
> > ioremap for a whole set of CPU registers is called from map_io, so ioremap
> > returns already mapped address, that is, it's just converting physical to
> > virtual addresses.
> 
> I see, that does make things better at least.
> 
> It would be nice to change the DT binding in some way so the register
> ranges are non-overlapping, but I'm not going to insist if the other
> reviewers are ok with the small inconsistency here.
> 
> Do you have any reason for not using the syscon driver for these
> registers?

I plan to use syscon for some registers to ensure the correct sequence
of read-modify-write. For all other registers, the access to which is not
needed from the different subsystems, it does not make sense and seriously
degrade performance due to locks.

As alternative, I can completely remove clps711x_ioremap_one() and simply
duplicate ioremap() for the entire range set of registers
(without request_mem_region). The functionality of driver will remain the same.
Will it be better?

-- 
Alexander Shiyan <shc_work@mail.ru>
