From: michael.vanderwesthuizen@smart-africa.com (Michael van der Westhuizen)
Date: Wed, 24 Jun 2015 08:14:58 +0200
Subject: [PATCH] ARM: ep93xx: toss the device ID into the entropy pool
In-Reply-To: <2274537.5rEXu4xPQS@wuerfel>
References: <1434638859-27381-1-git-send-email-linus.walleij@linaro.org>
 <2274537.5rEXu4xPQS@wuerfel>
Message-ID: <CAB5YaOmRW+gvToyJCkYYpaYp6A=QV55ws52C9anddELoYx8LEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 June 2015 at 22:39, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 June 2015 16:47:39 Linus Walleij wrote:
>> @@ -862,6 +863,12 @@ static const char __init *ep93xx_get_soc_id(void)
>>         if (id != id2)
>>                 return "invalid";
>>
>> +       /* Toss the unique ID into the entropy pool */
>> +       add_device_randomness(&id2, 4);
>> +       add_device_randomness(&id3, 4);
>> +       add_device_randomness(&id4, 4);
>> +       add_device_randomness(&id5, 4);
>> +
>>
>
> A stupid question from someone who does not understand computer
> security: Is there any concern about being able to identify a
> particular machine based on the random numbers generated at
> runtime afterwards?

No, not in this case.  The reason for this pattern (where any SoC specific
data that is not visible out of the SoC is mixed in to the initial entropy pool)
is to avoid class attacks against device families due to similarity of initial
random numbers affecting this quality of early ephemeral keys.

A general guideline is that any data that cannot be determined unless
you're actually running within the SoC can be mixed into the entropy pool.

Of course, nothing beats a half-decent hardware RNG as an initial entropy
source.

Michael
