From: rick.chang@mediatek.com (Rick Chang)
Date: Wed, 15 Mar 2017 10:17:32 +0800
Subject: [PATCH] media: mtk-jpeg: fix continuous log "Context is NULL"
In-Reply-To: <1489501282-52137-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1489501282-52137-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1489544252.27174.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-03-14 at 22:21 +0800, Minghsiu Tsai wrote:
> The symptom is continuous log "mtk-jpeg 18004000.jpegdec: Context is NULL"
> in kernel log. It is becauese the error handling in irq doesn't clear
> interrupt.
> 
> The calling flow like as below when issue happen
> mtk_jpeg_device_run()
> mtk_jpeg_job_abort()
>   v4l2_m2m_job_finish() -> m2m_dev->curr_ctx = NULL;
> mtk_jpeg_dec_irq()
>   v4l2_m2m_get_curr_priv()
>      -> m2m_dev->curr_ctx == NULL
>      -> return NULL
> log "Context is NULL"
> 
> There is race condition between job_abort() and irq. In order to simplify
> code, don't want to add extra flag to maintain state, empty job_abort() and
> clear interrupt before v4l2_m2m_get_curr_priv() in irq.
> 
> Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
Acked-by: Rick Chang <rick.chang@mediatek.com>
