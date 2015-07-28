From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 28 Jul 2015 14:31:50 +0100
Subject: [PATCH v4 1/4] iommu/iova: Avoid over-allocating when size-aligned
In-Reply-To: <35cb877828b570db84e89684ef76308cd1857f0c.1437070995.git.robin.murphy@arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
 <35cb877828b570db84e89684ef76308cd1857f0c.1437070995.git.robin.murphy@arm.com>
Message-ID: <1438090310.26913.158.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-07-16 at 19:40 +0100, Robin Murphy wrote:
> Currently, allocating a size-aligned IOVA region quietly adjusts the
> actual allocation size in the process, returning a rounded-up
> power-of-two-sized allocation. This results in mismatched behaviour in
> the IOMMU driver if the original size was not a power of two, where the
> original size is mapped, but the rounded-up IOVA size is unmapped.
> 
> Whilst some IOMMUs will happily unmap already-unmapped pages, others
> consider this an error, so fix it by computing the necessary alignment
> padding without altering the actual allocation size. Also clean up by
> making pad_size unsigned, since its callers always pass unsigned values
> and negative padding makes little sense here anyway.

Applied; thanks.

I'm not 100% sure we *need* the hunk in intel-iommu.c, we can probably
live without rounding the size up. It means we'll use huge pages less
often, but it's not clear that using them when we didn't *mean* to map
the full size of them was the right thing to do in the first place.

But it makes sense to apply the patch as-is, without changing the
effective behaviour, and ponder that more deeply later.

Thanks.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/785b9d33/attachment.bin>
