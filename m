From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 20 Jun 2016 10:39:16 -0600
Subject: [PATCH] coresight-stm: support mmapping channel regions with
 mmio_addr
In-Reply-To: <1465870615-10215-1-git-send-email-zhang.chunyan@linaro.org>
References: <1465870615-10215-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <CANLsYkzsHXDTSn5AJFhBgUkpiS+EF9O589gDLUqkNU0vPoWx8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 June 2016 at 20:16, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> CoreSight STM device allows direct mapping of the channel regions to
> userspace for zero-copy writing. To support this ability, the STM
> freamwork has provided a hook 'mmio_addr', this patch just implemented
> this hook for CoreSight STM.
>
> This patch also added an item into 'channel_space' to save the start
> physical address of channel region which mmap operation needs to know.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 73be58a..4e70478 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -109,6 +109,7 @@ module_param_named(
>   */
>  struct channel_space {
>         void __iomem            *base;
> +       phys_addr_t             phys;

Please document this new field the same way @base and @guaranteed are.

Thanks,
Mathieu

>         unsigned long           *guaranteed;
>  };
>
> @@ -356,6 +357,23 @@ static void stm_generic_unlink(struct stm_data *stm_data,
>         stm_disable(drvdata->csdev);
>  }
>
> +static phys_addr_t
> +stm_mmio_addr(struct stm_data *stm_data, unsigned int master,
> +             unsigned int channel, unsigned int nr_chans)
> +{
> +       struct stm_drvdata *drvdata = container_of(stm_data,
> +                                                  struct stm_drvdata, stm);
> +       phys_addr_t addr;
> +
> +       addr = drvdata->chs.phys + channel * BYTES_PER_CHANNEL;
> +
> +       if (offset_in_page(addr) ||
> +           offset_in_page(nr_chans * BYTES_PER_CHANNEL))
> +               return 0;
> +
> +       return addr;
> +}
> +
>  static long stm_generic_set_options(struct stm_data *stm_data,
>                                     unsigned int master,
>                                     unsigned int channel,
> @@ -761,7 +779,9 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata)
>         drvdata->stm.sw_end = 1;
>         drvdata->stm.hw_override = true;
>         drvdata->stm.sw_nchannels = drvdata->numsp;
> +       drvdata->stm.sw_mmiosz = BYTES_PER_CHANNEL;
>         drvdata->stm.packet = stm_generic_packet;
> +       drvdata->stm.mmio_addr = stm_mmio_addr;
>         drvdata->stm.link = stm_generic_link;
>         drvdata->stm.unlink = stm_generic_unlink;
>         drvdata->stm.set_options = stm_generic_set_options;
> @@ -808,6 +828,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>         ret = stm_get_resource_byname(np, "stm-stimulus-base", &ch_res);
>         if (ret)
>                 return ret;
> +       drvdata->chs.phys = ch_res.start;
>
>         base = devm_ioremap_resource(dev, &ch_res);
>         if (IS_ERR(base))
> --
> 1.9.1
>
