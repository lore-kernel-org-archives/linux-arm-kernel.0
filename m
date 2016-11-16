From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 16 Nov 2016 13:47:03 +0530
Subject: [linux-sunxi] Re: [PATCH v3 1/2] drm/bridge: dumb-vga-dac:
 Support a VDD regulator supply
In-Reply-To: <CAGb2v67LR4KEb0tfGkT8+TqTauNyCMq1n6mRdXsa6TUJV0xncA@mail.gmail.com>
References: <20161029110611.28951-1-wens@csie.org>
 <20161029110611.28951-2-wens@csie.org>
 <20161031062836.mnzdprqfezrfkx4g@rob-hp-laptop>
 <CAGb2v64tTacSAG1vvO28h8MN9JC9w+OzSrP+j2eTzqAiQKgaSA@mail.gmail.com>
 <CAGb2v67LR4KEb0tfGkT8+TqTauNyCMq1n6mRdXsa6TUJV0xncA@mail.gmail.com>
Message-ID: <8cda4dc8-8804-c34c-3a64-53c0ee01f2e8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/15/2016 08:29 AM, Chen-Yu Tsai wrote:
> Hi,
>
> On Wed, Nov 2, 2016 at 9:33 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Mon, Oct 31, 2016 at 2:28 PM, Rob Herring <robh@kernel.org> wrote:
>>> On Sat, Oct 29, 2016 at 07:06:10PM +0800, Chen-Yu Tsai wrote:
>>>> Some dumb VGA DACs are active components which require external power.
>>>> Add support for specifying a regulator as its power supply.
>>>>
>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>> ---
>>>>  .../bindings/display/bridge/dumb-vga-dac.txt       |  2 ++
>>>
>>> For the binding,
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>
> Any comments on this patch from the DRM people?

A comment below.

>
> ChenYu
>
>>>
>>> One code comment below...
>>>
>>>>  drivers/gpu/drm/bridge/dumb-vga-dac.c              | 35 ++++++++++++++++++++++
>>>>  2 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>>>> index 003bc246a270..164cbb15f04c 100644
>>>> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>>>> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>>>> @@ -16,6 +16,8 @@ graph bindings specified in Documentation/devicetree/bindings/graph.txt.
>>>>  - Video port 0 for RGB input
>>>>  - Video port 1 for VGA output
>>>>
>>>> +Optional properties:
>>>> +- vdd-supply: Power supply for DAC
>>>>
>>>>  Example
>>>>  -------
>>>> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
>>>> index afec232185a7..59781e031220 100644
>>>> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
>>>> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
>>>> @@ -12,6 +12,7 @@
>>>>
>>>>  #include <linux/module.h>
>>>>  #include <linux/of_graph.h>
>>>> +#include <linux/regulator/consumer.h>
>>>>
>>>>  #include <drm/drmP.h>
>>>>  #include <drm/drm_atomic_helper.h>
>>>> @@ -23,6 +24,7 @@ struct dumb_vga {
>>>>       struct drm_connector    connector;
>>>>
>>>>       struct i2c_adapter      *ddc;
>>>> +     struct regulator        *vdd;
>>>>  };
>>>>
>>>>  static inline struct dumb_vga *
>>>> @@ -124,8 +126,33 @@ static int dumb_vga_attach(struct drm_bridge *bridge)
>>>>       return 0;
>>>>  }
>>>>
>>>> +static void dumb_vga_enable(struct drm_bridge *bridge)
>>>> +{
>>>> +     struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
>>>> +     int ret;
>>>> +
>>>> +     if (!IS_ERR(vga->vdd)) {
>>>
>>> if (IS_ERR())
>>>         return;
>>>
>>> ...will save some intentation.
>>
>> I thought about that, though if someone were to add more stuff to
>> this, such as an enable GPIO, they might have to rework it. A standalone
>> block of code would be easier to work with. I'm OK either way though.
>>
>> ChenYu
>>
>>>
>>>> +             ret = regulator_enable(vga->vdd);
>>>> +
>>>> +             if (ret) {
>>>> +                     DRM_ERROR("Failed to enable vdd regulator: %d\n", ret);
>>>> +                     return;
>>>> +             }
>>>> +     }
>>>> +}
>>>> +
>>>> +static void dumb_vga_disable(struct drm_bridge *bridge)
>>>> +{
>>>> +     struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
>>>> +
>>>> +     if (!IS_ERR(vga->vdd))
>>>> +             regulator_disable(vga->vdd);
>>>> +}
>>>> +
>>>>  static const struct drm_bridge_funcs dumb_vga_bridge_funcs = {
>>>>       .attach         = dumb_vga_attach,
>>>> +     .enable         = dumb_vga_enable,
>>>> +     .disable        = dumb_vga_disable,
>>>>  };
>>>>
>>>>  static struct i2c_adapter *dumb_vga_retrieve_ddc(struct device *dev)
>>>> @@ -169,6 +196,14 @@ static int dumb_vga_probe(struct platform_device *pdev)
>>>>               return -ENOMEM;
>>>>       platform_set_drvdata(pdev, vga);
>>>>
>>>> +     vga->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
>>>> +     if (IS_ERR(vga->vdd)) {
>>>> +             ret = PTR_ERR(vga->vdd);
>>>> +             if (ret == -EPROBE_DEFER)
>>>> +                     return -EPROBE_DEFER;
>>>> +             dev_dbg(&pdev->dev, "No vdd regulator found: %d\n", ret);

A cleaner way would be to set vga->vdd to NULL here, and do:

	int ret = 0;

	if (vga->vdd)
		ret = regulator_enable(vga->vdd);

	if (ret) {
		...
		return;
	}

	/* if a gpio is added later */
	if (vga->gpio)
		ret = gpiod_set_value_cansleep(vga->gpio, 1);

	if (ret) {
		...
		return;
	}
	...

We don't really care what error code is contained in vga->vdd once we have
identified whether we got a regulator or not.

The same thing can be done for ddc too, but that can done left for later.

If you're okay with the suggestion, can you re-spin a patch?

Thanks,
Archit

>>>> +     }
>>>> +
>>>>       vga->ddc = dumb_vga_retrieve_ddc(&pdev->dev);
>>>>       if (IS_ERR(vga->ddc)) {
>>>>               if (PTR_ERR(vga->ddc) == -ENODEV) {
>>>> --
>>>> 2.9.3
>>>>
>>>
>>> --
>>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>>> For more options, visit https://groups.google.com/d/optout.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
