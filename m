From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Mon, 4 Jul 2011 13:58:51 +0900
Subject: [PATCH 3/3] rtc: rtc-s3c: allow multiple open / allow
	no-ioctl-open'ed rtc to have irq.
In-Reply-To: <014001cc39fc$27cb52c0$7761f840$%youn@samsung.com>
References: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
	<1309175006-9218-4-git-send-email-myungjoo.ham@samsung.com>
	<014001cc39fc$27cb52c0$7761f840$%youn@samsung.com>
Message-ID: <CAJ0PZbTqHr8-A-sm5YVVxicygDiTi6NCx2B8ycmpS9ARHMFMZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2011 at 12:40 PM, Changhwan Youn <chaos.youn@samsung.com> wrote:
> AbwBwAGUAbgAgAC8AIAB
> ? ? ? ?hAGwAbABvAHcAIABuAG8ALQBpAG8AYwB0AGwALQBvAHAAZQBuACcAZQBkACAAcgB0AGMAIAB0AG8AIABoAGEAdgBlACAAaQByAHEALgA=
> x-cr-puzzleid: {71A23705-5400-4E21-9C23-2B1E96E33A68}
>
> MyungJoo Ham wrote:
>> The previous rtc-s3c had two issues related with its IRQ.
>> 1. Users cannot open rtc multiple times because an open operation calls
>> request_irq on the same IRQ. (e.g., two user processes wants to open and
>> read RTC time from rtc-s3c at the same time)
>> 2. If alarm is set and no one has the rtc opened with filesystem
>> (either the alarm is set by kernel/boot-loader or user set an alarm
>> and closed rtc dev file), the pending bit is not cleared and no further
>> interrupt is invoked. When the alarm is used by the system itself such
>> as a resume from suspend-to-RAM or other Low-power modes/idle, this is a
>> critical issue.
>>
>> This patch mitigates these issue by calling request_irq at probe and
>> free_irq at remove.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
[]
>>
>> - ? ? return 0;
>> + ? ? ret = request_irq(s3c_rtc_alarmno, s3c_rtc_alarmirq,
>> + ? ? ? ? ? ? ? ? ? ? ? IRQF_DISABLED, ?"s3c2410-rtc alarm", rtc);
>>
>> + ? ? if (ret) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "IRQ%d error %d\n", s3c_rtc_alarmno,
>> ret);
>> + ? ? ? ? ? ? return ret;
>> + ? ? }
>> +
>> + ? ? ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
>> + ? ? ? ? ? ? ? ? ? ? ? IRQF_DISABLED, ?"s3c2410-rtc tick", rtc);
>> +
>> + ? ? if (ret) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "IRQ%d error %d\n", s3c_rtc_tickno,
> ret);
>> + ? ? ? ? ? ? free_irq(s3c_rtc_alarmno, rtc);
>> + ? ? }
>> +
>> + ? ? return ret;
>
> You need proper error handlings.
>
> Regards,
> Changhwan

Ah.. ok, I'll let them go through the error handling code like other errors do.

Thanks.


- MyungJoo

>
>> ? err_nortc:
>> ? ? ? s3c_rtc_enable(pdev, 0);
>> ? ? ? clk_disable(rtc_clk);
>> --
>> 1.7.4.1
>>
>> --
>> You received this message because you are subscribed to "rtc-linux".
>> Membership options at http://groups.google.com/group/rtc-linux .
>> Please read http://groups.google.com/group/rtc-linux/web/checklist
>> before submitting a driver.
>
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
