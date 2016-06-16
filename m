From: mika.batsman@gmail.com (=?UTF-8?Q?Mika_B=C3=A5tsman?=)
Date: Thu, 16 Jun 2016 13:13:03 +0300
Subject: anatop_regulator probe returns -EINVAL if regulator is set to
 bypass mode
In-Reply-To: <1879329.hU2uRcWFRn@galactica.lan>
References: <CACE3x1OUrK8ea78VDxf0bYxNnxBRrcH3xFE0amMsv2jYErRLmQ@mail.gmail.com>
 <1879329.hU2uRcWFRn@galactica.lan>
Message-ID: <CACE3x1NJMMUyjH26uWSmLFPFieKWOjN5o94G0H9EW0Z5mKhDMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

good to know. I'll prepare a patch.

Thanks,
Mika

On Tue, Jun 14, 2016 at 10:37 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Hi Mika,
>
> On 2016 M06 6, Mon 17:24:49 CEST Mika B?tsman wrote:
>> Hi Philipp, hi Markus,
>>
>> there's a problem with anatop regulator driver that relates to
>> functionality you have worked on. The related commits:
>> da0607c8 regulator: anatop: Fail on invalid voltage selector
>> d38018f2 regulator: anatop: Add bypass support to digital LDOs
>>
>>
>> So in case bootloader set the regulator to bypass mode sreg->sel gets set
>> to 0
>>         sreg->sel = (val & rdesc->vsel_mask) >> sreg->vol_bit_shift;
>>         if (sreg->sel == LDO_FET_FULL_ON) {
>>             sreg->sel = 0;
>>             sreg->bypass = true;
>>         }
>>
>> and a little bit later it's causing EINVAL to be returned.
>>         if (!sreg->sel) {
>>             dev_err(&pdev->dev, "Failed to read a valid default voltage
>> selector.\n");
>>             return -EINVAL;
>>         }
>>
>> Resulting in:
>> anatop_regulator 20c8000.anatop:regulator-vddcore at 140: Failed to read a
>> valid default voltage selector.
>> anatop_regulator: probe of 20c8000.anatop:regulator-vddcore at 140 failed with
>> error -22
>> anatop_regulator 20c8000.anatop:regulator-vddsoc at 140: Failed to read a
>> valid default voltage selector.
>> anatop_regulator: probe of 20c8000.anatop:regulator-vddsoc at 140 failed with
>> error -22
>>
>> Is that really the expected behaviour or should sreg->bypass be taken into
>> account before returning EINVAL? Like this:
>>
>>         if (!sreg->bypass && !sreg->sel) {
>
> Thanks for spotting this. This condition seems better. A EINVAL error was not
> intended for the bypass mode.
>
> Best Regards,
>
> Markus
>
>>             dev_err(&pdev->dev, "Failed to read a valid default voltage
>> selector.\n");
>>             return -EINVAL;
>>         }
>>
>>
>> Regards,
>> Mika
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
