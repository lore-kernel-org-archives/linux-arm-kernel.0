From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Jul 2014 16:42:26 +0200
Subject: [PATCH v3] ARM: EXYNOS: Fix suspend/resume sequences
In-Reply-To: <53C53A1A.6060701@samsung.com>
References: <53C51B57.9040404@samsung.com>
 <1405434287-22710-1-git-send-email-t.figa@samsung.com>
 <53C53A1A.6060701@samsung.com>
Message-ID: <53C7E0D2.1050307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 15.07.2014 16:26, Tomasz Figa wrote:
> Forgot to CC Daniel and linux-pm. Sorry for the noise.
> 
> On 15.07.2014 16:24, Tomasz Figa wrote:
>> Due to recent consolidation of Exynos suspend and cpuidle code, some
>> parts of suspend and resume sequences are executed two times, once from
>> exynos_pm_syscore_ops and then from exynos_cpu_pm_notifier() and thus it
>> breaks suspend, at least on Exynos4-based boards. In addition, simple
>> core power down from a cpuidle driver could, in case of CPU 0 could
>> result in calling functions that are specific to suspend and deeper idle
>> states.
>>
>> This patch fixes the issue by moving those operations outside the CPU PM
>> notifier into suspend and AFTR code paths. This leads to a bit of code
>> duplication, but allows additional code simplification, so in the end
>> more code is removed than added.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  arch/arm/mach-exynos/pm.c        | 164 ++++++++++++++++++---------------------
>>  drivers/cpuidle/cpuidle-exynos.c |  25 +-----
>>  2 files changed, 80 insertions(+), 109 deletions(-)
>>

Please consider this patch for next pull request with rc fixes. It
replaces following patches posted in this thread:

[PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies
[PATCH v2 5/6] ARM: EXYNOS: Fix suspend/resume sequences

and also similar patch by Chander:

[PATCH 2/2] cpuidle: Exynos: fix cpuidle for all states

Best regards,
Tomasz
