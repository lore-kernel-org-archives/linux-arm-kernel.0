From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 Aug 2013 10:59:22 +0530
Subject: [PATCH V2 00/35] CPUFreq: Implement light weight ->target(): for
 3.13
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpo=Kg9+68_aOpt-=YgNUvT_Srvgpd9t629X7DenrngNrKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2013 19:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Currently prototype of cpufreq_drivers target routines is:
>
> int target(struct cpufreq_policy *policy, unsigned int target_freq,
>         unsigned int relation);
>
> And most of the drivers call cpufreq_frequency_table_target() to get a valid
> index of their frequency table which is closest to the target_freq. And they
> don't use target_freq and relation after it.
>
> So, it makes sense to just do this work in cpufreq core before calling
> cpufreq_frequency_table_target() and simply pass index instead. But this can be
> done only with drivers which expose their frequency table with cpufreq core. For
> others we need to stick with the old prototype of target() until those drivers
> are converted to expose frequency tables.
>
> There are 7 drivers after this patchset which still use the heavy weight
> version, i.e. target() and 44 drivers have adopted this new approach, i.e.
> target_index().
>
> Once those 7 drivers are also moved to use .target_index(), .target() will be
> removed completely.

At a quick look at the status of drivers using target_index() it looks there is
scope of more optimizations around that part..

We can actually get rid of cpufreq_notify_transition() from those cpufreq
drivers and do that in core.. And that would cut down size of ->target_index()
routines even more :)

I will give it a try soon.
