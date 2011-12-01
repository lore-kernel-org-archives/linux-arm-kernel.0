From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 1 Dec 2011 11:57:18 +0100
Subject: flatmem broken for nommu? [Was: Re: does non-continuous RAM
 means I need to select the sparse memory model?]
In-Reply-To: <CAOMZO5DX_ZvCOu+pqZpJ7Ni2B=qmSFCZTHnuzKt==OsBsJZH=Q@mail.gmail.com>
References: <20111129203010.GA26618@pengutronix.de>
 <CAOMZO5DX_ZvCOu+pqZpJ7Ni2B=qmSFCZTHnuzKt==OsBsJZH=Q@mail.gmail.com>
Message-ID: <20111201105718.GJ26618@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 10:39:10PM -0200, Fabio Estevam wrote:
> Hi Uwe,
> 
> 2011/11/29 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > I'm currently working on a new arch port and my current machine has RAM
> > at 0x10000000 and 0x80000000. So there is a big hole between the two
> > banks. When selecting the sparse memory model it works, but when
> > selecting flat the machine runs into a BUG in mark_bootmem() called by
> > free_unused_memmap() to free the space between the two banks.
> 
> My understanding is that you have to select ARCH_HAS_HOLES_MEMORYMODEL.
I think that is not necessary.
 
> > Is that expected (meaning I cannot use the flat model)? I currently
> > don't have another machine handy that has >1 memory back to test that.
> 
> In case you have access to a MX35PDK you can try on this board as it does have
> the memory hole.
No I havn't, but I just used a 128MB machine and changed that in the
.fixup callback to 64MB + 32MB with a 32MB hole in between and it works
fine without ARCH_HAS_HOLES_MEMORYMODEL.

I debugged the problem a bit further and one symptom is that

	struct page *mem_map

is NULL for me. That looks wrong. I guess this is just broken for nommu.
I will dig into that later today.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
