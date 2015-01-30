From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 Jan 2015 10:47:15 +0530
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAL_Jsq+mhuR-DnjXo9Mmgpazgb_3R+sm+Ztkd7+6Q3iVw0aKOA@mail.gmail.com>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
 <20150128200600.GR21293@sirena.org.uk>
 <CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
 <CAL_Jsq+mhuR-DnjXo9Mmgpazgb_3R+sm+Ztkd7+6Q3iVw0aKOA@mail.gmail.com>
Message-ID: <CAKohpokig+CA00SSPhHfdMMgVm8PYHMRf+PLy0cGPbFYF6XT=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 21:12, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Jan 28, 2015 at 7:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> The goal is to choose the driver which we want to probe for a platform. There
>> can be multiple DT enabled cpufreq drivers present in a build and the platform
>> needs some way to choose one of them.
>
> That was not my original thought, but rather it is versioning the
> binding and a way to find OPP nodes. That doesn't mean we can't do
> things to make it easier to match to drivers.

Okay.

>> For example, if both cpufreq-dt, exynos-cpufreq and arm-big-little drivers are
>> present in a kernel build, the how do we specify which one a platform wants to
>> use.
>
> What does the exynos driver do that the other 2 don't?

There are efforts going on to start using cpufreq-dt instead
of exynos drivers. So, they might die at some point of time.

Anyway, there can be cpufreq drivers which co-exist
cpufreq-dt, even if they are parsing the same bindings.

> I will likely nak any such strings that are solely there to match to
> these 2 drivers. The information is there in DT already. It's just not
> a single property to match on. You can tell it is a big.LITTLE system
> by the fact your have 2 different cpu types. You can use the top level
> compatible strings when you need a machine specific driver. I would
> not be trying to get cpufreq platform devices to be created by
> of_platform_populate. The other issue I have is you may not always
> have 2 drivers for bL and non-bL. Really symmetric multi-cluster or
> single cluster should be a subset of functionality of bL.
>
> I think you just need to have an initcall which does this:
>
> if (of_find_matching_node_and_match(machine_specific_driver_match list))
>   platform_device_create(match->data);
> else if (is_big_little() && has_opp)
>   platform_device_create(big_little_device);
> else if (has_opp)
>   platform_device_create(cpufreq_dt_device);
>
> Or perhaps you handle the generic ones late in boot only if no machine
> specific driver has been probed. There is no generic solution ATM for
> selecting the best driver when there are multiple matches.

One thing is clear. The compatibility string here isn't going to be
like what I had in mind. So, let it just define the versioning
here and I will see how can I solve the driver-probe problem.
