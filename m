From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 7 Jun 2011 15:35:51 -0700
Subject: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <1307345414-26872-1-git-send-email-shawn.guo@linaro.org>
References: <1307345414-26872-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <BANLkTi=-t9HVc6U6QY07su+c3WztsGoq3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 6, 2011 at 12:30 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Like dma_set(get)_max_seg_size for max_segment_size, the patch adds
> max_segment_number into device_dma_parameters and creates the
> corresponding dmaengine API dma_set(get)_max_seg_number for it.
>
> Here is the user story that tells the need of the new api. ?The
> mxs-mmc is the mmc host controller for Freescale MXS architecture.
> There are a pair of ?mmc host specific parameters max_seg_size and
> max_segs that mxs-mmc host driver needs to tell mmc core, so that
> mmc core can know how big each data segment could be and how many
> segments could be handled one time in a scatter list by host driver.
>
> The mxs-mmc driver is one user of dmaengine mxs-dma, and it will call
> mxs-dma to transfer data in scatter list. ?That is to say mxs-mmc has
> no idea of what max_seg_size and max_segs should be, because they are
> all mxs-dma capability parameters, and mxs-mmc needs to query them
> from mxs-dma.
>
> Right now, there is well defined dma api (dma_get_max_seg_size) for
> mmc to query max_seg_size from dma driver, but the one for max_segs
> is missing. ?That's why mxs-mmc driver has to hard-code it.
>
> The mxs-mmc is just one example to demonstrate the need of the new
> api, and there are other mmc host drivers (mxcmmc on imx-dma is
> another example) and possibly even other dmaengine users need this
> new api to know the maximum segments that dma driver can handle per
> dma call.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v1:
> ?* Update commit message to explain why the new api is needed
>
> ?include/linux/device.h ? ? ?| ? ?1 +
> ?include/linux/dma-mapping.h | ? 15 +++++++++++++++
> ?2 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c66111a..44cb2528 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -487,6 +487,7 @@ struct device_dma_parameters {
> ? ? ? ? * sg limitations.
> ? ? ? ? */

Given the discussion seems like this patch is missing an update to the
documentation of the struct to clarify the definition of dma provider.
 I.e. that this info belongs to the device doing the dma, and that is
is not necessarily the same as the device that is requesting dma
service.

Other than that seems like a natural extension of the existing usage
of device_dma_parameters in drivers/dma/.
