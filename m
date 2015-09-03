From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 03 Sep 2015 12:27:47 +0800
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
Message-ID: <55E7CC43.7040608@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

? 09/03/2015 04:17 AM, Rob Herring ??:
> On Tue, Sep 1, 2015 at 1:14 AM, Yakir Yang <ykk@rock-chips.com> wrote:
>> Some edp screen do not have hpd signal, so we can't just return
>> failed when hpd plug in detect failed.
> This is a property of the panel (or connector perhaps), so this
> property should be located there. At least, it is a common issue and
> not specific to this chip. We could have an HDMI connector and failed
> to hook up HPD for example. A connector node is also where hpd-gpios
> should be located instead (and are already defined by
> ../bindings/video/hdmi-connector.txt). Perhaps we need a eDP connector
> binding, too.

Yep, I agree with your front point, it is a property of panel, not specific
to eDP controller, so this code should handle in connector logic.

But another question, if we just leave this property to connector,
then we would need to parse this property in analogix_dp-rockchip.c,
and then make an hook in analogix_dp_core.c driver. This is not nice,
and if there are some coming platform which alse want to use analogix_dp
code and meet this "no-hpd" situation,  then they would need duplicate
to parse this property and fill the hook in analogix_dp_core.c driver.
So it's little bit conflict  :-)

Beside I can not understand your example very well. Do you mean
that there are some HDMI monitor which also do not have HPD
signal (just like some eDP panel do not have hpd too), and then
the "hpd-gpios" ? Hmm... I don't know how the "hpd-gpios" want
to help in this case, would you mind show some sample code  :-D

> Are there any eDP panels which don't have EDID and need panel details in DT?

Oh, I think you want to collect some info that belong to panel
property but no indicate in panel EDID message, so those can
be collect in eDP connector binding, is it right ?

As for me, I just meet this "no-hpd" special situation.

- Yakir

>
> Rob
>
>> This is an hardware property, so we need add a devicetree property
>> "analogix,need-force-hpd" to indicate this sutiation.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v4: None
>> Changes in v3:
>> - Add "analogix,need-force-hpd" to indicate whether driver need foce
>>    hpd when hpd detect failed.
>>
>> Changes in v2: None
>>
>>   .../devicetree/bindings/drm/bridge/analogix_dp.txt |  4 ++-
>>   .../bindings/video/analogix_dp-rockchip.txt        |  1 +
>>   .../devicetree/bindings/video/exynos_dp.txt        |  1 +
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 36 +++++++++++++++++++---
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 ++
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  9 ++++++
>>   6 files changed, 47 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
>> index f54dc3e..c310367 100644
>> --- a/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
>> +++ b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
>> @@ -22,6 +22,9 @@ Required properties for dp-controller:
>>                  from general PHY binding: Should be "dp".
>>
>>   Optional properties for dp-controller:
>> +       -analogix,need-force-hpd:
>> +               Indicate driver need force hpd when hpd detect failed, this
>> +               is used for some eDP screen which don't have hpd signal.
>>          -hpd-gpios:
>>                  Hotplug detect GPIO.
>>                  Indicates which GPIO should be used for hotplug detection
>> @@ -31,7 +34,6 @@ Optional properties for dp-controller:
>>                  * Documentation/devicetree/bindings/video/exynos_dp.txt
>>                  * Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
>>
>> -
>>   [1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>>   -------------------------------------------------------------------------------
>>
>> diff --git a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
>> index 502483e..8b9ed7d 100644
>> --- a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
>> +++ b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
>> @@ -28,6 +28,7 @@ For the below properties, please refer to Analogix DP binding document:
>>   - phys (required)
>>   - phy-names (required)
>>   - hpd-gpios (optional)
>> +- analogix,need-force-hpd (optional)
>>   -------------------------------------------------------------------------------
>>
>>   Example:
>> diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
>> index ea03b3a..4f06e80 100644
>> --- a/Documentation/devicetree/bindings/video/exynos_dp.txt
>> +++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
>> @@ -41,6 +41,7 @@ For the below properties, please refer to Analogix DP binding document:
>>          -phys (required)
>>          -phy-names (required)
>>          -hpd-gpios (optional)
>> +       -analogix,need-force-hpd (optional)
>>          -video interfaces (optional)
>>
>>   Deprecated properties for DisplayPort:
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index f7227ec..e6b328a 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -63,15 +63,38 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
>>   {
>>          int timeout_loop = 0;
>>
>> -       while (analogix_dp_get_plug_in_status(dp) != 0) {
>> +       while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
>> +               if (analogix_dp_get_plug_in_status(dp) == 0)
>> +                       return 0;
>> +
>>                  timeout_loop++;
>> -               if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
>> -                       dev_err(dp->dev, "failed to get hpd plug status\n");
>> -                       return -ETIMEDOUT;
>> -               }
>>                  usleep_range(10, 11);
>>          }
>>
>> +       /*
>> +        * Some edp screen do not have hpd signal, so we can't just
>> +        * return failed when hpd plug in detect failed, DT property
>> +        * "need-force-hpd" would indicate whether driver need this.
>> +        */
>> +       if (!dp->need_force_hpd)
>> +               return -ETIMEDOUT;
>> +
>> +       /*
>> +        * The eDP TRM indicate that if HPD_STATUS(RO) is 0, AUX CH
>> +        * will not work, so we need to give a force hpd action to
>> +        * set HPD_STATUS manually.
>> +        */
>> +       dev_dbg(dp->dev, "failed to get hpd plug status, try to force hpd\n");
>> +
>> +       analogix_dp_force_hpd(dp);
>> +
>> +       if (analogix_dp_get_plug_in_status(dp) != 0) {
>> +               dev_err(dp->dev, "failed to get hpd plug in status\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       dev_dbg(dp->dev, "success to get plug in status after force hpd\n");
>> +
>>          return 0;
>>   }
>>
>> @@ -1287,6 +1310,9 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
>>          if (IS_ERR(dp->reg_base))
>>                  return PTR_ERR(dp->reg_base);
>>
>> +       dp->need_force_hpd =
>> +               of_property_read_bool(dev->of_node, "analogix,need-force-hpd");
>> +
>>          dp->hpd_gpio = of_get_named_gpio(dev->of_node, "hpd-gpios", 0);
>>          if (gpio_is_valid(dp->hpd_gpio))
>>                  dp->hpd_gpio = of_get_named_gpio(dev->of_node,
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> index d8945e2..6960ab3 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> @@ -160,6 +160,7 @@ struct analogix_dp_device {
>>          struct phy              *phy;
>>          int                     dpms_mode;
>>          int                     hpd_gpio;
>> +       bool                    need_force_hpd;
>>
>>          struct analogix_dp_plat_data *plat_data;
>>   };
>> @@ -180,6 +181,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>>                                         bool enable);
>>   void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
>>   void analogix_dp_init_hpd(struct analogix_dp_device *dp);
>> +void analogix_dp_force_hpd(struct analogix_dp_device *dp);
>>   enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
>>   void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp);
>>   void analogix_dp_reset_aux(struct analogix_dp_device *dp);
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> index 15346fe..3086afc 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> @@ -365,6 +365,15 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
>>          writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
>>   }
>>
>> +void analogix_dp_force_hpd(struct analogix_dp_device *dp)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
>> +       reg = (F_HPD | HPD_CTRL);
>> +       writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
>> +}
>> +
>>   enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp)
>>   {
>>          u32 reg;
>> --
>> 2.1.2
>>
>>
>
>
