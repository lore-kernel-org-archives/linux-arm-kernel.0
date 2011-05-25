From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 May 2011 15:36:30 -0700
Subject: [PATCH 07/15] OMAP: GPIO: handle save/restore ctx in GPIO driver
In-Reply-To: <87ipsypfzk.fsf@ti.com> (Kevin Hilman's message of "Wed, 25 May
	2011 15:33:51 -0700")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-8-git-send-email-tarun.kanti@ti.com>
	<87ipsypfzk.fsf@ti.com>
Message-ID: <87boyqpfv5.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

[...]
>> @@ -1394,11 +1409,17 @@ void omap2_gpio_resume_after_idle(void)
>>  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
>>  			clk_enable(bank->dbck);
>>  
>> -		if (!workaround_enabled)
>> +		pdev = to_platform_device(bank->dev);
>> +		ctx_lost_cnt_after = omap_device_get_context_loss_count(pdev);
>> +
>> +		if (ctx_lost_cnt_after == bank->ctx_lost_cnt_before)
>>  			continue;
>>  
>> +		if (!workaround_enabled)
>> +			goto restore_gpio_ctx;
>
> Now that these functions are all bank-specific, this
> 'workaround_enabled' flag should be made per-bank.

Oops, ignore this comment... I see it's done in the next patch.

Kevin
