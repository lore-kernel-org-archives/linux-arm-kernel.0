From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 5 Mar 2015 17:39:12 +0800
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150305091948.GH11010@pengutronix.de>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
 <20150305091948.GH11010@pengutronix.de>
Message-ID: <CALx668X2m0hMVQumGQmhhrKnv4h1hiYp20Q4FcKuECK3mhoJiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2015 at 17:19, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Mar 05, 2015 at 02:29:50PM +0530, Viresh Kumar wrote:
>> On 5 March 2015 at 13:12, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > We have clk_set_parent for changing the parent and clk_set_rate to
>> > change the rate. Use the former for changing the parent and the latter
>> > for changing the rate. What you are interested in is changing the
>> > parent, so use clk_set_parent for this and not abuse a side effect
>> > of clk_set_rate.
>>
>> clk_set_rate() for CPUs clock is responsible to change clock rate
>> of the CPU. Whether it plays with PLLs or muxes, its not that relevant.
>
> The sequence to change the CPU frequency on the Mediatek SoCs is like this:
>
> - Change CPU from CPU PLL to another clock source (intermediate source)
> - Change CPU PLL frequency
> - wait until PLL has settled
> - switch back to CPU PLL
>
> The frequency of the intermediate source is irrelevant, the important
> thing is that the CPU is switched to this source while the CPU PLL is
> reconfigured.
>
> In Pi-Chengs patches the switch to th eintermediate clock is done like:
>
>         rate = clk_get_rate(intermediate_clk);
>         clk_set_rate(cpu_clk, rate);
>
> Now the clk framework does the switch not because it's told to switch
> to another parent, but only because the other parent happens to be the
> only provider for that rate. That's rubbish, when the parent must be
> changed, then it should be done explicitly.

Hi,

Please correct me if I was wrong. But I think that's the reason why we have
a determine_rate hook here, isn't it?

> What if the CPU PLL and the intermediate clk happen to have the same
> rate? Then the clk_set_rate above simply does nothing, no parent is
> changed and the following rate change of the CPU PLL just crashes the
> system.

I think what I am trying to do in the determine_rate hook of cpumux is:

* if the target rate of clk_set_rate is equal to the rate of MAINPLL,
then switch
  the mux to MAINPLL
* otherwise, set the rate directly on ARMPLL and switch the mux back to
  ARMPLL if the current parent of mux is not ARMPLL

And if the CPU PLL and the intermediate clk happen to have the same rate,
I think the cpufreq-dt driver will change nothing on the clk framework. Or do
I misunderstand your point?

Thanks.

Best Regards,
Pi-Cheng

>
>>
>> > My suggestion is to take another approach. Implement clk_set_rate for
>> > these muxes and in the set_rate hook:
>> >
>> > - switch mux to intermediate PLL parent
>> > - call clk_set_rate() for the real parent PLL
>> > - switch mux back to real parent PLL
>> >
>> > This way the things happening behind the scenes are completely transparent
>> > to the cpufreq driver and you can use cpufreq-dt as is without changes.
>>
>> CPUFreq wants to change to intermediate frequency by itself against
>> some magic change behind the scene. The major requirement for that
>> comes from the fact that we want to send PRE/POST freq notifiers on
>> which loops-per-jiffie depends.
>
> Maybe, I don't know the internals of CPUFreq. But here the important
> thing is the rate change, not the parent change.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
