From: matthew@wil.cx (Matthew Wilcox)
Date: Fri, 17 Jun 2011 06:40:35 -0600
Subject: [PATCH v3 RESEND] dma-mapping: add new API for max_segment_number
In-Reply-To: <1308227453-2034-1-git-send-email-shawn.guo@linaro.org>
References: <BANLkTi=-t9HVc6U6QY07su+c3WztsGoq3Q@mail.gmail.com>
	<1308227453-2034-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110617124035.GA19693@parisc-linux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 08:30:53PM +0800, Shawn Guo wrote:
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

This approach would make sense if mxs-mmc were generic, but it's tied to
mxs-dma, so it can just as well call mxs-dma to find out how many segments
it supports.

> Right now, there is well defined dma api (dma_get_max_seg_size) for
> mmc to query max_seg_size from dma driver, but the one for max_segs
> is missing.  That's why mxs-mmc driver has to hard-code it.
> 
> The mxs-mmc is just one example to demonstrate the need of the new
> api, and there are other mmc host drivers (mxcmmc on imx-dma is
> another example) and possibly even other dmaengine users need this
> new api to know the maximum segments that dma driver can handle per
> dma call.

Again, mxcmmc can just call imx-dma directly.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
