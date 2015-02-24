From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 24 Feb 2015 15:00:35 -0700
Subject: [PATCH 1/1 v2] ARM: coresight: fix system halt when etm enable
 and add nosmp to command line
In-Reply-To: <1424354275-18747-1-git-send-email-Frank.Li@freescale.com>
References: <1424354275-18747-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <CANLsYkwpmbK3Z=mEq65MKN6ETiHKL2nZbq7=LBimJkLSCi3=2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2015 at 06:57,  <Frank.Li@freescale.com> wrote:
> From: Frank Li <Frank.Li@freescale.com>
>
> when nosmp set, only 1 core enabled. try to access disable core will halt.
> dts need added arm,primecell-periphid =  <id> for none-boot core
> otherwise amba_device_add will halt when read peripheral id.
>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
> Change from v1 to v2
>         - fixed typo
>
>  drivers/coresight/coresight-etm3x.c | 4 ++++
>  drivers/coresight/of_coresight.c    | 3 +--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/coresight/coresight-etm3x.c b/drivers/coresight/coresight-etm3x.c
> index 73c3669..d312952 100644
> --- a/drivers/coresight/coresight-etm3x.c
> +++ b/drivers/coresight/coresight-etm3x.c
> @@ -1829,6 +1829,10 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>                 return ret;
>
>         drvdata->cpu = pdata ? pdata->cpu : 0;
> +       if (drvdata->cpu < 0) {
> +               ret = -EINVAL;
> +               goto err_arch_supported;
> +       }
>
>         get_online_cpus();
>         etmdrvdata[drvdata->cpu] = drvdata;
> diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
> index c3efa41..6804bbd 100644
> --- a/drivers/coresight/of_coresight.c
> +++ b/drivers/coresight/of_coresight.c
> @@ -196,8 +196,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
>                 if (cell) {
>                         hwid = of_read_number(cell, of_n_addr_cells(dn));
>                         index = get_logical_index(hwid);
> -                       if (index != -EINVAL)
> -                               pdata->cpu = index;
> +                       pdata->cpu = index;
>                 }
>         }
>
> --
> 1.9.1
>

Frank,

Thanks for your submission - this is a valid scenario.  On the flip
side things have changed in "of_get_coresight_platform_data()" and
your patch's logic doesn't apply.  Go look at my next branch [1] - we
are now using "of_get_cpu_node()" so that things work on 64-bit
implementations.

Keep what you've done in "etm_probe()" but you will have to re-work
the other part - meddling with "cpu_online()" would be my first
choice...

Lastly please improve the commit log.  Adding a peripheral ID in the
DTS will indeed prevent AMBA from proving a non-responsive memory area
but it is not the point of the patch itself.

Thanks,
Mathieu

[1]. https://git.linaro.org/kernel/coresight.git/shortlog/refs/heads/next
