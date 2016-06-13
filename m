From: dianders@chromium.org (Doug Anderson)
Date: Mon, 13 Jun 2016 16:06:21 -0700
Subject: [PATCH 04/11] mmc: sdhci-of-arasan: Properly set
 corecfg_baseclkfreq on rk3399
In-Reply-To: <f5dcc018-bd60-87a7-798b-efc261e443dd@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-5-git-send-email-dianders@chromium.org>
 <f5dcc018-bd60-87a7-798b-efc261e443dd@rock-chips.com>
Message-ID: <CAD=FV=UzGZmwGTthqqO5Skxj5f0wsS5VKr4gYP2i9SUyGqvbjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, Jun 13, 2016 at 1:36 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> ? 2016/6/8 6:44, Douglas Anderson ??:
>>
>> In the the earlier change in this series ("Documentation: mmc:
>> sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs") we can see the
>> mechansim for specifying a syscon to properly set corecfg registers in
>> sdhci-of-arasan.  Now let's use this mechanism to properly set
>> corecfg_baseclkfreq on rk3399.
>>
>>> From [1] the corecfg_baseclkfreq is supposed to be set to:
>>
>>   Base Clock Frequency for SD Clock.
>>   This is the frequency of the xin_clk.
>>
>> This is a relatively easy thing to do.  Note that we assume that xin_clk
>> is not dynamic and we can check the clock at probe time.  If any real
>> devices have a dynamic xin_clk future patches could register for
>> notifiers for the clock.
>>
>> At the moment, setting corecfg_baseclkfreq is only supported for rk3399
>> since we need a specific map for each implementation.  The code is
>> written in a generic way that should make this easy to extend to other
>> SoCs.  Note that a specific compatible string for rk3399 is already in
>> use and so we add that to the table to match rk3399.
>>
>> [1]:
>> https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 189
>> ++++++++++++++++++++++++++++++++++---
>>  1 file changed, 178 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>> b/drivers/mmc/host/sdhci-of-arasan.c
>> index 3ff1711077c2..859ea1b21215 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -22,6 +22,8 @@
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>>  #include <linux/phy/phy.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>
>
> alphabetical order

It was, but with a different definition of alphabetical order.  ;)
"syscon" (s) comes after "regmap" (r).  ...but your way is better,
you're right.


>> +/**
>> + * sdhci_arasan_update_baseclkfreq - Set corecfg_baseclkfreq
>> + *
>> + * The corecfg_baseclkfreq is supposed to contain the MHz of clk_xin.
>> This
>> + * function can be used to make that happen.
>> + *
>> + * NOTES:
>> + * - Many existing devices don't seem to do this and work fine.  To keep
>> + *   compatibility for old hardware where the device tree doesn't provide
>> a
>> + *   register map, this function is a noop if a soc_ctl_map hasn't been
>> provided
>> + *   for this platform.
>> + * - It's assumed that clk_xin is not dynamic and that we use the SDHCI
>> divider
>> + *   to achieve lower clock rates.  That means that this function is
>> called once
>> + *   at probe time and never called again.
>> + *
>> + * @host:              The sdhci_host
>> + */
>> +static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_arasan_data *sdhci_arasan =
>> sdhci_pltfm_priv(pltfm_host);
>> +       const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =
>> +               sdhci_arasan->soc_ctl_map;
>> +       u32 mhz = DIV_ROUND_CLOSEST(clk_get_rate(pltfm_host->clk),
>> 1000000);
>> +
>
>
> It's broken when reading capabilities reg on RK3399 platform
> which means you should get it via clk framework. But you should consider
> the non-broken case.

I'm afraid I don't understand.  Can you elaborate?  Are you saying if
things weren't broken then we wouldn't have to ask the common clock
framework for this?  Where would we get this value?

...or are you suggesting that in other SoCs you wouldn't need to set
corecfg_baseclkfreq because it would be somehow automatic?  If that's
so then those SoCs should just set -1 for "shift" in their map and
this function will be a no-op.


>> +       /* Having a map is optional */
>> +       if (!soc_ctl_map)
>> +               return;
>> +
>> +       /* If we have a map, we expect to have a syscon */
>> +       if (!sdhci_arasan->soc_ctl_base) {
>> +               pr_warn("%s: Have regmap, but no soc-ctl-syscon\n",
>> +                       mmc_hostname(host->mmc));
>> +               return;
>> +       }
>> +
>> +       sdhci_arasan_syscon_write(host, &soc_ctl_map->baseclkfreq, mhz);
>
>
> should we check the return value, and if not -EINVAL, we should give
> another try?

I don't see a reason to check the return code here.  Specifically:

* If this is a SoC where you don't need to write corecfg_baseclkfreq
then we need do nothing about this error.

* If the regmap write failed (which would be terribly unexpected for a
memory mapped register) then we've already printed an error (in
sdhci_arasan_syscon_write).  Best course of action seems to keep going
and try anyway.


I don't think a retry is likely to help anything.


>> +}
>> +
>>  static int sdhci_arasan_probe(struct platform_device *pdev)
>>  {
>>         int ret;
>> +       const struct of_device_id *match;
>> +       struct device_node *node;
>>         struct clk *clk_xin;
>>         struct sdhci_host *host;
>>         struct sdhci_pltfm_host *pltfm_host;
>> @@ -207,6 +363,23 @@ static int sdhci_arasan_probe(struct platform_device
>> *pdev)
>>         pltfm_host = sdhci_priv(host);
>>         sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>>
>> +       match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
>> +       sdhci_arasan->soc_ctl_map = match->data;
>> +
>> +       node = of_parse_phandle(pdev->dev.of_node,
>> "arasan,soc-ctl-syscon", 0);
>
>
> should it be within the scope of arasan,sdhci-5.1 or
> rockchip,rk3399-sdhci-5.1?

IMHO it doesn't hurt to do this for all SoCs.  This will help
facilitate other SoCs adding their own syscon so that they can
properly modify corecfg registers.

I can't say that I know anything about the other Arasan PHYs, but
presumably they also have corecfg registers.  If/when maps are added
for SoCs including those PHYs then this would be useful for them.

If you want I could change the code to only call of_parse_phandle if
"sdhci_arasan->soc_ctl_map" was non-NULL, but that should have no
functional change since we'll never actually use the syscon if we have
no map.


-Doug
