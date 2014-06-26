From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 26 Jun 2014 11:48:24 +0200
Subject: [PATCH V5 16/20] ARM: exynos: cpuidle: Move the power sequence
 call in the cpu_pm notifier
In-Reply-To: <CADWw7Ojjk9U95-Sh3WfK+OuKBJk4_XAJgGNrNmt7gcaAjxwVKQ@mail.gmail.com>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
 <1397212815-16068-17-git-send-email-daniel.lezcano@linaro.org>
 <CADWw7Ojjk9U95-Sh3WfK+OuKBJk4_XAJgGNrNmt7gcaAjxwVKQ@mail.gmail.com>
Message-ID: <53ABEC68.7060500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

On 26.06.2014 11:07, Chander Kashyap wrote:
> On Fri, Apr 11, 2014 at 4:10 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:

[snip]

>> @@ -359,6 +373,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>>         switch (cmd) {
>>         case CPU_PM_ENTER:
>>                 if (cpu == 0) {
>> +                       exynos_pm_central_suspend();
>>                         exynos_cpu_save_register();
>>                 }
>>                 break;
>> @@ -368,6 +383,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>>                         if (!soc_is_exynos5250())
>>                                 scu_enable(S5P_VA_SCU);
>>                         exynos_cpu_restore_register();
>> +                       exynos_pm_central_resume();
> 
> This notifier is called for system wide suspend and cpuidle.
> 
> In case of Exynos cpuidle only AFTR and LPA state need to program
> central_sequencer and store/restore the registers.
> 
> But in 5420 (core-power-down), this is not required, and causing the regression.
> 
> Hence need to remove this notifier, or need to find a way to
> differentiate the cpuidle state.

This patch is already present in v3.16. Moreover, Exynos5420 cpuidle has
not been merged yet. This means that this issue is not a regression and
I believe any further work on this should be carried out as further
patches on top of this change.

Anyway, this change has introduced a regression, though, but in another
area - it broke suspend, at least on Exynos4-based devices, because now
certain steps are performed twice. I've sent a patch for 3.16-rc3 to fix
this by dropping custom suspend-specific syscore ops, effectively moving
most of the handling to CPU PM notifier, which also matches requirements
of AFTR and lower power states. See [1].

[1]
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32935.html

However, in this case, moving back to suspend-specific syscore_ops and
simply duplicating some code for lower cpuidle states might be a better
option. Care to send a patch (fix for 3.16, replacing mine) or I should
do it?

Best regards,
Tomasz
