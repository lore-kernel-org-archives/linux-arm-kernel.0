From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Feb 2015 11:32:30 +0000
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
References: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
 <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
Message-ID: <20150210113230.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 11:55:54AM -0800, Gregory Fong wrote:
> On Fri, Feb 6, 2015 at 1:41 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> > So it looks like the lib/show_mem.c does something different
> > #ifdef CONFIG_CMA
> >         printk("%lu pages reserved\n", (reserved - totalcma_pages));
> >         printk("%lu pages cma reserved\n", totalcma_pages);
> > #else
> >         printk("%lu pages reserved\n", reserved);
> > #endif
> >
> >
> > No need to change the name, instead I'd say fix up arm to match what
> > the generic showmem is doing.
> 
> The trouble is that lib/show_mem.c and ARM's show_mem use the
> 'reserved' variable to hold different info, which was not a problem I
> was aiming to tackle here, and am not sure I understand what's going
> on well enough to do so.  But let's give it a shot:
> 
> In lib/show_mem.c, reserved is calculated by iterating over all online
> nodes, then increasing reserved by (zone->present_pages -
> zone->managed_pages).  This count includes CMA pages and so when
> reserved pages is printed it should be 'reserved' - totalcma_pages, as
> it currently is.

So, some digging is needed into why the generic version is different.
You have to remember that many of the algorithms for this kind of thing
were based on the x86 implementation, so differences like this are
probably down to ARM being annoyingly overlooked or ignored when generic
changes happen.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
