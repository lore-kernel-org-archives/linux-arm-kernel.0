From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 15 Jul 2015 10:56:50 +0200
Subject: [Xen-devel] [PATCH v2 09/20] xen/biomerge: Don't allow biovec
 to be merge when Linux is not using 4KB page
In-Reply-To: <20150710191245.GA31063@l.oracle.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-10-git-send-email-julien.grall@citrix.com>
 <20150710191245.GA31063@l.oracle.com>
Message-ID: <55A62052.7020008@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Konrad,

On 10/07/2015 21:12, Konrad Rzeszutek Wilk wrote:
> On Thu, Jul 09, 2015 at 09:42:21PM +0100, Julien Grall wrote:
>> When Linux is using 64K page granularity, every page will be slipt in
>> multiple non-contiguous 4K MFN (page granularity of Xen).
>
> But you don't care about that on the Linux layer I think?

In general use case (i.e arch agnostic) we care about it. We don't want 
to merge 2 biovec if they are not living on the same MFNs.

> As in, is there an SWIOTLB that does PFN to MFN and vice-versa
> translation?
>
> I thought that ARM guests are not exposed to the MFN<->PFN logic
> and trying to figure that out to not screw up the DMA engine
> on a PCIe device slurping up contingous MFNs which don't map
> to contingous PFNs?


I will let these 2 questions for Stefano. He knows better than me 
swiotlb for ARM.

So far, I skipped swiotlb implementation for 64KB page granularity as 
I'm not sure what to do when a page is split across multiple MFNs.

Although I don't think this can happen with this specific series as:
	- The memory is a direct mapping so any Linux page is using contiguous 
MFNs.
	- Foreign mapping is using the 4KB of the Linux page. This is for an 
easier implementation.

For the latter, I plan to work on using the Linux page to map multiple 
foreign gfn. I have to talk with Stefano about it how to handle it.

Regards,

-- 
Julien Grall
