From: w@1wt.eu (Willy Tarreau)
Date: Mon, 22 Apr 2013 11:08:03 +0200
Subject: MVEBU and MVNETA driver
In-Reply-To: <5174F29D.5070908@itooo.com>
References: <5171419C.2090003@itooo.com> <20130419131237.GC22440@1wt.eu>
 <517150FF.9010806@itooo.com> <20130419144324.GD22440@1wt.eu>
 <51715BC7.3040906@free-electrons.com> <51716A8B.9080903@itooo.com>
 <20130422062024.GK30850@1wt.eu> <5174F29D.5070908@itooo.com>
Message-ID: <20130422090803.GA3715@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 10:19:41AM +0200, Greg wrote:
> I'm using SLAB allocator.
> As for offloading, I can't seem to be able to turn it on :
> >$ ethtool -K eth0 gro on
> >Cannot set device GRO settings: Operation not supported
> >$ ethtool -K eth0 gso on
> >Cannot set device generic segmentation offload settings: Operation not 
> >supported
> Default values :
> >$ ethtool -k eth0
> >Offload parameters for eth0:
> >rx-checksumming: off
> >tx-checksumming: on
> >scatter-gather: on
> >tcp-segmentation-offload: off
> >udp-fragmentation-offload: off
> >generic-segmentation-offload: off
> >generic-receive-offload: off
> >large-receive-offload: off
> >rx-vlan-offload: off
> >tx-vlan-offload: off
> >ntuple-filters: off
> >receive-hashing: off
> 
> I can see 1 difference between our setups, Mirabox has an Armada370, I 
> have an ArmadaXP, it would be interesting to know what Gregory is using.

OK so I guess you have a kernel version prior to 3.9-rc7. There is a bug
in the driver which causes it to report tx cksum and sg but they're not
enabled. You need to disable then enable them :

  ethtool -K eth0 tx off
  ethtool -K eth0 sg off
  ethtool -K eth0 tx on
  ethtool -K eth0 sg on

Then you can enable gso/gro. And that clearly explains a significant
performance difference.

> Another difference on my setup, and something I wanted to report you : 
> there is no PHY on my system. I had to instantiate a dummy PHY in the 
> device tree blob and bind it to the mvneta driver because it would fail 
> at init without PHY.

I think this is more something for Thomas then.

Regards,
Willy
