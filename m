From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Oct 2017 14:02:58 +0100
Subject: [PATCH v3 17/22][UPDATE] firmware: arm_scmi: add device power
 domain support genpd
In-Reply-To: <CAPDyKFpCxJXgT9F7_xq3eL13hnuhOy1sW8ipv0YeitfFhmOcNA@mail.gmail.com>
References: <1506604306-20739-18-git-send-email-sudeep.holla@arm.com>
 <1506692575-7743-1-git-send-email-sudeep.holla@arm.com>
 <CAPDyKFpCxJXgT9F7_xq3eL13hnuhOy1sW8ipv0YeitfFhmOcNA@mail.gmail.com>
Message-ID: <44ccfb6b-893c-14d9-d373-d00c5bce3f06@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/10/17 12:05, Ulf Hansson wrote:
> On 29 September 2017 at 15:42, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This patch hooks up the support for device power domain provided by
>> SCMI using the Linux generic power domain infrastructure.
>>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/Kconfig                   |  13 +++
>>  drivers/firmware/arm_scmi/Makefile         |   1 +
>>  drivers/firmware/arm_scmi/scmi_pm_domain.c | 136 +++++++++++++++++++++++++++++
>>  3 files changed, 150 insertions(+)
>>  create mode 100644 drivers/firmware/arm_scmi/scmi_pm_domain.c
>>
>> - updated to read the initial state instead of assuming off as
>>   suggested by Ulf
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index c3d1a12763ce..a4462bc661c8 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -40,6 +40,19 @@ config ARM_SCMI_PROTOCOL

[..]

>> +               domains[i] = &scmi_pd->genpd;
>> +
>> +               scmi_pd->domain = i;
>> +               scmi_pd->handle = handle;
>> +               scmi_pd->name = handle->power_ops->name_get(handle, i);
>> +               scmi_pd->genpd.name = scmi_pd->name;
>> +               scmi_pd->genpd.power_off = scmi_pd_power_off;
>> +               scmi_pd->genpd.power_on = scmi_pd_power_on;
>> +
>> +               if (handle->power_ops->state_get(handle, i, &state)) {
>> +                       dev_dbg(dev, "failed to get state for domain %d\n", i);
> 
> Perhaps dev_warn() instead?
> 

Will do.

[..]

> 
> Besides the nitpick above, feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 

Thanks.

-- 
Regards,
Sudeep
