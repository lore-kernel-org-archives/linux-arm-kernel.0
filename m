From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 1 Feb 2013 09:32:59 +0800
Subject: [rtc-linux] [PATCH] rtc: pl031: fix the missing operation on
 enable
In-Reply-To: <20130131144459.39f9a978.akpm@linux-foundation.org>
References: <1359507865-29808-1-git-send-email-haojian.zhuang@linaro.org>
 <20130131144459.39f9a978.akpm@linux-foundation.org>
Message-ID: <CAD6h2NS6dGYBvbwQ2u4FvQZ_uW8wUcT+cSA14xRzUyDfLwyQCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2013 06:44, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 30 Jan 2013 09:04:25 +0800
> Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>
>> RTC control register should be enabled in the process of initliazing.
>>
>> ...
>>
>> --- a/drivers/rtc/rtc-pl031.c
>> +++ b/drivers/rtc/rtc-pl031.c
>> @@ -44,6 +44,7 @@
>>  #define RTC_YMR              0x34    /* Year match register */
>>  #define RTC_YLR              0x38    /* Year data load register */
>>
>> +#define RTC_CR_EN    (1 << 0)        /* counter enable bit */
>>  #define RTC_CR_CWEN  (1 << 26)       /* Clockwatch enable bit */
>>
>>  #define RTC_TCR_EN   (1 << 1) /* Periodic timer enable bit */
>> @@ -320,7 +321,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
>>       struct pl031_local *ldata;
>>       struct pl031_vendor_data *vendor = id->data;
>>       struct rtc_class_ops *ops = &vendor->ops;
>> -     unsigned long time;
>> +     unsigned long time, data;
>>
>>       ret = amba_request_regions(adev, NULL);
>>       if (ret)
>> @@ -345,10 +346,11 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
>>       dev_dbg(&adev->dev, "designer ID = 0x%02x\n", amba_manf(adev));
>>       dev_dbg(&adev->dev, "revision = 0x%01x\n", amba_rev(adev));
>>
>> +     data = readl(ldata->base + RTC_CR);
>>       /* Enable the clockwatch on ST Variants */
>>       if (vendor->clockwatch)
>> -             writel(readl(ldata->base + RTC_CR) | RTC_CR_CWEN,
>> -                    ldata->base + RTC_CR);
>> +             data |= RTC_CR_CWEN;
>> +     writel(data | RTC_CR_EN, ldata->base + RTC_CR);
>
> Does this patch fix some user-visible misbehaviour?  If so, please
> fully describe that misbehaviour.
>
Hi Andrew,

I copy the description from rtc pl031 user manual (page 33 of
DDI0224.pdf) in below.

RTCCR is a 1-bit control register. When HIGH, the counter enable
signal is asserted to
enable the counter. Table 3-5 shows the bit assignments for the RTCCR register.

Table 3-5 RTCCR register
-----------------------------------------------------------------------------------------------------------------------
Bits       Name              Type                      Function
31:1       -                     Read/write             Reserved. Read
unpredictable. Should
                                                                be written as 0.
0           RTC start         Read/write             If set to 1, the
RTC is enabled. Once it is

enabled, any writes to this bit have no
                                                                effect
on the RTC until a system reset.
                                                                A read
returns the status of the RTC.
-----------------------------------------------------------------------------------------------------------------------

>From this document, RTCCR must be enabled before usage. Without this
patch, I really
failed to enable RTC in Hisilicon Hi3620 SoC. It results that the
register mapping section
in RTC is always read as zero. So I doubt that ST guys may already
enable this register
in bootloader. So they won't meet this issue.

Best Regards
Haojian
