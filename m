From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 14 Aug 2013 22:02:26 -0700
Subject: [PATCH v1 03/14] clk: Add of_clk_match() for device drivers
In-Reply-To: <20130813054839.GF14845@codeaurora.org>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-4-git-send-email-sboyd@codeaurora.org>
 <20130812202347.5348.76490@quantum> <20130813054839.GF14845@codeaurora.org>
Message-ID: <20130815050226.4443.39100@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2013-08-12 22:48:39)
> On 08/12, Mike Turquette wrote:
> > Quoting Stephen Boyd (2013-07-24 17:43:31)
> > > In similar fashion as of_regulator_match() add an of_clk_match()
> > > function that finds an initializes clock init_data structs from
> > > devicetree. Drivers should use this API to find clocks that their
> > > device is providing and then iterate over their match table
> > > registering the clocks with the init data parsed.
> > > 
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > Stephen,
> > 
> > In general I like this approach. Writing real device drivers for clock
> > controllers is The Right Way and of_clk_match helps.
> > 
> > Am I reading this correctly that the base register addresses/offsets for
> > the clock nodes still come from C files? For example I still see
> > pll8_desc defining reg stuff in drivers/clk/msm/gcc-8960.c.
> 
> I think we may be able to put the registers in DT but I don't
> know why we need to do that if we're already matching up nodes
> with C structs.

The reason to do so is to remove the per-clock data from the kernel
sources entirely. Separating logic and data.

> It also made me want to introduce devm_of_iomap()
> which just seemed wrong (if you have a dev struct why can't you
> use devm_ioremap()).
> 
> > 
> > What do you think about fetching this data from DT? My thinking here is
> > that the definition of that PLL structure would be in C, as would all of
> > the control logic. But any per-clock data whatsoever should live in DTS.
> > This means the clock data you supply in the DTS files in patches #9 and
> > #10 would have base addresses or offsets per-clock. I think this echoes
> > Mark R's concerns as well.
> > 
> > In the future if new chips have more of that type of PLL it would not
> > require changes to your clock driver, only new DTS data for the new
> > chip.
> > 
> > I could have that wrong though, there is a fair amount of indirection in
> > this series...
> 
> Let's take the PLL example and see if I follow what would be in
> DT and what would be in C.
> 
> Right now we have
> 
>         pll8: pll8 {
>                 #clock-cells = <0>;
>                 compatible = "qcom,pll";
>                 clocks = <&pxo>;
>         };
> 
> in DT and
> 
>         static struct pll_desc pll8_desc = {
>                 .l_reg = 0x3144,
>                 .m_reg = 0x3148,
>                 .n_reg = 0x314c,
>                 .config_reg = 0x3154,
>                 .mode_reg = 0x3140,
>                 .status_reg = 0x3158,
>                 .status_bit = 16,
>         };
> 
> in C. Do you want everything to be in DT? Something like:
> 
>         pll8: pll8 at 3140 {
>                 #clock-cells = <0>;
>                 compatible = "qcom,pll";
>                 clocks = <&pxo>;
>                 reg = <0x3140 0x20>;
>         };
> 
> and then assume that all those registers are offset from the base
> register and that the status bit is 16 (it usually is but not
> always)?

Ideally, yes. Adding new clocks of this type would not require changes
to the kernel sources.

> 
> The problem I see is this quickly breaks down with more
> complicated clocks like the RCGs.
> 
> We have
> 
>         gsbi5_uart_rcg: gsbi5_uart_rcg {
>                 #clock-cells = <0>;
>                 compatible = "qcom,p2-mn16-clock";
>                 clocks = <&pxo>, <&vpll8>;
>         };
> 
> in DT and
> 
>         static struct freq_tbl clk_tbl_gsbi_uart[] = {
>                 {  1843200, PLL8, 2,  6, 625 },
>                 {  3686400, PLL8, 2, 12, 625 },
>                 {  7372800, PLL8, 2, 24, 625 },
>                 { 14745600, PLL8, 2, 48, 625 },
>                 { 16000000, PLL8, 4,  1,   6 },
>                 { 24000000, PLL8, 4,  1,   4 },
>                 { 32000000, PLL8, 4,  1,   3 },
>                 { 40000000, PLL8, 1,  5,  48 },
>                 { 46400000, PLL8, 1, 29, 240 },
>                 { 48000000, PLL8, 4,  1,   2 },
>                 { 51200000, PLL8, 1,  2,  15 },
>                 { 56000000, PLL8, 1,  7,  48 },
>                 { 58982400, PLL8, 1, 96, 625 },
>                 { 64000000, PLL8, 2,  1,   3 },
>                 { }
>         };
> 
>         static struct rcg_desc gsbi5_uart_rcg = {
>                 .ctl_reg = 0x2a54,
>                 .ns_reg = 0x2a54,
>                 .md_reg = 0x2a50,
>                 .ctl_bit = 11,
>                 .mnctr_en_bit = 8,
>                 .mnctr_reset_bit = 7,
>                 .mnctr_mode_shift = 5,
>                 .pre_div_shift = 3,
>                 .src_sel_shift = 0,
>                 .n_val_shift = 16,
>                 .m_val_shift = 16,
>                 .parent_map = gcc_pxo_pll8_map,
>                 .freq_tbl = clk_tbl_gsbi_uart,
>         };
> 
> in C. It starts to get pretty unwieldy when you put this all in
> DT, plus you'll notice that the ns_reg and ctl_reg are the same
> here because we've generalized the code to work with different
> types of software interfaces (technically this clock has no ctl
> register, just an NS and MD register). Our multimedia clock
> controllers don't follow any standard base/offset pair and so the
> ctl_reg can be a different offset from the md_reg depending on
> which clock we're talking about. My initial try at translating
> this into DT pretty much just made every struct member into a
> property, including the duplicate register, expect for the
> frequency table, which could probably also be DT-ified with some
> work.
> 
>         gsbi5_uart_rcg: gsbi5_uart_rcg at 2a54 {
>                 #clock-cells = <0>;
>                 compatible = "qcom,p2-mn16-clock";
>                 clocks = <&pxo>, <&vpll8>;
>                 reg = <0x2a54 0x4>,
>                       <0x2a54 0x4>,
>                       <0x2a50 0x4>;
>                 ctl_bit = <11>;
>                 mnctr_en_bit = <8>;
>                 mnctr_reset_bit = <7>;
>                 mnctr_mode_shift = <5>;
>                 pre_div_shift = <3>;
>                 src_sel_shift = <0>;
>                 n_val_shift = <16>;
>                 m_val_shift = <16>;
>         };
> 
> This is great for making the kernel DT-data-driven, but I
> couldn't find any other driver that was describing register level
> details in DT.

Yeah, this sucks. Building a binding from a C struct is a bad idea. How
many permutations are there? Hopefully some clocks use the same bit
shifts and have reliable register offsets, with the only difference
being base address. If this is the case then a compatible string could
be done for each permutation assuming that number is low and manageable.

> 
> The good news is that newer clock controllers follow a standard
> and so we can specify one or two register properties and the type
> of clock and we're pretty much done. The software interface
> hasn't been randomized like on earlier controllers and bits
> within registers are always the same.

This does not suck. Just for the sake of argument let's say that you
only had to deal with this new and improved register layout and not the
old (current) stuff. Do you still see a reason to match DT data up with
C struct data objects in the kernel?

> We still have some clocks
> that are just on/off switches though and so we'll have to put
> register level details like which bit turns that clock on in DT
> (which I believe is not preferred/allowed?). I don't see any way
> to avoid that if we want it to be entirely DT driven.

This is what I'm doing for the generic clock bindings. No one has
screamed over that stuff so I guess rules were meant to be broken.

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
