From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 7 Oct 2010 03:50:57 +0900
Subject: [PATCH 4/7] ARM: oprofile: Move non-ARM code into separate
	init/exit
In-Reply-To: <20101006184407.GY13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<74092b0d162aafc21e408033cec6146e227363b5.1286222593.git.matt@console-pimps.org>
	<20101006133309.GP13563@erda.amd.com>
	<20101006144921.GQ13563@erda.amd.com>
	<20101006145311.GA3754@linux-sh.org>
	<20101006145903.GR13563@erda.amd.com>
	<AANLkTikGQe99k_fK5pZtkn-ht9jgC0guDkn28dSedjUo@mail.gmail.com>
	<20101006184407.GY13563@erda.amd.com>
Message-ID: <20101006185057.GB13879@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 08:44:07PM +0200, Robert Richter wrote:
> On 06.10.10 14:23:17, Grant Likely wrote:
> > >> diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
> > >> index b336cd9..76d97a5 100644
> > >> --- a/drivers/oprofile/oprof.c
> > >> +++ b/drivers/oprofile/oprof.c
> > >> @@ -252,6 +252,8 @@ static int __init oprofile_init(void)
> > >> ?{
> > >> ? ? ? int err;
> > >>
> > >> + ? ? memset(&oprofile_ops, 0, sizeof(struct oprofile_operations));
> > >> +
> > >
> > > Yes, this looks much better. Thanks Paul.
> > 
> > oprofile_ops is allocated in bss and so is already zeroed.  No need to
> > do it explicitly.
> 
> Before oprofile_arch_init() it isn't necessarily needed, but we should
> definitely add it before oprofile_timer_init(). For code readability I
> would rather tend to let the first in too.
> 
No, it was intentionally not added in between because architectures could
set a backtrace op even if they had no actual counter information to plug
in. oprofile_timer_init() is pretty careful to clear out all of the
unused fields manually, while leaving the backtrace setting untouched.

sh, ia64, and s390 all depend on this behaviour.
