From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Jun 2014 11:25:49 +0800
Subject: [linux-sunxi] Re: [PATCH v3 5/6] clk: sunxi: Add A23 clocks
 support
In-Reply-To: <20140625202029.GJ19569@lukather>
References: <1403603980-31101-1-git-send-email-wens@csie.org>
 <1403603980-31101-6-git-send-email-wens@csie.org>
 <20140625202029.GJ19569@lukather>
Message-ID: <CAGb2v66wBfq2z93gJ7Xh64o09AdFDWJwAS2VzgU_EVURKoQ+YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 4:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jun 24, 2014 at 05:59:39PM +0800, Chen-Yu Tsai wrote:
>> The clock control unit on the A23 is similar to the one found on the A31.
>>
>> The AHB1, APB1, APB2 gates on the A23 are almost identical to the ones
>> on the A31, but some outputs are missing.
>>
>> The main CPU PLL (PLL1) however is like that on older Allwinner SoCs,
>> such as the A10 or A20, but the N factor starts from 1 instead of 0.
>>
>> This patch adds support for PLL1 and all the basic clock muxes and gates.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/clock/sunxi.txt |   5 ++
>>  drivers/clk/sunxi/clk-sunxi.c                     | 103 ++++++++++++++++++++++
>>  2 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index 6fe9492..d4832a7 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
[...]
>> @@ -673,6 +739,25 @@ static const struct div_data sun4i_axi_data __initconst = {
>>       .width  = 2,
>>  };
>>
>> +static const struct clk_div_table sun8i_a23_axi_table[] __initconst = {
>> +     { .val = 0, .div = 1 },
>> +     { .val = 1, .div = 2 },
>> +     { .val = 2, .div = 3 },
>> +     { .val = 3, .div = 4 },
>> +     { .val = 4, .div = 4 },
>> +     { .val = 5, .div = 4 },
>> +     { .val = 6, .div = 4 },
>> +     { .val = 7, .div = 4 },
>> +     { } /* sentinel */
>> +};
>> +
>> +static const struct div_data sun8i_a23_axi_data __initconst = {
>> +     .shift  = 0,
>> +     .pow    = 0,
>
> These are the default value.

I am aware. This is consistent with all the other div_data
instances, which have all fields set regardless of default
values.

>> +     .width  = 3,
>> +     .table  = sun8i_a23_axi_table,
>> +};
>> +
>>  static const struct div_data sun4i_ahb_data __initconst = {
>>       .shift  = 4,
>>       .pow    = 1,

[...]

> Looks fine otherwise,
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

If you're ok with being consistent, I'll add your acked-by
without changing it. Otherwise I'll remove the fields with
default values.

Thanks!


ChenYu
