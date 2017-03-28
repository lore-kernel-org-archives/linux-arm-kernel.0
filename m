From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 28 Mar 2017 08:09:18 -0700
Subject: [PATCH 1/1] pinctrl: meson: meson8b: fix the NAND DQS pins
In-Reply-To: <20170325184350.7677-2-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 25 Mar 2017 19:43:50 +0100")
References: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
 <20170325184350.7677-2-martin.blumenstingl@googlemail.com>
Message-ID: <m2shlxa15t.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The nand_groups table uses different names for the NAND DQS pins than
> the GROUP() definition in meson8b_cbus_groups (nand_dqs_0 vs nand_dqs0).
> This prevents using the NAND DQS pins in the devicetree.
>
> I decided to rename both pins to nand_dqs_15 and nand_dqs_18 as both seem
> to serve the same function, just exposed on different pins (unlike the
> ethernet TX pins for example, where there's eth_txd0..3 - all of these
> can be active at the same time as they are different data lines).
>
> Fixes: 0fefcb6876d0 ("pinctrl: Add support for Meson8b")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

IMO, the fix should be a separate from the rename, since one is a fix
for a real issue and the other is cosmetic.

Kevin

> ---
>  drivers/pinctrl/meson/pinctrl-meson8b.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
> index 76f077f18193..bf747eb1f3f4 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson8b.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
> @@ -267,8 +267,8 @@ static const unsigned int nand_ale_pins[]	= { PIN(BOOT_11, 0) };
>  static const unsigned int nand_cle_pins[]	= { PIN(BOOT_12, 0) };
>  static const unsigned int nand_wen_clk_pins[]	= { PIN(BOOT_13, 0) };
>  static const unsigned int nand_ren_clk_pins[]	= { PIN(BOOT_14, 0) };
> -static const unsigned int nand_dqs_0_pins[]	= { PIN(BOOT_15, 0) };
> -static const unsigned int nand_dqs_1_pins[]	= { PIN(BOOT_18, 0) };
> +static const unsigned int nand_dqs_15_pins[]	= { PIN(BOOT_15, 0) };
> +static const unsigned int nand_dqs_18_pins[]	= { PIN(BOOT_18, 0) };
>  
>  static const unsigned int sdxc_d0_c_pins[]	= { PIN(BOOT_0, 0)};
>  static const unsigned int sdxc_d13_c_pins[]	= { PIN(BOOT_1, 0), PIN(BOOT_2, 0),
> @@ -527,8 +527,8 @@ static struct meson_pmx_group meson8b_cbus_groups[] = {
>  	GROUP(nand_cle,		2,	20),
>  	GROUP(nand_wen_clk,	2,	19),
>  	GROUP(nand_ren_clk,	2,	18),
> -	GROUP(nand_dqs_0,	2,	27),
> -	GROUP(nand_dqs_1,	2,	28),
> +	GROUP(nand_dqs_15,	2,	27),
> +	GROUP(nand_dqs_18,	2,	28),
>  	GROUP(sdxc_d0_c,	4,	30),
>  	GROUP(sdxc_d13_c,	4,	29),
>  	GROUP(sdxc_d47_c,	4,	28),
> @@ -739,8 +739,8 @@ static const char * const sdxc_c_groups[] = {
>  static const char * const nand_groups[] = {
>  	"nand_io", "nand_io_ce0", "nand_io_ce1",
>  	"nand_io_rb0", "nand_ale", "nand_cle",
> -	"nand_wen_clk", "nand_ren_clk", "nand_dqs0",
> -	"nand_dqs1"
> +	"nand_wen_clk", "nand_ren_clk", "nand_dqs_15",
> +	"nand_dqs_18"
>  };
>  
>  static const char * const nor_groups[] = {
