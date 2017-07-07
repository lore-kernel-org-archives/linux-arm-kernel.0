From: hugues.fruchet@st.com (Hugues FRUCHET)
Date: Fri, 7 Jul 2017 14:33:22 +0000
Subject: [PATCH] stm32-dcmi: constify vb2_ops structure
In-Reply-To: <20170706200517.GA5886@embeddedgus>
References: <20170706200517.GA5886@embeddedgus>
Message-ID: <d6b36309-2152-a55e-f160-ed43fdc3791c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Hugues Fruchet <hugues.fruchet@st.com>

On 07/06/2017 10:05 PM, Gustavo A. R. Silva wrote:
> Check for vb2_ops structures that are only stored in the ops field of a
> vb2_queue structure. That field is declared const, so vb2_ops structures
> that have this property can be declared as const also.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct vb2_ops i at p = { ... };
> 
> @ok@
> identifier r.i;
> struct vb2_queue e;
> position p;
> @@
> e.ops = &i at p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct vb2_ops e;
> @@
> e at i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
> struct vb2_ops i = { ... };
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>   drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index 83d32a5..24ef888 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -662,7 +662,7 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
>   		dcmi->errors_count, dcmi->buffers_count);
>   }
>   
> -static struct vb2_ops dcmi_video_qops = {
> +static const struct vb2_ops dcmi_video_qops = {
>   	.queue_setup		= dcmi_queue_setup,
>   	.buf_init		= dcmi_buf_init,
>   	.buf_prepare		= dcmi_buf_prepare,
> 
