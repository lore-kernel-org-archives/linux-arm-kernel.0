From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Nov 2011 18:35:45 +0000
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <20111120112809.GZ30612@pengutronix.de>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111117141706.GI4748@arm.com>
 <20111120112809.GZ30612@pengutronix.de>
Message-ID: <20111121183545.GF3272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2011 at 11:28:09AM +0000, Uwe Kleine-K?nig wrote:
> On Thu, Nov 17, 2011 at 02:17:06PM +0000, Catalin Marinas wrote:
> > On Thu, Nov 17, 2011 at 01:40:00PM +0000, Uwe Kleine-K?nig wrote:
> > > The linker places the unwind tables in readonly sections. So when using
> > > an XIP kernel these are located in ROM and cannot be modified.
> > > 
> > > For that reason don't convert the symbol addresses during boot (or
> > > module loading) but only when interpreting them in search_index().
> > > Moreover several consts are added to catch future writes and rename the
> > > member "addr" of struct unwind_idx to "addr_offset" to better match the
> > > new semantic.
> > > 
> > > This fixes unwinding on XIP which compared prel31 offsets to absolute
> > > addresses because the initial conversion from prel31 to absolute failed.
> > 
> > My only worry - does this increase the index search by doing the prel31
> > conversion every time? It could affect tools like lockdep that need to
> > get the backtrace regularly at run-time.
> I did a first test now using 
> 
> 	static int __init unwind_test(void)

With your latest patch, have you tried dropping __init from this
function? Since the .init.text section goes after the unwind_idx tables,
all the prel31 offsets are positive and the number of init functions is
smaller than the run-time ones.

-- 
Catalin
