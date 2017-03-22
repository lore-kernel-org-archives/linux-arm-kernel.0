From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 22 Mar 2017 10:22:57 +0100
Subject: [PATCH 3/5] clk: meson-gxbb: Add GXL/GXM GP0 Variant
In-Reply-To: <149014019624.54062.687648107621865354@resonance>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
 <1489411604-18700-4-git-send-email-narmstrong@baylibre.com>
 <149014019624.54062.687648107621865354@resonance>
Message-ID: <fb561438-dc9a-2e35-337c-6cabe589b0fe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 12:49 AM, Michael Turquette wrote:
> Hi Neil,
> 
> Quoting Neil Armstrong (2017-03-13 06:26:42)
>> @@ -821,6 +893,7 @@ struct pll_params_table gxbb_gp0_params_table[] = {
>>         &gxbb_hdmi_pll,
>>         &gxbb_sys_pll,
>>         &gxbb_gp0_pll,
>> +       &gxl_gp0_pll,

Yes, because this is the table used to change the register base, this won't harm in any way
to add SoC variant clocks, since they they are initialized using the gxbb_hw_onecell_data table.

> 
> Is there a reason for adding the pointer to this array here? It seems to
> me that the gxbb_gp0_pll and gxl_gp0_pll are mutually exclusive, so
> perhaps two different tables should be used?
> 
>>  };
>>  
>>  static struct meson_clk_mpll *const gxbb_clk_mplls[] = {
>> @@ -923,6 +996,10 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
>>         struct clk *parent_clk;
>>         struct device *dev = &pdev->dev;
>>  
>> +       /* Override GP0 clock for GXL/GXM */
>> +       if (of_device_is_compatible(dev->of_node, "amlogic,gxl-clkc"))
>> +               gxbb_hw_onecell_data.hws[CLKID_GP0_PLL] = &gxl_gp0_pll.hw;
> 
> Similarly, this above is a little ugly compared to dedicated tables for
> each variant.

Here is the true uglyness, but would you like to have the exact same gxbb_hw_onecell_data
duplicated for only two different clocks ?
The gxbb_hw_onecell_data table is 105 lines, and when adding new clocks, we will need to
make sure they are still synchronized.

If you have a better idea... I can still push a v2 with such table with also a
separate gxbb_clk_plls table stored in a struct given from of_device_get_match_data()

Neil

> 
> Regards,
> Mike
> 
>> +
>>         /*  Generic clocks and PLLs */
>>         clk_base = of_iomap(dev->of_node, 0);
>>         if (!clk_base) {
>> @@ -996,6 +1073,7 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
>>  
>>  static const struct of_device_id gxbb_clkc_match_table[] = {
>>         { .compatible = "amlogic,gxbb-clkc" },
>> +       { .compatible = "amlogic,gxl-clkc" },
>>         { }
>>  };
>>  
>> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
>> index 8ee2022..7f99bf6 100644
>> --- a/drivers/clk/meson/gxbb.h
>> +++ b/drivers/clk/meson/gxbb.h
>> @@ -71,6 +71,8 @@
>>  #define HHI_GP0_PLL_CNTL2              0x44 /* 0x11 offset in data sheet */
>>  #define HHI_GP0_PLL_CNTL3              0x48 /* 0x12 offset in data sheet */
>>  #define HHI_GP0_PLL_CNTL4              0x4c /* 0x13 offset in data sheet */
>> +#define        HHI_GP0_PLL_CNTL5               0x50 /* 0x14 offset in data sheet */
>> +#define        HHI_GP0_PLL_CNTL1               0x58 /* 0x16 offset in data sheet */
>>  
>>  #define HHI_XTAL_DIVN_CNTL             0xbc /* 0x2f offset in data sheet */
>>  #define HHI_TIMER90K                   0xec /* 0x3b offset in data sheet */
>> -- 
>> 1.9.1
>>
