From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Dec 2016 14:14:27 +0000
Subject: [RFC v2 PATCH 0/3] Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <20161213140711.GY14217@n2100.armlinux.org.uk>
References: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
 <20161213140711.GY14217@n2100.armlinux.org.uk>
Message-ID: <58500243.8070107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/16 14:07, Russell King - ARM Linux wrote:
> On Tue, Dec 13, 2016 at 01:45:01PM +0000, Vladimir Murzin wrote:
>> This patch set is trying to address the issue by providing region of
>> memory suitable for consistent DMA operations. It is supposed that such
>> region is marked by MPU as non-cacheable. Since we have MPU support in
>> Linux for R-class only and M-class setting MPU in bootloader, proposed
>> interface to advertise such memory is via "memdma=size at start" command
>> line option, to avoid clashing with normal memory (which usually comes
>> from dts) it'd be safer to use it together with "mem=" command line
>> option. Meanwhile, I'm open to suggestions for the better way telling
>> Linux of such memory.
> 
> For those nommu systems where the MPU is not used, how do they allocate
> DMA memory without setting aside a chunk of memory?
> 
>>From what I understand of the current nommu code, it would just use
> the normal page allocator for DMA memory allocation, so now requiring
> everything to fit the "nommu has mpu" case seems like it's going to
> break older nommu.
> 

Probably, it'd be better if we just fallback to dma-noop operations if there
is no dma region, i.e. assume that platform is coherent. We still need a way
to tell user that absence of such region can be reason of broken DMA.

Cheers
Vladimir
