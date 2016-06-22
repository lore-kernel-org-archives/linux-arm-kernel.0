From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 22 Jun 2016 12:07:16 +0100
Subject: [PATCH] coresight: etm4x: request to retain power to the trace
 unit when active
In-Reply-To: <576A6C84.4090304@arm.com>
References: <1466590513-22505-1-git-send-email-sudeep.holla@arm.com>
 <576A6C84.4090304@arm.com>
Message-ID: <576A7164.9090504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/06/16 11:46, Suzuki K Poulose wrote:
> On 22/06/16 11:15, Sudeep Holla wrote:
>> The Coresight ETMv4 architecture provides a way to request to keep the
>> power to the trace unit. This might help to collect the traces without
>> the need to disable the CPU power management(entering/exiting deeper
>> idle states).
>>
>> Trace PowerDown Control Register provides powerup request bit which when
>> set requests the system to retain power to the trace unit and emulate
>> the powerdown request.
>>
>> Typically, a trace unit drives a signal to the power controller to
>> request that the trace unit core power domain is powered up. However,
>> if the trace unit and the CPU are in the same power domain then the
>> implementation might combine the trace unit power up status with a
>> signal from the CPU.
>>
>> This patch requests to retain power to the trace unit when active and
>> to remove when inactive. Note this change will only request but the
>> behaviour depends on the implementation. However, it matches the
>> exact behaviour expected when the external debugger is connected with
>> respect to CPU power states.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
>
> Thanks for debugging this issue patiently and fixing it :)
> One comment below.
>

[...]

>>
>> @@ -293,6 +299,9 @@ static void etm4_disable_hw(void *info)
>
>>
>> +    /* power can be removed from the trace unit now */
>> +    writel_relaxed(0, drvdata->base + TRCPDCR);
>> +
>
> At the moment the other bits in TRCPDCR are reserved (RES0). However
> to prevent issues in the future, it would be safer to read the value
> and set/clear the Bit of our interest than blindly writing those values.

Agreed, I had done exactly like than when I wrote it initially and then
change seeing few other writes in the driver. Anyways fixed now and v2
on its way.

-- 
Regards,
Sudeep
