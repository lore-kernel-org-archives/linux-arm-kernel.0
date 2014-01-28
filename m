From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue, 28 Jan 2014 18:17:53 +0530
Subject: [PATCH v2 1/7] cpufreq: cpufreq-cpu0: allow optional safe voltage
 during frequency transitions
In-Reply-To: <20140128114932.GE20583@S2101-09.ap.freescale.net>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <1390047057-2239-2-git-send-email-thomas.ab@samsung.com>
 <20140127202543.4167.83362@quantum>
 <CAJuA9ah1vsgpD04QhM5RApkCe9xcvpPkLvdwzgadKGWvngAt+g@mail.gmail.com>
 <20140128114932.GE20583@S2101-09.ap.freescale.net>
Message-ID: <CAJuA9ahdZmL7r6VodvMC0DwnDR6bmbpr7+mZT=_N6WJdwYtP3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 5:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Jan 28, 2014 at 11:00:29AM +0530, Thomas Abraham wrote:
>> Hi Mike,
>>
>> On Tue, Jan 28, 2014 at 1:55 AM, Mike Turquette <mturquette@linaro.org> wrote:
>> > Quoting Thomas Abraham (2014-01-18 04:10:51)
>> >> From: Thomas Abraham <thomas.ab@samsung.com>
>> >>
>> >> On some platforms such as the Samsung Exynos, changing the frequency
>> >> of the CPU clock requires changing the frequency of the PLL that is
>> >> supplying the CPU clock. To change the frequency of the PLL, the CPU
>> >> clock is temporarily reparented to another parent clock.
>> >>
>> >> The clock frequency of this temporary parent clock could be much higher
>> >> than the clock frequency of the PLL at the time of reparenting. Due
>> >> to the temporary increase in the CPU clock speed, the CPU (and any other
>> >> components in the CPU clock domain such as dividers, mux, etc.) have to
>> >> to be operated at a higher voltage level, called the safe voltage level.
>> >> This patch adds optional support to temporarily switch to a safe voltage
>> >> level during CPU frequency transitions.
>> >>
>> >> Cc: Shawn Guo <shawn.guo@linaro.org>
>> >> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> >
>> > I'm not a fan of this change. This corner case should be abstracted away
>> > somehow. I had talked to Chander Kayshap previously about handling
>> > voltage changes in clock notifier callbacks, which then renders any
>> > voltage change as a trivial part of the clock rate transition. That
>> > means that this "safe voltage" thing could be handled automagically
>> > without any additional code in the CPUfreq driver.
>> >
>> > There are two nice ways to do this with the clock framework. First is
>> > explicit re-parenting with voltage scaling done in the clock rate-change
>> > notifiers:
>> >
>> > clk_set_parent(cpu_clk, temp_parent);
>> > /* implicit voltage scaling to "safe voltage" happens above */
>> > clk_set_rate(pll, some_rate);
>> > clk_set_parent(cpu_clk, pll);
>> > /* implicit voltage scaling to nominal OPP voltage happens above */
>> >
>> > The above sequence would require a separate exnyos CPUfreq driver, due
>> > to the added clk_set_parent logic.
>> >
>> > The second way to do this is to abstract the clk re-muxing logic out
>> > into the clk driver, which would allow cpufreq-cpu0 to be used for the
>> > exynos chips.
>>
>> This is the approach this patch series takes (patch 2/7). The clock
>> re-muxing logic is handled by a clock driver code. The difference from
>> what you suggested is that the safe voltage (that may be optionally)
>> required before doing the re-muxing is handled here in cpufreq-cpu0
>> driver.
>>
>> The safe voltage setup can be done in the notifier as you suggested.
>> But, doing that in cpufreq-cpu0 driver will help other platforms reuse
>> this feature if required. Also, if done here, the regulator handling
>> is localized in this driver which otherwise would need to be handled
>> in two places, cpufreq-cpu0 driver and the clock notifier.
>>
>> So I tend to prefer the approach in this patch but I am willing to
>> consider any suggestions. Shawn, it would be helpful if you could let
>> us know your thoughts on this. I am almost done with testing the v3 of
>> this series and want to post it so if there are any objections to the
>> changes in this patch, please let me know.
>
> To me, it's the best that we reuse cpufreq-cpu0 for exynos without any
> changes on cpufreq-cpu0 driver ;)

Okay, so that leaves us with the only option of handling "safe
voltage" using clock notifier callbacks as suggested by Mike. So there
are two options - a samsung specific cpufreq driver handling the clock
notifiers (and reusing cpufreq-cpu0 driver) or the samsung clock
driver handles the clock notifiers (and reusing cpufreq-cpu0 driver).

With the second option, the clock driver will have to handle the
regulator lookup from the cpu node, deferring regulator lookup until
the cpu and regulator devices are registered and using regulator api
inside clock driver. This seems like too much code to just manage the
"safe voltage".

So how about the first option of samsung specific cpufreq driver. If
there are any other alternatives, please let me know.

Thanks,
Thomas.

>
> Shawn
>
