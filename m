From: claude.youn@gmail.com (Seungwhan Youn)
Date: Fri, 8 Oct 2010 19:51:17 +0900
Subject: [PATCH 5/10] ARM: S5PV210: Add SCLK_SPDIF clock
In-Reply-To: <001b01cb66d1$d2a27010$77e75030$%kim@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286193154-17201-1-git-send-email-sw.youn@samsung.com>
	<001b01cb66d1$d2a27010$77e75030$%kim@samsung.com>
Message-ID: <AANLkTi=qpfv3z-dE7N9XO6GyTta43Fgy3gYN9DX5R1nP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 8, 2010 at 7:16 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Seungwhan Youn wrote:
>>
>> This patch add SCLK_SPDIF clock to support source clock of S/PDIF
>> on S5PV210.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/clock.c | ? 62
>> +++++++++++++++++++++++++++++++++++------
>> ?1 files changed, 53 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> index d562670..195a088 100644
>> --- a/arch/arm/mach-s5pv210/clock.c
>> +++ b/arch/arm/mach-s5pv210/clock.c
>> @@ -431,6 +431,12 @@ static struct clk init_clocks_disable[] = {
>> ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_p,
>> ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv210_clk_ip3_ctrl,
>> ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 6),
>> + ? ? }, {
>> + ? ? ? ? ? ? .name ? ? ? ? ? = "spdif",
>> + ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>> + ? ? ? ? ? ? .parent ? ? ? ? = &clk_p,
>> + ? ? ? ? ? ? .enable ? ? ? ? = s5pv210_clk_ip3_ctrl,
>> + ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 0),
>> ? ? ? },
>> ?};
>>
>> @@ -660,6 +666,53 @@ static struct clksrc_sources clkset_sclk_spdif = {
>> ? ? ? .nr_sources ? ? = ARRAY_SIZE(clkset_sclk_spdif_list),
>> ?};
>>
>> +static int s5pv210_spdif_set_rate(struct clk *clk, unsigned long rate)
>> +{
>> + ? ? struct clk *pclk;
>> + ? ? int ret;
>> +
>> + ? ? pclk = clk_get_parent(clk);
>> + ? ? if (IS_ERR(pclk))
>> + ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ret = pclk->ops->set_rate(pclk, rate);
>> + ? ? clk_put(pclk);
>> +
>> + ? ? return ret;
>> +}
>> +
>
> Similar with previous reply...please refer to it...
>

Please refer my previous reply on "[PATCH 3/10] ARM: S5PC100: Add
SCLK_SPDIF clock".

(snip)

Thanks,
Claude
