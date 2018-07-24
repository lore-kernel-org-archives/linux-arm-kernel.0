From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 24 Jul 2018 14:04:07 +0200
Subject: [PATCH 2/2] clk: meson-gxbb: Add video clocks
In-Reply-To: <CAFBinCAsfJ+5xgFM3mDAPU18N=1VFzjQZNQc5R_Ri5=BsMAKYA@mail.gmail.com>
References: <1532079581-978-1-git-send-email-narmstrong@baylibre.com>
 <1532079581-978-3-git-send-email-narmstrong@baylibre.com>
 <CAFBinCAsfJ+5xgFM3mDAPU18N=1VFzjQZNQc5R_Ri5=BsMAKYA@mail.gmail.com>
Message-ID: <520a75d8-9c20-7ed0-f416-0bbb408075a5@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/2018 21:00, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Jul 20, 2018 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add the clocks entries used in the video clock path, the clock path
>> is doubled to permit having different synchronized clocks for different
>> parts of the video pipeline.
> maybe you can add the comment about CLK_GET_RATE_NOCACHE here as well

Yes

> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/clk/meson/gxbb.c              | 667 ++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/gxbb.h              |  24 +-
>>  include/dt-bindings/clock/gxbb-clkc.h |  17 +
>>  3 files changed, 706 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>> index f79ea33..5fabedf 100644
>> --- a/drivers/clk/meson/gxbb.c
>> +++ b/drivers/clk/meson/gxbb.c
>> @@ -1508,6 +1508,570 @@ static struct clk_regmap gxbb_vapb = {
>>         },
>>  };
>>
>> +/* Video Clocks */
>> +
>> +static struct clk_regmap gxbb_vid_pll_div = {
>> +       .data = &(struct meson_vid_pll_div_data){
>> +               .val = {
>> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
>> +                       .shift   = 0,
>> +                       .width   = 15,
>> +               },
>> +               .sel = {
>> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
>> +                       .shift   = 16,
>> +                       .width   = 2,
>> +               },
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vid_pll_div",
>> +               .ops = &meson_vid_pll_div_ro_ops,
>> +               .parent_names = (const char *[]){ "hdmi_pll" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static u32 mux_table_vid_pll[] = { 0, 1 };
> you can drop this mux table

Yep

> 
>> +const char *gxbb_vid_pll_parent_names[] = { "vid_pll_div", "hdmi_pll" };
>> +
>> +static struct clk_regmap gxbb_vid_pll_sel = {
>> +       .data = &(struct clk_regmap_mux_data){
>> +               .offset = HHI_VID_PLL_CLK_DIV,
>> +               .mask = 0x1,
>> +               .shift = 18,
>> +               .table = mux_table_vid_pll,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vid_pll_sel",
>> +               .ops = &clk_regmap_mux_ops,
>> +               /*
>> +                * bit 18 selects from 2 possible parents:
>> +                * vid_pll_div or hdmi_pll
>> +                */
>> +               .parent_names = gxbb_vid_pll_parent_names,
>> +               .num_parents = ARRAY_SIZE(gxbb_vid_pll_parent_names),
>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vid_pll = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_PLL_CLK_DIV,
>> +               .bit_idx = 19,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vid_pll",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vid_pll_sel" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static u32 mux_table_vclk[] = { 0, 1, 2, 3, 4, 5, 6 };
> you can drop this mux table

Yep

> 
>> +const char *gxbb_vclk_parent_names[] = {
>> +       "vid_pll", "fclk_div4", "fclk_div3", "fclk_div5", "vid_pll",
>> +       "fclk_div7", "mpll1",
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_sel = {
>> +       .data = &(struct clk_regmap_mux_data){
>> +               .offset = HHI_VID_CLK_CNTL,
>> +               .mask = 0x7,
>> +               .shift = 16,
>> +               .table = mux_table_vclk,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk_sel",
>> +               .ops = &clk_regmap_mux_ops,
>> +               /*
>> +                * bits 16:18 selects from 8 possible parents:
>> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
>> +                * vid_pll, fclk_div7, mp1
>> +                */
>> +               .parent_names = gxbb_vclk_parent_names,
>> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_sel = {
>> +       .data = &(struct clk_regmap_mux_data){
>> +               .offset = HHI_VIID_CLK_CNTL,
>> +               .mask = 0x7,
>> +               .shift = 16,
>> +               .table = mux_table_vclk,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk2_sel",
>> +               .ops = &clk_regmap_mux_ops,
>> +               /*
>> +                * bits 16:18 selects from 8 possible parents:
>> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
>> +                * vid_pll, fclk_div7, mp1
>> +                */
>> +               .parent_names = gxbb_vclk_parent_names,
>> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_input = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_DIV,
>> +               .bit_idx = 16,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk_input",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk_sel" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_input = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VIID_CLK_DIV,
>> +               .bit_idx = 16,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk2_input",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk2_sel" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_div = {
>> +       .data = &(struct clk_regmap_div_data){
>> +               .offset = HHI_VID_CLK_DIV,
>> +               .shift = 0,
>> +               .width = 8,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk_div",
>> +               .ops = &clk_regmap_divider_ops,
>> +               .parent_names = (const char *[]){ "vclk_input" },
>> +               .num_parents = 1,
>> +               .flags = CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_div = {
>> +       .data = &(struct clk_regmap_div_data){
>> +               .offset = HHI_VIID_CLK_DIV,
>> +               .shift = 0,
>> +               .width = 8,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk2_div",
>> +               .ops = &clk_regmap_divider_ops,
>> +               .parent_names = (const char *[]){ "vclk2_input" },
>> +               .num_parents = 1,
>> +               .flags = CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL,
>> +               .bit_idx = 19,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk_div" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2 = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VIID_CLK_CNTL,
>> +               .bit_idx = 19,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk2",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk2_div" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_div1 = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL,
>> +               .bit_idx = 0,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk_div1",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_div2_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL,
>> +               .bit_idx = 1,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk_div2_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_div4_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL,
>> +               .bit_idx = 2,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk_div4_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_div6_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL,
>> +               .bit_idx = 3,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk_div6_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk_div12_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL,
>> +               .bit_idx = 4,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk_div12_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_div1 = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VIID_CLK_CNTL,
>> +               .bit_idx = 0,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk2_div1",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk2" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_div2_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VIID_CLK_CNTL,
>> +               .bit_idx = 1,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk2_div2_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk2" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_div4_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VIID_CLK_CNTL,
>> +               .bit_idx = 2,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk2_div4_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk2" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_div6_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VIID_CLK_CNTL,
>> +               .bit_idx = 3,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk2_div6_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk2" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_vclk2_div12_en = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VIID_CLK_CNTL,
>> +               .bit_idx = 4,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "vclk2_div12_en",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "vclk2" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk_div2 = {
>> +       .mult = 1,
>> +       .div = 2,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk_div2",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk_div2_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk_div4 = {
>> +       .mult = 1,
>> +       .div = 4,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk_div4",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk_div4_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk_div6 = {
>> +       .mult = 1,
>> +       .div = 6,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk_div6",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk_div6_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk_div12 = {
>> +       .mult = 1,
>> +       .div = 12,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk_div12",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk_div12_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk2_div2 = {
>> +       .mult = 1,
>> +       .div = 2,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk2_div2",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk2_div2_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk2_div4 = {
>> +       .mult = 1,
>> +       .div = 4,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk2_div4",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk2_div4_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk2_div6 = {
>> +       .mult = 1,
>> +       .div = 6,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk2_div6",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk2_div6_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static struct clk_fixed_factor gxbb_vclk2_div12 = {
>> +       .mult = 1,
>> +       .div = 12,
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "vclk2_div12",
>> +               .ops = &clk_fixed_factor_ops,
>> +               .parent_names = (const char *[]){ "vclk2_div12_en" },
>> +               .num_parents = 1,
>> +       },
>> +};
>> +
>> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +const char *gxbb_cts_parent_names[] = {
>> +       "vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
>> +       "vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
>> +       "vclk2_div6", "vclk2_div12"
>> +};
>> +
>> +static struct clk_regmap gxbb_cts_enci_sel = {
>> +       .data = &(struct clk_regmap_mux_data){
>> +               .offset = HHI_VID_CLK_DIV,
>> +               .mask = 0xf,
>> +               .shift = 28,
>> +               .table = mux_table_cts_sel,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "cts_enci_sel",
>> +               .ops = &clk_regmap_mux_ops,
>> +               .parent_names = gxbb_cts_parent_names,
>> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_cts_encp_sel = {
>> +       .data = &(struct clk_regmap_mux_data){
>> +               .offset = HHI_VID_CLK_DIV,
>> +               .mask = 0xf,
>> +               .shift = 20,
>> +               .table = mux_table_cts_sel,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "cts_encp_sel",
>> +               .ops = &clk_regmap_mux_ops,
>> +               .parent_names = gxbb_cts_parent_names,
>> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_cts_vdac_sel = {
>> +       .data = &(struct clk_regmap_mux_data){
>> +               .offset = HHI_VIID_CLK_DIV,
>> +               .mask = 0xf,
>> +               .shift = 28,
>> +               .table = mux_table_cts_sel,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "cts_vdac_sel",
>> +               .ops = &clk_regmap_mux_ops,
>> +               .parent_names = gxbb_cts_parent_names,
>> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +/* TOFIX: add support for cts_tcon */
>> +static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +const char *gxbb_cts_hdmi_tx_parent_names[] = {
>> +       "vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
>> +       "vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
>> +       "vclk2_div6", "vclk2_div12"
>> +};
>> +
>> +static struct clk_regmap gxbb_hdmi_tx_sel = {
>> +       .data = &(struct clk_regmap_mux_data){
>> +               .offset = HHI_HDMI_CLK_CNTL,
>> +               .mask = 0xf,
>> +               .shift = 16,
>> +               .table = mux_table_hdmi_tx_sel,
>> +       },
>> +       .hw.init = &(struct clk_init_data){
>> +               .name = "hdmi_tx_sel",
>> +               .ops = &clk_regmap_mux_ops,
>> +               /*
>> +                * bits 31:28 selects from 12 possible parents:
>> +                * vclk_div1, vclk_div2, vclk_div4, vclk_div6, vclk_div12
>> +                * vclk2_div1, vclk2_div2, vclk2_div4, vclk2_div6, vclk2_div12,
>> +                * cts_tcon
>> +                */
>> +               .parent_names = gxbb_cts_hdmi_tx_parent_names,
>> +               .num_parents = ARRAY_SIZE(gxbb_cts_hdmi_tx_parent_names),
>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_cts_enci = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL2,
>> +               .bit_idx = 0,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "cts_enci",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "cts_enci_sel" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_cts_encp = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL2,
>> +               .bit_idx = 2,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "cts_encp",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "cts_encp_sel" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_cts_vdac = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL2,
>> +               .bit_idx = 4,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "cts_vdac",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "cts_vdac_sel" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>> +static struct clk_regmap gxbb_hdmi_tx = {
>> +       .data = &(struct clk_regmap_gate_data){
>> +               .offset = HHI_VID_CLK_CNTL2,
>> +               .bit_idx = 5,
>> +       },
>> +       .hw.init = &(struct clk_init_data) {
>> +               .name = "hdmi_tx",
>> +               .ops = &clk_regmap_gate_ops,
>> +               .parent_names = (const char *[]){ "hdmi_tx_sel" },
>> +               .num_parents = 1,
>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +       },
>> +};
>> +
>>  /* VDEC clocks */
>>
>>  static const char * const gxbb_vdec_parent_names[] = {
>> @@ -1919,6 +2483,43 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
>>                 [CLKID_HDMI_PLL_OD2]        = &gxbb_hdmi_pll_od2.hw,
>>                 [CLKID_SYS_PLL_DCO]         = &gxbb_sys_pll_dco.hw,
>>                 [CLKID_GP0_PLL_DCO]         = &gxbb_gp0_pll_dco.hw,
>> +               [CLKID_VID_PLL_DIV]         = &gxbb_vid_pll_div.hw,
>> +               [CLKID_VID_PLL_SEL]         = &gxbb_vid_pll_sel.hw,
>> +               [CLKID_VID_PLL]             = &gxbb_vid_pll.hw,
>> +               [CLKID_VCLK_SEL]            = &gxbb_vclk_sel.hw,
>> +               [CLKID_VCLK2_SEL]           = &gxbb_vclk2_sel.hw,
>> +               [CLKID_VCLK_INPUT]          = &gxbb_vclk_input.hw,
>> +               [CLKID_VCLK2_INPUT]         = &gxbb_vclk2_input.hw,
>> +               [CLKID_VCLK_DIV]            = &gxbb_vclk_div.hw,
>> +               [CLKID_VCLK2_DIV]           = &gxbb_vclk2_div.hw,
>> +               [CLKID_VCLK]                = &gxbb_vclk.hw,
>> +               [CLKID_VCLK2]               = &gxbb_vclk2.hw,
>> +               [CLKID_VCLK_DIV1]           = &gxbb_vclk_div1.hw,
>> +               [CLKID_VCLK_DIV2_EN]        = &gxbb_vclk_div2_en.hw,
>> +               [CLKID_VCLK_DIV2]           = &gxbb_vclk_div2.hw,
>> +               [CLKID_VCLK_DIV4_EN]        = &gxbb_vclk_div4_en.hw,
>> +               [CLKID_VCLK_DIV4]           = &gxbb_vclk_div4.hw,
>> +               [CLKID_VCLK_DIV6_EN]        = &gxbb_vclk_div6_en.hw,
>> +               [CLKID_VCLK_DIV6]           = &gxbb_vclk_div6.hw,
>> +               [CLKID_VCLK_DIV12_EN]       = &gxbb_vclk_div12_en.hw,
>> +               [CLKID_VCLK_DIV12]          = &gxbb_vclk_div12.hw,
>> +               [CLKID_VCLK2_DIV1]          = &gxbb_vclk2_div1.hw,
>> +               [CLKID_VCLK2_DIV2_EN]       = &gxbb_vclk2_div2_en.hw,
>> +               [CLKID_VCLK2_DIV2]          = &gxbb_vclk2_div2.hw,
>> +               [CLKID_VCLK2_DIV4_EN]       = &gxbb_vclk2_div4_en.hw,
>> +               [CLKID_VCLK2_DIV4]          = &gxbb_vclk2_div4.hw,
>> +               [CLKID_VCLK2_DIV6_EN]       = &gxbb_vclk2_div6_en.hw,
>> +               [CLKID_VCLK2_DIV6]          = &gxbb_vclk2_div6.hw,
>> +               [CLKID_VCLK2_DIV12_EN]      = &gxbb_vclk2_div12_en.hw,
>> +               [CLKID_VCLK2_DIV12]         = &gxbb_vclk2_div12.hw,
>> +               [CLKID_CTS_ENCI_SEL]        = &gxbb_cts_enci_sel.hw,
>> +               [CLKID_CTS_ENCP_SEL]        = &gxbb_cts_encp_sel.hw,
>> +               [CLKID_CTS_VDAC_SEL]        = &gxbb_cts_vdac_sel.hw,
>> +               [CLKID_HDMI_TX_SEL]         = &gxbb_hdmi_tx_sel.hw,
>> +               [CLKID_CTS_ENCI]            = &gxbb_cts_enci.hw,
>> +               [CLKID_CTS_ENCP]            = &gxbb_cts_encp.hw,
>> +               [CLKID_CTS_VDAC]            = &gxbb_cts_vdac.hw,
>> +               [CLKID_HDMI_TX]             = &gxbb_hdmi_tx.hw,
>>                 [NR_CLKS]                   = NULL,
>>         },
>>         .num = NR_CLKS,
>> @@ -2090,6 +2691,43 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>>                 [CLKID_HDMI_PLL_OD2]        = &gxl_hdmi_pll_od2.hw,
>>                 [CLKID_SYS_PLL_DCO]         = &gxbb_sys_pll_dco.hw,
>>                 [CLKID_GP0_PLL_DCO]         = &gxl_gp0_pll_dco.hw,
>> +               [CLKID_VID_PLL_DIV]         = &gxbb_vid_pll_div.hw,
>> +               [CLKID_VID_PLL_SEL]         = &gxbb_vid_pll_sel.hw,
>> +               [CLKID_VID_PLL]             = &gxbb_vid_pll.hw,
>> +               [CLKID_VCLK_SEL]            = &gxbb_vclk_sel.hw,
>> +               [CLKID_VCLK2_SEL]           = &gxbb_vclk2_sel.hw,
>> +               [CLKID_VCLK_INPUT]          = &gxbb_vclk_input.hw,
>> +               [CLKID_VCLK2_INPUT]         = &gxbb_vclk2_input.hw,
>> +               [CLKID_VCLK_DIV]            = &gxbb_vclk_div.hw,
>> +               [CLKID_VCLK2_DIV]           = &gxbb_vclk2_div.hw,
>> +               [CLKID_VCLK]                = &gxbb_vclk.hw,
>> +               [CLKID_VCLK2]               = &gxbb_vclk2.hw,
>> +               [CLKID_VCLK_DIV1]           = &gxbb_vclk_div1.hw,
>> +               [CLKID_VCLK_DIV2_EN]        = &gxbb_vclk_div2_en.hw,
>> +               [CLKID_VCLK_DIV2]           = &gxbb_vclk_div2.hw,
>> +               [CLKID_VCLK_DIV4_EN]        = &gxbb_vclk_div4_en.hw,
>> +               [CLKID_VCLK_DIV4]           = &gxbb_vclk_div4.hw,
>> +               [CLKID_VCLK_DIV6_EN]        = &gxbb_vclk_div6_en.hw,
>> +               [CLKID_VCLK_DIV6]           = &gxbb_vclk_div6.hw,
>> +               [CLKID_VCLK_DIV12_EN]       = &gxbb_vclk_div12_en.hw,
>> +               [CLKID_VCLK_DIV12]          = &gxbb_vclk_div12.hw,
>> +               [CLKID_VCLK2_DIV1]          = &gxbb_vclk2_div1.hw,
>> +               [CLKID_VCLK2_DIV2_EN]       = &gxbb_vclk2_div2_en.hw,
>> +               [CLKID_VCLK2_DIV2]          = &gxbb_vclk2_div2.hw,
>> +               [CLKID_VCLK2_DIV4_EN]       = &gxbb_vclk2_div4_en.hw,
>> +               [CLKID_VCLK2_DIV4]          = &gxbb_vclk2_div4.hw,
>> +               [CLKID_VCLK2_DIV6_EN]       = &gxbb_vclk2_div6_en.hw,
>> +               [CLKID_VCLK2_DIV6]          = &gxbb_vclk2_div6.hw,
>> +               [CLKID_VCLK2_DIV12_EN]      = &gxbb_vclk2_div12_en.hw,
>> +               [CLKID_VCLK2_DIV12]         = &gxbb_vclk2_div12.hw,
>> +               [CLKID_CTS_ENCI_SEL]        = &gxbb_cts_enci_sel.hw,
>> +               [CLKID_CTS_ENCP_SEL]        = &gxbb_cts_encp_sel.hw,
>> +               [CLKID_CTS_VDAC_SEL]        = &gxbb_cts_vdac_sel.hw,
>> +               [CLKID_HDMI_TX_SEL]         = &gxbb_hdmi_tx_sel.hw,
>> +               [CLKID_CTS_ENCI]            = &gxbb_cts_enci.hw,
>> +               [CLKID_CTS_ENCP]            = &gxbb_cts_encp.hw,
>> +               [CLKID_CTS_VDAC]            = &gxbb_cts_vdac.hw,
>> +               [CLKID_HDMI_TX]             = &gxbb_hdmi_tx.hw,
>>                 [NR_CLKS]                   = NULL,
>>         },
>>         .num = NR_CLKS,
>> @@ -2265,6 +2903,35 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
>>         &gxbb_hdmi_pll_dco,
>>         &gxbb_sys_pll_dco,
>>         &gxbb_gp0_pll,
>> +       &gxbb_vid_pll,
>> +       &gxbb_vid_pll_sel,
>> +       &gxbb_vid_pll_div,
>> +       &gxbb_vclk,
>> +       &gxbb_vclk_sel,
>> +       &gxbb_vclk_div,
>> +       &gxbb_vclk_input,
>> +       &gxbb_vclk_div1,
>> +       &gxbb_vclk_div2_en,
>> +       &gxbb_vclk_div4_en,
>> +       &gxbb_vclk_div6_en,
>> +       &gxbb_vclk_div12_en,
>> +       &gxbb_vclk2,
>> +       &gxbb_vclk2_sel,
>> +       &gxbb_vclk2_div,
>> +       &gxbb_vclk2_input,
>> +       &gxbb_vclk2_div1,
>> +       &gxbb_vclk2_div2_en,
>> +       &gxbb_vclk2_div4_en,
>> +       &gxbb_vclk2_div6_en,
>> +       &gxbb_vclk2_div12_en,
>> +       &gxbb_cts_enci,
>> +       &gxbb_cts_enci_sel,
>> +       &gxbb_cts_encp,
>> +       &gxbb_cts_encp_sel,
>> +       &gxbb_cts_vdac,
>> +       &gxbb_cts_vdac_sel,
>> +       &gxbb_hdmi_tx,
>> +       &gxbb_hdmi_tx_sel,
>>  };
>>
>>  struct clkc_data {
>> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
>> index 72bc077..171b7d8 100644
>> --- a/drivers/clk/meson/gxbb.h
>> +++ b/drivers/clk/meson/gxbb.h
>> @@ -165,8 +165,28 @@
>>  #define CLKID_HDMI_PLL_OD2       163
>>  #define CLKID_SYS_PLL_DCO        164
>>  #define CLKID_GP0_PLL_DCO        165
>> -
>> -#define NR_CLKS                          166
>> +#define CLKID_VID_PLL_SEL        167
>> +#define CLKID_VID_PLL_DIV        168
>> +#define CLKID_VCLK_SEL           169
>> +#define CLKID_VCLK2_SEL                  170
>> +#define CLKID_VCLK_INPUT         171
>> +#define CLKID_VCLK2_INPUT        172
>> +#define CLKID_VCLK_DIV           173
>> +#define CLKID_VCLK2_DIV                  174
>> +#define CLKID_VCLK_DIV2_EN       177
>> +#define CLKID_VCLK_DIV4_EN       178
>> +#define CLKID_VCLK_DIV6_EN       179
>> +#define CLKID_VCLK_DIV12_EN      180
>> +#define CLKID_VCLK2_DIV2_EN      181
>> +#define CLKID_VCLK2_DIV4_EN      182
>> +#define CLKID_VCLK2_DIV6_EN      183
>> +#define CLKID_VCLK2_DIV12_EN     184
>> +#define CLKID_CTS_ENCI_SEL       195
>> +#define CLKID_CTS_ENCP_SEL       196
>> +#define CLKID_CTS_VDAC_SEL       197
>> +#define CLKID_HDMI_TX_SEL        198
>> +
>> +#define NR_CLKS                          203
>>
>>  /* include the CLKIDs that have been made part of the DT binding */
>>  #include <dt-bindings/clock/gxbb-clkc.h>
>> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
>> index 3979d48..9f7b99e 100644
>> --- a/include/dt-bindings/clock/gxbb-clkc.h
>> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> shouldn't this go into a separate patch?
> 
>> @@ -128,5 +128,22 @@
>>  #define CLKID_VDEC_1           153
>>  #define CLKID_VDEC_HEVC                156
>>  #define CLKID_GEN_CLK          159
>> +#define CLKID_VID_PLL          166
>> +#define CLKID_VCLK             175
>> +#define CLKID_VCLK2            176
>> +#define CLKID_VCLK_DIV1                185
>> +#define CLKID_VCLK_DIV2                186
>> +#define CLKID_VCLK_DIV4                187
>> +#define CLKID_VCLK_DIV6                188
>> +#define CLKID_VCLK_DIV12       189
>> +#define CLKID_VCLK2_DIV1       190
>> +#define CLKID_VCLK2_DIV2       191
>> +#define CLKID_VCLK2_DIV4       192
>> +#define CLKID_VCLK2_DIV6       193
>> +#define CLKID_VCLK2_DIV12      194
> at first I was confused why you need to export all the dividers,
> instead of simply calling clk_set_rate with "parent_rate (taken vom
> VCLK or VCLK2) divided by N"
> then I noticed that the four muxes below can use VCLK *or* VCLK2
> dividers as input (as far as I remember this is different on Meson8b:
> there the muxes below take either the VCLK dividers or the VCLK2
> dividers as input, but not both)

Ok, I need to be sure both hdmi and enci/encp takes clock from the
same vclk tree, and in some HDMI mode you need to have a x2 clock
to cts_enci/encp from the same 1x clock to cts_htmi.

So I will need to manually setup the parents to make sure CCF doesn't
make a random choice.

Then I'll be able to do a set_rate on vclk to setup the proper PLL rate.

> 
>> +#define CLKID_CTS_ENCI         199
>> +#define CLKID_CTS_ENCP         200
>> +#define CLKID_CTS_VDAC         201
>> +#define CLKID_HDMI_TX          202
> is my assumption correct that you need to choose a specific input
> clock (VCLK or VCLK2) for a specific use-case (ENCI, ENCP, VDAC,
> HDMI_TX)?
> let's say HDMI uses VLKC2 as input (I'm not sure if it really does):
> could you skip the VCLK_DIV_* parents in the HDMI_TX clock definition
> - or does the selection of a specific parent clock (VCLK or VCLK2)
> depend on the output rate?

HDMI takes vclk2 (why ? I'll keep this path since it's always used by the
vendor code), and CBVS takes vclk.
I suspect they tried to make is possible to have CVBS and HDMI output
work at the same time using the VPP2 instance. But no idea how it works.

As I sais before, you need to feed a x2 factor to hdmi and enci/encp for
some modes, and I can't let CCF decide since they must take the same
clock path (VCLK or VCLK2, not both).

> 
> 
> Regards
> Martin
> 

Neil
