From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 8 May 2012 10:28:55 +0200
Subject: [PATCH 1/6] ARM: OMAP2+: PM: protect the power domain state
 change by a mutex
In-Reply-To: <alpine.DEB.2.00.1205070033490.9984@utopia.booyaka.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
 <1334752782-28804-2-git-send-email-j-pihet@ti.com>
 <alpine.DEB.2.00.1205070033490.9984@utopia.booyaka.com>
Message-ID: <CAORVsuUQgz4xdG0t2n1+CX=m_=2_Uzyg6D6kEf5MqcG05zmQJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Thanks for the review. Do you plan to review the full set before I
start to address the comments.

On Mon, May 7, 2012 at 8:41 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Wed, 18 Apr 2012, jean.pihet at newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> This patch is missing a description, which would describe why this lock is
> needed and what it protects against. ?Please add this.
Ok

>
>> ---
>> ?arch/arm/mach-omap2/pm.c ? ? ? ? ?| ? ?8 ++++++--
>> ?arch/arm/mach-omap2/powerdomain.c | ? ?1 +
>> ?arch/arm/mach-omap2/powerdomain.h | ? ?3 ++-
>> ?3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index d0c1c96..6918a13 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -100,15 +100,17 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
>> ? ? ? if (!pwrdm || IS_ERR(pwrdm))
>> ? ? ? ? ? ? ? return -EINVAL;
>>
>> + ? ? mutex_lock(&pwrdm->lock);
>> +
>> ? ? ? while (!(pwrdm->pwrsts & (1 << pwrst))) {
>> ? ? ? ? ? ? ? if (pwrst == PWRDM_POWER_OFF)
>> - ? ? ? ? ? ? ? ? ? ? return ret;
>> + ? ? ? ? ? ? ? ? ? ? goto out;
>> ? ? ? ? ? ? ? pwrst--;
>> ? ? ? }
>>
>> ? ? ? next_pwrst = pwrdm_read_next_pwrst(pwrdm);
>> ? ? ? if (next_pwrst == pwrst)
>> - ? ? ? ? ? ? return ret;
>> + ? ? ? ? ? ? goto out;
>>
>> ? ? ? curr_pwrst = pwrdm_read_pwrst(pwrdm);
>> ? ? ? if (curr_pwrst < PWRDM_POWER_ON) {
>> @@ -141,6 +143,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
>> ? ? ? ? ? ? ? break;
>> ? ? ? }
>>
>> +out:
>> + ? ? mutex_unlock(&pwrdm->lock);
>> ? ? ? return ret;
>> ?}
>>
>
> So this mutex would protect against simultaneous calls to
> omap_set_pwrdm_state(), but shouldn't this protection be extended to
> anything that would change the powerdomain's state? ?For example, couldn't
> other calls to pwrdm_set_next_pwrst() race against this function?
The intention behind this patch set is to change the API to only use
omap_set_pwrdm_state to change the power domains states. Probably I
should emphasize more on that in the cover letter and commits
description.

>
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index 96ad3dbe..319b277 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -102,6 +102,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>> ? ? ? INIT_LIST_HEAD(&pwrdm->voltdm_node);
>> ? ? ? voltdm_add_pwrdm(voltdm, pwrdm);
>>
>> + ? ? mutex_init(&pwrdm->lock);
>> ? ? ? list_add(&pwrdm->node, &pwrdm_list);
>>
>> ? ? ? /* Initialize the powerdomain's state counter */
>> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
>> index 0d72a8a..6c6567d 100644
>> --- a/arch/arm/mach-omap2/powerdomain.h
>> +++ b/arch/arm/mach-omap2/powerdomain.h
>> @@ -19,7 +19,7 @@
>>
>> ?#include <linux/types.h>
>> ?#include <linux/list.h>
>> -
>> +#include <linux/mutex.h>
>> ?#include <linux/atomic.h>
>>
>> ?#include <plat/cpu.h>
>> @@ -116,6 +116,7 @@ struct powerdomain {
>> ? ? ? struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
>> ? ? ? struct list_head node;
>> ? ? ? struct list_head voltdm_node;
>> + ? ? struct mutex lock;
>> ? ? ? int state;
>> ? ? ? unsigned state_counter[PWRDM_MAX_PWRSTS];
>> ? ? ? unsigned ret_logic_off_counter;
>
> Please add a kerneldoc entry in the struct powerdomain documentation for
> this field.
Ok

>
>
> - Paul

Thanks,
Jean
