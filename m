From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 11 Jun 2014 08:44:49 +0900
Subject: [RESEND PATCH] ARM: EXYNOS: Fix the sequence of secondary CPU boot
 for Exynos3250
In-Reply-To: <5397963F.30109@gmail.com>
References: <1402442827-2321-1-git-send-email-cw00.choi@samsung.com>
 <5397963F.30109@gmail.com>
Message-ID: <53979871.2020903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 08:35 AM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 11.06.2014 01:27, Chanwoo Choi wrote:
>> This patch set AUTOWAKEUP_EN bit to ARM_CORE_CONFIGURATION register
>> because Exynos3250 removes WFE in secure mode so that turn on automatically
>> after setting CORE_LOCAL_PWR_EN. Also, This patch use dbs_sev() macro
>> to guarantee the data synchronization of command instead of IPI_WAKEUP
>> because Exynos3250 don't have WFE mode in secue mode.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos/platsmp.c  | 9 ++++++++-
>>  arch/arm/mach-exynos/pm.c       | 8 ++++++--
>>  arch/arm/mach-exynos/regs-pmu.h | 4 ++++
>>  3 files changed, 18 insertions(+), 3 deletions(-)
>>
> 
> This patch seems to be unneeded with Krzysztof's patch send a while ago
> [1]. As reported by Krzysztof, that patch apparently fixes SMP support
> on Exynos3250 and is much smaller and less invasive.
> 
> [1] - http://thread.gmane.org/gmane.linux.kernel.samsung-soc/32809

OK,
But Krzysztof's patch didn't include set S5P_CORE_AUTOWAKEUP_EN in EXYNOS_ARM_CORE_CONFIGURATION(cpu).
and then use arch_send_wakeup_ipi_mask(cpumask_of(cpu)) command instead of dsb_sev(). Exynos3250 don't need
send IPI message.

I'll send next patch which include only S5P_CORE_AUTOWAKEUP_EN and without sending IPI message.

Krzysztof's patch used of_machine_is_compatible("samsung,exynos3250") instead of soc_is_exynos3250().
Did you agree? If you agree to use of_machine_is_compatible(), I'll use it on next patch(v2).

Best Regards,
Chanwoo Choi
