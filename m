From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 16 Jun 2011 01:25:21 +0900
Subject: [PATCH v3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <1308139721-4008-1-git-send-email-shawn.guo@linaro.org>
References: <BANLkTi=-t9HVc6U6QY07su+c3WztsGoq3Q@mail.gmail.com>
	<1308139721-4008-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110616012124M.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun 2011 20:08:41 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> Like dma_set(get)_max_seg_size for max_segment_size, the patch adds
> max_segment_number into device_dma_parameters and creates the
> corresponding dmaengine API dma_set(get)_max_seg_number for it.
> 
> Here is the user story that tells the need of the new api.  The
> mxs-mmc is the mmc host controller for Freescale MXS architecture.
> There are a pair of  mmc host specific parameters max_seg_size and
> max_segs that mxs-mmc host driver needs to tell mmc core, so that
> mmc core can know how big each data segment could be and how many
> segments could be handled one time in a scatter list by host driver.
> 
> The mxs-mmc driver is one user of dmaengine mxs-dma, and it will call
> mxs-dma to transfer data in scatter list.  That is to say mxs-mmc has
> no idea of what max_seg_size and max_segs should be, because they are
> all mxs-dma capability parameters, and mxs-mmc needs to query them
> from mxs-dma.
> 
> Right now, there is well defined dma api (dma_get_max_seg_size) for
> mmc to query max_seg_size from dma driver, but the one for max_segs
> is missing.  That's why mxs-mmc driver has to hard-code it.
> 
> The mxs-mmc is just one example to demonstrate the need of the new
> api, and there are other mmc host drivers (mxcmmc on imx-dma is
> another example) and possibly even other dmaengine users need this
> new api to know the maximum segments that dma driver can handle per
> dma call.

As I wrote earlier, SCSI midlayer sets this parameter in a different
way (storing this in SCSI specific data structure).

If you add a new generic API for this parameter, please make sure that
the API works well for the others that already do the same
differently. That is, please send this to linux-scsi too (and discuss
with SCSI maintainer).
