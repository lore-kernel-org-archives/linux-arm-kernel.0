From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Dec 2016 10:02:54 +0100
Subject: [PATCH v2] rtc: armada38x: Followed the new recommendation for
 errata implementation
In-Reply-To: <20161221004308.terkq5u5pb2hbcbw@piout.net> (Alexandre Belloni's
 message of "Wed, 21 Dec 2016 01:43:08 +0100")
References: <20161213112510.25692-1-gregory.clement@free-electrons.com>
 <20161221004308.terkq5u5pb2hbcbw@piout.net>
Message-ID: <87tw9xiri9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,
 
 On mer., d?c. 21 2016, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:


I agree with all your remark expect one, see below:
[...]
>>  	rtc_update_irq(rtc->rtc_dev, 1, event);
>>  
>>  	return IRQ_HANDLED;
>> @@ -221,6 +282,11 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
>>  	if (!rtc)
>>  		return -ENOMEM;
>>  
>> +	rtc->val_to_freq = devm_kcalloc(&pdev->dev, SAMPLE_NR,
>> +				sizeof(struct value_to_freq), GFP_KERNEL);
>> +	if (!rtc->val_to_freq)
>> +		return -ENOMEM;
>> +
>
> The whole struct armada38x_rtc is already allocated just before. Maybe
> you can put the whole array inside the structure instead of doing a new
> allocation.

Actually it was done on purpose. Indeed the same RTC IP is used in the
Armada 3700 (a patch is coming soon), and for this IP this issue was
fixed and we do not need to store 100 read. That's why I want to
allocate the array only if needed.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
