From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jan 2013 14:53:34 -0700
Subject: [PATCH V5 1/3] clk: tegra: add Tegra specific clocks
In-Reply-To: <20130117155307.GF4118@tbergstrom-lnx.Nvidia.com>
References: <1358369575-7325-1-git-send-email-swarren@wwwdotorg.org>
 <20130117155307.GF4118@tbergstrom-lnx.Nvidia.com>
Message-ID: <50F872DE.9060109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 08:53 AM, Peter De Schrijver wrote:
> On Wed, Jan 16, 2013 at 09:52:53PM +0100, Stephen Warren wrote:
>> From: Prashant Gaikwad <pgaikwad@nvidia.com>
>>
>> Add Tegra specific clocks, pll, pll_out, peripheral, frac_divider, super.
>>
>> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
>> [swarren: alloc sizeof(*foo) not sizeof(struct foo), add comments re:
>> storing pointers to stack variables, make a timeout loop more idiomatic,
>> use _clk_pll_disable() not clk_disable_pll() from _program_pll() to
>> avoid redundant lock operations, unified tegra_clk_periph() and
>> tegra_clk_periph_nodiv(), unified tegra_clk_pll{,e}, rename all clock
>> registration functions so they don't have the same name as the clock
>> structs.]
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> ...
> 
>> +static int clk_plle_enable(struct clk_hw *hw)
>> +{
>> +       struct tegra_clk_pll *pll = to_clk_pll(hw);
>> +       unsigned long input_rate = clk_get_rate(clk_get_parent(hw->clk));
>> +       struct tegra_clk_pll_freq_table sel;
>> +       u32 val;
>> +       int err;
>> +
>> +       if (_get_table_rate(hw, &sel, pll->fixed_rate, input_rate))
>> +               return -EBUSY;
>> +
> 
> I think -EINVAL would be more appropriate here?

Yes. I fixed this and the PLL function parameters you mentioned in your
other email.
