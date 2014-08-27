From: nm@ti.com (Nishanth Menon)
Date: Wed, 27 Aug 2014 14:35:01 -0500
Subject: [PATCH 08/10] ARM: OMAP5/DRA7: PM: cpuidle MPU CSWR support
In-Reply-To: <7hvbpdbvb1.fsf@paris.lan>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
 <1408716154-26101-9-git-send-email-nm@ti.com>
 <7hvbpdbvb1.fsf@paris.lan>
Message-ID: <CAGo_u6o7vAf=syzDTyxh0-kOhmzAmtdG_ardgFgoPQofrGdxUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 2:13 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> + Daniel (cpuidle maintainer)
[...]
>> +static int omap_enter_idle_smp(struct cpuidle_device *dev,
>> +                            struct cpuidle_driver *drv,
>> +                            int index)
>> +{
>> +     struct idle_statedata *cx = state_ptr + index;
>> +     unsigned long flag;
>> +
>> +     raw_spin_lock_irqsave(&mpu_lock, flag);
>> +     cx->mpu_state_vote++;
>> +     if (cx->mpu_state_vote == num_online_cpus()) {
>> +             pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
>> +             omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
>> +     }
>> +     raw_spin_unlock_irqrestore(&mpu_lock, flag);
>> +
>> +     omap4_enter_lowpower(dev->cpu, cx->cpu_state);
>> +
>> +     raw_spin_lock_irqsave(&mpu_lock, flag);
>> +     if (cx->mpu_state_vote == num_online_cpus())
>> +             omap_set_pwrdm_state(mpu_pd, PWRDM_POWER_ON);
>> +     cx->mpu_state_vote--;
>> +     raw_spin_unlock_irqrestore(&mpu_lock, flag);
>> +
>> +     return index;
>> +}
>
> Hmm, maybe OMAP5/DRA7 CPUidle driver should be a new one based on MCPM?

Trying to understand benefit of MCPM here - at least without a deeper
understanding of mcpm infrastructure benefits (first look seemed a
little heavy for OMAP5/DRA7 needs).

Neither DRA7/OMAP5 are multi-cluster, the SoCs are not targetted for
"OFF" of CPU1/0, we have mercury hardware to help with context and
sync issues.

Being able to reuse most of existing OMAP4 infrastructure code is
useful as well to leave the existing omap4 framework as being lighter
in complexity -esp in a cpuidle like hot path?

The spin_lock is only for the programming of MPU power domain in a
consistent manner - I suppose might have been the trigger for
proposing mcpm?

---
Regards,
Nishanth Menon
