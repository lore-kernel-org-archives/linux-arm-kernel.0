From: zhongjiang@huawei.com (zhong jiang)
Date: Mon, 13 Aug 2018 21:07:28 +0800
Subject: [PATCH] arm:pm: Use kmemdup to replace duplicating its
 implementation
In-Reply-To: <37f8ff09-b0c2-5cc6-87d4-8138e7b66b32@mleia.com>
References: <1533868851-316-1-git-send-email-zhongjiang@huawei.com>
 <37f8ff09-b0c2-5cc6-87d4-8138e7b66b32@mleia.com>
Message-ID: <5B718290.4010302@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/8/13 20:28, Vladimir Zapolskiy wrote:
> Hi zhong jiang,
>
> On 08/10/2018 05:40 AM, zhong jiang wrote:
>> kmemdup is better than kmalloc() + memcpy(), and we do not like
>> open code. So just use kmemdup instead.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/arm/mach-lpc32xx/pm.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
>> index 6247157..6eefff8 100644
>> --- a/arch/arm/mach-lpc32xx/pm.c
>> +++ b/arch/arm/mach-lpc32xx/pm.c
>> @@ -86,7 +86,8 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>>  	void *iram_swap_area;
>>  
>>  	/* Allocate some space for temporary IRAM storage */
>> -	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
>> +	iram_swap_area = kmemdup((void *)TEMP_IRAM_AREA,
>> +				lpc32xx_sys_suspend_sz, GFP_KERNEL);
> there is a minor coding style issue, which is reported by checkpatch:
>
> CHECK: Alignment should match open parenthesis
> #53: FILE: arch/arm/mach-lpc32xx/pm.c:90:
>
> Other than that the change is valid, I'll fix the indentation issue
> myself and apply the change for v4.19.
 Thank you for doing this. I will notice that for next time.

 Sincerely,
 zhong jiang
> --
> Best wishes,
> Vladimir
>
>>  	if (!iram_swap_area) {
>>  		printk(KERN_ERR
>>  		       "PM Suspend: cannot allocate memory to save portion "
>> @@ -94,10 +95,6 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>>  		return -ENOMEM;
>>  	}
>>  
>> -	/* Backup a small area of IRAM used for the suspend code */
>> -	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
>> -		lpc32xx_sys_suspend_sz);
>> -
>>  	/*
>>  	 * Copy code to suspend system into IRAM. The suspend code
>>  	 * needs to run from IRAM as DRAM may no longer be available
>>
>
> .
>
