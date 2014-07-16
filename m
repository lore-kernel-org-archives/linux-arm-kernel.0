From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jul 2014 10:58:50 +0100
Subject: BUG: i.MX6-FEC: broken TCP tx checksumming
In-Reply-To: <CAOpc7mFpW=ZDdF3g-MK4TaNje5KBWimUwUgxoebg-wmb+OQ8zA@mail.gmail.com>
References: <CAOpc7mFpW=ZDdF3g-MK4TaNje5KBWimUwUgxoebg-wmb+OQ8zA@mail.gmail.com>
Message-ID: <20140716095850.GO21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 10:27:45AM +0200, Holger Schurig wrote:
> on my target I use the i:MX6 FEC with kernel 3.16-rc5. Very quickly I
> was able to "ping", but TCP (e.g. ssh) didn't work.
> 
> I first suspected autonegotiation, because "mii-tool eth0" shows
> (wrongly) eth0: negotiated "1000baseT-HD flow-control, link ok".
> Despite my switch not a gigabit one ...

That's rather weird - that line is printed by the generic phy layer,
so it suggests a bug in either the generic phy support, or the phy
driver itself.  It shouldn't report HD mode for gigabit with my patch
series applied - the FEC hardware doesn't support HD at gigabit speeds.

> Then I found out that
> "ethtool eth0" worked better, it displayed "Speed: 100Mb/s", "Duplex:
> Full". And with ping working, it couldn't be gigabit-ethernet against
> a non-gigabit switch anyway ...

That's again read via the generic phy layer, and that suggests that
the phy finally reported the correct speed... again, I wonder if
something in the phy layer is buggy.  I've never seen this behaviour
here with Atheros AR8035.

> I then looked at linux-next and applied the FEC related patches from
> it. To no avail.

In some ways, no change is good.

> Finally I made started wireshark (on the desktop). And Wireshark said:
> 
>   Header checksum: 0x0000 [incorrect, should be 0xe65e (may be caused
> by "IP checksum offload"?)]
> 
> So I tried "ethtool -K eth0 tx off" (on the i.MX6 board) and suddenly
> ssh worked.

That sounds like the hardware IP header checksumming isn't working.  Is
there anything specific to your setup?  VLAN maybe?

Which gcc version are you using?

It could be that the hardware isn't seeing the update for cbd_esc before
cbd_sc.  To test that out, can you try putting a wmb() before the writes
to bdp->cbd_sc in:

fec_enet_txq_submit_frag_skb
fec_enet_txq_submit_skb
fec_enet_txq_put_data_tso
fec_enet_txq_put_hdr_tso

to ensure that the previous transmit descriptor updates are pushed out
before the descriptor is handed over to the hardware.  That's a little
heavy-weight, but let's use the sledge hammer first...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
