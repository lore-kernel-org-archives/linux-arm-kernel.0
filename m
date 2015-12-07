From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 8 Dec 2015 10:59:53 +1100
Subject: [linux-sunxi] [PATCH 21/23] staging: mt29f_spinand: switch to
 mtd_ooblayout_ops
In-Reply-To: <1449527178-5930-22-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449527178-5930-22-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CAGRGNgV09JJ7+hDVJwZcp89nEsgNS6r2Mo1_R+EEAT9=aR-Z_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Tue, Dec 8, 2015 at 9:26 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/staging/mt29f_spinand/mt29f_spinand.c | 44 ++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> index cb9d5ab..967d50a 100644
> --- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> +++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> @@ -42,23 +42,29 @@ static inline struct spinand_state *mtd_to_state(struct mtd_info *mtd)
>  static int enable_hw_ecc;
>  static int enable_read_hw_ecc;
>
> -static struct nand_ecclayout spinand_oob_64 = {
> -       .eccbytes = 24,
> -       .eccpos = {
> -               1, 2, 3, 4, 5, 6,
> -               17, 18, 19, 20, 21, 22,
> -               33, 34, 35, 36, 37, 38,
> -               49, 50, 51, 52, 53, 54, },
> -       .oobfree = {
> -               {.offset = 8,
> -                       .length = 8},
> -               {.offset = 24,
> -                       .length = 8},
> -               {.offset = 40,
> -                       .length = 8},
> -               {.offset = 56,
> -                       .length = 8},
> -       }
> +static int spinand_oob_64_eccpos(struct mtd_info *mtd, int eccbyte)
> +{
> +       if (eccbyte > 23)
> +               return -ERANGE;
> +
> +       return ((eccbyte / 6) * 16) + 1;

Are you sure this is correct? My reading of this is that we'd get 1
for eccbytes 0 through 5.

Would

((eccbyte / 6) * 16) + (eccbyte % 6) + 1

be more correct?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
