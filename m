From: stigge@antcom.de (Roland Stigge)
Date: Fri, 28 Sep 2012 11:52:22 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CACRpkdZ+1ffsMDRZXYb5RRndoXstj_QHvHOpeikRY0bas72dKQ@mail.gmail.com>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CACRpkdZ+1ffsMDRZXYb5RRndoXstj_QHvHOpeikRY0bas72dKQ@mail.gmail.com>
Message-ID: <50657356.4010801@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 11:14 AM, Linus Walleij wrote:
>> @@ -686,6 +731,13 @@ read-only attributes:
>>
>>         "ngpio" ... how many GPIOs this manges (N to N + ngpio - 1)
>>
>> +       "block" ... get/set Block GPIO:
>> +                   * reads: space separated list of GPIO inputs of this chip that
>> +                     are set to 1, e.g. "83 85 87 99"
>> +                   * write: space separated list of GPIO outputs of this chip
>> +                     that are to be set or cleared, e.g. "80 -83 -85" (prefix
>> +                     "-" clears)
> 
> This sort of breaks the sysfs convention of one value per file,
> does it not?
> 
> It's not like I have some better idea, just we need to think about
> other possible solutions.
> 
> The GPIO sysfs interface is not universally liked. What are the
> typical applications you have for this? Industrial control by
> bit-banging userspace processes?

Yes, I had several projects in the past with the need of setting groups
of GPIOs at once (typically, 8 bit busses via GPIO lines), so needed to
provide some hacks. Don't want to do this over and over again. :-)

Bit-banging in kernel and userspace.

It's hard to do the one-value-per-file right for a several-gpios-at-once
goal. :-) I originally had a one-value solution: A bit map, continuously
hex coded, like in the original kernel API idea (e.g. 0x000F0A0010).
Wasn't sure because it encodes GPIO numbers in a weird way.

Strictly formally: Isn't a comma-separated list of a GPIO block (e.g.
"80,81,85") a singe value in a sense? :-) Or other possibilities? Maybe
some node in /proc? Or some kind of new character device node?

Otherwise, I need to think about leaving out the sysfs for this purpose.

Thanks in advance,

Roland
