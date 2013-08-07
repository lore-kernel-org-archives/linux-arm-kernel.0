From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Aug 2013 23:24:45 +0530
Subject: [PATCH 1/6] clk: Tegra: Add CPU0 clock driver
In-Reply-To: <52028859.20008@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org>
 <52028620.6000608@wwwdotorg.org>
 <CAKohpokVgcMfmKmjkxc9Dr3z6mBKad23uUdB4ydN_xzGHdfedQ@mail.gmail.com>
 <52028859.20008@wwwdotorg.org>
Message-ID: <CAKohpokK7F7tYJnisVjF=NCRb9zUjQNzrFdXs+QsPSb4oqyytA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2013 23:18, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/07/2013 11:45 AM, Viresh Kumar wrote:
>> On 7 August 2013 23:08, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 08/07/2013 08:46 AM, Viresh Kumar wrote:
>>>> This patch adds CPU0's clk driver for Tegra. It will be used by the generic
>>>> cpufreq-cpu0 driver to get/set cpu clk.
>>>>
>>>> Most of the platform specific bits are picked from tegra-cpufreq.c.
>>>
>>> Hmmm. I'm not sure if it makes sense to represent this as a clock
>>> object; isn't this more of a virtual construct that manages the rate of
>>> the clock, rather than an actual clock? The actual clock already exists
>>> as "cpu".
>>
>> I see it as this: There is a clock in system for cpu, call it "cpu". Now we
>> must be able to provide get/set routines for it. A set should set the
>> frequency to whatever is asked for and should really worry about how
>> that is being set. This part is internal to "cpu" clk.
>
> Sure.
>
>> This is what cpufreq-cpu0 driver should expect and does. Current "cpu"
>> clock implemented doesn't provide this facility ? And so this wrapper
>> made sense to me.
>
> But the additional management logic on top of the raw clock is exactly
> what the cpufreq driver is for. This patch series is basically moving
> the cpufreq driver code inside the clock code instead.

Above "sure" didn't go very well with what you wrote here :)

The additional management that we are required to do isn't cpufreq
driver specific but cpu or platform specific. cpufreq shouldn't care
about how CPU's clock is set to a particular frequency, its headache
of CPU's clk driver instead. cpu is yet another device and so
clk_set_rate() must be enough to set its frequency....

There might be other frameworks that need to set frequency of this
device later on and surely we don't want to replicate such piece of
code to every user..

Does it make sense to you?
