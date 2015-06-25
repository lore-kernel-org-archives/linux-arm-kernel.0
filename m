From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 25 Jun 2015 20:45:22 +0900
Subject: [PATCH-v4 2/3] mfd: 88pm800: Set default interrupt clear method
In-Reply-To: <558BE3D6.2010801@linaro.org>
References: <1435217189-19578-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435217189-19578-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150625102618.GC15013@x1> <558BE3D6.2010801@linaro.org>
Message-ID: <CAJKOXPfbSV-WVVQrxrzvBJwpLaLskZVmnTQ5SUv=kV3SL_1SMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-25 20:19 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>
>
> On Thursday 25 June 2015 03:56 PM, Lee Jones wrote:

(...)

>>> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
>>> index 97cb283..94b3dcd 100644
>>> --- a/include/linux/mfd/88pm80x.h
>>> +++ b/include/linux/mfd/88pm80x.h
>>> @@ -77,6 +77,8 @@ enum {
>>>   #define PM800_WAKEUP2         (0x0E)
>>>   #define PM800_WAKEUP2_INV_INT         (1 << 0)
>>>   #define PM800_WAKEUP2_INT_CLEAR               (1 << 1)
>>> +#define PM800_WAKEUP2_INT_READ_CLEAR           (0 << 1)
>>> +#define PM800_WAKEUP2_INT_WRITE_CLEAR          (1 << 1)
>>>   #define PM800_WAKEUP2_INT_MASK                (1 << 2)
>>
>>
>> Use the BIT() macro.
>>
>
> I thought about this, but the whole file doesn't use it, so I also
> chose not to.
>
>
>>>   #define PM800_POWER_UP_LOG    (0x10)
>>> @@ -300,7 +302,7 @@ struct pm80x_chip {
>>>         struct regmap_irq_chip_data *irq_data;
>>>         int type;
>>>         int irq;
>>> -       int irq_mode;
>>> +       int irq_clr_on_wr;      /* '1': Clear on write, '0': Clear on
>>> read*/
>>
>>
>> Whitespace issue.
>>
>
> Didn't see any...and I also ran checkpatch.
>
>> Shouldn't this be a bool?
>>
>
> Just was not sure about any older board file interface.
> Ideally it should be bool only.
>
>> Actually even better, I would define; CLR_ON_WRITE and CLR_ON_READ,
>> and call the variable irq_clear_method, or something.
>>
>> Much clearer that way I think.
>>
>
> We have slowly decided to almost hardcode it to one value if there is
> no board file. I feel we should just keep it to simple.
>
> If you still insist, I can implement.

The bool would be indeed nicer and still you could hard-code the
desired value on DT system:
+               /* by default, set irq clear method on write */
+               pdata->irq_clear_method = CLR_ON_WRITE;

However the question is how this would influence existing platforms
using board files. Are there any in kernel or in downstream?

Best regards,
Krzysztof
