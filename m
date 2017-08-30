From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 30 Aug 2017 22:15:45 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <CABxcv==JFm0H_kB8LRyRpZNbajcO3UkxYOepkk=YUAaT1UH1gg@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
 <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato>
 <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
 <20170830174228.sx5jgtxxy56zq47t@ninjato>
 <CABxcv==JFm0H_kB8LRyRpZNbajcO3UkxYOepkk=YUAaT1UH1gg@mail.gmail.com>
Message-ID: <CAMuHMdXRVnHsvCNfRqRgTusdyhOYcV7bWconD99OgXmVcHT8yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wed, Aug 30, 2017 at 9:57 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>> I think we should talk about the same case: Let me repeat what I did:
>>
>> 1) I added your patch "eeprom: at24: Add OF device ID table"
>> 2) I added an EEPROM node to an I2C
>>
>> +       eeprom at 50 {
>> +               compatible = "renesas,24c01";
>> +               reg = <0x50>;
>> +       };
>>
>> -> no at24 binding to the device
>>
>> 3) I revert your patch
>>
>> -> at24 binding to the device
>>
>
> I've tested this and you are right, it fails...
>
> The problem is that the patch also changes how the driver obtains the
> EEPROM parameters (the magic value in the entry's data field).
>
> So even when module autoload and device / driver matching works, the
> driver probe function fails because if (client->dev.of_node) the
> driver attempts to get the entry data using
> of_device_get_match_data(), which is obviously wrong since the
> compatible string in the dev node isn't present in the OF table.
>
> The id->driver_data from the I2C table should be used instead since
> that's the table that matches in this case.
>
> One option is to fallback to id->driver_data if
> of_device_get_match_data() fails, but that's just an (ugly)
> workaround. So I agree with you that the best option is to wait for
> the DTS patches to land first.

Which means new kernels won't work with old DTBs. Oops...
I'm afraid that needs to be fixed.  People care about DTB backward
compatibility on many platforms.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
