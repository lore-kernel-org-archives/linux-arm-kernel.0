From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 6 Dec 2016 12:58:08 +0100
Subject: [PATCH v3 1/3] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <689efaa1-d8d9-6937-5880-3ed7a1401268@ti.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
 <1480932549-30811-2-git-send-email-bgolaszewski@baylibre.com>
 <689efaa1-d8d9-6937-5880-3ed7a1401268@ti.com>
Message-ID: <CAMpxmJUCE86Y030jpLVD7=S6UThmRB2p-xS-oD3swnUSvMWe2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-05 11:15 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Monday 05 December 2016 03:39 PM, Bartosz Golaszewski wrote:
>> The aemif clock is added twice to the lookup table in da850.c. This
>> breaks the children list of pll0_sysclk3 as we're using the same list
>> links in struct clk. When calling clk_set_rate(), we get stuck in
>> propagate_rate().
>>
>> Create a separate clock for nand, inheriting the rate of the aemif
>> clock and retrieve it in the davinci_nand module.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/da850.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index e770c97..c008e5e 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -367,6 +367,11 @@ static struct clk aemif_clk = {
>>       .flags          = ALWAYS_ENABLED,
>>  };
>>
>> +static struct clk aemif_nand_clk = {
>> +     .name           = "nand",
>> +     .parent         = &aemif_clk,
>> +};
>> +
>>  static struct clk usb11_clk = {
>>       .name           = "usb11",
>>       .parent         = &pll0_sysclk4,
>> @@ -537,7 +542,7 @@ static struct clk_lookup da850_clks[] = {
>>       CLK("da830-mmc.0",      NULL,           &mmcsd0_clk),
>>       CLK("da830-mmc.1",      NULL,           &mmcsd1_clk),
>>       CLK("ti-aemif",         NULL,           &aemif_clk),
>> -     CLK(NULL,               "aemif",        &aemif_clk),
>> +     CLK(NULL,               "aemif",        &aemif_nand_clk),
>
> Why use a NULL device name here?

Hi Sekhar,

there's an issue with this bit. I added an of_dev_auxdata entry to
da8xx-dt.c for the nand node, but it didn't work (the nand driver
could not get the clock). When I dug deeper, it turned out, the nand
node is created from aemif_probe() instead of from
da850_init_machine() and the lookup table is not passed as argument to
of_platform_populate().

There are two solutions: one is using "620000000.nand" as dev_id in
the clock lookup table, but that's ugly. The second is leaving dev_id
as NULL - I verified that the nand driver works correctly having only
the connector id. Please let me know which one you prefer or if you
have other ideas.

Best regards,
Bartosz Golaszewski
