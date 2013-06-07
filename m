From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 07 Jun 2013 16:49:17 -0700
Subject: [PATCH] ARM: mach-imx6q: Enable the codec clock earlier
In-Reply-To: <51B27010.5060603@boundarydevices.com>
References: <1370642870-8051-1-git-send-email-festevam@gmail.com>
 <20130607222051.GD18614@n2100.arm.linux.org.uk>
 <CAOMZO5B_PY0p1vqEUiYA88uhzYaOjnr5o9nXeEgLkKpPxD1LRQ@mail.gmail.com>
 <51B27010.5060603@boundarydevices.com>
Message-ID: <51B2717D.4080500@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/7/2013 4:43 PM, Troy Kisky wrote:
> On 6/7/2013 4:16 PM, Fabio Estevam wrote:
>> Hi Russell,
>>
>> On Fri, Jun 7, 2013 at 7:20 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>
>>> Umm... doesn't that mean that imx-sgtl5000 should be getting this clock
>>> and turning it on itself, and disabling it on device removal?
>> Yes, you are right.
>>
>> Actually imx-sgtl500 does get this clock and turn it on itself.
>>
>> The problem is that imx-sgtl5000 is getting called after the codec
>> sgtl500 codec is probed.
>>
>> ***** reading codec ID
>> sgtl5000: probe of 0-000a failed with error -5
>> ***** enabling the codec clock
>> imx-sgtl5000 sound.13: ASoC: CODEC (null) not registered
>> imx-sgtl5000 sound.13: snd_soc_register_card failed (-517)
>> platform sound.13: Driver imx-sgtl5000 requests probe deferral
>>
>>
>> And then If I do:
>>
>> --- a/sound/soc/codecs/sgtl5000.c
>> +++ b/sound/soc/codecs/sgtl5000.c
>> @@ -1525,7 +1525,7 @@ static int sgtl5000_i2c_probe(struct i2c_client 
>> *client,
>>          /* read chip information */
>>          ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
>>          if (ret)
>> -               return ret;
>> +               return -EPROBE_DEFER;
>>
>>          if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
>>              SGTL5000_PARTID_PART_ID) {
>>
>> Then the probe is succesful on the second attemp.
>>
>> I will post this to the alsa-devel list.
>>
>> Thanks,
>>
>> Fabio Estevam
>>
>
> Perhaps a delay is needed after the clock is turned on, to when you 
> can read a register.
>
> Using -EPROBE_DEFER seems like an abuse. Shouldn't it turn the clock 
> back off before it returns anyway?
>
> Troy
>
Sorry, I read that wrong.  Maybe sgtl5000 needs to get the clock, as 
well as imx-sgtl5000.


Troy
