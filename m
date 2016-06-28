From: k.debski@samsung.com (Kamil Debski)
Date: Tue, 28 Jun 2016 11:57:29 +0200
Subject: [PATCH] media: s5p-mfc fix memory leak in s5p_mfc_remove()
In-Reply-To: <1465847114-7427-1-git-send-email-shuahkh@osg.samsung.com>
References: <1465847114-7427-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <025e01d1d123$7c14e620$743eb260$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Shuah,

Which branch do you base your patches on?

I have trouble applying this path
(https://patchwork.linuxtv.org/patch/34577/) and 
"s5p-mfc fix null pointer deference in clk_core_enable()"
(https://patchwork.linuxtv.org/patch/34751/) 
onto current linuxtv/master.

The top commit of linuxtv/master is :
"commit 0db5c79989de2c68d5abb7ba891bfdb3cd3b7e05
Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date:   Thu Jun 16 08:04:40 2016 -0300

    [media] media-devnode.h: Fix documentation"

Could you please rebase the two patches mentioned above to the
linuxtv/master?

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland


> -----Original Message-----
> From: Shuah Khan [mailto:shuahkh at osg.samsung.com]
> Sent: Monday, June 13, 2016 9:45 PM
> To: kyungmin.park at samsung.com; k.debski at samsung.com;
> jtp.park at samsung.com; mchehab at osg.samsung.com
> Cc: Shuah Khan; linux-arm-kernel at lists.infradead.org; linux-
> media at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH] media: s5p-mfc fix memory leak in s5p_mfc_remove()
> 
> s5p_mfc_remove() fails to release encoder and decoder video devices.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> Changes since v1:
> - Addressed comments from Javier Martinez Canillas and added
>   his reviewed by:
> 
>  drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index 274b4f1..f537b74 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -1318,6 +1318,8 @@ static int s5p_mfc_remove(struct platform_device
> *pdev)
> 
>  	video_unregister_device(dev->vfd_enc);
>  	video_unregister_device(dev->vfd_dec);
> +	video_device_release(dev->vfd_enc);
> +	video_device_release(dev->vfd_dec);
>  	v4l2_device_unregister(&dev->v4l2_dev);
>  	s5p_mfc_release_firmware(dev);
>  	vb2_dma_contig_cleanup_ctx(dev->alloc_ctx[0]);
> --
> 2.7.4
