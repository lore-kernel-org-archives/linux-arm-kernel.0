From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Tue, 25 Nov 2014 16:47:46 +0530
Subject: [RFC PATCH] regulator: core: do not disable regulator if boot_on
 is set
In-Reply-To: <1416913037.2741.1.camel@pengutronix.de>
References: <1416912803-10772-1-git-send-email-pramod.gurav@smartplayin.com>
 <1416913037.2741.1.camel@pengutronix.de>
Message-ID: <5474655A.9090201@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 04:27 PM, Lucas Stach wrote:
> Am Dienstag, den 25.11.2014, 16:23 +0530 schrieb Pramod Gurav:
>> Currently the regulator core disables the regulators which are unused
>> or whose reference count is zero or if they are configured always_on.
>> This change adds a check in this logic to see if a regulator is
>> configured as boot_on and does not disable it if found true.
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>>
>> ---
>>
>> The issue was found on apq8064 based IFC6410 on which a fixed regulator
>> configured as regulator-boot-on in DT and was being disabled when not in
>> use. Tested this change on this board and found working.
>>
> Um, why would this be the correct fix? regulator-boot-on just tells the
> regulator core that the bootloader might have left this regulator
> enabled. If you want it to stay on after the kernel finished init you
> need to mark it as always-on.

Thanks Lucas. Shall mark it as alway_on.
> 
>>  drivers/regulator/core.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>> index cd87c0c..9f7a13f 100644
>> --- a/drivers/regulator/core.c
>> +++ b/drivers/regulator/core.c
>> @@ -4019,7 +4019,7 @@ static int __init regulator_init_complete(void)
>>  		ops = rdev->desc->ops;
>>  		c = rdev->constraints;
>>  
>> -		if (c && c->always_on)
>> +		if (c && (c->always_on || c->boot_on))
>>  			continue;
>>  
>>  		if (c && !(c->valid_ops_mask & REGULATOR_CHANGE_STATUS))
> 
