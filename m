From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 31 Jul 2016 22:50:06 +0800
Subject: [PATCH 2/3] phy: sun4i: add support for A64 usb phy
In-Reply-To: <706a0517-a2bf-ee67-338d-859f67105cee@redhat.com>
References: <20160731112536.4625-1-icenowy@aosc.xyz>
 <20160731112536.4625-2-icenowy@aosc.xyz>
 <706a0517-a2bf-ee67-338d-859f67105cee@redhat.com>
Message-ID: <CAGb2v65tbM=-4HthAiN2hLvKYCSQg_WDCXrFcAO94cohd1FfDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 31, 2016 at 10:39 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 31-07-16 13:25, Icenowy Zheng wrote:
>>
>> There's something unknown in the pmu part.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
>
> Cool, I really like the work you're doing on A64 support,
> keep up the good work!
>
>> ---
>>  drivers/phy/phy-sun4i-usb.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> index 0a45bc6..6f94369 100644
>> --- a/drivers/phy/phy-sun4i-usb.c
>> +++ b/drivers/phy/phy-sun4i-usb.c
>> @@ -97,6 +97,7 @@ enum sun4i_usb_phy_type {
>>         sun6i_a31_phy,
>>         sun8i_a33_phy,
>>         sun8i_h3_phy,
>> +       sun50i_a64_phy,
>>  };
>>
>>  struct sun4i_usb_phy_cfg {
>> @@ -180,8 +181,9 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy
>> *phy, u32 addr, u32 data,
>>
>>         mutex_lock(&phy_data->mutex);
>>
>> -       if (phy_data->cfg->type == sun8i_a33_phy) {
>> -               /* A33 needs us to set phyctl to 0 explicitly */
>> +       if (phy_data->cfg->type == sun8i_a33_phy ||
>> +           phy_data->cfg->type == sun50i_a64_phy) {
>> +               /* A33 or A64 needs us to set phyctl to 0 explicitly */
>>                 writel(0, phyctl);
>>         }
>>
>
> Maybe add a "bool explicitly_0_phyctl;" to sun4i_usb_phy_cfg ?
>
> Note I'm not sure of this myself, feel free to keep this as is,
> we can always introduce such a bool when we get a 3th SoC which
> needs it.
>
>> @@ -264,6 +266,12 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>>                 val = readl(phy->pmu + REG_PMU_UNK_H3);
>>                 writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
>>         } else {
>> +               /* A64 needs also this unknown bit */
>> +               if (data->cfg->type == sun50i_a64_phy) {
>> +                       val = readl(phy->pmu + REG_PMU_UNK_H3);
>> +                       writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
>> +               }
>> +
>>                 /* Enable USB 45 Ohm resistor calibration */
>>                 if (phy->index == 0)
>>                         sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01,
>> 1);
>
>
> Erm, as pointed out thus duplicates code from the H3 code path, I believe
> that you should add a "bool needs_h3_pmu_unk_poke;" to sun4i_usb_phy_cfg
> and then change this bit of the code to:
>
>         if (data->cfg->needs_h3_pmu_unk_poke) {
>                 val = readl(phy->pmu + REG_PMU_UNK_H3);
>                 writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
>         }
>
>         if (data->cfg->type == sun8i_h3_phy) {
>                 if (phy->index == 0) {
>                         val = readl(data->base + REG_PHY_UNK_H3);
>                         writel(val & ~1, data->base + REG_PHY_UNK_H3);
>                 }
>         } else {
>                 ... (original code)
>         }
>
> That seems like a cleaner solution to me.
>
> And do not forget to set the needs_h3_pmu_unk_poke for the h3!
>
> I would not add it to the sun4i_usb_phy_cfg structs for the
> other type SoCs, if part of the struct is initialized the
> rest will get set to 0 by the compiler and I believe that
> it things will be more readable without an explicit:
>
>         .needs_h3_pmu_unk_poke = false
>
> Everywhere.
>

FYI: H3 USB PHY support is not complete. USB0 PHY is not supported, and
it does not work. I did a preliminary comparison of this PHY driver and
the code in Allwinner's SDK. There are some bits missing.

ChenYu

>
> Thanks & Regards,
>
> Hans
>
>
>
>
>
>> @@ -762,6 +770,14 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg =
>> {
>>         .dedicated_clocks = true,
>>  };
>>
>> +static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
>> +       .num_phys = 2,
>> +       .type = sun50i_a64_phy,
>> +       .disc_thresh = 3,
>> +       .phyctl_offset = REG_PHYCTL_A33,
>> +       .dedicated_clocks = true,
>> +};
>> +
>>  static const struct of_device_id sun4i_usb_phy_of_match[] = {
>>         { .compatible = "allwinner,sun4i-a10-usb-phy", .data =
>> &sun4i_a10_cfg },
>>         { .compatible = "allwinner,sun5i-a13-usb-phy", .data =
>> &sun5i_a13_cfg },
>> @@ -770,6 +786,7 @@ static const struct of_device_id
>> sun4i_usb_phy_of_match[] = {
>>         { .compatible = "allwinner,sun8i-a23-usb-phy", .data =
>> &sun8i_a23_cfg },
>>         { .compatible = "allwinner,sun8i-a33-usb-phy", .data =
>> &sun8i_a33_cfg },
>>         { .compatible = "allwinner,sun8i-h3-usb-phy", .data =
>> &sun8i_h3_cfg },
>> +       { .compatible = "allwinner,sun50i-a64-usb-phy", .data =
>> &sun50i_a64_cfg},
>>         { },
>>  };
>>  MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
>>
>
