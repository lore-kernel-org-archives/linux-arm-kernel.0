From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Nov 2013 12:04:39 -0500
Subject: [PATCH] arm: mm: refactor v7 cache cleaning ops to use way/index
 sequence
In-Reply-To: <alpine.LFD.2.10.1311191155080.9667@knanqh.ubzr>
References: <1384874993-4577-1-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.10.1311191155080.9667@knanqh.ubzr>
Message-ID: <528B9A27.6010000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 November 2013 11:58 AM, Nicolas Pitre wrote:
> On Tue, 19 Nov 2013, Lorenzo Pieralisi wrote:
> 
>> Set-associative caches on all v7 implementations map the index bits
>> to physical addresses LSBs and tag bits to MSBs. On most systems with
>> sane DRAM controller configurations, this means that the current v7
>> cache flush routine using set/way operations triggers a DRAM memory
>> controller precharge/activate for every cache line writeback since the
>> cache routine cleans lines by first fixing the index and then looping
>> through ways.
>>
>> Given the random content of cache tags, swapping the order between
>> indexes and ways loops do not prevent DRAM pages precharge and
>> activate cycles but at least, on average, improves the chances that
>> either multiple lines hit the same page or multiple lines belong to
>> different DRAM banks, improving throughput significantly.
>>
>> This patch swaps the inner loops in the v7 cache flushing routine to
>> carry out the clean operations first on all sets belonging to a given
>> way (looping through sets) and then decrementing the way.
>>
>> Benchmarks showed that by swapping the ordering in which sets and ways
>> are decremented in the v7 cache flushing routine, that uses set/way
>> operations, time required to flush caches is reduced significantly,
>> owing to improved writebacks throughput to the DRAM controller.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Could you include some benchmark results so we have an idea of the 
> expected improvement scale?  Other than that...
> 
Am Curious about the results as well. For the patch itself
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
