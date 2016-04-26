From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Apr 2016 22:18:04 +0800
Subject: [PATCH] regulator: axp20x: Fix LDO4 linear voltage range
In-Reply-To: <1461679251-25538-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1461679251-25538-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v648p8T5PqxZTyvoZsugcTM03-mqjNnwSZLXJq_KnErFdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 10:00 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The current linear voltage range for the LDO4 regulator found in the APX20X
> PMICs assumes that the voltage is linear between 2.5 and 3.1V.
>
> However, the PMIC can output up to 3.3V on that regulator by skipping the
> 2.6V and 2.9V steps.
>
> Fix the ranges to read and set the proper voltages.
>
> Fixes: 13d57e64352a ("regulator: axp20x: Use linear voltage ranges for AXP20X LDO4")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Hans sent an identical patch (plus another fix) a month ago though.

> ---
> Hi Mark,
>
> This patch fixes a commit merged into 4.6-rc1, so it should probably go in
> the next -rc release.
>
> Thanks!
> Maxime
>
>  drivers/regulator/axp20x-regulator.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 40cd894e4df5..29ab0985b46e 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -157,7 +157,9 @@ static struct regulator_ops axp20x_ops_sw = {
>  static const struct regulator_linear_range axp20x_ldo4_ranges[] = {
>         REGULATOR_LINEAR_RANGE(1250000, 0x0, 0x0, 0),
>         REGULATOR_LINEAR_RANGE(1300000, 0x1, 0x8, 100000),
> -       REGULATOR_LINEAR_RANGE(2500000, 0x9, 0xf, 100000),
> +       REGULATOR_LINEAR_RANGE(2500000, 0x9, 0x9, 0),
> +       REGULATOR_LINEAR_RANGE(2700000, 0xa, 0xb, 100000),
> +       REGULATOR_LINEAR_RANGE(3000000, 0xc, 0xf, 100000),
>  };
>
>  static const struct regulator_desc axp20x_regulators[] = {
> --
> 2.8.1
>
