From: joel@jms.id.au (Joel Stanley)
Date: Wed, 27 Sep 2017 16:11:15 +1000
Subject: [PATCH v2 1/5] clk: Add clock driver for ASPEED BMC SoCs
In-Reply-To: <1506310811.30138.15.camel@aj.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-2-joel@jms.id.au>
 <1506310811.30138.15.camel@aj.id.au>
Message-ID: <CACPK8XeQz=63PyEEC8947ppBa3UAJ0u5Na_oT6aHGk3OurKCJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 1:40 PM, Andrew Jeffery <andrew@aj.id.au> wrote:

>> +struct aspeed_clk_gate {
>> +     struct clk_hw   hw;
>> +     struct regmap   *map;
>> +     u8              clock_idx;
>> +     s8              reset_idx;
>> +     u8              flags;
>> +     spinlock_t      *lock;
>> +};
>
> It feels like the two structures could be unified, but the result turns into a
> bit of a mess with a union of structs to limit the space impact, so perhaps we
> shouldn't go there?

I agree; it's not going to make it any easier to read so lets leave it as is.

>
>> +
>> +#define to_aspeed_clk_gate(_hw) container_of(_hw, struct aspeed_clk_gate, hw)
>> +
>> +/* TODO: ask Aspeed about the actual parent data */
>> +static const struct aspeed_gate_data aspeed_gates[] __initconst = {
>> +/*    clk rst   name                 parent          flags   */
>> +     {  0, -1, "eclk-gate",          "eclk",         0 }, /* Video Engine */
>> +     {  1,  7, "gclk-gate",          NULL,           0 }, /* 2D engine */
>> +     {  2, -1, "mclk-gate",          "mpll",         CLK_IS_CRITICAL }, /* SDRAM */
>> +     {  3,  6, "vclk-gate",          NULL,           0 }, /* Video Capture */
>> +     {  4, 10, "bclk-gate",          "bclk",         0 }, /* PCIe/PCI */
>> +     {  5, -1, "dclk-gate",          NULL,           0 }, /* DAC */
>> +     {  6, -1, "refclk-gate",        "clkin",        CLK_IS_CRITICAL },
>> +     {  7,  3, "usb-port2-gate",     NULL,           0 }, /* USB2.0 Host port 2 */
>> +     {  8,  5, "lclk-gate",          NULL,           0 }, /* LPC */
>> +     {  9, 15, "usb-uhci-gate",      NULL,           0 }, /* USB1.1 (requires port 2 enabled) */
>> +     { 10, 13, "d1clk-gate",         NULL,           0 }, /* GFX CRT */
>
> Is there a typo in the AST2400 datasheet? It claims bit 10 is "D2CLK".

The ast2500 says d1clk, and the ast2400 says d2clk. Both call it the
GFX CRT clock. Normally changes between the two are in a different
colour, but we don't have that here :(

I'll ask Ryan if he knows what's going on.

>
>> +     /* 11: reserved */
>> +     /* 12: reserved */
>> +     { 13, 4,  "yclk-gate",          NULL,           0 }, /* HAC */
>> +     { 14, 14, "usb-port1-gate",     NULL,           0 }, /* USB2 hub/USB2 host port 1/USB1.1 dev */
>> +     { 15, -1, "uart1clk-gate",      "uart",         0 }, /* UART1 */
>> +     { 16, -1, "uart2clk-gate",      "uart",         0 }, /* UART2 */
>> +     { 17, -1, "uart5clk-gate",      "uart",         0 }, /* UART5 */
>> +     /* 18: reserved */
>> +     { 19, -1, "espiclk-gate",       NULL,           0 }, /* eSPI */
>
> 19 is reserved on the AST2400, and must be kept at '1'.

Yeah. This is another difference between the SoCs that isn't called
out by the "this has changed" colouring of the datasheet.

I'd suggest it's not worth adding the code to make the driver return
an error when requesting this one. If anyone feels strongly about it
we could skip the registration of this one at probe time on the
ast2400.

>
>> +     { 20, 11, "mac1clk-gate",       "clkin",        0 }, /* MAC1 */
>> +     { 21, 12, "mac2clk-gate",       "clkin",        0 }, /* MAC2 */
>> +     /* 22: reserved */
>> +     /* 23: reserved */
>> +     { 24, -1, "rsaclk-gate",        NULL,           0 }, /* RSA */
>> +     { 25, -1, "uart3clk-gate",      "uart",         0 }, /* UART3 */
>> +     { 26, -1, "uart4clk-gate",      "uart",         0 }, /* UART4 */
>> +     { 27, 16, "sdclk-gate",         NULL,           0 }, /* SDIO/SD */
>> +     { 28, -1, "lhclk-gate",         "lhclk",        0 }, /* LPC master/LPC+ */
>> +     /* 29: reserved */
>> +     /* 30: reserved */
>> +     /* 31: reserved */
>
> Interestingly bits 29-30 are reserved in both the AST2400 and AST2500
> datasheets, but are reserved-clear in the AST2400 datasheet and reserved-set in
> the AST2500 datasheet. This may affect how we write register.

The driver doesn't change the value, so I think we're safe.

> Separately, at one point I mistook the clk column for the index the entry
> should appear at, which isn't the case. Do you think designated intializers
> might help?

Will make the table a bit awkward, but it's a good suggestion. I'll
give it a go for v3.

>> +     /*
>> +      * This way all clock fetched before the platform device probes,
>
> Typo: "clocks"

Nice catch. It's a typo in the Gemini driver as well ;)

>
>> +      * except those we assign here for early use, will be deferred.
>> +      */
>> +     for (i = 0; i < ASPEED_NUM_CLKS; i++)
>> +             aspeed_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);

>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>> @@ -0,0 +1,43 @@
>> +#ifndef DT_BINDINGS_ASPEED_CLOCK_H
>> +#define DT_BINDINGS_ASPEED_CLOCK_H
>> +
>> +#define ASPEED_NUM_CLKS      34
>
> This is a bit of a nit pick: Do the constants below represent all the
> clocks in the SoC(s)? Maybe if not it's better to define
> ASPEED_NUM_CLKS in terms of (n + ASPEED_CLK_GATES) at the bottom - that
> way when a clock or gate is added ASPEED_NUM_CLKS has better locality and
> better visual progression in context.

Okay, I put it at the bottom.

>> +#define ASPEED_CLK_GATE_LHCCLK               (23 + ASPEED_CLK_GATES)
>
> Looks like there's an off-by-one error here: ASPEED_NUM_CLKS should be (23 +
> ASPEED_CLK_GATES + 1) = 35.

Thanks, fixed.
