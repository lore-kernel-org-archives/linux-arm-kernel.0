From: w@1wt.eu (Willy Tarreau)
Date: Thu, 11 Apr 2013 17:03:26 +0200
Subject: [PATCH] net: mv643xx_eth: Add GRO support
In-Reply-To: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
Message-ID: <20130411150326.GA19978@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Thu, Apr 11, 2013 at 04:47:49PM +0200, Sebastian Hesselbarth wrote:
> I did some simple tests on Dove/Cubox with 'netperf -cCD' and
> gso/gro/lro options on
> mv643xx_eth. The tests may not be sufficient, as I am not that into
> net performance testing.

In fact the difference only happens when the NIC has not verified the
checksum itself IIRC, which should be for non-IPv4 traffic. I agree
that it's not easy to test a bridge with a cubox which has a single
port :-) Maybe you'll see a difference in IPv6 traffic or with VLAN
traffic, as I seem to remember this chip does not do cksum offloading
on VLANs, but I could be wrong.

> I tried todays net-next on top of 3.9-rc6 without any gro patch, with
> the initial
> patch (Soeren) and your proposed patch (Willy). The results show that
> both patches
> allow a significant increase in throughput compared to
> netif_receive_skb (!gro, !lro)
> alone. Having gro with lro disabled gives some 2% more throughput
> compared to lro only.

Indeed this is consistent with my memories, since Eric improved the
GRO path, it became faster than LRO on this chip.

Regards,
Willy
