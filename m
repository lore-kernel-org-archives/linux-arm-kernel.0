From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 25 Jan 2017 12:46:19 +0000
Subject: [PATCH] arm64: dma-mapping: Fix dma_mapping_error() when
 bypassing SWIOTLB
In-Reply-To: <1485347826.2306.3.camel@crowfest.net>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
 <9e74b2f91b0b4b649a898db47225e5ea3b6a0417.1485345401.git.robin.murphy@arm.com>
 <1485347826.2306.3.camel@crowfest.net>
Message-ID: <86997e7b-cf20-8724-41e5-43fd175d616c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/17 12:37, Michael Zoran wrote:
> On Wed, 2017-01-25 at 12:03 +0000, Robin Murphy wrote:
>> hen bypassing SWIOTLB on small-memory systems, we need to avoid
>> calling
>> into swiotlb_dma_mapping_error() in exactly the same way as we avoid
>> swiotlb_dma_supported(), because the former also relies on SWIOTLB
>> state
>> being initialised.
>>
> 
> I didn't submit the initial ARM64 port of the RPI 3, so I don't know
> much about this.  But from a third personal point of view, this seems
> to side step the main issue here.

On the contrary - the main issue is that we're calling into an
uninitialised SWIOTLB, and not initialising SWIOTLB on arm64 systems
where all the RAM is below 4GB is the exact purpose of b67a8b29df7e.
This particular call was obviously overlooked in the original patch
because it happened to still work on systems with a different memory map
(or more likely without a DMA offset).

Robin.

> 
> From an ARM64 subsystem point of view, what exactly is the
> correct/recommended method for ensuring the mm subsystem is initialized
> correctly?
> 
> 
