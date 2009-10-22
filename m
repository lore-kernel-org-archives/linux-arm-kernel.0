From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 23 Oct 2009 00:17:29 +0200
Subject: [PATCH v3 4/4] iop: implement sched_clock()
In-Reply-To: <e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
References: <19160.60691.72229.932486@pilspetsen.it.uu.se>
	<e9c3a7c20910221449i6a9f8bc6y6b3af1f2f7fe1c44@mail.gmail.com>
Message-ID: <19168.55801.851167.570526@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Williams writes:
 > Hi Mikael,
 > 
 > On Fri, Oct 16, 2009 at 3:00 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
 > > This adds a better sched_clock() to the IOP platform,
 > > implemented using its new clocksource support.
 > >
 > > Tested on n2100, compile-tested for all plat-iop machines.
 > >
 > > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
 > > ---
 > 
 > I applied this series and my iop13xx does not get past "Uncompressing
 > Linux".  Bisecting points to this patch i.e. the other three are ok
 > (at least for booting).  Any ideas?  I won't have time to debug this
 > for a while.

Thanks for testing and for doing the bisection.

Actually I do have an idea what it might be. sched_clock() is
"registered" (if you can call it that) at link-time simply by
virtue of being defined, while the other machinery it needs
(clocksource) is enabled at boot-time at some semi-unknown point.
So there's an early boot-time window where calls to sched_clock()
may occur but won't work.

I've seen vague references to this issue in other platforms'
code, but nothing really concrete. Obviously I never saw that
issue on my n2100 and frankly forgot about it until now.

I'll have to grep around for the appropriate fix; in the mean
time, just dropping this one patch is the right solution, as
nothing else in this series depends on it.

/Mikael
