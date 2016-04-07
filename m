From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 7 Apr 2016 16:43:30 +0100
Subject: [PATCH 06/14] coresight: tmc: making prepare/unprepare functions
 generic
In-Reply-To: <1458678202-3447-7-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
 <1458678202-3447-7-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <57068022.6010405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/16 20:23, Mathieu Poirier wrote:
> Dealing with HW related matters in tmc_read_prepare/unprepare
> becomes convoluted when many cases need to be handled distinctively.
>
> As such moving processing related to HW setup to individual driver
> files and keep the core driver generic.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 68 ++++++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 50 +++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tmc.c     | 55 ++++----------------
>   drivers/hwtracing/coresight/coresight-tmc.h     |  8 +--
>   4 files changed, 131 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 467d19221f7b..789384be81b6 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -71,7 +71,7 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>   	}
>   }
>
> -void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
> +static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>   {
>   	CS_UNLOCK(drvdata->base);
>
> @@ -202,3 +202,69 @@ const struct coresight_ops tmc_etf_cs_ops = {
>   	.sink_ops	= &tmc_etf_sink_ops,
>   	.link_ops	= &tmc_etf_link_ops,
>   };
> +

> +int tmc_read_prepare_etf(struct tmc_drvdata *drvdata)

...

> +int tmc_read_unprepare_etf(struct tmc_drvdata *drvdata)


Ideally, we are operating ETF as if it was an ETB in the sink mode,
so,

tmc_read_{prepare/unprepare}_etb sounds more intuitive than _etf.

Nothing wrong with the current code.

Thanks
Suzuki
