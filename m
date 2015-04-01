From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 01 Apr 2015 15:14:11 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150327171946.GL1562@arm.com>
References: <20150327171946.GL1562@arm.com>
Message-ID: <1427894051.22236.6.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-03-27 at 17:19 +0000, Will Deacon wrote:
> 
> Please can you pull the following IOMMU changes for 4.1? They move the
> per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
> IOMMUs such as the ARM SMMU to support different page sizes within a
> given SoC.

Can't we kill it entirely? It's always been horrid. Just let the IOMMU
driver fill the page tables as it sees according to the virtual/physical
size and alignment of the range it's asked to map.

We already lie about the supported page sizes in the Intel VT-d driver
and claim to support everything, just to make the caller "Just Ask" as
it should.

We might have to fix the loop that KVM uses to unmap pages, and
potentially the bizarre unmap() API which returns the page size that it
unmapped, but we should do that anyway :)

Perhaps we could have an unmap function which returns a list of unmapped
pages chained on pg->freelist, if this was the last use of those pages
(as ISTR it is in the KVM case).

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/b353f16c/attachment.bin>
