From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 Jan 2015 11:06:55 +0530
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAL_JsqKrjvOw4hwOfS_V1g8As0N1xTbf4S1wKnxHdeoHyxH66A@mail.gmail.com>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
 <CAL_JsqKrjvOw4hwOfS_V1g8As0N1xTbf4S1wKnxHdeoHyxH66A@mail.gmail.com>
Message-ID: <CAKohpomkaUHyjcU5GbajWEBnBDjhFgUGnnTDzMRUw+C4gh4u4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 21:52, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Jan 23, 2015 at 4:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> - Getting clock sharing information between CPUs. Single shared clock vs
>>   independent clock per core vs shared clock per cluster.
>
> I'd like to see acks from Qualcomm folks to make sure this works for them.

@Stephen: Can I have your inputs as well here?

>> +  Required properties:
>> +  - opp-khz: Frequency in kHz
>> +  - opp-microvolt: voltage in micro Volts
>
> This can be optional as it is valid to have frequency scaling without
> voltage scaling. More so for bus scaling than cpu scaling.

Right.

>> +  Optional properties:
>> +  - opp-intermediate: Stable opp we *must* switch to, before switching to the
>> +    target opp. Contains phandle of one of the opp-node present in opp-list.
>
> What about cases where perhaps you have a more complex sequencing
> arrangement? For example, what if you have to hit each step (to go
> from A -> D you have to go A -> B -> C -> D). Perhaps each OPP could
> have an opp-next property which lists other OPPs you can transition to
> (and no property means no restriction).

I haven't seen such examples yet but yeah that might be required
at some point of time.

> Do you have a specific user in mind? If not, I think we can defer this
> issue. I think the binding is flexible enough to accommodate this in
> the future.

Yeah, Tegra and Mediatek already need it. Even cpufreq core does
support it currently.

What about keeping it as is for now and extending to opp-next in case
it is required. Or maybe add opp-next right now. So, for the case of
single intermediate-freq, all OPPs except the intermediate one will have
opp-next set to intermediate opp. And intermediate opp doesn't fill this.

I will think about it a bit more though.

>> +       cpu0_opp: opp0 {
>> +               compatible = "linux,cpu-dvfs";
>
> As I said before, drop the linux part. I'm not sure about cpu-dvfs
> either. Nothing is specific to cpus and you are necessarily doing
> voltage scaling. You could want to find all cpu OPPs though. Perhaps:
> "cpu-operating-point", "operating-point";

What about "operating-point-v2", as that's the real version.

> It is not documented either.

Will do.

>> +       cpu1_opp: opp1 {
>> +               compatible = "linux,cpu-dvfs";
>> +               opp-list = <&cpu0_opplist>;
>> +               opp-intermediate = <&cpu0_intermediate>;
>> +       };
>
> This doesn't add anything other than some indirection to imply
> independent OPPs. The only way I know the clocks are not shared is you
> told me so in the example. I'd still prefer to determine from the

Will document that clearly.

> clock api whether 2 clocks can be changed independently. That didn't

Mike Turquette has objected to that earlier and so we moved
to DT to find this out..

> seem to be agreed on, so you could simply add a "shared-opp" property
> to opp0 to mark an OPP as shared or not. Then you can remove the
> opp-list and these other cpuX_opp nodes.

Okay.
