From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 23 Oct 2009 14:04:29 +0200
Subject: [PATCH v3 4/4] iop: implement sched_clock()
In-Reply-To: <19168.55801.851167.570526@pilspetsen.it.uu.se>
References: <19160.60691.72229.932486@pilspetsen.it.uu.se>
	<e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
	<19168.55801.851167.570526@pilspetsen.it.uu.se>
Message-ID: <19169.39885.258937.672777@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson writes:
 > Dan Williams writes:
 >  > Hi Mikael,
 >  > 
 >  > On Fri, Oct 16, 2009 at 3:00 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
 >  > > This adds a better sched_clock() to the IOP platform,
 >  > > implemented using its new clocksource support.
 >  > >
 >  > > Tested on n2100, compile-tested for all plat-iop machines.
 >  > >
 >  > > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
 >  > > ---
 >  > 
 >  > I applied this series and my iop13xx does not get past "Uncompressing
 >  > Linux".  Bisecting points to this patch i.e. the other three are ok
 >  > (at least for booting).  Any ideas?  I won't have time to debug this
 >  > for a while.
 > 
 > Thanks for testing and for doing the bisection.
 > 
 > Actually I do have an idea what it might be. sched_clock() is
 > "registered" (if you can call it that) at link-time simply by
 > virtue of being defined, while the other machinery it needs
 > (clocksource) is enabled at boot-time at some semi-unknown point.
 > So there's an early boot-time window where calls to sched_clock()
 > may occur but won't work.

Hmm, even with CONFIG_PRINTK_TIME I can't reproduce any crashes,
all that happens is that sched_clock() returns 0 until shortly
after the clocksource is initialized.

Do you have any local patches in that kernel, in particular anything
that might depend on sched_clock()?

Can you send me your .config?

And finally, can you boot your kernel (with the sched_clock() patch)
with Sascha Hauer's earlyprintk patch(*) applied and enabled(**), and
capture the boot messages?

(*) http://lists.arm.linux.org.uk/lurker/message/20090129.153915.ed65e33d.en.html
(**) CONFIG_DEBUG_LL=y and CONFIG_DEBUG_LL_CONSOLE=y, append "earlyprintk" to boot params
