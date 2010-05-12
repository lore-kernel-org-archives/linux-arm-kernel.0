From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 May 2010 13:24:59 +0100
Subject: [BUG] bug when enabling VM DEBUG
In-Reply-To: <20100512115340.GA11261@Chamillionaire.breakpoint.cc>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>
	<AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>
	<4BEA1559.9000107@gmail.com>
	<1273662639.23818.67.camel@e102109-lin.cambridge.arm.com>
	<20100512115340.GA11261@Chamillionaire.breakpoint.cc>
Message-ID: <1273667099.23818.86.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 12:53 +0100, Sebastian Andrzej Siewior wrote:
> * Catalin Marinas | 2010-05-12 12:10:39 [+0100]:
> 
> >> > --- a/drivers/ata/libata-sff.c
> >> > +++ b/drivers/ata/libata-sff.c
> >> > @@ -894,7 +894,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
> >> >                                         do_write);
> >> >          }
> >> >
> >> > -       if (!do_write)
> >> > +       if (!do_write&&  !PageSlab(page))
> >> >                  flush_dcache_page(page);
> >>
> >> I would think that check belongs inside flush_dcache_page itself, rather
> >> than forcing every driver to include it..
> >
> >Sebastian (cc'ed) reported this as well for MIPS.
> Thx. The patch above looks what I've sent a while ago. Jeff was going to
> merge it afaik.
> 
> >I think it makes sense for this check to be done in the
> >flush_dcache_page() function.
> 
> Why should flush_dcache_page() not flush pages you tell it?
> From Documentation/cachetlb.txt:
> |   NOTE: This routine need only be called for page cache pages
> |          which can potentially ever be mapped into the address
> |          space of a user process.  So for example, VFS layer code
> |          handling vfs symlinks in the page cache need not call
> |          this interface at all.
> 
> A page from slab or stack is not going to see the sky of user land and
> therefore it should not be fed into flush_dcache_page().

You are right :), so fixing the driver is the best approach.

-- 
Catalin
