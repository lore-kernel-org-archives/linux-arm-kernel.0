From: jibin.xu@windriver.com (Jibin Xu)
Date: Mon, 11 Sep 2017 17:55:05 +0800
Subject: [PATCH] sysrq : fix Show Regs call trace on ARM
In-Reply-To: <8c09c309-e088-1dd6-8d6f-f8929acf0f5f@suse.cz>
References: <20170911031142.254308-1-jibin.xu@windriver.com>
 <8c09c309-e088-1dd6-8d6f-f8929acf0f5f@suse.cz>
Message-ID: <5dd5bb30-15af-ab44-8b56-57c3c1d53bc4@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,Jiri:

get_irq_regs() in the softirq context return NULL.

thanks,
Jibin Xu

On 2017?09?11? 13:24, Jiri Slaby wrote:
> On 09/11/2017, 05:11 AM, Jibin Xu wrote:
> ...
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -245,8 +245,10 @@ static void sysrq_handle_showallcpus(int key)
>>   	 * architecture has no support for it:
>>   	 */
>>   	if (!trigger_all_cpu_backtrace()) {
>> -		struct pt_regs *regs = get_irq_regs();
>> +		struct pt_regs *regs = NULL;
>>   
>> +		if (in_irq())
>> +			regs = get_irq_regs();
> Maybe a stupid question: how does get_irq_regs() behave in the softirq
> context? I.e. what about s/in_irq/in_interrupt/?
>
> thanks,
