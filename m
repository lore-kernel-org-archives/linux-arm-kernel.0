From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Sep 2017 14:40:49 +0100
Subject: [PATCH v3 17/22] firmware: arm_scmi: add device power domain
 support using genpd
In-Reply-To: <CAPDyKFo0oFrtGgb9REX-y3mAgQ7pTFnyD6ZcqwhEZ7oSRfV4oA@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-18-git-send-email-sudeep.holla@arm.com>
 <CAPDyKFo0oFrtGgb9REX-y3mAgQ7pTFnyD6ZcqwhEZ7oSRfV4oA@mail.gmail.com>
Message-ID: <68c18868-99c5-20e0-d65e-6ad1afdedde5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/09/17 22:18, Ulf Hansson wrote:
> On 28 September 2017 at 15:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This patch hooks up the support for device power domain provided by
>> SCMI using the Linux generic power domain infrastructure.
>>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/Kconfig                   |  13 +++
>>  drivers/firmware/arm_scmi/Makefile         |   1 +
>>  drivers/firmware/arm_scmi/scmi_pm_domain.c | 134 +++++++++++++++++++++++++++++
>>  3 files changed, 148 insertions(+)
>>  create mode 100644 drivers/firmware/arm_scmi/scmi_pm_domain.c
>>

[...]

>> +       for (i = 0; i < num_domains; i++, scmi_pd++) {
>> +               domains[i] = &scmi_pd->genpd;
>> +
>> +               scmi_pd->domain = i;
>> +               scmi_pd->handle = handle;
>> +               scmi_pd->name = handle->power_ops->name_get(handle, i);
>> +               scmi_pd->genpd.name = scmi_pd->name;
>> +               scmi_pd->genpd.power_off = scmi_pd_power_off;
>> +               scmi_pd->genpd.power_on = scmi_pd_power_on;
>> +
>> +               /*
>> +                * Treat all power domains as off at boot.
>> +                *
>> +                * The SCP firmware itself may have switched on some domains,
>> +                * but for reference counting purpose, keep it this way.
>> +                */
> 
> I think it would be better to give the correct information about the
> state of the PM domain. Otherwise genpd may end up thinking a PM
> domain is off, while in fact it's on - thus wasting power.
> 

Agreed, I missed to notice that. I will fixup and send the update.

-- 
Regards,
Sudeep
