From: mgorman@suse.de (Mel Gorman)
Date: Wed, 25 Mar 2015 11:49:45 +0000
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
References: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
 <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
 <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
Message-ID: <20150325114945.GK4701@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 02:08:12AM -0700, Gregory Fong wrote:
> Hello,
> 
> On Tue, Feb 10, 2015 at 3:32 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Feb 09, 2015 at 11:55:54AM -0800, Gregory Fong wrote:
> >> On Fri, Feb 6, 2015 at 1:41 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> >> > So it looks like the lib/show_mem.c does something different
> >> > #ifdef CONFIG_CMA
> >> >         printk("%lu pages reserved\n", (reserved - totalcma_pages));
> >> >         printk("%lu pages cma reserved\n", totalcma_pages);
> >> > #else
> >> >         printk("%lu pages reserved\n", reserved);
> >> > #endif
> >> >
> >> >
> >> > No need to change the name, instead I'd say fix up arm to match what
> >> > the generic showmem is doing.
> >>
> >> The trouble is that lib/show_mem.c and ARM's show_mem use the
> >> 'reserved' variable to hold different info, which was not a problem I
> >> was aiming to tackle here, and am not sure I understand what's going
> >> on well enough to do so.  But let's give it a shot:
> >>
> >> In lib/show_mem.c, reserved is calculated by iterating over all online
> >> nodes, then increasing reserved by (zone->present_pages -
> >> zone->managed_pages).  This count includes CMA pages and so when
> >> reserved pages is printed it should be 'reserved' - totalcma_pages, as
> >> it currently is.
> >
> > So, some digging is needed into why the generic version is different.
> > You have to remember that many of the algorithms for this kind of thing
> > were based on the x86 implementation, so differences like this are
> > probably down to ARM being annoyingly overlooked or ignored when generic
> > changes happen.
> >
> 
> Revisiting this finally, it looks like this was changed by Mel about a
> year and a half ago in commit c78e93630d15b5f5774213aad9bdc9f52473a89b
> "mm: do not walk all of system memory during show_mem"[1], which
> removes the pfn walk and gets this info from struct zone instead,
> saving a lot of time.  Is there any reason to not to change the ARM
> show_mem to do this as well?

I did not read through this thread and only see this mail but AFAIK,
the same change should be safe on ARM. I simply had no means of testing
ARM changes and the problem only affected large machines. For all I knew,
ARM developers really cared about the accuracy of this information so I
played it safe.

-- 
Mel Gorman
SUSE Labs
