From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 17 Oct 2014 11:09:07 +0200
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <543FFEFB.2010604@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
 <20140925170108.GE8306@8bytes.org> <5432E757.10201@codeaurora.org>
 <20141015091652.GB13162@ulmo> <543FFEFB.2010604@codeaurora.org>
Message-ID: <20141017090906.GN28786@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 10:23:07AM -0700, Olav Haugan wrote:
> On 10/15/2014 2:16 AM, Thierry Reding wrote:
> >Perhaps make the return value ssize_t so that we can propagate errors?
> >
> 
> I am fine with that. Joerg?

I am not so sure this is a good idea. On error the function should
return the size that is already mapped, so that the caller can check
that against the expected size and just call iommu_unmap with the
returned size when return value does not match expected size.

The benefit of ssize_t is that we can return more detailed error
information when the function did not map anything yet. But this
complicates the error handling for the caller and implementers might get
it wrong and return an error-value even when some space was already
mapped, so that the caller can not unmap the addresses.

So taking this into mind, I prefer it to be size_t for now. We can
always change it later if it turns out to be wrong.

Regards,

	Joerg
