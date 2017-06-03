From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 3 Jun 2017 22:58:39 +0800
Subject: [PATCH 13/19] drm/sun4i: hdmi: Add support for controller
 hardware variants
In-Reply-To: <20170602193827.rnjum6x5ra4x5wef@flea.lan>
References: <20170602101024.18940-1-wens@csie.org>
 <20170602101024.18940-14-wens@csie.org>
 <20170602193827.rnjum6x5ra4x5wef@flea.lan>
Message-ID: <CAGb2v676G4A5MWAgJdotszJZkGf5OtLw9n71wTWP=+2gpSRf5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 3, 2017 at 3:38 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Jun 02, 2017 at 06:10:18PM +0800, Chen-Yu Tsai wrote:
>> The HDMI controller found in earlier Allwinner SoCs have slight
>> differences:
>>
>>   - Need different initial values for the PLL related registers
>>
>>   - Different behavior of the DDC and TMDS clocks
>>
>>   - Different register layout for the DDC portion
>>
>>   - Separate DDC parent clock on the A31
>>
>>   - Explicit reset control
>>
>> The clock variants are supported within their implementations,
>> which only expose a create function for each variant.
>>
>> The different layout of the DDC registers necessitates a separate
>> version of struct drm_connector_helper_funcs.
>>
>> A new variant data structure is created to store pointers to the
>> above functions, structures, and the different initial values.
>> Another flag notates whether there is a separate DDC parent clock.
>> If not, the TMDS clock is passed to the DDC clock create function,
>> as before.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun6i-a31.c   |   2 +-
>>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |   8 +++
>>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 114 ++++++++++++++++++++++++++-------
>>  3 files changed, 100 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
>> index 4d6078fca9ac..e48186985a51 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
>> @@ -610,7 +610,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", lcd_ch1_parents,
>>
>>  static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(30), 0);
>>
>> -static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x140, BIT(31), 0);
>> +static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x154, BIT(31), 0);
>
> Unrelated change?

Indeed. :(

>>
>>  static const char * const mbus_parents[] = { "osc24M", "pll-periph",
>>                                            "pll-ddr" };
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> index c39c2a245339..c63d0bd95963 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> @@ -155,6 +155,8 @@ enum sun4i_hdmi_pkt_type {
>>       SUN4I_HDMI_PKT_END = 15,
>>  };
>>
>> +struct sun4i_hdmi_variant;
>> +
>>  struct sun4i_hdmi {
>>       struct drm_connector    connector;
>>       struct drm_encoder      encoder;
>> @@ -162,9 +164,13 @@ struct sun4i_hdmi {
>>
>>       void __iomem            *base;
>>
>> +     /* Reset control */
>> +     struct reset_control    *reset;
>> +
>>       /* Parent clocks */
>>       struct clk              *bus_clk;
>>       struct clk              *mod_clk;
>> +     struct clk              *ddc_parent_clk;
>>       struct clk              *pll0_clk;
>>       struct clk              *pll1_clk;
>>
>> @@ -175,6 +181,8 @@ struct sun4i_hdmi {
>>       struct sun4i_drv        *drv;
>>
>>       bool                    hdmi_monitor;
>> +
>> +     const struct sun4i_hdmi_variant *variant;
>>  };
>>
>>  int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> index 457614073501..9ded40aaed32 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> @@ -20,8 +20,10 @@
>>  #include <linux/clk.h>
>>  #include <linux/component.h>
>>  #include <linux/iopoll.h>
>> +#include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>>
>>  #include "sun4i_backend.h"
>>  #include "sun4i_crtc.h"
>> @@ -315,6 +317,56 @@ static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
>>       .atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
>>  };
>>
>> +struct sun4i_hdmi_variant {
>> +     const struct drm_connector_helper_funcs *connector_helpers;
>> +     int (*ddc_create)(struct sun4i_hdmi *hdmi, struct clk *clk);
>> +     int (*tmds_create)(struct sun4i_hdmi *hdmi);
>> +     bool has_ddc_parent_clk;
>> +     bool has_reset_control;
>> +
>> +     u32 pad_ctrl0_init_val;
>> +     u32 pad_ctrl1_init_val;
>> +     u32 pll_ctrl_init_val;
>> +};
>> +
>> +#define SUN4I_HDMI_PAD_CTRL1_MASK    (GENMASK(24, 7) | GENMASK(5, 0))
>> +#define SUN4I_HDMI_PLL_CTRL_MASK     (GENMASK(31, 8) | GENMASK(3, 0))
>> +
>> +static const struct sun4i_hdmi_variant sun5i_variant = {
>> +     .connector_helpers      = &sun4i_hdmi_connector_helper_funcs,
>> +     .ddc_create             = sun4i_ddc_create,
>> +     .tmds_create            = sun4i_tmds_create,
>
> If we store the variants info for those clocks in that structure, we
> don't need those functions anymore. This would be cleaner imho.

I'll see what I can do.

>> +     .has_ddc_parent_clk     = false,
>> +     .has_reset_control      = false,
>
> Those two are the default values

Right. I wanted them to be explicitly labeled.

ChenYu
