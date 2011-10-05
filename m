From: javi.merino@arm.com (Javi Merino)
Date: Wed, 05 Oct 2011 13:57:09 +0100
Subject: [PATCH] ARM: pl330: Fix a race condition
In-Reply-To: <4E7896D8.5090606@arm.com>
References: <1316452291-19632-1-git-send-email-javi.merino@arm.com>
	<CABb+yY0BGHSMA08uDMNkdSehFkQ_9afzzbkdpPkD0cz3owVWBQ@mail.gmail.com>
	<4E7896D8.5090606@arm.com>
Message-ID: <4E8C5425.80303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/11 14:36, Javi Merino wrote:
> On 19/09/11 19:07, Jassi Brar wrote:
>> IIUIC your race scenario should be taken care of simply by doing...
>>
>> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
>> index 97912fa..7129cfb 100644
>> --- a/arch/arm/common/pl330.c
>> +++ b/arch/arm/common/pl330.c
>> @@ -1546,7 +1546,7 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
>>
>>  		/* Start the next */
>>  	case PL330_OP_START:
>> -		if (!_start(thrd))
>> +		if (!_thrd_active(thrd) && !_start(thrd))
>>  			ret = -EIO;
>>  		break;
>>
> 
> My first reaction was this was just moving the race condition, but
> thinking about it carefully, it looks like a better (simpler) solution.
> 
>> Could you please test if it fixes the issue?
> 
> Yes, I'll kick off runs later today and see how it goes.  I don't have a
> way to reproduce the bug consistently, I just do lots of DMA
> transactions and eventually, I end up hitting it.  I'll run it overnight
> and see if it fixes it or not.

I have run a lot of tests using your patch and I haven't been able to
reproduce the bug so your proposed solution is probably a better
(simpler) fix than mine.

Cheers,
Javi
