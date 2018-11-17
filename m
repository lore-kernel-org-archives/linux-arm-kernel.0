From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 17 Nov 2018 22:09:23 +0100
Subject: [PATCH v2 4/4] clk: meson-gxbb: Add video clocks
In-Reply-To: <1541516257-16157-5-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
 <1541516257-16157-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCBSMNGKB5HSM_x5xgnxXZSymxrLE826AYLqwa3BMG4_KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Neil,

On Tue, Nov 6, 2018 at 3:59 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the clocks entries used in the video clock path, the clock path
> is doubled to permit having different synchronized clocks for different
> parts of the video pipeline.
>
> All dividers are flagged with CLK_GET_RATE_NOCACHE, and all gates are flagged
> with CLK_IGNORE_UNUSED since they are currently directly handled by the
> Meson DRM Driver.
> Once the DRM Driver is fully migrated to using the Common Clock Framework
> to handle the video clock tree, the CLK_GET_RATE_NOCACHE and CLK_IGNORE_UNUSED
> will be dropped.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I'm aware that this has been applied already
I only found a few nit-picks - so this is looking good!

> ---
>  drivers/clk/meson/gxbb.c | 722 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 722 insertions(+)
>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 0fd354b..30fbf8f 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -1558,6 +1558,616 @@ static struct clk_regmap gxbb_vapb = {
>         },
>  };
>
> +/* Video Clocks */
> +
> +static struct clk_regmap gxbb_vid_pll_div = {
> +       .data = &(struct meson_vid_pll_div_data){
> +               .val = {
> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
> +                       .shift   = 0,
> +                       .width   = 15,
> +               },
> +               .sel = {
> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
> +                       .shift   = 16,
> +                       .width   = 2,
> +               },
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vid_pll_div",
> +               .ops = &meson_vid_pll_div_ro_ops,
> +               .parent_names = (const char *[]){ "hdmi_pll" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +const char *gxbb_vid_pll_parent_names[] = { "vid_pll_div", "hdmi_pll" };
> +
> +static struct clk_regmap gxbb_vid_pll_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VID_PLL_CLK_DIV,
> +               .mask = 0x1,
> +               .shift = 18,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vid_pll_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bit 18 selects from 2 possible parents:
> +                * vid_pll_div or hdmi_pll
> +                */
> +               .parent_names = gxbb_vid_pll_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_vid_pll_parent_names),
you could get rid of the comment if you inline
gxbb_vid_pll_parent_names and set num_parents to 2 manually

> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vid_pll = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_PLL_CLK_DIV,
> +               .bit_idx = 19,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vid_pll",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vid_pll_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +const char *gxbb_vclk_parent_names[] = {
> +       "vid_pll", "fclk_div4", "fclk_div3", "fclk_div5", "vid_pll",
> +       "fclk_div7", "mpll1",
> +};
> +
> +static struct clk_regmap gxbb_vclk_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .mask = 0x7,
> +               .shift = 16,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bits 16:18 selects from 8 possible parents:
> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
> +                * vid_pll, fclk_div7, mp1
> +                */
does it select from 7 or 8 parents? you are listing only 7
the same applies for the usages below

> +               .parent_names = gxbb_vclk_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .mask = 0x7,
> +               .shift = 16,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               /*
> +                * bits 16:18 selects from 8 possible parents:
> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
> +                * vid_pll, fclk_div7, mp1
> +                */
> +               .parent_names = gxbb_vclk_parent_names,
> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_input = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_DIV,
> +               .bit_idx = 16,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_input",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_input = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_DIV,
> +               .bit_idx = 16,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_input",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_VID_CLK_DIV,
> +               .shift = 0,
> +               .width = 8,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "vclk_input" },
> +               .num_parents = 1,
> +               .flags = CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_VIID_CLK_DIV,
> +               .shift = 0,
> +               .width = 8,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "vclk2_input" },
> +               .num_parents = 1,
> +               .flags = CLK_GET_RATE_NOCACHE,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 19,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk_div" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 19,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2_div" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div1 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 0,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div1",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div2_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 1,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div2_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div4_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 2,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div4_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div6_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 3,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div6_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk_div12_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VID_CLK_CNTL,
> +               .bit_idx = 4,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk_div12_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div1 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 0,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div1",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div2_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 1,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div2_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div4_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 2,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div4_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div6_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 3,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div6_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_regmap gxbb_vclk2_div12_en = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = HHI_VIID_CLK_CNTL,
> +               .bit_idx = 4,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "vclk2_div12_en",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_names = (const char *[]){ "vclk2" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div2 = {
> +       .mult = 1,
> +       .div = 2,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div2",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div2_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div4 = {
> +       .mult = 1,
> +       .div = 4,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div4",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div4_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div6 = {
> +       .mult = 1,
> +       .div = 6,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div6",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div6_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk_div12 = {
> +       .mult = 1,
> +       .div = 12,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk_div12",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk_div12_en" },
> +               .num_parents = 1,
> +       },
> +};
> +
> +static struct clk_fixed_factor gxbb_vclk2_div2 = {
> +       .mult = 1,
> +       .div = 2,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "vclk2_div2",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "vclk2_div2_en" },
for the fclk_divX clocks we use the clk_fixed_factor as parent of the gate
you're doing it the other way around here (as well as for the vclk1
clocks above and the other vclk2 clocks below)
I'm not sure which way is correct though

[snip]


Regards
Martin
