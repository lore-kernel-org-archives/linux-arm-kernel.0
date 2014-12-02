From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 2 Dec 2014 09:28:58 +0100
Subject: [PATCH] mtd: gpmi: properly handle bitflips in erased pages
In-Reply-To: <20141201233748.GJ21347@ld-irv-0074>
References: <1417461159-2972-1-git-send-email-boris.brezillon@free-electrons.com>
 <20141201194139.GI21347@ld-irv-0074>
 <20141201211818.4e97f2e2@bbrezillon>
 <20141201233748.GJ21347@ld-irv-0074>
Message-ID: <20141202092858.57341105@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Dec 2014 15:37:48 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> On Mon, Dec 01, 2014 at 09:18:18PM +0100, Boris Brezillon wrote:
> > On Mon, 1 Dec 2014 11:41:39 -0800 Brian Norris <computersforpeace@gmail.com> wrote:
> > > On Mon, Dec 01, 2014 at 08:12:39PM +0100, Boris Brezillon wrote:
> > > > Brian, I really like the idea of having a generic implementation for this
> > > > feature (using read_page_raw) as you suggested here [1], but this implies
> > > > having a temporary buffer to store the page read in raw mode and keep the page
> > > > read in normal (HW ECC engine eanbled) mode, and I'm not sure we want to
> > > > allocate more buffers than we already have.
> > > 
> > > Why does this require an additional buffer? If we've already noticed an
> > > ECC error, we're expected to return raw data anyway, so what's the
> > > problem with clobbering the original data with a raw version of the
> > > data?
> > 
> > Well in the GPMI particular case (and more generally all NAND
> > controllers which do not support subpage write) this is true, but if you
> > can do subpage write, then you might have a bit flip in a specific
> > chunk which is still empty, while other chunks are written and are
> > expecting standard ECC correction.
> > In this case you want to keep the 3 chunks with  standard ECC correction
> > and only one in raw mode with 'erased page bitflips' fixed.
> 
> So the problem's not really with subpage write, exactly; the problem is
> for drivers that support subpage write, we don't have a way to perform a
> raw subpage read without touching the other subpages.

Yes, that's what I was trying to explain :-), and the only solution I
see to address that is to have 2 buffers and then pick the most
appropriate data for a given chunk.
Do you think we should focus on support for "non subpage write"
controllers first, and then find an alternative for these controllers
if someone really needs it ?

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
