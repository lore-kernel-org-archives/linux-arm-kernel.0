From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Oct 2015 15:39:58 +0800
Subject: [linux-sunxi] [PATCH 2/6] mfd: axp20x: Split the driver into core
 and i2c bits
In-Reply-To: <CAGRGNgXAtuV+9+i=rRerRX6T9=i6W+dDCBJN8Jh8QS7A82r+VA@mail.gmail.com>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
 <1444840342-9233-3-git-send-email-wens@csie.org>
 <CAGRGNgXAtuV+9+i=rRerRX6T9=i6W+dDCBJN8Jh8QS7A82r+VA@mail.gmail.com>
Message-ID: <CAGb2v66qa6aw4_YUxawuJk2M-fz24usYqcwKVAr6uKw-FBWjvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 6:37 AM, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Chen-Yu,
>
> On Thu, Oct 15, 2015 at 3:32 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> The axp20x driver assumes the device is i2c based. This is not the
>> case with later models, which use a proprietary 2 wire serial bus
>> called "Reduced Serial Bus".
>>
>> This patch follows the example of mfd/wm831x and splits it into
>> an interface independet core, and an i2c specific glue layer.
>>
>> The old MFD_AXP20X Kconfig symbol is kept until sub-device drivers
>> and defconfigs have migrated to the new MFD_AXP20X_CORE symbol.
>>
>> Included but unused header files are removed as well.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/mfd/Kconfig                     |  18 ++++-
>>  drivers/mfd/Makefile                    |   3 +-
>>  drivers/mfd/{axp20x.c => axp20x-core.c} | 105 +++-----------------------
>>  drivers/mfd/axp20x-i2c.c                | 127 ++++++++++++++++++++++++++++++++
>>  include/linux/mfd/axp20x.h              |  33 ++++++++-
>>  5 files changed, 186 insertions(+), 100 deletions(-)
>>  rename drivers/mfd/{axp20x.c => axp20x-core.c} (87%)
>>  create mode 100644 drivers/mfd/axp20x-i2c.c
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 99d63675f073..9ba3feb3f2fc 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -79,15 +79,25 @@ config MFD_BCM590XX
>>         help
>>           Support for the BCM590xx PMUs from Broadcom
>>
>> +# Keep the old symbol until subdevice driver dependencies and defconfigs
>> +# have been updated.
>>  config MFD_AXP20X
>> -       bool "X-Powers AXP20X"
>> +       bool "X-Powers AXP series PMICs"
>> +       select MFD_AXP20X_I2C
>
> Unless something has changed in KConfig, (and my knowledge on this is
> likely to be outdated) I don't believe this will work as I don't think
> selects don't get propagated like you expect. Have you checked that
> all possible configuration options survive make oldconfig and build
> without warnings?

Yeah this totally did not work out like I expected.

> Also, unless there's some compelling reason not to, it's probably a
> good idea to update the dependent drivers and defconfigs now. (or make
> this change in a gentler manner.)

What I wanted was to keep the original symbol for a release cycle or
more, giving me time to update the related entries across the kernel.
After the changes are in, we could remove the old one.

The other way would be to change MFD_AXP20X to a hidden symbol, and
let the 2 new ones select that. Then we'd just update all the
defconfigs.

I'll rework this and add defconfig updates.

Thanks
ChenYu

>> +
>> +config MFD_AXP20X_CORE
>> +       bool
>>         select MFD_CORE
>> -       select REGMAP_I2C
>>         select REGMAP_IRQ
>> +
>> +config MFD_AXP20X_I2C
>> +       bool "X-Powers AXP series I2C PMICs"
>> +       select MFD_AXP20X_CORE
>> +       select REGMAP_I2C
>>         depends on I2C=y
>>         help
>> -         If you say Y here you get support for the X-Powers AXP202, AXP209 and
>> -         AXP288 power management IC (PMIC).
>> +         If you say Y here you get support for the X-Powers AXP series I2C
>> +         based power management ICs (PMICs).
>>           This driver include only the core APIs. You have to select individual
>>           components like regulators or the PEK (Power Enable Key) under the
>>           corresponding menus.
>
> Thanks,
>
> --
> Julian Calaby
>
> Email: julian.calaby at gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/
