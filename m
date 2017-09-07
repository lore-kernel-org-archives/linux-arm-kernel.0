From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 7 Sep 2017 17:30:37 +0100
Subject: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
In-Reply-To: <8e4764f5-0e5d-7fd6-529b-35914e1e3668@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
 <de1a6b52-5e4f-1c0a-af3d-f6adb4b01daf@huawei.com>
 <fd4200c1-3c89-23f1-a2b1-6457ef8475c1@arm.com>
 <8e4764f5-0e5d-7fd6-529b-35914e1e3668@huawei.com>
Message-ID: <24e7e405-ad4a-4847-6177-987966182cbd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/17 02:55, Bob Liu wrote:
> Speak to the invalidation, I have one more question.
> 
> There is a time window between 1) modify page table;  2) tlb invalidate;
> 
> ARM-CPU                           Device
> 
> 1. modify page table
> 
>                              ^^^^^
>                               Can still write data through smmu tlb even page table was already modified.
>                               (At this point, the same virtual addr may not point to the same thing for CPU and device!!!
>                                I'm afraid there may be some data-loss or other potential problems if this situation happens.)
> 
> 2. tlb invalidate range

The mm code serializes map/unmap operations with mm->mmap_sem, and at a
lower level I think the pte lock is used to prevent more subtle races.
Don't take my word for it though, mm/ is still very obscure to me. So the
kernel shouldn't be able to reuse the VA for something else before the tlb
invalidation completes. Even if you're using the CMDQ to invalidate
instead of TLBI instructions, you're still called by a notifier from the
mm code so there is no problem.

Thanks,
Jean
