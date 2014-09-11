From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Sep 2014 12:14:50 -0700
Subject: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
In-Reply-To: <20140911190136.GM3755@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911173943.GB18849@atomide.com>
 <20140911190136.GM3755@pengutronix.de>
Message-ID: <20140911191449.GF18849@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [140911 12:02]:
> On Thu, Sep 11, 2014 at 10:39:43AM -0700, Tony Lindgren wrote:
> > * Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [140910 01:27]:
> > > of_device_ids (i.e. compatible strings and the respective data) are not
> > > supposed to change at runtime. All functions working with of_device_ids
> > > provided by <linux/of.h> work with const of_device_ids. So mark the
> > > non-const function parameters and structs for OMAP2+ as const, too.
> > 
> > Hmm this does not seem to compile with omap2plus_defconfig because
> > of section type conflicts. Looks like there's some issue now with the
> > use of __initconst:
> > 
> > arch/arm/mach-omap2/board-generic.c:262:20: error: dra72x_boards_compat causes a section type conflict with omap_dt_match_table
> > arch/arm/mach-omap2/board-generic.c:30:34: note: ?omap_dt_match_table? was declared here
> > scripts/Makefile.build:257: recipe for target 'arch/arm/mach-omap2/board-generic.o' failed
> The problem is dra74x_boards_compat though:
> 
> 	static const char *dra74x_boards_compat[] __initconst = {
> 		...
> 
> *dra74x_boards_compat is const, but dra74x_boards_compat isn't, so
> either the variable must go into __initdata or it must be declared as:
> 
> 	static const char * const dra74x_boards_compat[] __initconst = {
> 		...

Ah OK.
 
> (but then I guess you get another warning because struct machine_desc's
> dt_compat is declared as
> 
> 	const char **dt_compat;
> 
> .)
> 
> With the patch below, arch/arm/mach-omap2/board-generic.c compiles just
> fine. Don't know yet if the additional const in <asm/mach_desc.h> is
> problematic ...

Yes OK thanks. It Would be nice to have those as __initconst to discard
the unused ones.

Regards,

Tony
