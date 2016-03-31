From: blogic@openwrt.org (John Crispin)
Date: Thu, 31 Mar 2016 16:07:20 +0200
Subject: [PATCH] mfd: mt6397: irq domain should initialize before
 mfd_add_devices()
In-Reply-To: <1459431711.395.6.camel@mtksdaap41>
References: <1459322708-21363-1-git-send-email-henryc.chen@mediatek.com>
 <56FB99DB.6010901@openwrt.org> <1459388452.18284.2.camel@mtksdaap41>
 <1459391533.21870.15.camel@mtksdaap41> <56FCE910.8030100@openwrt.org>
 <1459431711.395.6.camel@mtksdaap41>
Message-ID: <56FD2F18.4050508@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31/03/2016 15:41, Yingjoe Chen wrote:
> On Thu, 2016-03-31 at 11:08 +0200, John Crispin wrote:
>>
>> On 31/03/2016 04:32, Yingjoe Chen wrote:
>>> On Thu, 2016-03-31 at 09:40 +0800, Henry Chen wrote:
>>>> On Wed, 2016-03-30 at 11:18 +0200, John Crispin wrote:
>>>>> Hi,
>>>>>
>>>>> small nitpick inline
>>>>>
>>>>> On 30/03/2016 09:25, Henry Chen wrote:
>>>>>> Some sub driver like RTC module need irq domain from parent to create
>>>>>> irq mapping when driver initialize. so move mt6397_irq_init() before
>>>>>> mfd_add_devices().
>>>>>>
>>>>>> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
>>>>>> ---
>>>>>> This patch fixed the below warning based on "Linux kernel v4.6-rc1"
>>>>>> WARNING: CPU: 1 PID: 132 at kernel/mediatek/kernel/irq/irqdomain.c:471
>>>>>> irq_create_mapping+0xc4/0xd0
>>>>>> ---
>>>>>>  drivers/mfd/mt6397-core.c | 37 ++++++++++++++++++++++---------------
>>>>>>  1 file changed, 22 insertions(+), 15 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
>>>>>> index 8e8d932..a879223 100644
>>>>>> --- a/drivers/mfd/mt6397-core.c
>>>>>> +++ b/drivers/mfd/mt6397-core.c
>>>>>> @@ -270,22 +270,36 @@ static int mt6397_probe(struct platform_device *pdev)
>>>>>>  		goto fail_irq;
>>>>>>  	}
>>>>>>  
>>>>>> +	pmic->irq = platform_get_irq(pdev, 0);
>>>>>> +
>>>>>>  	switch (id & 0xff) {
>>>>>>  	case MT6323_CID_CODE:
>>>>>> -		pmic->int_con[0] = MT6323_INT_CON0;
>>>>>> -		pmic->int_con[1] = MT6323_INT_CON1;
>>>>>> -		pmic->int_status[0] = MT6323_INT_STATUS0;
>>>>>> -		pmic->int_status[1] = MT6323_INT_STATUS1;
>>>>>> +		if (pmic->irq > 0) {
>>>>>
>>>>> should this not be
>>>>>
>>>>> 		if (pmic->irq >= 0) {
>>>>>
>>>>> i think the code before your patch was wrong as linux irqs start with 0.
>>>>>
>>>>> 	John
>>>> Hi John,
>>>>
>>>> Thanks, I will modify this.
>>>
>>> Linux irq start from 1, 0 is invalid. I can't find the document saying
>>> this now, but you could see this from irq_create_mapping() in
>>> kernel/irq/irqdomain.c
>>>
>>> I think the code should have check return from platform_get_irq and
>>> handle -EPROBE_DEFER, but maybe it should be another patch?
>>>
>>> BTW, in this function, it is possible that pmic->irq_domain will be NULL
>>> in fail_irq error handling. We should check before calling
>>> irq_domain_remove.
>>>
>>> Joe.C
>>>
>>
>> Hi,
>>
>> looking at
>> http://lxr.free-electrons.com/source/drivers/base/platform.c#L87 there
>> is a check in line #100 ret >= 0
>>
>> checking the return value of pmic->irq = platform_get_irq(pdev, 0);
>> should follow the same pattern i think .. unless i have a thinko and am
>> reading the code wrong.
> 
> 
> I'm not sure why platform_get_irq() check for 0, but I think the code
> logic is differnet.
> 
> When platform_get_irq() return 0 to our code, it means we don't have
> valid irq to use. In this case it doesn't make any sense to continue
> init irq.
> 
> 
> Joe.C
> 


--> http://lwn.net/Articles/470820/

indeed ARM has changed this is seems. was not aware of this change,
sorry for the noise

	John
