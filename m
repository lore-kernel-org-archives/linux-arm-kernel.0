From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 08 Aug 2013 01:25:08 +0200
Subject: [PATCH] cpufreq: exynos5440: Fix to skip when new frequency same
 as current
In-Reply-To: <CAKohpom0gPk9BXRP2eEuX_HBXDut=wynrZfvOH1tcEQY6CMLNQ@mail.gmail.com>
References: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
 <52022FC2.2010109@arm.com>
 <CAKohpom0gPk9BXRP2eEuX_HBXDut=wynrZfvOH1tcEQY6CMLNQ@mail.gmail.com>
Message-ID: <2331427.ybQdfvflPh@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 07, 2013 05:03:59 PM Viresh Kumar wrote:
> On 7 August 2013 17:00, Sudeep KarkadaNagesha
> <Sudeep.KarkadaNagesha@arm.com> wrote:
> > Any particular reason we need this check in all drivers after your
> > commit: 5a1c0228 "cpufreq: Avoid calling cpufreq driver's target()
> > routine if target_freq == policy->cur"
> >
> > I think it can removed from all drivers, am I missing something ?
> 
> Yeah.. Just a bit though :)
> 
> So, cpufreq core checks this when we call target for any frequency.
> Now, cpufreq driver actually does a cpufreq_frequency_table_target()
> and so the frequency may vary than what is requested, in case
> requested frequency isn't picked from the table.
> 
> In such cases we check it again to be sure that we aren't at this
> frequency already..
> 
> Earlier I thought of calling cpufreq_frequency_table_target() in the
> core before calling target but dropped the idea as I wasn't sure of
> the side effects.
> 
> @Rafael: Do you see why we shouldn't/can't call
> cpufreq_frequency_table_target() from the core itself and so drivers
> never need to do it?

It looks like it would require us to redefine .target() to take next_state
instead of target_freq (at least in the acpi-cpufreq case), wouldn't it?

Rafael
