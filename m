From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Jun 2018 22:58:34 +0200
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180622074936.GG112168@atomide.com>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com>
Message-ID: <20180627205834.GB29478@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-06-22 00:49:36, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180622 07:22]:
> > * Pavel Machek <pavel@ucw.cz> [180621 12:18]:
> > > Hi!
> > > 
> > > V4.18 is slower than it should be.
> > > 
> > > user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > > | wc -c
> > > 10044291
> > > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > > user at devuan:~$ uname -a
> > > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > > 19:26:37 CEST 2018 armv7l GNU/Linux
> > > 
> > > That bzip should take 12 seconds, not minute.
> > > 
> > > Any ideas? Do you see it, too?
> > 
> > I've noticed firefox is super slow.. Git bisect time?
> 
> Hmm not happening for me at least on duovero and droid4,
> I'm getting about 20s for v4.17 and v4.18-rc1.

Okay, so I know what was wrong with my config. I had l2cache disabled
-- and this solved it:

+CONFIG_OUTER_CACHE=y
+CONFIG_OUTER_CACHE_SYNC=y
+CONFIG_CACHE_L2X0=y
+CONFIG_PL310_ERRATA_588369=y
+CONFIG_PL310_ERRATA_727915=y
+CONFIG_PL310_ERRATA_753970=y
+CONFIG_PL310_ERRATA_769419=y

Now I'm at 12 seconds.

user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 - | wc -c
10043993
11.41user 0.44system 11.63 (0m11.637s) elapsed 101.97%CPU
user at devuan:~$ uname -a
Linux devuan 4.18.0-rc2-88315-g3452793-dirty #756 SMP Wed Jun 27 22:16:59 CEST 2018 armv7l GNU/Linux
user at devuan:~$

I was about to add "facepalm" emoji here, as disabling l2 cache is
major mistake. OTOH if you also see 20 seconds, then either there is
another problem, or you need to enable l2 cache, too (and I don't have
to feel too bad for misconfiguring it).

Best regards, 
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/8a34fb90/attachment.sig>
