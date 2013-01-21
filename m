From: john.stultz@linaro.org (John Stultz)
Date: Mon, 21 Jan 2013 13:00:15 -0800
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <201301212041.17951.arnd@arndb.de>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de>
Message-ID: <50FDAC5F.4040605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 12:41 PM, Arnd Bergmann wrote:
> On Monday 21 January 2013, Matt Sealey wrote:
>> config HZ
>>          int
>>          default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
>>                  ARCH_S5PV210 || ARCH_EXYNOS4
>>          default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
>>          default AT91_TIMER_HZ if ARCH_AT91
>>          default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
>>          default 100
>>
>> There is a patch floating around ("ARM: OMAP2+: timer: remove
>> CONFIG_OMAP_32K_TIMER")
>> which modifies the OMAP line, so I'll ignore that for my below
>> example, and I saw a patch for adding Exynos5 processors to the top
>> default somewhere around here.
>>
>> So, based on those getting in, in my case here, I can see a situation where;
>>
>> * I build multiplatform for i.MX6 and Exynos4/5 ARCH_MULTIPLATFORM, I
>> will get CONFIG_HZ=200.
>>
>> * If I built for just i.MX6, I will get CONFIG_HZ=100.
>>
>> Either way, if I boot a kernel on i.MX6, CONFIG_HZ depends on the
>> other ARM platforms I also want to boot on it.. this is not exactly
>> multiplatform compliant, right?
> Right. It's pretty clear that the above logic does not work
> with multiplatform.  Maybe we should just make ARCH_MULTIPLATFORM
> select NO_HZ to make the question much less interesting.

Although, even with NO_HZ, we still have some sense of HZ.

> Regarding the defaults, I would suggest putting them into all the
> defaults into the defconfig files and removing the other hardcoding
> otherwise. Ben Dooks and Russell are probably the best to know
> what triggered the 200 HZ for s3c24xx and for ebsa110. My guess
> is that the other samsung ones are the result of cargo cult
> programming.
>
> at91 and omap set the HZ value to something that is derived
> from their hardware timer, but we have also forever had logic
> to calculate the exact time when that does not match. This code
> has very recently been moved into the new register_refined_jiffies()
> function. John can probably tell is if this solves all the problems
> for these platforms.

Yea, as far as timekeeping is concerned, we shouldn't be HZ dependent 
(and the register_refined_jiffies is really only necessary if you're not 
expecting a proper clocksource to eventually be registered), assuming 
the hardware can do something close to the HZ value requested.

So I'd probably want to hear about what history caused the specific 200 
HZ selections, as I suspect there's actual hardware limitations there. 
So if you can not get actual timer ticks any faster then 200 HZ on that 
hardware, setting HZ higher could cause some jiffies related timer 
trouble (ie: if the kernel thinks HZ is 1000 but the hardware can only 
do 200, that's a different problem then if the hardware actually can 
only do 999.8 HZ). So things like timer-wheel timeouts may not happen 
when they should.

I suspect the best approach for multi-arch in those cases may be to 
select HZ=100 and use HRT to allow more modern systems to have 
finer-grained timers.

thanks
-john
