From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 01 Apr 2015 16:46:10 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401143904.GL1552@arm.com>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org> <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org> <20150401140512.GJ1552@arm.com>
 <1427898490.22236.10.camel@infradead.org> <20150401143904.GL1552@arm.com>
Message-ID: <1427899570.22236.14.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-01 at 15:39 +0100, Will Deacon wrote:
> 
> However, once we have that, we run into the same problem that we've got
> with the current pgsize_bitmap. Namely, that it needs to be a per-domain
> property to avoid it changing dynamically following an initial map request
> or a probe of a new IOMMU device.

That's not so much of a problem, surely? When adding devices to a new
domain without any mappings, the minimum page size of the domain is the
largest of all the IOMMUs participating in that domain.

And if you try to add new devices after you've already started making
mappings, we refuse the addition if it would raise the minimum page size
higher than the page sizes you're already using.

In VT-d we already have very similar logic for superpage and snooping
support.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/a29d5818/attachment-0001.bin>
