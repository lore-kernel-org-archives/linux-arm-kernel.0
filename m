From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 7 Aug 2013 17:33:53 +0530
Subject: [PATCH V3 2/3] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <2149257.I47GXnTNnE@amdc1227>
References: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
 <1375865122-5258-3-git-send-email-padma.v@samsung.com>
 <2149257.I47GXnTNnE@amdc1227>
Message-ID: <CAAgF-BcyqW=YMun4yX5ExNy1BMbeW2i08EyBgXmdh5twBcm=ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Aug 7, 2013 at 4:32 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Padmavathi,
>
> [Ccing DT maintainers with a little comment about contents of this patch
> for them:
>
> This is a rework of Samsung i2s bindings to make them more reasonable than
> they are at the moment. I know this was supposed to be stable, fixed, ABI,
> etc., but as we discussed a lot the whole topic of DT bindings, we need to
> sanitize existing bindings and this patch is a part of this work.]
>

[snip]

>>
>>  Required SoC Specific Properties:
>>
>> -- compatible : "samsung,i2s-v5"
>> +- compatible : should be one of the following.
>> +   - samsung,s3c6410-i2s: for 8/16/24bit stereo I2S. Previous versions
>> +     has only 8/16bit support.
>
> The comment about previous versions seems a bit enigmatic.
>
> If there is another variant supported by this driver that supports only
> 8/16bit audio data, then it should have a separate compatible value.

For previous i2s controllers there are two other i2s drivers
available. I think I can delete this comment here.

>
>> +   - samsung,s3c6410-i2sv4: for 8/16/24bit multichannel(5.1 channel)
>> I2S. +     Introduced in s3c6410. This also applicable for s5p64x0
>> platforms. +   - samsung,s5pc100-i2s: for 8/16/24bit multichannel(5.1
>> channel) I2S +     with secondary fifo and s/w reset control.
>> +   - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
>> +     secondary fifo, s/w reset control and internal mux for root clk
>> src. +
>>  - reg: physical base address of the controller and length of memory
>> mapped region.
>>  - dmas: list of DMA controller phandle and DMA request line ordered
>> pairs. @@ -21,13 +30,6 @@ Required SoC Specific Properties:
>>
>>  Optional SoC Specific Properties:
>>
>> -- samsung,supports-6ch: If the I2S Primary sound source has 5.1 Channel
>> -  support, this flag is enabled.
>> -- samsung,supports-rstclr: This flag should be set if I2S software reset
>> bit -  control is required. When this flag is set I2S software reset bit
>> will be -  enabled or disabled based on need.
>> -- samsung,supports-secdai:If I2S block has a secondary FIFO and internal
>> DMA, -  then this flag is enabled.
>>  - samsung,idma-addr: Internal DMA register base address of the audio
>>    sub system(used in secondary sound source).
>>  - pinctrl-0: Should specify pin control groups used for this controller.
>> @@ -46,9 +48,6 @@ i2s0: i2s at 03830000 {
>
> The example has also a compatible value set to "samsung,i2s-v5". I don't
> think this is compliant to the new bindings.

Yes. It's my mistake. Will change this to new one.

>
>>               <&clock_audss EXYNOS_I2S_BUS>,
>>               <&clock_audss EXYNOS_SCLK_I2S>;
>>       clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
>> -     samsung,supports-6ch;
>> -     samsung,supports-rstclr;
>> -     samsung,supports-secdai;
>>       samsung,idma-addr = <0x03000000>;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&i2s0_bus>;
>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index 47e08dd..8a5504c 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -40,6 +40,7 @@ enum samsung_dai_type {
>>
>>  struct samsung_i2s_dai_data {
>
> const struct samsung_i2s_dai_data

OK.

>
>>       int dai_type;
>> +     u32 quirks;
>>  };
>>
>>  struct i2s_dai {
>> @@ -1032,18 +1033,18 @@ static struct i2s_dai *i2s_alloc_dai(struct
>> platform_device *pdev, bool sec)
>>
>>  static const struct of_device_id exynos_i2s_match[];
>>
>> -static inline int samsung_i2s_get_driver_data(struct platform_device
>> *pdev) +static inline struct samsung_i2s_dai_data
>> *samsung_i2s_get_driver_data( +                                               struct platform_device
> *pdev)
>>  {
>>  #ifdef CONFIG_OF
>> -     struct samsung_i2s_dai_data *data;
>>       if (pdev->dev.of_node) {
>>               const struct of_device_id *match;
>>               match = of_match_node(exynos_i2s_match, pdev->dev.of_node);
>> -             data = (struct samsung_i2s_dai_data *) match->data;
>> -             return data->dai_type;
>> +             return (struct samsung_i2s_dai_data *) match->data;
>
> If you make the dai_data const this cast will be no longer necessary.
>
>>       } else
>>  #endif
>> -             return platform_get_device_id(pdev)->driver_data;
>> +             return (struct samsung_i2s_dai_data *)
>> +                             platform_get_device_id(pdev)->driver_data;
>>  }
>>
>>  #ifdef CONFIG_PM_RUNTIME
>> @@ -1074,13 +1075,13 @@ static int samsung_i2s_probe(struct
>> platform_device *pdev) struct resource *res;
>>       u32 regs_base, quirks = 0, idma_addr = 0;
>>       struct device_node *np = pdev->dev.of_node;
>> -     enum samsung_dai_type samsung_dai_type;
>> +     struct samsung_i2s_dai_data *i2s_dai_data;
>
> const

OK.

>
>>       int ret = 0;
>>
>>       /* Call during Seconday interface registration */
>> -     samsung_dai_type = samsung_i2s_get_driver_data(pdev);
>> +     i2s_dai_data = samsung_i2s_get_driver_data(pdev);
>>
>> -     if (samsung_dai_type == TYPE_SEC) {
>> +     if (i2s_dai_data->dai_type == TYPE_SEC) {
>>               sec_dai = dev_get_drvdata(&pdev->dev);
>>               if (!sec_dai) {
>>                       dev_err(&pdev->dev, "Unable to get drvdata\n");
>> @@ -1129,15 +1130,7 @@ static int samsung_i2s_probe(struct
>> platform_device *pdev) idma_addr = i2s_cfg->idma_addr;
>>               }
>>       } else {
>> -             if (of_find_property(np, "samsung,supports-6ch", NULL))
>> -                     quirks |= QUIRK_PRI_6CHAN;
>> -
>> -             if (of_find_property(np, "samsung,supports-secdai", NULL))
>> -                     quirks |= QUIRK_SEC_DAI;
>> -
>> -             if (of_find_property(np, "samsung,supports-rstclr", NULL))
>> -                     quirks |= QUIRK_NEED_RSTCLR;
>> -
>> +             quirks = i2s_dai_data->quirks;
>>               if (of_property_read_u32(np, "samsung,idma-addr",
>>                                        &idma_addr)) {
>>                       if (quirks & QUIRK_SEC_DAI) {
>> @@ -1250,27 +1243,60 @@ static int samsung_i2s_remove(struct
>> platform_device *pdev) return 0;
>>  }
>>
>> +static struct samsung_i2s_dai_data i2sv3_dai_type = {
>
> const

OK.

>
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_NO_MUXPSR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data i2sv4_dai_type = {
>
> ditto
>
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_NO_MUXPSR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data i2sv5_c100_dai_type = {
>
> ditto
>
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_NO_MUXPSR | QUIRK_SEC_DAI |
>> +                     QUIRK_NEED_RSTCLR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data i2sv5_dai_type = {
>
> ditto
>
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data samsung_dai_type_sec = {
>
> ditto
>
>> +     .dai_type = TYPE_SEC,
>> +};
>> +
>>  static struct platform_device_id samsung_i2s_driver_ids[] = {
>>       {
>> -             .name           = "samsung-i2s",
>> -             .driver_data    = TYPE_PRI,
>> +             .name           = "samsung,s3c6410-i2s",
>> +             .driver_data    = (kernel_ulong_t)&i2sv3_dai_type,
>> +     }, {
>> +             .name           = "samsung,s3c6410-i2s-multi",
>> +             .driver_data    = (kernel_ulong_t)&i2sv4_dai_type,
>> +     }, {
>> +             .name           = "samsung,s5pc100-i2s",
>> +             .driver_data    = (kernel_ulong_t)&i2sv5_c100_dai_type,
>>       }, {
>> -             .name           = "samsung-i2s-sec",
>> -             .driver_data    = TYPE_SEC,
>> +             .name           = "samsung,s5pv210-i2s",
>> +             .driver_data    = (kernel_ulong_t)&i2sv5_dai_type,
>> +     }, {
>> +             .name           = "samsung-i2s-sec",
>> +             .driver_data    = (kernel_ulong_t)&samsung_dai_type_sec,
>>       },
>>       {},
>>  };
>>  MODULE_DEVICE_TABLE(platform, samsung_i2s_driver_ids);
>>
>>  #ifdef CONFIG_OF
>> -static struct samsung_i2s_dai_data samsung_i2s_dai_data_array[] = {
>> -     [TYPE_PRI] = { TYPE_PRI },
>> -     [TYPE_SEC] = { TYPE_SEC },
>> -};
>> -
>>  static const struct of_device_id exynos_i2s_match[] = {
>> -     { .compatible = "samsung,i2s-v5",
>> -       .data = &samsung_i2s_dai_data_array[TYPE_PRI],
>> +     {
>> +             .compatible = "samsung,s3c6410-i2s",
>> +             .data = &i2sv3_dai_type,
>> +     }, {
>> +             .compatible = "samsung,s5pv210-i2s",
>> +             .data = &i2sv5_dai_type,
>
> Hmm, documentation mentions 4 compatible values (and possibly one is
> missing there), but this patch adds only 2 of them. I don't think this is
> correct, especially that the driver already supports handling all of them.

Documentation mentions about all the compatible strings which are all
supported by this driver for reference. But some of the platforms
haven't converted to DT yet so here I added the compatible strings for
DT compliant platforms and compatible strings for non-DT compliant
platforms I added in the platform_device_id structure. Any way we have
to make all legacy platforms  DT compliant so we need this
"samsung,s3c6410-i2s-multi" in future.

>
> Best regards,
> Tomasz
>

Thanks
Padma
