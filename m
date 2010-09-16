From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Fri, 17 Sep 2010 00:27:13 +0200
Subject: [PATCH 1/3] [ARM] tegra: add PCI Express clocks
In-Reply-To: <AANLkTinN0rYG7rp5Gs3TyGOAQu5qJ18V_-yEuManuX33@mail.gmail.com>
References: <cover.1284655723.git.mike@compulab.co.il>
	<79b943ad0c9d4b99a6207e1a7e3ae09bbbe4fae5.1284655723.git.mike@compulab.co.il>
	<AANLkTinN0rYG7rp5Gs3TyGOAQu5qJ18V_-yEuManuX33@mail.gmail.com>
Message-ID: <AANLkTi=Mw33sVDdGLMxKh0HN0fKbzzUKqr6R9NHKEUFT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 11:27 PM, Colin Cross <ccross@google.com> wrote:
> On Thu, Sep 16, 2010 at 9:53 AM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>> ?arch/arm/mach-tegra/tegra2_clocks.c | ? 76 +++++++++++++++++++++++++++++++++-
>> ?1 files changed, 73 insertions(+), 3 deletions(-)
>
> <snip>
>
>> -static int tegra2_pll_clk_wait_for_lock(struct clk *c)
>> +static int tegra2_pll_clk_wait_for_bit_set(struct clk *c, int bit)
>> ?{
>> ? ? ? ?ktime_t before;
>>
>> ? ? ? ?before = ktime_get();
>> - ? ? ? while (!(clk_readl(c->reg + PLL_BASE) & PLL_BASE_LOCK)) {
>> + ? ? ? while (!(clk_readl(c->reg + PLL_BASE) & bit)) {
>> ? ? ? ? ? ? ? ?if (ktime_us_delta(ktime_get(), before) > 5000) {
>> ? ? ? ? ? ? ? ? ? ? ? ?pr_err("Timed out waiting for lock bit on pll %s",
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?c->name);
>> @@ -414,7 +416,7 @@ static int tegra2_pll_clk_enable(struct clk *c)
>> ? ? ? ?val |= PLL_MISC_LOCK_ENABLE;
>> ? ? ? ?clk_writel(val, c->reg + PLL_MISC(c));
>>
>> - ? ? ? tegra2_pll_clk_wait_for_lock(c);
>> + ? ? ? tegra2_pll_clk_wait_for_bit_set(c, PLL_BASE_LOCK);
>>
>> ? ? ? ?return 0;
>> ?}
>
> I've been told by Nvidia that the pll lock bits are not reliable, and
> will be removing uses of tegra2_pll_clk_wait_for_lock and replacing
> them with delays selected by each pll. ?Can you confirm with Nvidia
> that PLLE_MISC_READY works?

I'll try to get a confirmation from NVidia....
