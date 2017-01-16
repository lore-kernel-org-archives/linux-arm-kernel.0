From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Mon, 16 Jan 2017 17:51:30 +0100
Subject: [linux-sunxi] [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
In-Reply-To: <20170116164300.j2zvjkxr7c5h5hyo@lukather>
References: <20161125002852.18097-1-megous@megous.com>
 <0985b1ec-ba95-1505-cc59-adec4b88238f@megous.com>
 <20170109095946.6esbfx6pafega5cd@lukather>
 <557330d0-2dcd-2211-8538-51c4d6b68834@megous.com>
 <20170116164300.j2zvjkxr7c5h5hyo@lukather>
Message-ID: <f1ccd8ce-df6c-8204-71ab-2f774ac269d5@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Dne 16.1.2017 v 17:43 Maxime Ripard napsal(a):
>> It does lock up quickly with mainline ccu_nkmp_find_best algorithm
>> for finding factors.
>>
>> Even with linux kernel, it breaks. It's just more difficult to hit the
>> right conditions. I got oops only right after boot when running cpuburn
>> to trigger thermal_zone issued OPP change, if I first run some cpupower
>> commands. That's why I wrote this program to stress test various CPU_PLL
>> change/factor selection algorithms independently of everything else, to
>> get more predictable and quicker testing results.
> 
> Understood. Do you have the code available somewhere?

It's a bit messy, but it's here:

https://github.com/megous/h3-firmware/blob/master/main.c

>>>> What works is selecting NKMP factors so that M is always 1 and P is
>>>> anything other than /1 only for frequencies under 288MHz. As mandated by
>>>> the H3 datasheet. Mainline ccu_nkmp_find_best doesn't respect these
>>>> conditions. With that I can change CPUX frequencies randomly 20x a
>>>> second so far indefinitely without the main CPU ever locking up.
>>>>
>>>> Please drop or revert this patch. It is not a correct approach to the
>>>> problem. I'd suggest dropping the entire clock notifier mechanism, too,
>>>> unless it can be proven to work reliably.
>>>
>>> It has been proven to work reliably on a number of other SoCs.
>>
>> Unless it was stress tested like this with randomy changed settings, I
>> doubt you can call it reliable. It may just be very hard to hit the
>> issue on linux with particular OPP/thermal zone configuration. That's
>> because the issue is dependent on before and after NKMP values. People
>> may have just been lucky so far.
> 
> Yes, or maybe we just have OPPs that just don't trigger a low enough P
> factor.
> 
> There's no rush anyway, the H3 cpufreq support is not enabled at the
> moment, so that code basically does nothing for the moment.
> 
> What's your current plan to fix that? I guess the easiest (and most
> likely to be reusable) would be to allow for clock tables, instead of
> using the generic approach. We might have some other clocks (like
> audio or video) that would need such a precise tuning in the future
> too.

My proposed solution is this for M factor (H3 specific solution):

https://github.com/megous/linux/commit/88be3d421e958579026135d8acec4b3983958738

and this for P factor:

https://github.com/megous/linux/commit/d7f274ed0c13fa9b4099445cb6bf9b2f8f2cfa8a

Perhaps it should be configurable if the P limitation is not universal
for all NKMP clocks. But I haven't read all the datasheets.

It was verified with the above arisc firmware to work reliably, so it
should be enough. It is simpler and the factor table should not be
necessary in this case.

regards,
  o.

> Maxime
> 
