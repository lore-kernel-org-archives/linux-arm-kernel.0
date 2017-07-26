From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed, 26 Jul 2017 09:08:37 +0200
Subject: [PATCH v4 0/9] add support for Sama5d2 audio PLLs and enable
 ClassD
In-Reply-To: <20170726065732.zphp7zaug4ypcqzj@piout.net>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
 <194d2fc6-4c88-bc3b-1127-b4c0bdb7c6a1@microchip.com>
 <20170726065732.zphp7zaug4ypcqzj@piout.net>
Message-ID: <a2f50c1d-7889-8a62-a7d4-240d6310de15@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 26/07/2017 08:57, Alexandre Belloni wrote:
> On 25/07/2017 at 17:44:19 +0200, Nicolas Ferre wrote:
>> On 25/07/2017 at 09:37, Quentin Schulz wrote:
>>> This patch series adds support for the audio PLLs and enables ClassD that
>>> can be found in ATMEL Sama5d2 SoC.
>>>
>>> There are two audio PLLs (PMC and PAD) that shares the same parent (FRAC).
>>> FRAC can output between 620 and 700MHz and only multiply the rate of its
>>> parent. The two audio PLLs then divide the FRAC rate to best match the
>>> asked rate.
>>>
>>> I basically took an old patch series posted by Nicolas on December, 6th
>>> 2016[1][2][3] and the comments Boris did on the first version[4] Nicolas
>>> sent on July, 15th 2015.
>>>
>>> I also fixed the function used to compute the divisors, removed useless
>>> spinlocks and added a range to the audio frac PLL to stay within vendor's
>>> supported range. Clocks that are children of gclk (generated-clk) are now
>>> able to propagate rate to the audio PLL clocks when needed.
>>>
>>> However, there are multiple children clocks that could technically
>>> change the rate of audio_pll (via gck). With the rate locking introduced
>>> in Jerome Brunet's patch series[5], the first consumer to enable the clock
>>> will be the one definitely setting the rate of the clock. Without the rate
>>> locking, the last consumer to set the rate will be able to mess with the
>>> rate.
>>> Since audio IPs are most likely to request the same rate, we enforce
>>> that the only clks able to modify gck rate are those of audio IPs.
>>>
>>> To remain consistent, we deny other clocks to be children of audio_pll.
>>
>> Quentin,
>>
>> Thanks for having revived this series. Everything's okay on my side for
>> this v4. I think that my tag isn't missing from any patch of this
>> series. Now we surely need to define which path it must take...
>>
> 
> I'll take the two dts patches now as the bindings have been acked.
> Everything else should probably go through the clk tree.
> 

Thanks for taking the dts patches.

I agree that the remaining should go through the clk tree. @Stephen,
@Michael, any objection (apart from your reviews on the patches) on
taking this through your tree?

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
