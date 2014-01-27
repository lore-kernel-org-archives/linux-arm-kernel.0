From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jan 2014 15:54:14 +0100
Subject: [PATCH v2 2/5] clk: sunxi: Add USB clock register defintions
In-Reply-To: <20140127144349.GJ3867@lukather>
References: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
 <1390426587-16287-3-git-send-email-hdegoede@redhat.com>
 <20140127144349.GJ3867@lukather>
Message-ID: <52E67316.5020906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 01/27/2014 03:43 PM, Maxime Ripard wrote:
> Hi Hans,
> 
> Mostly looking good, but I have a few comments below.
> 
> On Wed, Jan 22, 2014 at 10:36:24PM +0100, Hans de Goede wrote:
>> From: Roman Byshko <rbyshko@gmail.com>
>> 
>> Add register definitions for the usb-clk register found on sun4i, sun5i and sun7i SoCs.
>> 
>> Signed-off-by: Roman Byshko <rbyshko@gmail.com> Signed-off-by: Hans de Goede <hdegoede@redhat.com> --- Documentation/devicetree/bindings/clock/sunxi.txt |  5 +++++ drivers/clk/sunxi/clk-sunxi.c                     | 12 ++++++++++++ 2 files changed, 17 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt index 79c7197..8bccb6a 100644 --- a/Documentation/devicetree/bindings/clock/sunxi.txt +++ b/Documentation/devicetree/bindings/clock/sunxi.txt @@ -37,6 +37,8 @@ Required properties: "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31 "allwinner,sun4i-mod0-clk" - for the module 0 family of clocks "allwinner,sun7i-a20-out-clk" - for the external output clocks +	"allwinner,sun4i-usb-gates-clk" - for usb gates + resets on A10 / A20 +
>> "allwinner,sun5i-a13-usb-gates-clk" - for usb gates + resets on A13
> 
> Maybe we can just remove the gates from there? Even though they are gates, they are also (a bit) more than that.

To be clear you mean s/usb-gates-clk/usb-clk/ right ?

That sounds reasonable :)

> 
>> Required properties for all clocks: - reg : shall be the control register address for the clock. @@ -49,6 +51,9 @@ Required properties for all clocks: Additionally, "allwinner,*-gates-clk" clocks require: - clock-output-names : the corresponding gate names that the clock controls
>> 
>> +And "allwinner,*-usb-gates-clk" clocks also require: +- reset-cells : shall be set to 1 +
> 
> You should also document what value we should put in the cells, and where to refer to to find the right one.

Ok.

> 
>> Clock consumers should specify the desired clocks they use with a "clocks" phandle cell. Consumers that are using a gated clock should provide an additional ID in their clock property. This ID is the diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c index f1a147c..18cbc3c 100644 --- a/drivers/clk/sunxi/clk-sunxi.c +++ b/drivers/clk/sunxi/clk-sunxi.c @@ -813,6 +813,16 @@ static const struct gates_data sun4i_ahb_gates_data __initconst = { .mask = {0x7F77FFF, 0x14FB3F}, };
>> 
>> +static const struct gates_data sun4i_usb_gates_data __initconst = { +	.mask = {0x1C0}, +	.reset_mask = 0x07, +}; + +static const struct gates_data sun5i_a13_usb_gates_data __initconst = { +	.mask = {0x140}, +	.reset_mask = 0x03, +}; +
> 
> I guess that means that we will have the OHCI0 gate declared with <&...-gates-clk 6>, while it's actually the first gate for this clock?

Correct.

> Maybe introducing an offset field in the gates_data would be a good idea, so that we always start from indexing the gates from 0 in the DT?

Well for the other "gates" type clks we also have holes in the range, and
we always refer to the clk with the bit number in the reg as the clock-cell
value.

Here the hole just happens to be at the start, but it seems best to me
to be consistent and keep using the bit nr inside the reg as clock-cell
value, without an offset.

> 
>> static const struct gates_data sun5i_a10s_ahb_gates_data __initconst = { .mask = {0x147667e7, 0x185915}, }; @@ -1159,6 +1169,8 @@ static const struct of_device_id clk_gates_match[] __initconst = { {.compatible = "allwinner,sun6i-a31-apb1-gates-clk", .data = &sun6i_a31_apb1_gates_data,}, {.compatible = "allwinner,sun7i-a20-apb1-gates-clk", .data = &sun7i_a20_apb1_gates_data,}, {.compatible = "allwinner,sun6i-a31-apb2-gates-clk", .data = &sun6i_a31_apb2_gates_data,}, +	{.compatible = "allwinner,sun4i-usb-gates-clk", .data = &sun4i_usb_gates_data,}, +	{.compatible =
>> "allwinner,sun5i-a13-usb-gates-clk", .data = &sun5i_a13_usb_gates_data,}, {} };
> 
> Thanks a lot! Maxime

Regards,

Hans

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLmcxYACgkQF3VEtJrzE/vjVgCfT8pMd/WAl2lr5HVURDcr6zz6
pDsAnjStUQa3j6WGOHPstjO2kV3WwkKO
=ozuq
-----END PGP SIGNATURE-----
