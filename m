From: robherring2@gmail.com (Rob Herring)
Date: Fri, 21 Jan 2011 09:00:04 -0600
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
In-Reply-To: <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
	<43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
	<4D38641E.2000301@gmail.com>
	<c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
Message-ID: <4D399F74.9050302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On 01/21/2011 07:43 AM, Santosh Shilimkar wrote:
>> -----Original Message-----
>> From: Rob Herring [mailto:robherring2 at gmail.com]
>> Sent: Thursday, January 20, 2011 10:05 PM
>> To: Santosh Shilimkar
>> Cc: linux-arm-kernel at lists.infradead.org; Russell King; linux-
>> omap at vger.kernel.org; Linus Walleij
>> Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
>> to speed-up boot
>
> [..]
>
>>>>
>>>> There's already one way to do this with pre-calculated lpj.
>>>>
>>> How about the hot-plug path? This is not for just boot.
>>
>> The path is the same for hotplug and secondary boot, so yes for
>> both.
>> Plus you get the added benefit of speeding up the primary core boot
>> as well.
>>
> No 'preset_lpj' will not work for the hotplug path when
> cpufreq is active. It just useful only for boot in
> its current form.

Why? If preset_lpj is non-zero, calibrate_delay will effectively be 
skipped which is the same thing your patch does.

This is the cpfreq loops_per_jiffy adjustment function for SMP:

static inline void adjust_jiffies(unsigned long val, struct 
cpufreq_freqs *ci)
{
	return;
}

And delay.S uses the global loops_per_jiffy, not the per cpu value. The 
only place I see the per cpu value get used is /proc/cpuinfo.

Consider the following sequence:

- scale down the cpu freq
- hot unplug a core
- hot plug a core
   - calls calibrate_delay and update the global loops_per_jiffy
- scale up the cpu freq
- udelay time is now much too short!!!

So for that reason, I would just remove calibrate_delay unconditionally. 
Better to have the 1% inaccuracy and longer delays at low frequency than 
to have too short of a delay at high freq.

Rob
