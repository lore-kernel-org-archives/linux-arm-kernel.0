From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 30 Aug 2017 22:59:14 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <CAMuHMdXRVnHsvCNfRqRgTusdyhOYcV7bWconD99OgXmVcHT8yw@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
 <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato>
 <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
 <20170830174228.sx5jgtxxy56zq47t@ninjato>
 <CABxcv==JFm0H_kB8LRyRpZNbajcO3UkxYOepkk=YUAaT1UH1gg@mail.gmail.com>
 <CAMuHMdXRVnHsvCNfRqRgTusdyhOYcV7bWconD99OgXmVcHT8yw@mail.gmail.com>
Message-ID: <CABxcv=kbnNY9wvcRDuK02f6s6kmqd3SFhjwVg8zikVDqtRU4Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

On Wed, Aug 30, 2017 at 10:15 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Javier,
>
> On Wed, Aug 30, 2017 at 9:57 PM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>>> I think we should talk about the same case: Let me repeat what I did:
>>>
>>> 1) I added your patch "eeprom: at24: Add OF device ID table"
>>> 2) I added an EEPROM node to an I2C
>>>
>>> +       eeprom at 50 {
>>> +               compatible = "renesas,24c01";
>>> +               reg = <0x50>;
>>> +       };
>>>
>>> -> no at24 binding to the device
>>>
>>> 3) I revert your patch
>>>
>>> -> at24 binding to the device
>>>
>>
>> I've tested this and you are right, it fails...
>>
>> The problem is that the patch also changes how the driver obtains the
>> EEPROM parameters (the magic value in the entry's data field).
>>
>> So even when module autoload and device / driver matching works, the
>> driver probe function fails because if (client->dev.of_node) the
>> driver attempts to get the entry data using
>> of_device_get_match_data(), which is obviously wrong since the
>> compatible string in the dev node isn't present in the OF table.
>>
>> The id->driver_data from the I2C table should be used instead since
>> that's the table that matches in this case.
>>
>> One option is to fallback to id->driver_data if
>> of_device_get_match_data() fails, but that's just an (ugly)
>> workaround. So I agree with you that the best option is to wait for
>> the DTS patches to land first.
>
> Which means new kernels won't work with old DTBs. Oops...
> I'm afraid that needs to be fixed.  People care about DTB backward
> compatibility on many platforms.
>

Right, I've yet to find one of those mythical platforms that ship old
DTBs with new kernels, but I agree with you since people seem to care
about backward compatibility (at least on theory).

So I see two options then:

1) Use the workaround I mentioned and lookup the I2C device ID table
entry data if of_device_get_match_data() fails

2) Only call of_device_get_match_data() if (dev->of_node &&
of_match_device(dev->driver->of_match_table, dev))

Not sure what's the preferred idiom for these cases.

To good thing about keeping backward compatibility is that Wolfram
would be able to pick the driver patch even before the DTS patches
land.

Best regards,
Javier
