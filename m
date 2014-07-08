From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Jul 2014 10:45:14 +0530
Subject: [PATCH v4 7/8] ARM: Exynos: switch to using generic cpufreq-cpu0
 driver
In-Reply-To: <11343238.VgTHVsC3iv@wuerfel>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <61090198.zodNL4xIig@wuerfel>
 <CAL_JsqL0Yi=SjAm0BtS_2SO2xg8kOaLsydo9m6qcZgb+Pcpa8Q@mail.gmail.com>
 <11343238.VgTHVsC3iv@wuerfel>
Message-ID: <CAKohpomfZZBzVSWzat3QHWv+M-dCN86P29Rsj1zgkwjjaHi+Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Rob/Mike et al,

We didn't conclude anything out of this thread and so kicking it
again as we need to close bindings to support cpufreq-cpu0
better for platforms not sharing clock lines across all CPUs.

https://lkml.org/lkml/2014/7/1/358

On 14 May 2014 20:03, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 May 2014 08:45:23 Rob Herring wrote:

>> We already have properties which indicate this driver can be used by a
>> platform: opp table and a clock for the cpu. If this information is

There can be platform drivers which also depend on these properties
and picking cpufreq-cpu0 on this basis doesn't look correct.

>> not sufficient to determine whether you can use this driver or not,
>> then you simply need to match against the platform. Perhaps the match
>> list should be a blacklist rather than a whitelist, so new platforms
>> work without a kernel change.
>
> We'd not only need a blacklist, but also a way to tell whether we
> want to use the cpu0 or the big/little implementation, which currently
> have indistinguishable bindings.

Correct and there can be other platform drivers which cannot use
cpufreq-cpu0 (though I am trying to force people to use cpufreq-cpu0
instead of a new driver).

Is something terribly wrong with having a property at 'cpus' node
which can point to the driver we want to use? Like:

        cpus {
                #address-cells = <1>;
                #size-cells = <0>;
                scaling-method = "cpufreq-cpu0"

                cpu at 0 {
                        ....
                };

                ....
        };

Or if we can reuse compatibility string some way.


[Copying mail from Mike]

On 15 May 2014 02:46, Mike Turquette <mturquette@linaro.org> wrote:
> The hardware property that matters for cpufreq-cpu0 users is that a
> multi-core CPU uses a single clock input to scale frequency across all
> of the cores in that cluster. So an accurate description is:
>
> scaling-method = "clock-ganged"; //hardware-people-speak
>
> Or,
>
> scaling-method = "clock-shared"; //software-people-speak
>
> Versus independently scalable CPUs in an SMP cluster:
>
> scaling-method = "independent"; //x86, Krait, etc.
>
> Or perhaps instead of "independent" at the parent "cpus" node we would
> put the following in each cpu at N node:
>
> scaling-method = "clock";
>
> Or "psci" or "acpi" or whatever.
>
> Thought exercise: for Hyperthreaded(tm) CPUs with 2 virtual cores for
> every hard CPU (and multiple CPUs in a cluster):
>
> scaling-method = "paired";
>
> Or more simply, "hyperthreaded".

Probably we have mixed both the problems. We have two problems to
solve:
- Identifying which driver to probe for a platform, earlier explanation
I tried to gave were around that..

- Identifying if clocks are shared between CPUs? If yes which ones?

Probably Mike's suggestions were around this second problem, but
I still couldn't make out which CPUs share clock line from his
examples.

Please see if we can close this thread soon... Few platforms are waiting
to reuse cpufreq-cpu0 :)

--
viresh
