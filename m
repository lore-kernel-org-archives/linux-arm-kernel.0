From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jan 2015 17:31:28 +0000
Subject: [RFCv2 2/2] dma-buf: add helpers for sharing attacher
 constraints with dma-parms
In-Reply-To: <1421813807-9178-3-git-send-email-sumit.semwal@linaro.org>
References: <1421813807-9178-1-git-send-email-sumit.semwal@linaro.org>
 <1421813807-9178-3-git-send-email-sumit.semwal@linaro.org>
Message-ID: <20150121173128.GV26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 09:46:47AM +0530, Sumit Semwal wrote:
> +static int calc_constraints(struct device *dev,
> +			    struct dma_buf_constraints *calc_cons)
> +{
> +	struct dma_buf_constraints cons = *calc_cons;
> +
> +	cons.dma_mask &= dma_get_mask(dev);

I don't think this makes much sense when you consider that the DMA
infrastructure supports buses with offsets.  The DMA mask is th
upper limit of the _bus_ specific address, it is not a mask per-se.

What this means is that &= is not the right operation.  Moreover,
simply comparing masks which could be from devices on unrelated
buses doesn't make sense either.

However, that said, I don't have an answer for what you want to
achieve here.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
