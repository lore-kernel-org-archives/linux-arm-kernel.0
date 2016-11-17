From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 17 Nov 2016 15:55:47 +0800
Subject: [PATCH v4 1/2] drm/bridge: dumb-vga-dac: Support a VDD regulator
 supply
In-Reply-To: <31b8b5b9-9621-286a-7649-cc999ab020da@codeaurora.org>
References: <20161116154232.872-1-wens@csie.org>
 <20161116154232.872-2-wens@csie.org>
 <31b8b5b9-9621-286a-7649-cc999ab020da@codeaurora.org>
Message-ID: <CAGb2v668A-hFnWy22_DarSSZ6TkvH5=WH-UvaXOFQJBqyKzPXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 3:48 PM, Archit Taneja <architt@codeaurora.org> wrote:
> Hi,
>
> Thanks for the patch.
>
>
> On 11/16/2016 09:12 PM, Chen-Yu Tsai wrote:
>>
>> Some dumb VGA DACs are active components which require external power.
>> Add support for specifying a regulator as its power supply.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/display/bridge/dumb-vga-dac.txt       |  2 ++
>>  drivers/gpu/drm/bridge/dumb-vga-dac.c              | 35
>> ++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>> b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>> index 003bc246a270..164cbb15f04c 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>> @@ -16,6 +16,8 @@ graph bindings specified in
>> Documentation/devicetree/bindings/graph.txt.
>>  - Video port 0 for RGB input
>>  - Video port 1 for VGA output
>>
>> +Optional properties:
>> +- vdd-supply: Power supply for DAC
>>
>>  Example
>>  -------
>> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
>> b/drivers/gpu/drm/bridge/dumb-vga-dac.c
>> index afec232185a7..15b549f94307 100644
>> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
>> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
>> @@ -12,6 +12,7 @@
>>
>>  #include <linux/module.h>
>>  #include <linux/of_graph.h>
>> +#include <linux/regulator/consumer.h>
>>
>>  #include <drm/drmP.h>
>>  #include <drm/drm_atomic_helper.h>
>> @@ -23,6 +24,7 @@ struct dumb_vga {
>>         struct drm_connector    connector;
>>
>>         struct i2c_adapter      *ddc;
>> +       struct regulator        *vdd;
>>  };
>>
>>  static inline struct dumb_vga *
>> @@ -124,8 +126,32 @@ static int dumb_vga_attach(struct drm_bridge *bridge)
>>         return 0;
>>  }
>>
>> +static void dumb_vga_enable(struct drm_bridge *bridge)
>> +{
>> +       struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
>> +       int ret = 0;
>> +
>> +       if (vga->vdd)
>> +               ret = regulator_enable(vga->vdd);
>> +
>> +       if (ret) {
>> +               DRM_ERROR("Failed to enable vdd regulator: %d\n", ret);
>> +               return;
>
>
> We don't need this return for now. If you're okay with it, can I fix this
> and queue to misc?

Yes, please!

Thanks
ChenYu

>
> Thanks,
> Archit
>
>
>> +       }
>> +}
>> +
>> +static void dumb_vga_disable(struct drm_bridge *bridge)
>> +{
>> +       struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
>> +
>> +       if (vga->vdd)
>> +               regulator_disable(vga->vdd);
>> +}
>> +
>>  static const struct drm_bridge_funcs dumb_vga_bridge_funcs = {
>>         .attach         = dumb_vga_attach,
>> +       .enable         = dumb_vga_enable,
>> +       .disable        = dumb_vga_disable,
>>  };
>>
>>  static struct i2c_adapter *dumb_vga_retrieve_ddc(struct device *dev)
>> @@ -169,6 +195,15 @@ static int dumb_vga_probe(struct platform_device
>> *pdev)
>>                 return -ENOMEM;
>>         platform_set_drvdata(pdev, vga);
>>
>> +       vga->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
>> +       if (IS_ERR(vga->vdd)) {
>> +               ret = PTR_ERR(vga->vdd);
>> +               if (ret == -EPROBE_DEFER)
>> +                       return -EPROBE_DEFER;
>> +               vga->vdd = NULL;
>> +               dev_dbg(&pdev->dev, "No vdd regulator found: %d\n", ret);
>> +       }
>> +
>>         vga->ddc = dumb_vga_retrieve_ddc(&pdev->dev);
>>         if (IS_ERR(vga->ddc)) {
>>                 if (PTR_ERR(vga->ddc) == -ENODEV) {
>>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
