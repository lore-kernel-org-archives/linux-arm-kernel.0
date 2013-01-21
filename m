From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 20:41:17 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
Message-ID: <201301212041.17951.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Matt Sealey wrote:
> 
> ARM seems to be the only "major" platform not using the
> kernel/Kconfig.hz definitions, instead rolling it's own and setting
> what could be described as both reasonable and unreasonable defaults
> for platforms. If we're going wholesale for multiplatform on ARM then
> having CONFIG_HZ be selected dependent on platform options seems
> rather curious since building a kernel for Exynos, OMAP or so will
> force the default to a value which is not truly desired by the
> maintainers.

Agreed 100%.

(adding John Stultz to Cc, he's the local time expert)

> config HZ
>         int
>         default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
>                 ARCH_S5PV210 || ARCH_EXYNOS4
>         default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
>         default AT91_TIMER_HZ if ARCH_AT91
>         default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
>         default 100
> 
> There is a patch floating around ("ARM: OMAP2+: timer: remove
> CONFIG_OMAP_32K_TIMER")
> which modifies the OMAP line, so I'll ignore that for my below
> example, and I saw a patch for adding Exynos5 processors to the top
> default somewhere around here.
> 
> So, based on those getting in, in my case here, I can see a situation where;
> 
> * I build multiplatform for i.MX6 and Exynos4/5 ARCH_MULTIPLATFORM, I
> will get CONFIG_HZ=200.
> 
> * If I built for just i.MX6, I will get CONFIG_HZ=100.
> 
> Either way, if I boot a kernel on i.MX6, CONFIG_HZ depends on the
> other ARM platforms I also want to boot on it.. this is not exactly
> multiplatform compliant, right?

Right. It's pretty clear that the above logic does not work
with multiplatform.  Maybe we should just make ARCH_MULTIPLATFORM
select NO_HZ to make the question much less interesting.

Regarding the defaults, I would suggest putting them into all the
defaults into the defconfig files and removing the other hardcoding
otherwise. Ben Dooks and Russell are probably the best to know 
what triggered the 200 HZ for s3c24xx and for ebsa110. My guess
is that the other samsung ones are the result of cargo cult
programming.

at91 and omap set the HZ value to something that is derived
from their hardware timer, but we have also forever had logic
to calculate the exact time when that does not match. This code
has very recently been moved into the new register_refined_jiffies()
function. John can probably tell is if this solves all the problems
for these platforms.

> Additionally, using kernel/Kconfig.hz is a predicate for enabling
> (forced enabling, even) CONFIG_SCHED_HRTICK which is defined nowhere
> else. I don't know how many ARM systems here benefit from this, if
> there is a benefit, or what this really means.. if you really have a
> high resolution timer (and hrtimers enabled) that would assist the
> scheduler this way, is it supposed to make a big difference to the way
> the scheduler works for the better or worse? Is this actually
> overridden by ARM sched_clock handling or so? Shouldn't there be a
> help entry or some documentation for what this option does? I have
> CC'd the scheduler maintainers because I'd really like to know what I
> am doing here before I venture into putting patches out which could
> potentially rip open spacetime and have us all sucked in..

Yes, that sounds like yet another bug.

	Arnd
