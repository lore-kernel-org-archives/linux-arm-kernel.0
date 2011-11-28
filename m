From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Nov 2011 10:22:17 +0100
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <20111121183545.GF3272@arm.com>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111117141706.GI4748@arm.com>
 <20111120112809.GZ30612@pengutronix.de>
 <20111121183545.GF3272@arm.com>
Message-ID: <20111128092217.GG17668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 21, 2011 at 06:35:45PM +0000, Catalin Marinas wrote:
> On Sun, Nov 20, 2011 at 11:28:09AM +0000, Uwe Kleine-K?nig wrote:
> > On Thu, Nov 17, 2011 at 02:17:06PM +0000, Catalin Marinas wrote:
> > > On Thu, Nov 17, 2011 at 01:40:00PM +0000, Uwe Kleine-K?nig wrote:
> > > > The linker places the unwind tables in readonly sections. So when using
> > > > an XIP kernel these are located in ROM and cannot be modified.
> > > > 
> > > > For that reason don't convert the symbol addresses during boot (or
> > > > module loading) but only when interpreting them in search_index().
> > > > Moreover several consts are added to catch future writes and rename the
> > > > member "addr" of struct unwind_idx to "addr_offset" to better match the
> > > > new semantic.
> > > > 
> > > > This fixes unwinding on XIP which compared prel31 offsets to absolute
> > > > addresses because the initial conversion from prel31 to absolute failed.
> > > 
> > > My only worry - does this increase the index search by doing the prel31
> > > conversion every time? It could affect tools like lockdep that need to
> > > get the backtrace regularly at run-time.
> > I did a first test now using 
> > 
> > 	static int __init unwind_test(void)
> 
> With your latest patch, have you tried dropping __init from this
> function? Since the .init.text section goes after the unwind_idx tables,
> all the prel31 offsets are positive and the number of init functions is
> smaller than the run-time ones.
Yeah, it works fine. In fact unwinding unwind_test yields:

	do_one_initcall+0x50/0x158
	kernel_init+0x78/0x120
	kernel_thread_exit+0x0/0x8

where kernel_thread_exit is not in .init.text, too.

I don't know why you asked? Did you see a bug? Or is it just to let me
do enough testing before you start reviewing my patches?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
