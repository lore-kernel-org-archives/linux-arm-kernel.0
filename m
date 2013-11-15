From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 16:08:03 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5286A953.8030807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2013 01:54 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> dma_request_slave_channel() simply returns NULL whenever DMA channel
> lookup fails. Lookup could fail for two distinct reasons:
> 
> a) No DMA specification exists for the channel name.
>    This includes situations where no DMA specifications exist at all, or
>    other general lookup problems.
> 
> b) A DMA specification does exist, yet the driver for that channel is not
>    yet registered.
> 
> Case (b) should trigger deferred probe in client drivers. However, since
> they have no way to differentiate the two situations, it cannot.
> 
> Implement new function dma_request_slave_channel_or_err(), which performs
> identically to dma_request_slave_channel(), except that it returns an
> error-pointer rather than NULL, which allows callers to detect when
> deferred probe should occur.
...

...
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h

> +static inline struct dma_chan *dma_request_slave_channel_or_err(
> +					struct device *dev, const char *name)
> +{
> +	return ERR_PTR(-ENODEV);
> +}

That requires the following to be squashed into it, which I'll apply
locally:

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b908b0fda72b..f156c145fad2 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -22,6 +22,7 @@
 #define LINUX_DMAENGINE_H

 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/uio.h>
 #include <linux/bug.h>
 #include <linux/scatterlist.h>
