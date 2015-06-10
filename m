From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 10 Jun 2015 09:57:13 +0200
Subject: [linux-sunxi] [PATCH 2/8] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
In-Reply-To: <CAGb2v652W+i6L1k5-CnHtXZXdJjFswkcyFGromhWSYaXtitW_w@mail.gmail.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-3-git-send-email-hdegoede@redhat.com>
 <CAGb2v652W+i6L1k5-CnHtXZXdJjFswkcyFGromhWSYaXtitW_w@mail.gmail.com>
Message-ID: <5577EDD9.8020900@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10-06-15 03:19, Chen-Yu Tsai wrote:
> On Wed, Jun 10, 2015 at 5:37 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Add a cell for the usb power_supply part of the axp20x PMICs.
>>
>> Note that this cell is only for the usb power_supply part and not the
>> ac-power / battery-charger / rtc-backup-bat-charger bits.
>>
>> Depending on the board each of those must be enabled / disabled separately
>> in devicetree as most boards do not use all 4. So in dt each one needs its
>> own child-node of the axp20x node. Another reason for using separate child
>> nodes for each is so that other devicetree nodes can have a power-supply
>> property with a phandle referencing a node representing a single
>> power-supply.
>>
>> The decision to use a separate devicetree node for each is reflected on
>> the kernel side by each getting its own mfd-cell / platform_device and
>> platform-driver.
>>
>> Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/mfd/axp20x.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 6ffbc11..47ce233 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -113,6 +113,30 @@ static struct resource axp20x_pek_resources[] = {
>>          },
>>   };
>>
>> +static struct resource axp20x_usb_power_supply_resources[] = {
>> +       {
>> +               .name   = "VBUS_PLUGIN",
>> +               .start  = AXP20X_IRQ_VBUS_PLUGIN,
>> +               .end    = AXP20X_IRQ_VBUS_PLUGIN,
>> +               .flags  = IORESOURCE_IRQ,
>> +       }, {
>> +               .name   = "VBUS_REMOVAL",
>> +               .start  = AXP20X_IRQ_VBUS_REMOVAL,
>> +               .end    = AXP20X_IRQ_VBUS_REMOVAL,
>> +               .flags  = IORESOURCE_IRQ,
>> +       }, {
>> +               .name   = "VBUS_VALID",
>> +               .start  = AXP20X_IRQ_VBUS_VALID,
>> +               .end    = AXP20X_IRQ_VBUS_VALID,
>> +               .flags  = IORESOURCE_IRQ,
>> +       }, {
>> +               .name   = "VBUS_NOT_VALID",
>> +               .start  = AXP20X_IRQ_VBUS_NOT_VALID,
>> +               .end    = AXP20X_IRQ_VBUS_NOT_VALID,
>> +               .flags  = IORESOURCE_IRQ,
>> +       },
>> +};
>> +
>>   static struct resource axp22x_pek_resources[] = {
>>          {
>>                  .name   = "PEK_DBR",
>> @@ -165,7 +189,7 @@ static const struct regmap_config axp20x_regmap_config = {
>>          .val_bits       = 8,
>>          .wr_table       = &axp20x_writeable_table,
>>          .volatile_table = &axp20x_volatile_table,
>> -       .max_register   = AXP20X_FG_RES,
>> +       .max_register   = AXP20X_OCV(15),
>>          .cache_type     = REGCACHE_RBTREE,
>>   };
>>
>> @@ -368,6 +392,12 @@ static struct mfd_cell axp20x_cells[] = {
>>                  .resources              = axp20x_pek_resources,
>>          }, {
>>                  .name                   = "axp20x-regulator",
>> +       }, {
>> +               .name                   = "axp20x-usb-power-supply",
>
> Could we use either "vbus-power-supply" to match the AXP datasheets,
> or "otg-power-supply" which is slightly more obvious to board owners?

I do not like the vbus name, since it does not indicate which bus
it is, OTOH you are right that is what it is called in the datasheet.

As for using otg, I think that usb is better then.

All in all I believe that the current usb name is best, but if others
disagree I'm open to renaming this.

So anyone else have an opinion on what would be a good name for the
cell and the compatible ?

Regards,

Hans
