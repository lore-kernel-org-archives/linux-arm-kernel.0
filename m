From: ccross@android.com (Colin Cross)
Date: Thu, 26 Jan 2012 23:10:58 -0800
Subject: [PATCH v1 3/3] ARM: tegra: cpuidle driver for tegra
In-Reply-To: <B5906170F1614E41A8A28DE3B8D1214331791EA6@DBDE01.ent.ti.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
 <1327594923-21822-4-git-send-email-pdeschrijver@nvidia.com>
 <B5906170F1614E41A8A28DE3B8D1214331791EA6@DBDE01.ent.ti.com>
Message-ID: <CAMbhsRQ00Cm-wo9hL9jRfpUfATPZc+znNJu-EagK6qV0qRs4SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 10:59 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> On Thu, Jan 26, 2012 at 21:52:03, Peter De Schrijver wrote:
> [...]
>> +static int tegra_idle_enter_lp3(struct cpuidle_device *dev,
>> + ? ? struct cpuidle_driver *drv, int index)
>> +{
>> + ? ? ktime_t enter, exit;
>> + ? ? s64 us;
>> +
>> + ? ? local_irq_disable();
>> + ? ? local_fiq_disable();
>> +
>> + ? ? enter = ktime_get();
>> +
>> + ? ? tegra_cpu_wfi();
>> +
>> + ? ? exit = ktime_sub(ktime_get(), enter);
>> + ? ? us = ktime_to_us(exit);
>> +
>> + ? ? local_fiq_enable();
>> + ? ? local_irq_enable();
>> +
>> + ? ? dev->last_residency = us;
>> +
>> + ? ? return index;
>> +}
>
> You can probably drop local_irq_disable() and local_irq_enable().

local_irq_enable() is required by the cpuidle call semantics.  See
arch/arm/process.c, it has a 				WARN_ON(irqs_disabled()) after the
idle function call.  The local_irq_disable() can and probably should
be dropped, although a comment that the function is called with
interrupts off and is expected to return with interrupts on would be
helpful.
