From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 31 May 2013 18:30:52 -0700
Subject: [PATCH] arm: Prevent memory aliasing on non-LPAE kernels
In-Reply-To: <3054064.aJsgTxiNUL@wuerfel>
References: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
 <3054064.aJsgTxiNUL@wuerfel>
Message-ID: <51A94ECC.5090303@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2013 3:24 PM, Arnd Bergmann wrote:
>> +       if (size > ((phys_addr_t)~0))
>> +               size = ((phys_addr_t)~0);
>> +
>> +       /* arm_add_memory() already checks for the case of base + size > 4GB */
>> +#endif
>>          arm_add_memory(base, size);
>>   }
>
> This looks wrong for the case where 'base' is between >0 and 4GB and 'size'
> makes it spill over the 4GB boundary. You need to set
> 'size = (phys_addr_t)~0 - base' then.
>

Ah. I believe arm_add_memory() already has the logic to handle this 
case. Here, we are just trying to shrink 'size' to fit into phys_addr_t, 
since it is currently u64 but arm_add_memory() uses phys_addr_t for its 
arguments. I did not want to have this logic in two places, but I can do 
what you said if you like.


-- 
  The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
  hosted by The Linux Foundation
