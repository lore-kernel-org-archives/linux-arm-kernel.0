From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 24 Apr 2018 19:52:55 +0100
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <e7c4053a-20cc-d2db-16da-100b1157eca4@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <57d77955-caa7-ddac-df7d-7eef1f05dbb2@codeaurora.org>
 <66ec18ca-ea4e-d224-c9c5-8dbee5da8a72@arm.com>
 <e7c4053a-20cc-d2db-16da-100b1157eca4@codeaurora.org>
Message-ID: <73db4255-9f7a-28d8-a37f-6ecbf1135cb0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/18 18:17, Sinan Kaya wrote:
> On 4/24/2018 5:33 AM, Jean-Philippe Brucker wrote:
>>> Please return pasid when you find an io_mm that is already bound. Something like
>>> *pasid = io_mm->pasid should do the work here when bond is true.
>> Right. I think we should also keep returning 0, not switch to -EEXIST or
>> similar. So in next version a driver can call bind(devX, mmY) multiple
>> times, but the first unbind() removes the bond.
> 
> If we are going to allow multiple binds, then the last unbind should
> remove the bond rather than the first one via reference counting.

Yeah that's probably better. Since a bond belongs to a device driver it
doesn't need multiple bind/unbind, so earlier in this thread (1/37) I
talked about removing the bond->refs. But thinking about it, there still
is a need for it. When mm exits, we now need to call the device driver's
mm_exit handler outside of the spinlock, so we have to take a ref in
order to prevent a concurrent unbind() from freeing the bond.

Thanks,
Jean
