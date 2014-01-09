From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 09 Jan 2014 14:12:05 -0800
Subject: [PATCH v4 02/15] clk: Allow drivers to pass in a regmap
In-Reply-To: <52CE055C.5030103@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
 <20140109015158.7168.60274@quantum> <52CE055C.5030103@codeaurora.org>
Message-ID: <52CF1EB5.9070706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/14 18:11, Stephen Boyd wrote:
> On 01/08/14 17:51, Mike Turquette wrote:
>> Patch #3 illustrates the sort of struct-member-creep that worries me.
>> What is to stop someone from putting "unsigned int divider_reg" or
>> "unsigned int mux_reg", and then the thing just keeps growing.
>>
> I see two ways forward if you don't want these members in struct clk_hw.
>
> 1) Inheritance: struct clk_regmap wrapper struct and
> clk_register_regmap() and devm_clk_register_regmap() and then another
> wrapper struct around that.
>
>  example:
>
> struct clk_regmap {
>         struct clk_hw hw;
>         struct regmap *regmap;
>         unsigned int enable_reg;
>         unsigned int enable_mask;
>         bool enable_is_inverted;
> };
>
> struct clk_branch {
>         u32     hwcg_reg;
>         u32     halt_reg;
>         u8      hwcg_bit;
>         u8      halt_bit;
>         u8      halt_check;
>
>         struct clk_regmap       clkr;
> };
>
> static struct clk_branch gsbi1_uart_clk = {
>         .halt_reg = 0x2fcc,
>         .halt_bit = 10,
>         .clkr = {
>                 .enable_reg = 0x29d4,
>                 .enable_mask = BIT(9),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "gsbi1_uart_clk",
>                         .parent_names = (const char *[]){
>                                 "gsbi1_uart_src",
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_branch_ops,
>                         .flags = CLK_SET_RATE_PARENT,
>                 },
>         },
> };

The downside to this approach is that we have to have two similar
structs for struct clk_gate if we want to support regmap in that code
path. If we put the regmap inside struct clk_hw we don't have two
different structs, we would just assign different ops.

struct clk_gate {
        struct clk_hw hw;
        void __iomem    *reg;
        u8              bit_idx;
        u8              flags;
        spinlock_t      *lock;
};

and

struct clk_gate_regmap {
        struct clk_regmap hw;
        u8              flags;
        spinlock_t      *lock;
};

Do you have any preference on which way we move forward here? I have the
wrapper method all finished and ready to send if you agree with that
approach.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
