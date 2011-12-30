From: b32955@freescale.com (Huang Shijie)
Date: Fri, 30 Dec 2011 16:17:54 +0800
Subject: [PATCH] MTD/GPMI bugfix : reset the BCH module when it is not MX23
In-Reply-To: <20111230074643.GA3018@tarshish>
References: <1325215690-22209-1-git-send-email-b32955@freescale.com>
 <20111230074643.GA3018@tarshish>
Message-ID: <4EFD73B2.7020801@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch:
> Hi Huang,
>
> On Fri, Dec 30, 2011 at 11:28:10AM +0800, Huang Shijie wrote:
>> In MX28, if we do not reset the BCH module. The BCH module may
>> becomes unstable when the board reboots for several thousands times.
>> This bug has been catched in customer's production.
>>
>> The patch adds some comments, and fixes it now.
>>
>> Also change gpmi_reset_block() to static.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
> [snip]
>
>> -	ret = gpmi_reset_block(r->bch_regs, true);
>> +	/* The bug only exits in mx23, the following chips fix it. */
>> +	if (GPMI_IS_MX23(this))
>> +		ret = gpmi_reset_block(r->bch_regs, true);
>> +	else
>> +		ret = gpmi_reset_block(r->bch_regs, false);
> This can be shortened to:
>
>      ret = gpmi_reset_block(r->bch_regs, GPMI_IS_MX23(this));
thanks a lot.

I will use it in new patch.

Huang Shijie
>>   	if (ret)
>>   		goto err_out;
>>
>> -- 
>> 1.7.0.4
> baruch
>
