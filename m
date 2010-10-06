From: robert.richter@amd.com (Robert Richter)
Date: Wed, 6 Oct 2010 21:22:35 +0200
Subject: [PATCH 4/7] ARM: oprofile: Move non-ARM code into separate
	init/exit
In-Reply-To: <AANLkTin579dqJsdtpesJ0erWP3Pgi39XHQs46xMAGJDW@mail.gmail.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<74092b0d162aafc21e408033cec6146e227363b5.1286222593.git.matt@console-pimps.org>
	<20101006133309.GP13563@erda.amd.com>
	<20101006144921.GQ13563@erda.amd.com>
	<20101006145311.GA3754@linux-sh.org>
	<20101006145903.GR13563@erda.amd.com>
	<AANLkTikGQe99k_fK5pZtkn-ht9jgC0guDkn28dSedjUo@mail.gmail.com>
	<20101006184407.GY13563@erda.amd.com>
	<AANLkTin579dqJsdtpesJ0erWP3Pgi39XHQs46xMAGJDW@mail.gmail.com>
Message-ID: <20101006192235.GA13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.10.10 14:58:06, Grant Likely wrote:
> On Wed, Oct 6, 2010 at 12:44 PM, Robert Richter <robert.richter@amd.com> wrote:
> > On 06.10.10 14:23:17, Grant Likely wrote:
> >> >> diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
> >> >> index b336cd9..76d97a5 100644
> >> >> --- a/drivers/oprofile/oprof.c
> >> >> +++ b/drivers/oprofile/oprof.c
> >> >> @@ -252,6 +252,8 @@ static int __init oprofile_init(void)
> >> >> ?{
> >> >> ? ? ? int err;
> >> >>
> >> >> + ? ? memset(&oprofile_ops, 0, sizeof(struct oprofile_operations));
> >> >> +
> >> >
> >> > Yes, this looks much better. Thanks Paul.
> >>
> >> oprofile_ops is allocated in bss and so is already zeroed. ?No need to
> >> do it explicitly.
> >
> > Before oprofile_arch_init() it isn't necessarily needed, but we should
> > definitely add it before oprofile_timer_init(). For code readability I
> > would rather tend to let the first in too.
> 
> ?  Sorry, I don't understand what you're trying to say.  Because
> oprofile_ops is statically allocated in bss; it will be zeroed before
> *any* of the init hooks is called.

The first call to oprofile_arch_init() might leave a dirty struct, but
as Paul just pointed out the function is aware of it and cleans up the
struct during init where necessary. The backtrace callback setup will
be reused if arch init fails (seems to be an ugly hack). So it is
better not to zero the struct then and keep everything unchanged.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
