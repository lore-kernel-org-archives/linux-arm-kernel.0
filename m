From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 1 Dec 2011 16:39:33 +0100
Subject: flatmem broken for nommu? [Was: Re: does non-continuous RAM
 means I need to select the sparse memory model?]
In-Reply-To: <20111201105718.GJ26618@pengutronix.de>
References: <20111129203010.GA26618@pengutronix.de>
 <CAOMZO5DX_ZvCOu+pqZpJ7Ni2B=qmSFCZTHnuzKt==OsBsJZH=Q@mail.gmail.com>
 <20111201105718.GJ26618@pengutronix.de>
Message-ID: <20111201153933.GL26618@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 01, 2011 at 11:57:18AM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Nov 29, 2011 at 10:39:10PM -0200, Fabio Estevam wrote:
> > 2011/11/29 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > > Hello,
> > >
> > > I'm currently working on a new arch port and my current machine has RAM
> > > at 0x10000000 and 0x80000000. So there is a big hole between the two
> > > banks. When selecting the sparse memory model it works, but when
> > > selecting flat the machine runs into a BUG in mark_bootmem() called by
> > > free_unused_memmap() to free the space between the two banks.
> > 
> > My understanding is that you have to select ARCH_HAS_HOLES_MEMORYMODEL.
> I think that is not necessary.
>  
> > > Is that expected (meaning I cannot use the flat model)? I currently
> > > don't have another machine handy that has >1 memory back to test that.
> > 
> > In case you have access to a MX35PDK you can try on this board as it does have
> > the memory hole.
> No I havn't, but I just used a 128MB machine and changed that in the
> .fixup callback to 64MB + 32MB with a 32MB hole in between and it works
> fine without ARCH_HAS_HOLES_MEMORYMODEL.
> 
> I debugged the problem a bit further and one symptom is that
> 
> 	struct page *mem_map
> 
> is NULL for me. That looks wrong. I guess this is just broken for nommu.
> I will dig into that later today.
The problem is that the memory for mem_map is allocated using:

	map = alloc_bootmem_node_nopanic(pgdat, size);

without any error checking. The _nopanic was introduced by commit

	8f389a99 (mm: use alloc_bootmem_node_nopanic() on really needed path)

I don't understand the commit's log and don't really see why it should
be allowed to not panic if the allocation failes here but use a NULL
pointer instead.
I put the people involved in 8f389a99 on Cc, maybe someone can comment?

Apart from that it seems I cannot use flatmem as is on my machine. It
has only 128kiB at 0x10000000 + 1MiB at 0x80000000 and needs 14MiB to hold the
table of "struct page"s. :-(

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
