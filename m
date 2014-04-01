From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Tue, 01 Apr 2014 07:00:29 -0700
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140401092638.GA10224@n2100.arm.linux.org.uk>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
Message-ID: <533AC67D.2060906@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 04/01/2014 02:26 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 26, 2014 at 12:11:35AM +0000, Russell King - ARM Linux wrote:
>> On Mon, Mar 24, 2014 at 11:44:43PM +0000, Russell King - ARM Linux wrote:
>>> Now, you mention packet loss above.  Even on half-duplex networks, I
>>> would not expect there to be much packet loss because of the
>>> retransmissions after a collision, and 100Mbit networks handle this
>>> much better than 10Mbit.  It takes repeated collisions to cause a
>>> packet to actually be dropped (and a packet being dropped because
>>> of collisions should be logged by the transmitting host in its
>>> interface statistics.)
>>>
>>> Another possibility is that the FEC isn't properly negotiating with
>>> the hub, and the two ends are ending up configured differently, or
>>> that it is negotiating properly but the FEC isn't being configured
>>> correctly.
>>>
>>> Now that we know a little more about your setup, including that it
>>> seems to be one specific setup which is causing the problems, I'll
>>> do some more testing - I have an old Allied Telesys 10/100 hub here
>>> which I'll try putting the iMX6 on and re-run your tests.
>>
>> PC --- 100Mbit hub --- iMX6S
>>
>> iperf (2.0.5) -c PC -r reports:
>>
>> iMX6 Tx: [  5]  0.0-10.0 sec  85.5 MBytes  71.5 Mbits/sec
>> iMX6 Rx: [  3]  0.0-10.0 sec   103 MBytes  86.2 Mbits/sec
>>
>> However, there's a marked difference when the iMX6 sends - the
>> collision LED is almost permanently on at full brightness, whereas
>> when the PC is sending, it's almost always off.
>>
>> I'm seeing lots of late collisions and CRC errors in the statistics
>> registers.
>>
>> It looks to me like the iMX6's transmitter is blathering at any moment,
>> not taking any notice whether there's already a carrier on the RX side.
>> I'm not yet sure what to make of this yet.
>
> Last night, I performed a different test:
>
> PC --- Gigabit switch --- 10/100Mbit hub --- 10Mbit hub --- iMX6S
>             |
>    (the rest of my network)
>
> This shows that all the (late) collisions occur in the 10Mbit domain,
> and very few in the 100Mbit domain, which puts the blame fairly
> squarely on the iMX6 side.
>
> I can see nothing wrong with the setup of the iMX6, nor of the AR8035
> phy which my board has.  Both the phy and the FEC appear to correctly
> indicate that they are configured for half-duplex with flow control
> disabled, and I've been through the iomux settings for the RGMII
> interface.
>
> So, I'm left with three possibilities:
> - the AR8035 doesn't work with half-duplex
> - there is something wrong with the signalling for carrier sense between
>    the AR8035 and the FEC.
> - the iMX6 FEC doesn't work with half-duplex
>
> It's not easy to monitor the TX_CTL and RX_CTL signals and make sense of
> them, so I can't really say what's at fault at the moment, but from what
> I can see, my hardware fails to work correctly with half-duplex
> connections.
>

What value do you have for pad control register
IOMUXC_SW_PAD_CTL_PAD_RGMII_TX_CTL (0x020E0388)?

I notice in some of the DTS files that this has a value of 0x100b0,
which seems wrong. Bit 16 seems to be a HYSteresis bit, and enabling
that seems wrong (also bit 7 seems wrong, as it's undefined in the RM).
