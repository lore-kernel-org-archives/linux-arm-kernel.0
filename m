From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 6 Oct 2016 09:44:39 -0600
Subject: [PATCH 3/8] PM / Domains: Allow domain power states to be read
 from DT
In-Reply-To: <CAMuHMdU4HiauULf4fX67Cwj1GQmEExBiu4WyQPJBbj=xNg0eEQ@mail.gmail.com>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-4-git-send-email-lina.iyer@linaro.org>
 <CAMuHMdU4HiauULf4fX67Cwj1GQmEExBiu4WyQPJBbj=xNg0eEQ@mail.gmail.com>
Message-ID: <20161006154439.GC28930@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06 2016 at 02:04 -0600, Geert Uytterhoeven wrote:
>Hi Lina,
>
>On Wed, Oct 5, 2016 at 10:31 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> This patch allows domains to define idle states in the DT. SoC's can
>> define domain idle states in DT using the "domain-idle-states" property
>> of the domain provider. Calling of_pm_genpd_init() will  read the idle
>> states and initialize the genpd for the domain.
>>
>> In addition to the entry and exit latency for idle state, also add
>> residency_ns, param and of_node property to each state. A domain idling
>> in a state is only power effecient if it stays idle for a certain period
>> in that state. The residency provides this minimum time for the idle
>> state to provide power benefits. The param is a state specific u32 value
>> that the platform may use for that idle state.
>>
>> This patch is based on the original patch by Marc Titinger.
>>
>> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |   8 ++++
>>  2 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 740afa9..368a5b8 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1895,6 +1895,109 @@ out:
>>         return ret ? -EPROBE_DEFER : 0;
>>  }
>>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>> +
>> +static const struct of_device_id idle_state_match[] = {
>> +       { .compatible = "arm,idle-state", },
>
>Do we want ARM-specific compatible values without an #ifdef in drivers/base/?
>
>I know we already have "samsung,power-domain".
>Perhaps that should be protected by #ifdef, too.
>
The arm,idle-state DT binding is re-used here to describe domain idle
states, because that is exactly what we need here. The binding is not
dependent on the ARM architecture, so we won't need a #ifdef around
this. I do agree that using this compatible is not very intuitive.

Thanks,
Lina
