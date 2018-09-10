From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 10 Sep 2018 11:17:24 -0600
Subject: [PATCH] coresight: tmc: Refactor loops in etb dump
In-Reply-To: <1536142147-21323-1-git-send-email-leo.yan@linaro.org>
References: <1536142147-21323-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CANLsYkw092cYLUKOw9hc6SDMgw+rSHj2NTdx73m1zybLO7Z0Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Sep 2018 at 04:09, Leo Yan <leo.yan@linaro.org> wrote:
>
> In ETB dump function tmc_etb_dump_hw() it has nested loops.  The second
> level loop is to iterate index in the range [0 .. drvdata->memwidth);
> but the index isn't really used in the code, thus the second level
> loop is useless.
>
> This patch is to remove the second level loop; the refactor also reduces
> indentation and we can use 'break' to replace 'goto' tag.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 9c599c9..8b34161 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -34,23 +34,20 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>  {
>         char *bufp;
>         u32 read_data, lost;
> -       int i;
>
>         /* Check if the buffer wrapped around. */
>         lost = readl_relaxed(drvdata->base + TMC_STS) & TMC_STS_FULL;
>         bufp = drvdata->buf;
>         drvdata->len = 0;
>         while (1) {
> -               for (i = 0; i < drvdata->memwidth; i++) {
> -                       read_data = readl_relaxed(drvdata->base + TMC_RRD);
> -                       if (read_data == 0xFFFFFFFF)
> -                               goto done;
> -                       memcpy(bufp, &read_data, 4);
> -                       bufp += 4;
> -                       drvdata->len += 4;
> -               }
> +               read_data = readl_relaxed(drvdata->base + TMC_RRD);
> +               if (read_data == 0xFFFFFFFF)
> +                       break;
> +               memcpy(bufp, &read_data, 4);
> +               bufp += 4;
> +               drvdata->len += 4;

I implemented these loops in accordance with the reference manual,
which is advising to read one ETB memory word at a time.  But taking a
step back getting rid of the inner loop yields exactly the same
result.  So I'll go ahead and apply your patch.

Thanks,
Mathieu

>         }
> -done:
> +
>         if (lost)
>                 coresight_insert_barrier_packet(drvdata->buf);
>         return;
> --
> 2.7.4
>
