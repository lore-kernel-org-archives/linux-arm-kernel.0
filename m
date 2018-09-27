From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 27 Sep 2018 15:37:05 -0500
Subject: [PATCH v2 05/22] soc/fsl/qbman: add APIs to retrieve the probing
 status
In-Reply-To: <20180926132247.10971-6-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
 <20180926132247.10971-6-laurentiu.tudor@nxp.com>
Message-ID: <CADRPPNQCAs61R-2bLQDEO2ooDMHeVt2jJq8nh4rUNZk3jhDwGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 8:26 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Add a couple of new APIs to check the probing status of qman and bman:
>  'int bman_is_probed()' and 'int qman_is_probed()'.
> They return the following values.
>  *  1 if qman/bman were probed correctly
>  *  0 if qman/bman were not yet probed
>  * -1 if probing of qman/bman failed
> Drivers that use qman/bman driver services are required to use these
> APIs before calling any functions exported by qman or bman drivers
> or otherwise they will crash the kernel.
> The APIs will be used in the following couple of qbman portal patches
> and later in the series in the dpaa1 ethernet driver.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

As this is part of a bug fix for v4.19, applied on soc/fsl for fix.

> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>  drivers/soc/fsl/qbman/qman_ccsr.c | 11 +++++++++++
>  include/soc/fsl/bman.h            |  8 ++++++++
>  include/soc/fsl/qman.h            |  8 ++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index d180da003e4a..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -121,6 +121,7 @@ static void bm_set_memory(u64 ba, u32 size)
>   */
>  static dma_addr_t fbpr_a;
>  static size_t fbpr_sz;
> +static int __bman_probed;
>
>  static int bman_fbpr(struct reserved_mem *rmem)
>  {
> @@ -167,6 +168,12 @@ static irqreturn_t bman_isr(int irq, void *ptr)
>         return IRQ_HANDLED;
>  }
>
> +int bman_is_probed(void)
> +{
> +       return __bman_probed;
> +}
> +EXPORT_SYMBOL_GPL(bman_is_probed);
> +
>  static int fsl_bman_probe(struct platform_device *pdev)
>  {
>         int ret, err_irq;
> @@ -177,6 +184,8 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         u16 id, bm_pool_cnt;
>         u8 major, minor;
>
> +       __bman_probed = -1;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res) {
>                 dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
> @@ -266,6 +275,8 @@ static int fsl_bman_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       __bman_probed = 1;
> +
>         return 0;
>  };
>
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 0cfe79f85a66..383a49dcce68 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -274,6 +274,7 @@ static const struct qman_error_info_mdata error_mdata[] = {
>  static u32 __iomem *qm_ccsr_start;
>  /* A SDQCR mask comprising all the available/visible pool channels */
>  static u32 qm_pools_sdqcr;
> +static int __qman_probed;
>
>  static inline u32 qm_ccsr_in(u32 offset)
>  {
> @@ -689,6 +690,12 @@ static int qman_resource_init(struct device *dev)
>         return 0;
>  }
>
> +int qman_is_probed(void)
> +{
> +       return __qman_probed;
> +}
> +EXPORT_SYMBOL_GPL(qman_is_probed);
> +
>  static int fsl_qman_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -699,6 +706,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
>         u16 id;
>         u8 major, minor;
>
> +       __qman_probed = -1;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res) {
>                 dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
> @@ -845,6 +854,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       __qman_probed = 1;
> +
>         return 0;
>  }
>
> diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
> index eaaf56df4086..5b99cb2ea5ef 100644
> --- a/include/soc/fsl/bman.h
> +++ b/include/soc/fsl/bman.h
> @@ -126,4 +126,12 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num);
>   */
>  int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num);
>
> +/**
> + * bman_is_probed - Check if bman is probed
> + *
> + * Returns 1 if the bman driver successfully probed, -1 if the bman driver
> + * failed to probe or 0 if the bman driver did not probed yet.
> + */
> +int bman_is_probed(void);
> +
>  #endif /* __FSL_BMAN_H */
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index d4dfefdee6c1..597783b8a3a0 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -1186,4 +1186,12 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
>   */
>  int qman_release_cgrid(u32 id);
>
> +/**
> + * qman_is_probed - Check if qman is probed
> + *
> + * Returns 1 if the qman driver successfully probed, -1 if the qman driver
> + * failed to probe or 0 if the qman driver did not probed yet.
> + */
> +int qman_is_probed(void);
> +
>  #endif /* __FSL_QMAN_H */
> --
> 2.17.1
>
