From: arvind.yadav.cs@gmail.com (arvindY)
Date: Sun, 3 Dec 2017 01:56:38 +0530
Subject: [PATCH 08/10] net: fjes: Handle return value of platform_get_irq
 and platform_get_resource
In-Reply-To: <1bbebd1a-4cca-0ef0-bdc1-ae50a4218f30@cogentembedded.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1512242782-7134-9-git-send-email-arvind.yadav.cs@gmail.com>
 <1bbebd1a-4cca-0ef0-bdc1-ae50a4218f30@cogentembedded.com>
Message-ID: <5A230C7E.4050705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sunday 03 December 2017 01:36 AM, Sergei Shtylyov wrote:
> Hello!
>
> On 12/02/2017 10:26 PM, Arvind Yadav wrote:
>
>> platform_get_irq() and platform_get_resource() can fail here and
>> we must check its return value.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/net/fjes/fjes_main.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
>> index 750954b..540dd51 100644
>> --- a/drivers/net/fjes/fjes_main.c
>> +++ b/drivers/net/fjes/fjes_main.c
>> @@ -1265,9 +1265,19 @@ static int fjes_probe(struct platform_device 
>> *plat_dev)
>>       adapter->interrupt_watch_enable = false;
>>         res = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
>> +    if (!res) {
>> +        err = -EINVAL;
>> +        goto err_free_netdev;
>> +    }
>> +
>>       hw->hw_res.start = res->start;
>>       hw->hw_res.size = resource_size(res);
>>       hw->hw_res.irq = platform_get_irq(plat_dev, 0);
>> +    if (hw->hw_res.irq <= 0) {
>
>    This function no longer returns 0 on error, no need to check for <= 0.
>
>> +        err = hw->hw_res.irq ? hw->hw_res.irq : -ENODEV;
>> +        goto err_free_netdev;
>
>    gcc allows a shorter way to write that.
>
>         err = hw->hw_res.irq ?: -ENODEV;
Yes, you are right, But first is more readable. That's why I have used.
>
>> +    }
>> +
>>       err = fjes_hw_init(&adapter->hw);
>>       if (err)
>>           goto err_free_netdev;
>
> MBR, Sergei
Thanks,
~arvind
