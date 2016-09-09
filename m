From: andrew-ct.chen@mediatek.com (andrew-ct chen)
Date: Fri, 9 Sep 2016 09:25:14 +0800
Subject: [PATCH] [media] VPU: mediatek: fix null pointer dereference on
 pdev
In-Reply-To: <20160907171027.16424-1-colin.king@canonical.com>
References: <20160907171027.16424-1-colin.king@canonical.com>
Message-ID: <1473384314.10811.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-09-07 at 18:10 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> pdev is being null checked, however, prior to that it is being
> dereferenced by platform_get_drvdata.  Move the assignments of
> vpu and run to after the pdev null check to avoid a potential
> null pointer dereference.
> 

Reviewed-by:Andrew-CT Chen <andrew-ct.chen@mediatek.com>

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/media/platform/mtk-vpu/mtk_vpu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
> index c9bf58c..43907a3 100644
> --- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
> +++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
> @@ -523,9 +523,9 @@ static int load_requested_vpu(struct mtk_vpu *vpu,
>  
>  int vpu_load_firmware(struct platform_device *pdev)
>  {
> -	struct mtk_vpu *vpu = platform_get_drvdata(pdev);
> +	struct mtk_vpu *vpu;
>  	struct device *dev = &pdev->dev;
> -	struct vpu_run *run = &vpu->run;
> +	struct vpu_run *run;
>  	const struct firmware *vpu_fw = NULL;
>  	int ret;
>  
> @@ -534,6 +534,9 @@ int vpu_load_firmware(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	vpu = platform_get_drvdata(pdev);
> +	run = &vpu->run;
> +
>  	mutex_lock(&vpu->vpu_mutex);
>  	if (vpu->fw_loaded) {
>  		mutex_unlock(&vpu->vpu_mutex);
