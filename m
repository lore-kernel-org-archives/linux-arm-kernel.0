From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 14 Jun 2016 16:09:23 +0800
Subject: [PATCH 2/2 v16] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
References: <1464861445-11086-1-git-send-email-jitao.shi@mediatek.com>
 <1464861445-11086-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <CAGS+omDpakAsjijbhUG9gJZ6WA=+UBJ2fhhmp-ZEz7CtK8AHCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

On Thu, Jun 2, 2016 at 5:57 PM, Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> Changes since v15:
>  - Drop drm_connector_(un)register calls from parade ps8640.
>    The main DRM driver mtk_drm_drv now calls
>    drm_connector_register_all() after drm_dev_register() in the
>    mtk_drm_bind() function. That function should iterate over all
>    connectors and call drm_connector_register() for each of them.
>    So, remove drm_connector_(un)register calls from parade ps8640.

[snip...]

> +static void ps8640_pre_enable(struct drm_bridge *bridge)
> +{
> +       struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +       struct i2c_client *client = ps_bridge->page[2];
> +       int err;
> +       u8 set_vdo_done;
> +       ktime_t timeout;
> +
> +       if (ps_bridge->in_fw_update)
> +               return;
> +
> +       if (ps_bridge->enabled)
> +               return;
> +
> +       err = drm_panel_prepare(ps_bridge->panel);
> +       if (err < 0) {
> +               DRM_ERROR("failed to prepare panel: %d\n", err);
> +               return;
> +       }
> +

(1) For patch v10, Philipp Zabel commented that gpio_slp_n &
gpio_rst_n are both active low, and that the device tree should
contain a reset-gpios property with the GPIO_ACTIVE_LOW flag set.
(2) However, you did change the the reset logic from v10 -> v11, but
it isn't clear why (nor mentioned in the patch notes).

v10 (https://patchwork.kernel.org/patch/8357851/) had:

+ gpiod_set_value(ps_bridge->gpio_slp_n, 1);
+ gpiod_set_value(ps_bridge->gpio_rst_n, 0);
+
+ err = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
+    ps_bridge->supplies);
+ if (err < 0) {
+ DRM_ERROR("cannot enable regulators %d\n", err);
+ goto err_panel_unprepare;
+ }
+
+ usleep_range(500, 700);
+ gpiod_set_value(ps_bridge->gpio_rst_n, 1);

In other words:
  (a) de-assert power down
  (b) assert reset
  (c) enable 1.2 & 3.3 regulators
  (d) <wait for  regulator delay> (aka regulator-ramp-delay in device-tree)
  (e) wait an additional 2 ms (as requested by Parade for ps8640 to stabilize?)
  (f) de-assert reset
  (g) wait 200 ms (for ps8640 FW to load?)

This mostly made sense to me, except for step (a)... I'm not sure why
you de-assert power down before enabling the regulators.  It seems
like you'd want to do that later, maybe after reset (can you ask
Paradetech?).

Now (as of v11) it has changed to:

> +       err = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
> +                                   ps_bridge->supplies);
> +       if (err < 0) {
> +               DRM_ERROR("cannot enable regulators %d\n", err);
> +               goto err_panel_unprepare;
> +       }
> +
> +       gpiod_set_value(ps_bridge->gpio_slp_n, 1);
> +       gpiod_set_value(ps_bridge->gpio_rst_n, 0);
> +       usleep_range(2000, 2500);
> +       gpiod_set_value(ps_bridge->gpio_rst_n, 1);

Two additional comments:

(3) if you correctly configure these gpios as GPIO_ACTIVE_LOW, you can
drop the "_n" suffix, which will make the driver code easier to
understand.
(4) "gpio_slp_n" is called "PD#" by the PS8640 datasheet, so a better
name might be: "gpio_power_down".

Thanks,
-Dan
