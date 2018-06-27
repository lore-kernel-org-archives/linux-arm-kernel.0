From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Jun 2018 21:48:57 +0200
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180626061604.GK112168@atomide.com>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com> <20180625094949.GA17001@amd>
 <20180626061604.GK112168@atomide.com>
Message-ID: <20180627194857.GA29478@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-06-25 23:16:04, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180625 09:52]:
> > Hi!
> > 
> > > > > V4.18 is slower than it should be.
> > > > > 
> > > > > user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > > > > | wc -c
> > > > > 10044291
> > > > > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > > > > user at devuan:~$ uname -a
> > > > > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > > > > 19:26:37 CEST 2018 armv7l GNU/Linux
> > > > > 
> > > > > That bzip should take 12 seconds, not minute.
> > > > > 
> > > > > Any ideas? Do you see it, too?
> > > > 
> > > > I've noticed firefox is super slow.. Git bisect time?
> > > 
> > > Hmm not happening for me at least on duovero and droid4,
> > > I'm getting about 20s for v4.17 and v4.18-rc1.
> > 
> > Something weird is going on here. My notes say it should be 12
> > seconds.
> > 
> > It is indeed 20 seconds for v4.17, but it is 12 seconds in v4.14.
> > 
> > v4.14 is:
> > # CONFIG_CPU_FREQ is not set
> > CONFIG_CPU_IDLE=y
> > # CONFIG_CPU_IDLE_GOV_LADDER is not set
> > CONFIG_CPU_IDLE_GOV_MENU=y
> > # CONFIG_ARM_CPUIDLE is not set
> > 
> > In v4.18, I have:
> > 
> > CONFIG_CPU_FREQ=y
> > CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> > CONFIG_CPU_FREQ_GOV_COMMON=y
> > CONFIG_CPU_FREQ_STAT=y
> > CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> > 
> > CONFIG_CPU_IDLE=y
> > CONFIG_CPU_IDLE_GOV_MENU=y
> > CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y
> 
> I gave it a quick try here with v4.14 and it was 21 seconds
> on 4430 duovero. But this was with omap2plus_defconfig.

Ok, so I was able to create .config where bzip2 takes 12 seconds, on
v4.18...

In my normal config, it takes between 20 seconds and minute. Numbers
seem to be stable between boots.

In "fast" config:
processor  : 1
model name : ARMv7 Processor rev 3 (v7l)
BogoMIPS   : 2393.70
Features   : half thumb fastmult vfp edsp thumbee neon vfpv3 tls
vfpd32
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	  : 0x1
CPU part	  : 0xc09
CPU revision	  : 3

12 to 20 seconds is .. pretty significant slowdown. Is it possible
that "fast" config misses errata workaround with impact this
significant?

Best regards,
									Pavel




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: delme.gz
Type: application/gzip
Size: 24600 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/daff125a/attachment-0001.gz>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/daff125a/attachment-0001.sig>
