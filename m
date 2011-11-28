From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 28 Nov 2011 10:07:31 +0000
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <20111128100219.GH17668@pengutronix.de>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111117141706.GI4748@arm.com>
 <20111120112809.GZ30612@pengutronix.de>
 <20111121183545.GF3272@arm.com>
 <20111128092217.GG17668@pengutronix.de>
 <20111128094502.GA1121@arm.com>
 <20111128100219.GH17668@pengutronix.de>
Message-ID: <20111128100731.GB1121@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 10:02:19AM +0000, Uwe Kleine-K?nig wrote:
> On Mon, Nov 28, 2011 at 09:45:03AM +0000, Catalin Marinas wrote:
> > On Mon, Nov 28, 2011 at 09:22:17AM +0000, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > On Mon, Nov 21, 2011 at 06:35:45PM +0000, Catalin Marinas wrote:
> > > > On Sun, Nov 20, 2011 at 11:28:09AM +0000, Uwe Kleine-K?nig wrote:
> > > > > On Thu, Nov 17, 2011 at 02:17:06PM +0000, Catalin Marinas wrote:
> > > > > > On Thu, Nov 17, 2011 at 01:40:00PM +0000, Uwe Kleine-K?nig wrote:
> > > > > > > The linker places the unwind tables in readonly sections. So when using
> > > > > > > an XIP kernel these are located in ROM and cannot be modified.
> > > > > > > 
> > > > > > > For that reason don't convert the symbol addresses during boot (or
> > > > > > > module loading) but only when interpreting them in search_index().
> > > > > > > Moreover several consts are added to catch future writes and rename the
> > > > > > > member "addr" of struct unwind_idx to "addr_offset" to better match the
> > > > > > > new semantic.
> > > > > > > 
> > > > > > > This fixes unwinding on XIP which compared prel31 offsets to absolute
> > > > > > > addresses because the initial conversion from prel31 to absolute failed.
> > > > > > 
> > > > > > My only worry - does this increase the index search by doing the prel31
> > > > > > conversion every time? It could affect tools like lockdep that need to
> > > > > > get the backtrace regularly at run-time.
> > > > > I did a first test now using 
> > > > > 
> > > > > 	static int __init unwind_test(void)
> > > > 
> > > > With your latest patch, have you tried dropping __init from this
> > > > function? Since the .init.text section goes after the unwind_idx tables,
> > > > all the prel31 offsets are positive and the number of init functions is
> > > > smaller than the run-time ones.
> > > Yeah, it works fine. In fact unwinding unwind_test yields:
> > > 
> > > 	do_one_initcall+0x50/0x158
> > > 	kernel_init+0x78/0x120
> > > 	kernel_thread_exit+0x0/0x8
> > > 
> > > where kernel_thread_exit is not in .init.text, too.
> > > 
> > > I don't know why you asked? Did you see a bug? Or is it just to let me
> > > do enough testing before you start reviewing my patches?
> > 
> > It's not a bug, just a wondering about the performance figures you got
> > with your latest patch. When you have __init to unwind_test, the
> > .init.text functions are placed by the linker after the unwinding table,
> > with having a positive prel31 address. All the non-init functions are
> > placed before the table with a negative prel31. With your latest patch,
> > you split the set of functions in two ranges - the non-init one with a
> > negative prel31 and the init functions with a positive prel31 and the
> > binary search only happens on one of these ranges. The problem is that
> > the init range is much smaller than the non-init one, so your benchmark
> > figures may not be realistic.
> > 
> > Could you run the simple benchmark on a non-init function?
> Without __init I get with the original implementation:
> 
> 	34139, 34127, 34100
> 
> and with my patch I get
> 
> 	33456, 33425, 33407
> 
> So the speedup here is smaller here, but still OK.

OK, so as long as it is not much worse than before, I'm ok with this.
I'll do a proper review of the patch in the next day or so.

Thanks.

-- 
Catalin
