From: jenskuske@gmail.com (Jens Kuske)
Date: Sun, 1 Nov 2015 14:21:41 +0100
Subject: [PATCH v4 4/6] reset: sunxi: Add Allwinner H3 bus resets
In-Reply-To: <13919923.o3Dj9msmoa@wuerfel>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-5-git-send-email-jenskuske@gmail.com>
 <13919923.o3Dj9msmoa@wuerfel>
Message-ID: <563611E5.3000206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/10/15 09:27, Arnd Bergmann wrote:
> On Tuesday 27 October 2015 17:50:24 Jens Kuske wrote:
>>
>> +static int sun8i_h3_bus_reset_xlate(struct reset_controller_dev *rcdev,
>> +                                   const struct of_phandle_args *reset_spec)
>> +{
>> +       unsigned int index = reset_spec->args[0];
>> +
>> +       if (index < 96)
>> +               return index;
>> +       else if (index < 128)
>> +               return index + 32;
>> +       else if (index < 160)
>> +               return index + 64;
>> +       else
>> +               return -EINVAL;
>> +}
>> +
>>
> 
> This looks like you are doing something wrong and should either
> put the actual number into DT, or use a two-cell representation,
> with the first cell indicating the block (0, 1 or 2), and the
> second cell the index.
> 

I tried to fix up the somewhat strange register layout here.

>From the datasheet:
BUS_SOFT_RST_REG0	0x02C0	Bus Software Reset Register 0
BUS_SOFT_RST_REG1	0x02C4	Bus Software Reset Register 1
BUS_SOFT_RST_REG2	0x02C8	Bus Software Reset Register 2
BUS_SOFT_RST_REG3	0x02D0	Bus Software Reset Register 3
BUS_SOFT_RST_REG4	0x02D8	Bus Software Reset Register 4

0x2cc and 0x2d4 are unused for some reason, but the regs are named 0-4,
so it lead to some confusion with the actual numbers in DT.
If we shouldn't do this I would be ok with putting the actual number
into DT too.

Jens
