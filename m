From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 25 Feb 2016 19:32:55 +0100
Subject: [PATCH] pinctrl: lpc18xx: ensure ngroups is initialized at
 correct place
In-Reply-To: <1456335170-20718-1-git-send-email-colin.king@canonical.com>
References: <1456335170-20718-1-git-send-email-colin.king@canonical.com>
Message-ID: <CAGhQ9VykdYLA-ey2pzDVtccLPZvHNYLzmLHKyOnKr2TLLV+2yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

On 24 February 2016 at 18:32, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The initialization of ngroups is occurring at the end of the
> first iteration of the outer loop, which means that the
> assignment  pins[ngroups++] = i is potentially indexing into
> a region outside of array pins because ngroups is not initialized.
> Instead, initialize ngroups in the inner loop before the first
> inner loop iteration.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pinctrl/pinctrl-lpc18xx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
> index f0bebbe..ed1cfa7 100644
> --- a/drivers/pinctrl/pinctrl-lpc18xx.c
> +++ b/drivers/pinctrl/pinctrl-lpc18xx.c
> @@ -1170,9 +1170,8 @@ static int lpc18xx_create_group_func_map(struct device *dev,
>         u16 pins[ARRAY_SIZE(lpc18xx_pins)];
>         int func, ngroups, i;
>
> -       for (func = 0; func < FUNC_MAX; ngroups = 0, func++) {
> -
> -               for (i = 0; i < ARRAY_SIZE(lpc18xx_pins); i++) {
> +       for (func = 0; func < FUNC_MAX; func++) {
> +               for (ngroups = 0, i = 0; i < ARRAY_SIZE(lpc18xx_pins); i++) {

Good catch!

Reviewed-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
