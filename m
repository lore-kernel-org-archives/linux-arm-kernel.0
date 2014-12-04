From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 4 Dec 2014 19:37:11 +0530
Subject: [RFC] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <1417692868.9037.4.camel@pengutronix.de>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
 <1417692868.9037.4.camel@pengutronix.de>
Message-ID: <CAKohponP3PXd5b=YY7bpBK6FTNc5_Y7RU=X7q7dP1bYELcW6Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On 4 December 2014 at 17:04, Lucas Stach <l.stach@pengutronix.de> wrote:

>> +- opp-list@*:
>> +  List of nodes defining performance points. Following belong to the nodes
>> +  within the opp-lists.
>> +
>> +  Required properties:
>> +  - frequency-kHz: Frequency in kHz
>> +  - voltage-uV: voltage in micro Volts
>> +
>> +  Optional properties:
>> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
>> +  - status: Marks the node enabled/disabled.
>
> What about devices with multiple different turbo states? We have seen

You mean that a state may or maynot be turbo at some point of time ?

> CPUs that boost to different states in the x86 world, surely we will
> encounter something like this in the ARM world too. Do we just mark them
> all as turbo OPPs and let the driver decide what to do? If we want to

Maybe yes. But the good thing about binding this time is, it is expandable.
So, if there is a future need that we can't think of today, then we can surely
do incremental changes here.

> keep using cpufreq-dt for as much devices as possible is it really

Its not about cpufreq-dt alone. We maybe using other drivers as well..

> sufficient to know that this is a turbo state, without knowing the
> conditions required for activating the state?

Can you elaborate more on this? If something is required and we
know what exactly it is, then we can put up the right binding right
now as well..

>> +- opp@*:
>> +  Operating performance point node per device. Multiple devices sharing it can
>> +  use its phandle in their 'opp' property.
>> +
>> +  Required properties:
>> +  - opp-list: phandle to opp-list defined above.
>> +
>> +  Optional properties:
>> +  - clocks: Tuple of clock providers
>> +  - clock-names: Clock names
>> +  - opp-supply: phandle to the parent supply/regulator node
>> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
>
> This is extremely ill defined. It doesn't say in which direction the
> tolerance is to be applied. Can you go below or above the OPP specified
> voltage? For now everyone just assumes that it has to work both ways.

Yes, the binding is as per today's requirements (or rather implementations).
So it is both ways. But if everybody agrees on it, we can improve it..

> Also with this binding the tolerance is applied for all OPPs, where is
> very much depends on the individual OPP.

Hmm, Not only this but the same is true for clock latency as well. We
*may* need that per opp node sometime..

> If you are going to redefine OPPs anyway I would really like to see this
> property die and rather have a min/max voltage per OPP. That way you can

Maybe yes.

> properly express the OPP constraints. Most OPPs will likely allow a much
> higher voltage than their minimal specified one, except when you go over
> thermal limits with a high clock/voltage combination.

Yes.

>> +  - clock-latency: Specify the possible maximum transition latency for clock,
>> +    in unit of nanoseconds.
>
> Why do we need this? This is property of the clock. We should be able to
> handle this completely internally in the kernel. I don't know if the
> clock API has something like this right now, but it should be a trivial
> addition.

This is not only clock's latency, but is somehow named this way. This should
give the time it takes to change from frequency A to frequency B, which include
change in supplies as well.. So, this probably is dvfs-latency ..

This is required by cpufreq right now, but would be useful for the energy aware
scheduler as well. So, yes this is important. Also, it might also be required to
be per OPP...

Probably we can use voltage-tolerance and clock-latency at both
levels. list-level
and OPP level. list level being at higher priority ?

Thanks for your quick comments :)
