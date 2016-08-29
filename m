From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2016 15:28:41 +0200
Subject: [PATCH 2/4 v2] soc: qcom: add EBI2 driver
In-Reply-To: <201608291520.07798.arnd@arndb.de>
References: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
 <1472028758-29272-3-git-send-email-linus.walleij@linaro.org>
 <201608291520.07798.arnd@arndb.de>
Message-ID: <CACRpkdZHHGZaaxym9f-3mGREmokRhgNm3yb_HxaP0=_iuZNk1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 3:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 August 2016, Linus Walleij wrote:
>
>> +static void qcom_ebi2_setup_chipselect(struct device_node *np,
>> +                                    struct device *dev,
>> +                                    void __iomem *ebi2_base,
>> +                                    void __iomem *ebi2_xmem,
>> +                                    u32 csindex)
>> +{
>> +     const struct cs_data *csd;
>> +     u32 slowcfg, fastcfg;
>> +     u32 val;
>> +     int ret;
>> +     int i;
>> +
>> +     csd = &cs_info[csindex];
>> +     val = readl_relaxed(ebi2_base);
>> +     val |= csd->enable_mask;
>> +     writel_relaxed(val, ebi2_base);
>> +     dev_dbg(dev, "enabled CS%u\n", csindex);
>
> better use readl/writel instead of *_relaxed() if it's not performance critical.
> If you have a function that is worth optimizing with relaxed accessors, add a
> comment about how your concluded that it's safe to do so.

OK changing it.

>> +static struct platform_driver qcom_ebi2_driver = {
>> +     .probe = qcom_ebi2_probe,
>> +     .driver = {
>> +             .name = "qcom-ebi2",
>> +             .of_match_table = qcom_ebi2_of_match,
>> +     },
>> +};
>> +builtin_platform_driver(qcom_ebi2_driver);
>
> Why not allow this to be a loadable module?

I don't see any point in it, it's so basic to be able to access the
MMIO devices on the platform, the plan was to select the driver
from the corresponding mach-qcom SoC type (MSM8660+APQ8060).

But I can make it a module instead, if preferred.

Yours,
Linus Walleij
