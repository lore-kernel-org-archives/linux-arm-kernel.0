From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 11 Oct 2012 13:28:19 +0200
Subject: alignment faults in 3.6
In-Reply-To: <1349952970.1232.5.camel@sakura.staff.proxad.net>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <506ED18C.3010009@gmail.com> <20121005140556.GQ4625@n2100.arm.linux.org.uk>
 <506EEFBB.3060705@gmail.com> <507619FA.6080001@jonmasters.org>
 <yw1xtxu1pwtv.fsf@unicorn.mansr.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7038@saturn3.aculab.com>
 <yw1xpq4ppcju.fsf@unicorn.mansr.com>
 <1349949638.21172.8445.camel@edumazet-glaptop>
 <1349950926.21172.8521.camel@edumazet-glaptop>
 <20121011103257.GO4625@n2100.arm.linux.org.uk>
 <1349952574.21172.8604.camel@edumazet-glaptop>
 <1349952970.1232.5.camel@sakura.staff.proxad.net>
Message-ID: <1349954899.21172.8728.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-11 at 12:56 +0200, Maxime Bizon wrote:
> On Thu, 2012-10-11 at 12:49 +0200, Eric Dumazet wrote:
> 
> 
> > So if you have an alignment fault, thats because IP header is not
> > aligned on 4 bytes ?
> > 
> > If so a driver is buggy and must be fixed.
> 
> So a driver that does not align the ip header is buggy ?
> 

exactly.

> I always thought it was ok not to do so (with a potential performance
> penalty).
> 

Apparently not for some arches.

> I have some MIPS hardware that is not able to DMA on anything but 32bits
> aligned addresses (bcm63xx). I tried once to add a memcpy instead of
> taking unaligned faults and the result was *much slower* on a ipv4
> forwarding test (which is what the hardware is used for).
> 

You probably are aware that a driver can use : 

- a fragment to hold the frame given by the hardware, with whatever
alignment is needed by the hardware.

Then allocate an skb with enough room (128 bytes) to pull the headers as
needed later.

skb = netdev_alloc_skb_ip_align(dev, 128);

Attach the fragment to the skb, and feed stack with this skb.
(pull the ethernet header before calling eth_type_trans()

Most modern drivers exactly use this strategy and get nice performance.

Of course, if hardware doesnt need a strange alignment, we can avoid the
fragment and directly use 

skb = netdev_alloc_skb_ip_align(dev, 1536);

So all drivers can be fixed if needed.
