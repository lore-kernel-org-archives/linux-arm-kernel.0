From: schwab@linux-m68k.org (Andreas Schwab)
Date: Wed, 02 Mar 2016 10:28:40 +0100
Subject: [PATCH 1/6] rtc: generic: allow building on all architectures
In-Reply-To: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
 (Geert Uytterhoeven's message of "Wed, 2 Mar 2016 09:57:27 +0100")
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-2-git-send-email-arnd@arndb.de>
 <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
Message-ID: <mvmwpplns8n.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> +#else
>> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
>> +#endif
>>
>>  static int __init generic_rtc_probe(struct platform_device *dev)
>>  {
>>         struct rtc_device *rtc;
>> +       const struct rtc_class_ops *ops;
>> +
>> +       ops = dev_get_platdata(&dev->dev);
>> +       if (!ops)
>> +               ops = &generic_rtc_ops;
>
> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
> undefined behavior?

Yes, that is guaranteed, the operations cancel each other (6.5.3.2#3: If
the operand is the result of a unary * operator, neither that operator
nor the & operator is evaluated and the result is as if both were
omitted).

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
