From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 10 Aug 2016 10:15:46 -0700
Subject: [PATCH 2/2] remoteproc: core: Rework obtaining a rproc from a DT
 phandle
In-Reply-To: <20160719154905.23344-2-lee.jones@linaro.org>
References: <20160719154905.23344-1-lee.jones@linaro.org>
 <20160719154905.23344-2-lee.jones@linaro.org>
Message-ID: <20160810171546.GN26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 19 Jul 08:49 PDT 2016, Lee Jones wrote:

> In this patch we;
>  - Use a subsystem generic phandle to obtain an rproc
>    - We have to support TI's bespoke version for the time being
>  - Convert wkup_m3_ipc driver to new API
>  - Rename the call to be more like other, similar OF calls
>  - Move feature-not-enabled inline stub to the headers
>  - Strip out duplicate code by calling into of_get_rproc_by_index()
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 41 ++++++++----------------------------
>  drivers/soc/ti/wkup_m3_ipc.c         | 14 +++---------
>  include/linux/remoteproc.h           |  4 ++--
>  3 files changed, 14 insertions(+), 45 deletions(-)
> 
[..]
> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
> index 8823cc8..15481f3 100644
> --- a/drivers/soc/ti/wkup_m3_ipc.c
> +++ b/drivers/soc/ti/wkup_m3_ipc.c
> @@ -385,7 +385,6 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	int irq, ret;
> -	phandle rproc_phandle;
>  	struct rproc *m3_rproc;
>  	struct resource *res;
>  	struct task_struct *task;
> @@ -430,16 +429,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
>  		return PTR_ERR(m3_ipc->mbox);
>  	}
>  
> -	if (of_property_read_u32(dev->of_node, "ti,rproc", &rproc_phandle)) {
> -		dev_err(&pdev->dev, "could not get rproc phandle\n");
> -		ret = -ENODEV;
> -		goto err_free_mbox;
> -	}
> -
> -	m3_rproc = rproc_get_by_phandle(rproc_phandle);
> -	if (!m3_rproc) {
> -		dev_err(&pdev->dev, "could not get rproc handle\n");
> -		ret = -EPROBE_DEFER;
> +	m3_rproc = of_get_rproc_by_phandle(dev->of_node);
> +	if (IS_ERR(m3_rproc)) {
> +		ret = PTR_ERR(m3_rproc);
>  		goto err_free_mbox;
>  	}
>  

Santosh, do you have any objections to me merging this?

of_get_rproc_by_phandle() will fall back and attempt to acquire the
handle from ti,rproc if the generic "rprocs" property doesn't exist.

Regards,
Bjorn
