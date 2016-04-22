From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 22 Apr 2016 15:57:14 +0100
Subject: [PATCH] drivers: firmware: psci: unify enable-method binding on
 ARM {64,32}-bit systems
In-Reply-To: <20160422144440.GN10606@leverpostej>
References: <1461335911-13233-1-git-send-email-sudeep.holla@arm.com>
 <20160422144440.GN10606@leverpostej>
Message-ID: <571A3BCA.8060002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/04/16 15:44, Mark Rutland wrote:
> On Fri, Apr 22, 2016 at 03:38:31PM +0100, Sudeep Holla wrote:
>> Currently ARM CPUs DT bindings allows different enable-method value for
>> PSCI based systems. On ARM 64-bit this property is required and must be
>> "psci" while on ARM 32-bit systems this property is optional and must
>> be "arm,psci".
>
> FWIW, "arm,psci" has always been the compatible string for the PSCI
> node, and was never intended to be the enable-method. So as far as I can
> tell, this was a mistake/bug, and not a deliberate attempt at specifying
> 32-bit differently.
>

I agree.

>> This is problematic if 32-bit OS is run on 64-bit system which has
>> "psci" as enable-method rather than the expected "arm,psci".
>>
>> So let's unify the value into "psci" and remove support for "arm,psci"
>> before it finds any users.
>>
>> Reported-by: Soby Mathew <Soby.Mathew@arm.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> This was definitely a mistake, as "arm,psci" was the compatible string
> for the psci node, and was never the enable-method. So:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks.

> Hopefully no-one's begun to use this.
>

Seems so. Even the 32-bit kernel doesn't make use of that.

The first user was for idle(see below) which was added in v4.6 just to
keep it in sync with binding. It would be good to get it fixed before
the final v4.6

>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 11bfee8b79a9..b5d05807e6ec 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -360,7 +360,7 @@ static struct cpuidle_ops psci_cpuidle_ops __initdata = {
>>   	.init = psci_dt_cpu_init_idle,
>>   };
>>
>> -CPUIDLE_METHOD_OF_DECLARE(psci, "arm,psci", &psci_cpuidle_ops);
>> +CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);

-- 
Regards,
Sudeep
