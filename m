From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 13 Jan 2017 17:11:39 +0000
Subject: [PATCH] coresight: STM: Balance enable/disable
In-Reply-To: <CANLsYkyO-anR4V411tHFkNBPNy0Vk3DCympLScP9ZC=uJ-UX9g@mail.gmail.com>
References: <1484047315-14407-1-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkyO-anR4V411tHFkNBPNy0Vk3DCympLScP9ZC=uJ-UX9g@mail.gmail.com>
Message-ID: <c59476a6-f2c8-6b00-ca46-d2d2379d44c9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 16:48, Mathieu Poirier wrote:
> On 10 January 2017 at 04:21, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> The stm is automatically enabled when an application sets the policy
>> via ->link() call back by using coresight_enable(), which keeps the
>> refcount of the current users of the STM. However, the unlink() callback
>> issues stm_disable() directly, which leaves the STM turned off, without
>> the coresight layer knowing about it. This prevents any further uses
>> of the STM hardware as the coresight layer still thinks the STM is
>> turned on and doesn't issue an stm_enable(). Even manually enabling
>> the STM via sysfs can't really enable the hw.
>>
...
>>
>> This patch balances the unlink operation by using the coresight_disable(),
>> keeping the coresight layer in sync with the hardware state.
>>
>> Fixes: commit 237483aa5cf43 ("coresight: stm: adding driver for CoreSight STM component")
>> Cc: Pratik Patel <pratikp@codeaurora.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: stable at vger.kernel.org # 4.7+
>> Reported-by: Robert Walker <robert.walker@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-stm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
>> index 3524452..57b7330 100644
>> --- a/drivers/hwtracing/coresight/coresight-stm.c
>> +++ b/drivers/hwtracing/coresight/coresight-stm.c
>> @@ -356,7 +356,7 @@ static void stm_generic_unlink(struct stm_data *stm_data,
>>         if (!drvdata || !drvdata->csdev)
>>                 return;
>>
>> -       stm_disable(drvdata->csdev, NULL);
>> +       coresight_disable(drvdata->csdev);
>>  }
>>
>>  static phys_addr_t
>
> Applied - thanks,

Mathieu, Greg,

I think this should go into 4.10 (either way, as fix in this cycle or via stable after the release). I think
it would be easier if it goes in as fix during one of these rc cycle.

Please let me know your thoughts.

Suzuki

> Mathieu
>
>> --
>> 2.7.4
>>
