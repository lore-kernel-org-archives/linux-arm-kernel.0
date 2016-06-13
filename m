From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 13 Jun 2016 09:42:43 -0400
Subject: [PATCH] media: s5p-mfc fix memory leak in s5p_mfc_remove()
In-Reply-To: <1465436115-13880-1-git-send-email-shuahkh@osg.samsung.com>
References: <1465436115-13880-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <CABxcv=nT_zp2BkvSV04sqaXmZGnQz=z-cGURDJwUW7hthD6-Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On Wed, Jun 8, 2016 at 9:35 PM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> s5p_mfc_remove() fails to release encoder and decoder video devices.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index 274b4f1..af61f54 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -1317,7 +1317,9 @@ static int s5p_mfc_remove(struct platform_device *pdev)
>         destroy_workqueue(dev->watchdog_workqueue);
>
>         video_unregister_device(dev->vfd_enc);
> +       video_device_release(dev->vfd_enc);
>         video_unregister_device(dev->vfd_dec);
> +       video_device_release(dev->vfd_dec);
>         v4l2_device_unregister(&dev->v4l2_dev);
>         s5p_mfc_release_firmware(dev);
>         vb2_dma_contig_cleanup_ctx(dev->alloc_ctx[0]);
> --

Can you please do the remove operations in the inverse order of their
counterparts? IOW to do the release for both encoder and decoder after
their unregistration.

After that change:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
