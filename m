From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 16:18:33 -0800
Subject: [PATCH 2/7] ARM: Add Broadcom Brahma-B15 readahead cache support
In-Reply-To: <20170118225630.GS27312@n2100.armlinux.org.uk>
References: <20170118202927.28740-1-f.fainelli@gmail.com>
 <20170118202927.28740-3-f.fainelli@gmail.com>
 <20170118225630.GS27312@n2100.armlinux.org.uk>
Message-ID: <47d36b8c-4786-7077-c623-d2bbc29b8863@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 02:56 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2017 at 12:29:21PM -0800, Florian Fainelli wrote:
>> The readahead cache only intercepts reads, not writes, as such, some
>> data can remain stale in any of its buffers, such that we need to flush
>> it, which is an operation that needs to happen in a particular order:
>>
>> - disable the readahead cache
>> - flush it
>> - call the appropriate cache-v7.S function
>> - re-enable
> 
> I really do hope that the above explanation is wrong, because if that's
> really how it's implemented, it's going to cause coherency problems.
> 
> It's got to at least monitor writes, otherwise how do you guarantee
> that the CPU doesn't see stale data?  IOW:

Yes, it does monitor writes, the explanation given here was wrong. Thanks!

> 
> Consider this at the L2 memory-side interface (iow, downstream of the
> point-of-coherency):
> 
> 	CPU1		CPU2		Read-ahead buffer
> 			read cache line C
> 					reads cache line C and C+1
> 	writes cache line C+1
> 			read cache line C+1
> 
> What ensures that CPU2 sees the written out cache line from CPU1?
-- 
Florian
