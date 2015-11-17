From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 17 Nov 2015 11:50:38 +0100
Subject: [PATCH] pinctrl: mediatek: fix a memleak when do dt maps.
In-Reply-To: <CAGS+omCiaD-JJdvL77Y4HuvWjgC5tvLDLspsAgXPtD5AP3JA7w@mail.gmail.com>
References: <1447734177-17258-1-git-send-email-hongzhou.yang@mediatek.com>
 <CAGS+omCiaD-JJdvL77Y4HuvWjgC5tvLDLspsAgXPtD5AP3JA7w@mail.gmail.com>
Message-ID: <564B067E.2010000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/11/15 09:25, Daniel Kurtz wrote:
> On Tue, Nov 17, 2015 at 12:22 PM, Hongzhou Yang
> <hongzhou.yang@mediatek.com> wrote:
>> configs will kmemdup to dup_configs in pictrl util function.
>> So configs need to be freed.
>>
>> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
>> ---
>>   Fix a memleak issue.
>>
>>   drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   24 ++++++++++++++----------
>>   1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
>> index bbf0230..0f9e416 100644
>> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
>> @@ -520,21 +520,23 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>>          if (has_config && num_pins >= 1)
>>                  maps_per_pin++;
>>
>> -       if (!num_pins || !maps_per_pin)
>> -               return -EINVAL;
>> +       if (!num_pins || !maps_per_pin) {
>> +               err = -EINVAL;
>> +               goto exit;
>> +       }
>>
>>          reserve = num_pins * maps_per_pin;
>>
>>          err = pinctrl_utils_reserve_map(pctldev, map,
>>                          reserved_maps, num_maps, reserve);
>>          if (err < 0)
>> -               goto fail;
>> +               goto exit;
>>
>>          for (i = 0; i < num_pins; i++) {
>>                  err = of_property_read_u32_index(node, "pinmux",
>>                                  i, &pinfunc);
>>                  if (err)
>> -                       goto fail;
>> +                       goto exit;
>>
>>                  pin = MTK_GET_PIN_NO(pinfunc);
>>                  func = MTK_GET_PIN_FUNC(pinfunc);
>> @@ -543,20 +545,21 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>>                                  func >= ARRAY_SIZE(mtk_gpio_functions)) {
>>                          dev_err(pctl->dev, "invalid pins value.\n");
>>                          err = -EINVAL;
>> -                       goto fail;
>> +                       goto exit;
>>                  }
>>
>>                  grp = mtk_pctrl_find_group_by_pin(pctl, pin);
>>                  if (!grp) {
>>                          dev_err(pctl->dev, "unable to match pin %d to group\n",
>>                                          pin);
>> -                       return -EINVAL;
>> +                       err = -EINVAL;
>> +                       goto exit;
>>                  }
>>
>>                  err = mtk_pctrl_dt_node_to_map_func(pctl, pin, func, grp, map,
>>                                  reserved_maps, num_maps);
>>                  if (err < 0)
>> -                       goto fail;
>> +                       goto exit;
>>
>>                  if (has_config) {
>>                          err = pinctrl_utils_add_map_configs(pctldev, map,
>> @@ -564,13 +567,14 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>>                                          configs, num_configs,
>>                                          PIN_MAP_TYPE_CONFIGS_GROUP);
>>                          if (err < 0)
>> -                               goto fail;
>> +                               goto exit;
>>                  }
>>          }
>>
>> -       return 0;
>> +       err = 0;
>>
>> -fail:
>> +exit:
>> +       kfree(configs);
>>          return err;
>>   }
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
