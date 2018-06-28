From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Jun 2018 02:06:55 -0700
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180627205834.GB29478@amd>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com> <20180627205834.GB29478@amd>
Message-ID: <20180628090655.GL112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180627 21:01]:
> On Fri 2018-06-22 00:49:36, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [180622 07:22]:
> > > * Pavel Machek <pavel@ucw.cz> [180621 12:18]:
> > > > Hi!
> > > > 
> > > > V4.18 is slower than it should be.
> > > > 
> > > > user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > > > | wc -c
> > > > 10044291
> > > > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > > > user at devuan:~$ uname -a
> > > > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > > > 19:26:37 CEST 2018 armv7l GNU/Linux
> > > > 
> > > > That bzip should take 12 seconds, not minute.
> > > > 
> > > > Any ideas? Do you see it, too?
> > > 
> > > I've noticed firefox is super slow.. Git bisect time?
> > 
> > Hmm not happening for me at least on duovero and droid4,
> > I'm getting about 20s for v4.17 and v4.18-rc1.
> 
> Okay, so I know what was wrong with my config. I had l2cache disabled
> -- and this solved it:
> 
> +CONFIG_OUTER_CACHE=y
> +CONFIG_OUTER_CACHE_SYNC=y
> +CONFIG_CACHE_L2X0=y
> +CONFIG_PL310_ERRATA_588369=y
> +CONFIG_PL310_ERRATA_727915=y

We have these in omap2plus_defconfig.

> +CONFIG_PL310_ERRATA_753970=y
> +CONFIG_PL310_ERRATA_769419=y

These two should not be needed from what I recall. Have not
checked against processor revisions or errata though. But
I verified that my duovero time stays at 21 seconds also
with these enabled. It seems to run at 600MHz so it's slower
compared to droid4.

> Now I'm at 12 seconds.
> 
> user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 - | wc -c
> 10043993
> 11.41user 0.44system 11.63 (0m11.637s) elapsed 101.97%CPU
> user at devuan:~$ uname -a
> Linux devuan 4.18.0-rc2-88315-g3452793-dirty #756 SMP Wed Jun 27 22:16:59 CEST 2018 armv7l GNU/Linux
> user at devuan:~$
> 
> I was about to add "facepalm" emoji here, as disabling l2 cache is
> major mistake. OTOH if you also see 20 seconds, then either there is
> another problem, or you need to enable l2 cache, too (and I don't have
> to feel too bad for misconfiguring it).

OK. I checked and duovero runs only at 600MHz. I can only
get down to 19 seconds with omap2plus_defconfig if I disable
CONFIG_CPU_FREQ so the max speed is maintained from bootloader.
Otherwise it runs at most at 1GHz, I think any higher speeds
need smartreflex and voltage scaling working which we don't
have in the mainline kernel. Not sure what happens with higher
speeds with mainline kernel or if they are unsafe in the long
run.

Anyways, care to post your .config somewhere so I can see what
the numbers are for me with it?

Regards,

Tony
