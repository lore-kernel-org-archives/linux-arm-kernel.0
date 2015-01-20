From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 20 Jan 2015 11:02:53 +0800
Subject: [PATCH] kprobes: bugfix: set kprobes_all_disarmed earlier to
 enable re-optimization.
In-Reply-To: <54B3AED2.5070000@hitachi.com>
References: <1420461075-27012-1-git-send-email-wangnan0@huawei.com>
 <54B3AED2.5070000@hitachi.com>
Message-ID: <54BDC55D.3090200@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/12 19:24, Masami Hiramatsu wrote:
> (2015/01/05 21:31), Wang Nan wrote:
>> In original code, the probed instruction doesn't get optimized after
>>
>> echo 0 > /sys/kernel/debug/kprobes/enabled
>> echo 1 > /sys/kernel/debug/kprobes/enabled
>>
>> This is because original code checks kprobes_all_disarmed in
>> optimize_kprobe(), but this flag is turned off after calling that
>> function. Therefore, optimize_kprobe() will see
>> kprobes_all_disarmed == true and doesn't do the optimization.
> 
> OK, a workaround is to disable/enable optimizing via sysctl.
> 
>>
>> This patch simply turns off kprobes_all_disarmed earlier to enable
>> optimization.
>>
> 
> Anyway, thank you for finding that! :)
> 
> Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> 

Hi Masami Hiramatsu,

What about this patch? Are you still thinking on it like
'[PATCH] kprobes: bugfix: checks kprobes_all_disarmed in unoptimized_kprobe()' ?

Thank you.

> 
>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>> ---
>>  kernel/kprobes.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index bad4e95..b185464 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -2320,6 +2320,12 @@ static void arm_all_kprobes(void)
>>  	if (!kprobes_all_disarmed)
>>  		goto already_enabled;
>>  
>> +	/*
>> +	 * optimize_kprobe() called by arm_kprobe() checks
>> +	 * kprobes_all_disarmed, so set kprobes_all_disarmed before
>> +	 * arm_kprobe.
>> +	 */
>> +	kprobes_all_disarmed = false;
>>  	/* Arming kprobes doesn't optimize kprobe itself */
>>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>>  		head = &kprobe_table[i];
>> @@ -2328,7 +2334,6 @@ static void arm_all_kprobes(void)
>>  				arm_kprobe(p);
>>  	}
>>  
>> -	kprobes_all_disarmed = false;
>>  	printk(KERN_INFO "Kprobes globally enabled\n");
>>  
>>  already_enabled:
>>
> 
> 
