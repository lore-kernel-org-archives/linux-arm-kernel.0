From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 21 Jul 2014 12:23:51 +0200
Subject: [PATCH v3] ARM: EXYNOS: Fix suspend/resume sequences
In-Reply-To: <53C53A1A.6060701@samsung.com>
References: <53C51B57.9040404@samsung.com>
 <1405434287-22710-1-git-send-email-t.figa@samsung.com>
 <53C53A1A.6060701@samsung.com>
Message-ID: <53CCEA37.4060104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

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

This is an important regression fix for 3.16 and today 3.16-rc6 was
already released...

Kukjin, could you pick up this patch and few others you missed and make
sure that it is included in 3.16-rc7? If you are busy, maybe Arnd or
Olof could take them directly?

Best regards,
Tomasz
