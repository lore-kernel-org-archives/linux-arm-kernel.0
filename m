From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 1 Dec 2011 21:18:27 +0100
Subject: flatmem broken for nommu? [Was: Re: does non-continuous RAM
 means I need to select the sparse memory model?]
In-Reply-To: <4ED7A6EF.1000705@the2masters.de>
References: <20111129203010.GA26618@pengutronix.de>
 <CAOMZO5DX_ZvCOu+pqZpJ7Ni2B=qmSFCZTHnuzKt==OsBsJZH=Q@mail.gmail.com>
 <20111201105718.GJ26618@pengutronix.de>
 <20111201153933.GL26618@pengutronix.de>
 <4ED7A6EF.1000705@the2masters.de>
Message-ID: <20111201201827.GN26618@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On Thu, Dec 01, 2011 at 05:10:23PM +0100, Stefan Hellermann wrote:
> Am 01.12.2011 16:39, schrieb Uwe Kleine-K?nig:
> > The problem is that the memory for mem_map is allocated using:
> > 
> > 	map = alloc_bootmem_node_nopanic(pgdat, size);
> > 
> > without any error checking. The _nopanic was introduced by commit
> > 
> > 	8f389a99 (mm: use alloc_bootmem_node_nopanic() on really needed path)
> > 
> > I don't understand the commit's log and don't really see why it should
> > be allowed to not panic if the allocation failes here but use a NULL
> > pointer instead.
> > I put the people involved in 8f389a99 on Cc, maybe someone can comment?
> > 
> > Apart from that it seems I cannot use flatmem as is on my machine. It
> > has only 128kiB at 0x10000000 + 1MiB at 0x80000000 and needs 14MiB to hold the
> > table of "struct page"s. :-(
> > 
> > Best regards
> > Uwe
> > 
> The commit was made after an bug report from me. I have an old x86
> tablet pc with only 8Mb Ram. This machine fails early on bootup without
> this commit. I found an archived message of the bug report here:
> http://comments.gmane.org/gmane.linux.kernel/1135909
I saw that, too, but still I think that at least the last hunk in this
patch is wrong. (I didn't check the others.) For me the allocation for
mem_map failed and instead of handling the error somehow (be it a panic
or not) just using NULL isn't nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
