From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 5 Mar 2015 19:33:58 +0800
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150305105104.GJ11010@pengutronix.de>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
 <20150305091948.GH11010@pengutronix.de>
 <CALx668X2m0hMVQumGQmhhrKnv4h1hiYp20Q4FcKuECK3mhoJiA@mail.gmail.com>
 <20150305105104.GJ11010@pengutronix.de>
Message-ID: <CALx668VvUKTijtoAMoDg2oTmMnad_aq-DSvkaneHnWt+Yo1Dfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2015 at 18:51, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Mar 05, 2015 at 05:39:12PM +0800, Pi-Cheng Chen wrote:
>> On 5 March 2015 at 17:19, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Thu, Mar 05, 2015 at 02:29:50PM +0530, Viresh Kumar wrote:
>> >> On 5 March 2015 at 13:12, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> >> > We have clk_set_parent for changing the parent and clk_set_rate to
>> >> > change the rate. Use the former for changing the parent and the latter
>> >> > for changing the rate. What you are interested in is changing the
>> >> > parent, so use clk_set_parent for this and not abuse a side effect
>> >> > of clk_set_rate.
>> >>
>> >> clk_set_rate() for CPUs clock is responsible to change clock rate
>> >> of the CPU. Whether it plays with PLLs or muxes, its not that relevant.
>> >
>> > The sequence to change the CPU frequency on the Mediatek SoCs is like this:
>> >
>> > - Change CPU from CPU PLL to another clock source (intermediate source)
>> > - Change CPU PLL frequency
>> > - wait until PLL has settled
>> > - switch back to CPU PLL
>> >
>> > The frequency of the intermediate source is irrelevant, the important
>> > thing is that the CPU is switched to this source while the CPU PLL is
>> > reconfigured.
>> >
>> > In Pi-Chengs patches the switch to th eintermediate clock is done like:
>> >
>> >         rate = clk_get_rate(intermediate_clk);
>> >         clk_set_rate(cpu_clk, rate);
>> >
>> > Now the clk framework does the switch not because it's told to switch
>> > to another parent, but only because the other parent happens to be the
>> > only provider for that rate. That's rubbish, when the parent must be
>> > changed, then it should be done explicitly.
>>
>> Hi,
>>
>> Please correct me if I was wrong. But I think that's the reason why we have
>> a determine_rate hook here, isn't it?
>>
>> > What if the CPU PLL and the intermediate clk happen to have the same
>> > rate? Then the clk_set_rate above simply does nothing, no parent is
>> > changed and the following rate change of the CPU PLL just crashes the
>> > system.
>>
>> I think what I am trying to do in the determine_rate hook of cpumux is:
>>
>> * if the target rate of clk_set_rate is equal to the rate of MAINPLL,
>> then switch
>>   the mux to MAINPLL
>> * otherwise, set the rate directly on ARMPLL and switch the mux back to
>>   ARMPLL if the current parent of mux is not ARMPLL
>>
>> And if the CPU PLL and the intermediate clk happen to have the same rate,
>> I think the cpufreq-dt driver will change nothing on the clk framework. Or do
>> I misunderstand your point?
>
> Imagine the board starts with both the CPU PLL and Intermediate PLL
> running with the same frequency with the CPU driven from the CPU PLL.
> Now the cpufreq driver does it's very first frequency transition. Now
> when clk_set_rate is used with the intention to switch to the
> intermediate PLL nothing will happen because the CPU PLL already runs
> at the desired frequency. Reconfiguring the CPU PLL then crashes your
> system.
>
> Another reason why abusing clk_set_rate to change the parent is this:
> You have this in your SoC:
>
>             ---
> CPU_PLL ---|   |
>            |   |
>            |   |----- CPU
>            |   |
> IM_PLL ----|   |
>             ---
>
> Now you do a clk_set_rate(CPU, clk_get_rate(IM_PLL)) which (often) works
> in your case. Many SoCs have an additional divider though, like this:
>
>             ---
> CPU_PLL ---|   |
>            |   |   ----
>            |   |--| :x | --- CPU
>            |   |   ----
> IM_PLL ----|   |
>             ---
>
> Now clk_set_rate(CPU, clk_get_rate(IM_PLL)) doesn't give anything
> sensible anymore.
>
> Given the variance of different SoCs I don't think it makes sense
> to try to handle all these cases. Instead the cpufreq-dt driver
> should just call clk_set_rate() on the CPU clock with the desired
> target frequency. Everything else should be handled in the clock
> driver which has intimate knowledge about the SoC anyway.

Now I got it. Thanks for your elaboration. I will investigate the way
you suggested to implement intermediate clock switching.

Best Regards,
Pi-Cheng

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
