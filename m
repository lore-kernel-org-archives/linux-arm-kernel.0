From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Jul 2014 13:55:57 +0530
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <20140723072442.GC15759@ulmo.nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
 <20140723065412.GA15759@ulmo.nvidia.com>
 <CAKohponmg24pvnX2Jhfg5LHKKHx3VEm-6a_JXTGhVXY-aj3EOw@mail.gmail.com>
 <20140723072442.GC15759@ulmo.nvidia.com>
Message-ID: <CAKohponfKzuK+TnQvWcvaT8hRX8XZJWXWGMQw138DCwP=qcx+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 July 2014 12:54, Thierry Reding <thierry.reding@gmail.com> wrote:
> ARM_TEGRA_CPUFREQ is still optional, so the select only applies when the
> Tegra cpufreq driver is enabled. This is mostly just out of convenience,
> though. The Tegra cpufreq driver uses the generic CPU0 cpufreq driver so
> a select will automatically pull in the necessary dependency. With a

Not necessarily. cpufreq-cpu0 can have few unmet dependency. And so
there are chances that tegra driver is compiled but cpufreq-cpu0 isn't as
we didn't mention it as a *hard* dependency.

And so at boot, there wouldn't be any cpufreq support even when tegra's
cpufreq driver is available.

Though, menuconfig may give some warnings no such situations.

> "depends on" the Tegra cpufreq driver only becomes available after
> you've selected GENERIC_CPUFREQ_CPU0, which is somewhat unintuitive.
>
> To illustrate with an example: as a user, I want to enable CPU frequency
> scaling on Tegra. So I use menuconfig to navigate to the "CPU Frequency
> scaling" menu (enable it if not available yet) and look for an entry
> that says "Tegra". But I can't find it because it's hidden due to the
> lack of GENERIC_CPUFREQ_CPU0. That the Tegra CPU frequency driver uses a
> generic driver is an implementation detail that users shouldn't have to
> be aware of.

Don't know, the guy compiling out stuff should be knowledgeable enough to
have a look why tegra cpufreq entry isn't shown in menu. As, probably the
above problem I mentioned looks to be of more significance than this one,
atleast to me :)

And, another thing to mention is that CONFIG_TEGRA_CPUFREQ is valid
for earlier platforms as well and so a select/depends wouldn't be valid for
earlier platforms. We probably need another Kconfig entry here.

> But we're using cpu_dev->of_node, so we need to make sure cpu_dev
> doesn't go away suddenly. Simply keeping a reference to ->of_node
> won't ensure that.

Oh, yeah I completely agree, but don't see that as a normal code style
people follow. Probably they take cpu for granted, which doesn't look
right :)

> I guess technically it would be better if get_cpu_device() already
> incremented the reference count on the returned struct device. Currently
> it would theoretically still be possible for the device to disappear
> between the call to get_cpu_device() and a call to get_device().

I agree again.
