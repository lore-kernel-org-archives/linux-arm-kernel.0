From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Jun 2018 15:26:18 +0200
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180626061604.GK112168@atomide.com>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com> <20180625094949.GA17001@amd>
 <20180626061604.GK112168@atomide.com>
Message-ID: <20180627132618.GA32007@amd>
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

Weird. In v4.18 I seen times from 57 seconds to 27 seconds to 20
seconds. It seems to be consistent after boot.

v4.14 is fast... 12 second. v4.15 (all-v4.15 branch) -- no
boot. all-v4.16 -- 15.7 seconds. all-v4.18 with "all" config: time
varies (20, 24, 27, 57 seconds). all-v4.18 with "droid4" config: 20
seconds.

What needs to be done to get cpufreq to work? One of my hypothesis is
that cpu is running at wrong rate. I have it enabled in config, but no
luck:

user at devuan:~$ zcat /proc/config.gz | grep CPU_FREQ
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set
user at devuan:~$ sudo cpufreq-info
cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq at vger.kernel.org, please.
analyzing CPU 0:
  no or unknown cpufreq driver is active on this CPU
    maximum transition latency: 0.00 ms.
    analyzing CPU 1:
 no or unknown cpufreq driver is active on this CPU
 maximum transition latency: 0.00 ms.
user at devuan:~$

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/387e589d/attachment.sig>
