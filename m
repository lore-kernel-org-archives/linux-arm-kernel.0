From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Jan 2018 17:58:29 +0530
Subject: [PATCH v4 5/7] clk: Introduce davinci clocks
In-Reply-To: <42102b7d-4e3c-d5fc-b0db-48a1203757ba@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-6-git-send-email-david@lechnology.com>
 <42102b7d-4e3c-d5fc-b0db-48a1203757ba@lechnology.com>
Message-ID: <521d77e1-1375-7ef0-4ef5-d8a3401d1b73@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 January 2018 03:01 AM, David Lechner wrote:
> Forgot to cc linux-clk, so doing that now...
> 
> 
> On 12/31/2017 05:39 PM, David Lechner wrote:
>> This introduces new drivers for arch/arm/mach-davinci. The code is based
>> on the clock drivers from there and adapted to use the common clock
>> framework.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>> ? drivers/clk/Makefile????????????????????? |?? 1 +
>> ? drivers/clk/davinci/Makefile????????????? |?? 3 +
>> ? drivers/clk/davinci/da8xx-cfgchip-clk.c?? | 380
>> ++++++++++++++++++++++++++++++
>> ? drivers/clk/davinci/pll.c???????????????? | 333
>> ++++++++++++++++++++++++++
>> ? drivers/clk/davinci/psc.c???????????????? | 217 +++++++++++++++++
>> ? include/linux/clk/davinci.h?????????????? |? 46 ++++
>> ? include/linux/platform_data/davinci_clk.h |? 25 ++
>> ? 7 files changed, 1005 insertions(+)

This is a pretty huge patch and I think each of cfgchip, pll and PSC
clocks deserve a patch of their own.

On the PLL patch, please describe how the PLL implementation on DaVinci
is different from Keystone, so no reuse is really possible. Similarly
for the PSC patch (no non-DT support in keystone etc).

>> diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
>> new file mode 100644
>> index 0000000..8ae85ee
>> --- /dev/null
>> +++ b/drivers/clk/davinci/psc.c
>> @@ -0,0 +1,217 @@

>> +static void psc_config(struct davinci_psc_clk *psc,
>> +?????????????? enum davinci_psc_state next_state)
>> +{
>> +??? u32 epcpr, ptcmd, pdstat, pdctl, mdstat, mdctl, ptstat;
>> +
>> +??? mdctl = readl(psc->base + MDCTL + 4 * psc->lpsc);
>> +??? mdctl &= ~MDSTAT_STATE_MASK;
>> +??? mdctl |= next_state;
>> +??? /* TODO: old davinci clocks for da850 set MDCTL_FORCE bit for
>> sata and
>> +???? * dsp here. Is this really needed?
>> +???? */
>> +??? writel(mdctl, psc->base + MDCTL + 4 * psc->lpsc);
>> +
>> +??? pdstat = readl(psc->base + PDSTAT + 4 * psc->pd);
>> +??? if ((pdstat & PDSTAT_STATE_MASK) == 0) {
>> +??????? pdctl = readl(psc->base + PDSTAT + 4 * psc->pd);
>> +??????? pdctl |= PDCTL_NEXT;
>> +??????? writel(pdctl, psc->base + PDSTAT + 4 * psc->pd);
>> +
>> +??????? ptcmd = BIT(psc->pd);
>> +??????? writel(ptcmd, psc->base + PTCMD);
>> +
>> +??????? do {
>> +??????????? epcpr = __raw_readl(psc->base + EPCPR);
>> +??????? } while (!(epcpr & BIT(psc->pd)));
>> +
>> +??????? pdctl = __raw_readl(psc->base + PDCTL + 4 * psc->pd);
>> +??????? pdctl |= PDCTL_EPCGOOD;
>> +??????? __raw_writel(pdctl, psc->base + PDCTL + 4 * psc->pd);

Can we shift to regmap here too? Then the polling loops like above can
be converted to regmap_read_poll_timeout() too like you have done elsewhere.

Thanks,
Sekhar
