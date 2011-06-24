From: eric.miao@linaro.org (Eric Miao)
Date: Fri, 24 Jun 2011 12:17:41 +0800
Subject: [PATCH] usb: fsl_udc_core: fix build breakage when building for
	ARM arch
In-Reply-To: <1308873788-22881-1-git-send-email-agust@denx.de>
References: <1308873788-22881-1-git-send-email-agust@denx.de>
Message-ID: <BANLkTi=FkiWjHOZ13zpABfPO5ArHBTjA8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 8:03 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Commit 09ba0def introduced build breakage on ARM arch.
> Fix it by setting accessors using a static inline function
> which is a nop when compiling the driver for ARM arch.
>
> Don't use flush_dcache_range(), convert to the DMA API
> usage instead. USB2.0CV Halt Endpoint Test succeeds on
> PPC. Tested both on ARM i.MX31 and mpc5121 PPC.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

This looks good to me.

Acked-by: Eric Miao <eric.miao@linaro.org>

> ---
> ?drivers/usb/gadget/fsl_udc_core.c | ? 30 +++++++++++++++++++-----------
> ?1 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> index 2cd9a60..eab033f 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -46,7 +46,6 @@
> ?#include <asm/system.h>
> ?#include <asm/unaligned.h>
> ?#include <asm/dma.h>
> -#include <asm/cacheflush.h>
>
> ?#include "fsl_usb2_udc.h"
>
> @@ -118,6 +117,17 @@ static void (*_fsl_writel)(u32 v, unsigned __iomem *p);
> ?#define fsl_readl(p) ? ? ? ? ? (*_fsl_readl)((p))
> ?#define fsl_writel(v, p) ? ? ? (*_fsl_writel)((v), (p))
>
> +static inline void fsl_set_accessors(struct fsl_usb2_platform_data *pdata)
> +{
> + ? ? ? if (pdata->big_endian_mmio) {
> + ? ? ? ? ? ? ? _fsl_readl = _fsl_readl_be;
> + ? ? ? ? ? ? ? _fsl_writel = _fsl_writel_be;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? _fsl_readl = _fsl_readl_le;
> + ? ? ? ? ? ? ? _fsl_writel = _fsl_writel_le;
> + ? ? ? }
> +}
> +
> ?static inline u32 cpu_to_hc32(const u32 x)
> ?{
> ? ? ? ?return udc_controller->pdata->big_endian_desc
> @@ -132,6 +142,8 @@ static inline u32 hc32_to_cpu(const u32 x)
> ? ? ? ? ? ? ? ?: le32_to_cpu((__force __le32)x);
> ?}
> ?#else /* !CONFIG_PPC32 */
> +static inline void fsl_set_accessors(struct fsl_usb2_platform_data *pdata) {}
> +
> ?#define fsl_readl(addr) ? ? ? ? ? ? ? ?readl(addr)
> ?#define fsl_writel(val32, addr) writel(val32, addr)
> ?#define cpu_to_hc32(x) ? ? ? ? cpu_to_le32(x)
> @@ -1348,9 +1360,6 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
> ? ? ? ?/* Fill in the reqest structure */
> ? ? ? ?*((u16 *) req->req.buf) = cpu_to_le16(tmp);
>
> - ? ? ? /* flush cache for the req buffer */
> - ? ? ? flush_dcache_range((u32)req->req.buf, (u32)req->req.buf + 8);
> -
> ? ? ? ?req->ep = ep;
> ? ? ? ?req->req.length = 2;
> ? ? ? ?req->req.status = -EINPROGRESS;
> @@ -1358,6 +1367,11 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
> ? ? ? ?req->req.complete = NULL;
> ? ? ? ?req->dtd_count = 0;
>
> + ? ? ? dma_sync_single_for_device(udc->gadget.dev.parent,
> + ? ? ? ? ? ? ? req->req.dma, req->req.length,
> + ? ? ? ? ? ? ? ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> + ? ? ? req->mapped = 0;
> +
> ? ? ? ?/* prime the data phase */
> ? ? ? ?if ((fsl_req_to_dtd(req) == 0))
> ? ? ? ? ? ? ? ?fsl_queue_td(ep, req);
> @@ -2470,13 +2484,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?/* Set accessors only after pdata->init() ! */
> - ? ? ? if (pdata->big_endian_mmio) {
> - ? ? ? ? ? ? ? _fsl_readl = _fsl_readl_be;
> - ? ? ? ? ? ? ? _fsl_writel = _fsl_writel_be;
> - ? ? ? } else {
> - ? ? ? ? ? ? ? _fsl_readl = _fsl_readl_le;
> - ? ? ? ? ? ? ? _fsl_writel = _fsl_writel_le;
> - ? ? ? }
> + ? ? ? fsl_set_accessors(pdata);
>
> ?#ifndef CONFIG_ARCH_MXC
> ? ? ? ?if (pdata->have_sysif_regs)
> --
> 1.7.1
>
>
