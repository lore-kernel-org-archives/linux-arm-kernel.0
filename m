From: itooo@itooo.com (Greg)
Date: Mon, 22 Apr 2013 10:19:41 +0200
Subject: MVEBU and MVNETA driver
In-Reply-To: <20130422062024.GK30850@1wt.eu>
References: <5171419C.2090003@itooo.com> <20130419131237.GC22440@1wt.eu>
 <517150FF.9010806@itooo.com> <20130419144324.GD22440@1wt.eu>
 <51715BC7.3040906@free-electrons.com> <51716A8B.9080903@itooo.com>
 <20130422062024.GK30850@1wt.eu>
Message-ID: <5174F29D.5070908@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/04/2013 08:20, Willy Tarreau a ?crit :
> On Fri, Apr 19, 2013 at 06:02:19PM +0200, Greg wrote:
>> A simple tool like netcat shows ~470Mbps but this limited by the CPU.
>> Iperf isn't CPU limited
>>
>> The same test with Marvell LSP shows ~940Mbps in both directions.
> I've retested here on my mirabox using httpterm as the tcp server.
> Using the normal send() syscall, it emits 839 Mbps on a single TCP
> connection. Using splice(), it emits 969 Mbps in the same conditions.
>
> Here's what ethtool is saying about the NIC's tuning :
> # ethtool -k eth0
> Offload parameters for eth0:
> rx-checksumming: off
> tx-checksumming: on
> scatter-gather: on
> tcp-segmentation-offload: off
> udp-fragmentation-offload: off
> generic-segmentation-offload: on
> generic-receive-offload: on
> large-receive-offload: off
> rx-vlan-offload: off
> tx-vlan-offload: off
> ntuple-filters: off
> receive-hashing: off
>
> I've tried changing other settings such as the interrupt delays
> (rx-usecs, rx-frames, tx-frames) but this has no effect. So in
> short, I cannot reproduce this behaviour. Are you using the SLOB
> allocator ? I'm asking because I remember experiencing very poor
> performance with it in the past.
>
Willy,

I'm using SLAB allocator.
As for offloading, I can't seem to be able to turn it on :
> $ ethtool -K eth0 gro on
> Cannot set device GRO settings: Operation not supported
> $ ethtool -K eth0 gso on
> Cannot set device generic segmentation offload settings: Operation not 
> supported
Default values :
> $ ethtool -k eth0
> Offload parameters for eth0:
> rx-checksumming: off
> tx-checksumming: on
> scatter-gather: on
> tcp-segmentation-offload: off
> udp-fragmentation-offload: off
> generic-segmentation-offload: off
> generic-receive-offload: off
> large-receive-offload: off
> rx-vlan-offload: off
> tx-vlan-offload: off
> ntuple-filters: off
> receive-hashing: off

I can see 1 difference between our setups, Mirabox has an Armada370, I 
have an ArmadaXP, it would be interesting to know what Gregory is using.

Another difference on my setup, and something I wanted to report you : 
there is no PHY on my system. I had to instantiate a dummy PHY in the 
device tree blob and bind it to the mvneta driver because it would fail 
at init without PHY.

Regards,
