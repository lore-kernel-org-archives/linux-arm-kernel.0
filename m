From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Mon, 4 Jul 2011 13:56:21 +0900
Subject: [rtc-linux] [PATCH 2/3] rtc: rtc-s3c: Disable alarm entries that
	are not chosen.
In-Reply-To: <013101cc39f3$9b44b830$d1ce2890$%youn@samsung.com>
References: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
	<1309175006-9218-3-git-send-email-myungjoo.ham@samsung.com>
	<013101cc39f3$9b44b830$d1ce2890$%youn@samsung.com>
Message-ID: <CAJ0PZbRf-Q3r9D9EbhSG+VuzLWWbWqXKJ4A1byLUGn5On=ArVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2011 at 11:39 AM, Changhwan Youn <chaos.youn@samsung.com> wrote:
> MyungJoo Ham wrote:
>> When rtc_setalarm is called, the entries that are not chosen (entries
>> without valid time values) should be disabled. However, in the previous
>> rtc-s3c driver, they are not explicitly disabled (did not changed). This
>> patch allows to disable such entries even if they were previously used.
>
> This has already been implemented by current code.
> The original code you modified only leaves alarm enable bit.
> You may misunderstand the code.

Ah.. sorry. I misunderstood when I was writing the commit message.

It is not about the enable bits of each time entry. It is about the enable bit.

However, as rtc->ops->set_alarm is not called when alarm->enabled is
false, the patch becomes meaningless.

Please never mind this patch.

>
> Regards,
> Changhwan
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?drivers/rtc/rtc-s3c.c | ? ?3 ++-
>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
>> index 3c8dfa7..be85ea5 100644
>> --- a/drivers/rtc/rtc-s3c.c
>> +++ b/drivers/rtc/rtc-s3c.c
>> @@ -273,7 +273,8 @@ static int s3c_rtc_setalarm(struct device *dev, struct
>> rtc_wkalrm *alrm)
>> ? ? ? ? ? ? ? ?1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
>> ? ? ? ? ? ? ? ?tm->tm_hour, tm->tm_min, tm->tm_sec);
>>
>> - ? ? alrm_en = readb(base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
>> + ? ? /* Disable entires that are not chosen by alrm */
>> + ? ? alrm_en = S3C2410_RTCALM_ALMEN;
>> ? ? ? writeb(0x00, base + S3C2410_RTCALM);
>>
>> ? ? ? if (tm->tm_sec < 60 && tm->tm_sec >= 0) {
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
