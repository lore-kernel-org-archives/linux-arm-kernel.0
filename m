From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 29 Jun 2015 08:33:21 +0200
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
Message-ID: <5590E6B1.90206@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 28-06-15 22:40, Sylvain Munaut wrote:
> Hi,
>
>
> I'm working on a DMA driver that uses the the streaming DMA API to
> synchronize the access between host and device. The data flow is
> exclusively from the device to the host (video grabber).
>
> As such, I call dma_sync_single_for_cpu when the hardware is done
> writing a frame to make sure that the cpu gets up to date data when
> accessing the zone.
>
> However this call takes a _long_ time to complete. For a 6 Megabytes
> buffer, it takes about 13 ms which is just crazy ... at that rate it'd
> be faster to just read random data from a random buffer to trash the
> measly 512k of cache ...

I have the same experience: The cache flush is so slow, that it is about as 
fast to just memcpy() the whole region.


> Is there any alternative that's faster when dealing with large buffers ?
>
> (The platform is a Zynq 7000 - Dual Cortex A9).

Yes.

You're on a Zynq, and that has an ACP port. Connect through that instead of an 
HP port (interface is almost the same), add "dma-coherent" to the devicetree 
and also add my patch that properly maps this into userspace.

The penalty of the ACP port is that it will write a lot slower to the memory 
(about half the speed of the 600MB/s you get from the HP port) because of all 
the cache administration. The good news is that all memory will be cacheable 
once more, and all the dma_sync_... calls will turn into no-ops. You don't 
have to change your driver and the logic also remains the same.


Another approach is to make your software uncached-memory friendly. If you 
process the frames sequentially and use NEON instructions to fetch large 
aligned chunks for further processing, the absense of caching won't matter much.

M.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
