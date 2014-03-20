From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 23:06:00 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de> <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
Message-ID: <20140320230559.GF7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 07:27:43PM -0300, Fabio Estevam wrote:
> "I tried the patch and it seems a little better but still has problems.
> When I first started the test I saw dropped packets.  After about 2 minutes
> I got the pause again with the accompanying kernel backtrace.  It looks
> like I got some more debug information from the backtrace however (I think
> that was part of the patch.)

Thanks.  Now that we can see the ring, we can see what's going on.
Every entry with a non-NULL skb is a packet which has been queued up
for transmission, but which hasn't been reaped.  Any entry with a "SC"
value of 0x1c00 has been transmitted.

S marks the ring entry where the next packet to be transmitted would
be placed into the ring.  H points at the previous entry which was
reaped - in other words, the next packet which would be reaped if it
were transmitted would be ring entry 14.

However, this hasn't happened, because that packet is still marked for
the FEC to transmit it.  The really odd thing is, it has transmitted
the subsequent packets from 15 to 63, and 0 to 12.

The obvious question is: was the packet at 14 actually transmitted,
and has the update to the descriptor been lost somehow - that would
require a log of the last 64-ish transmitted packets, and knowledge
of what those packets should contain to really confirm - just wondering
whether we could transmit an additional byte containing the ring index
on these small packets which we could then capture.  We would have to
be certain that the capture itself hasn't dropped any packets.

I'll look into some further patches which would allow that to be
confirmed - I can't do that immediately as I've rather a lot to deal
with at the moment.

> fec 63fec000.ethernet eth0: TX ring dump
> Nr    SC     addr       len  SKB
>  0    0x1c00 0xce485000  106 de5db480
>  1    0x1c00 0xce485800  106 de5b7540
>  2    0x1c00 0xce486000  106 de5b7300
>  3    0x1c00 0xce486800  106 de5b73c0
>  4    0x1c00 0xce487000  106 de5b7e40
>  5    0x1c00 0xce487800  106 de5b7840
>  6    0x1c00 0xce500000  106 de5b7b40
>  7    0x1c00 0xce500800  106 de5b7600
>  8    0x1c00 0xce501000  106 de5b7d80
>  9    0x1c00 0xce501800  106 de5b7180
> 10    0x1c00 0xce502000  106 de5b7a80
> 11    0x1c00 0xce502800  106 de5b7240
> 12    0x1c00 0xce503000  106 de5b7000
> 13 SH 0x1c00 0x00000000   66   (null)
> 14    0x9c00 0xce504000   66 de5b90c0
> 15    0x1c00 0xce504800   66 de5b9a80
> 16    0x1c00 0xce505000   66 de5b9840
> 17    0x1c00 0xce505800   66 de5b9000
> 18    0x1c00 0xce506000   66 de5b9480
> 19    0x1c00 0xce506800   66 de5b9b40
> 20    0x1c00 0xce507000   66 de5b9600
> 21    0x1c00 0xce507800   66 de5b9900
> 22    0x1c00 0xce508000   66 de5b9180
> 23    0x1c00 0xce508800   66 de5b9240
> 24    0x1c00 0xce509000   66 de5b93c0
> 25    0x1c00 0xce509800   66 de5b9540
> 26    0x1c00 0xce50a000  106 de5b9780
> 27    0x1c00 0xce50a800   66 de5b9d80
> 28    0x1c00 0xce50b000  106 de5b9cc0
> 29    0x1c00 0xce50b800   66 de5b99c0
> 30    0x1c00 0xce50c000  106 de5b9300
> 31    0x1c00 0xce50c800  106 de7e9900
> 32    0x1c00 0xce50d000   66 de7e9e40
> 33    0x1c00 0xce50d800  106 de7e96c0
> 34    0x1c00 0xce50e000   66 de7e9c00
> 35    0x1c00 0xce50e800  106 de7e9d80
> 36    0x1c00 0xce50f000  106 de7e9cc0
> 37    0x1c00 0xce50f800   66 de7e9f00
> 38    0x1c00 0xce510000  106 de7e9a80
> 39    0x1c00 0xce510800  106 de7e90c0
> 40    0x1c00 0xce511000   66 de7e9240
> 41    0x1c00 0xce511800  106 de7e9000
> 42    0x1c00 0xce512000  106 de7e9780
> 43    0x1c00 0xce512800   66 de7e9300
> 44    0x1c00 0xce513000  106 de7e9840
> 45    0x1c00 0xce513800  106 de5dbd80
> 46    0x1c00 0xce514000   66 de5dbb40
> 47    0x1c00 0xce514800  106 de5db780
> 48    0x1c00 0xce515000  106 de5db9c0
> 49    0x1c00 0xce515800   66 de5db600
> 50    0x1c00 0xce516000  106 de5db540
> 51    0x1c00 0xce516800  106 de5db000
> 52    0x1c00 0xce517000   66 de5dbc00
> 53    0x1c00 0xce517800  106 de5db6c0
> 54    0x1c00 0xce518000   66 de5db3c0
> 55    0x1c00 0xce518800  106 de5db300
> 56    0x1c00 0xce519000  106 de5dbf00
> 57    0x1c00 0xce519800   66 de5db0c0
> 58    0x1c00 0xce51a000  106 de5db900
> 59    0x1c00 0xce51a800  106 de5db240
> 60    0x1c00 0xce51b000   66 de5dbe40
> 61    0x1c00 0xce51b800  106 de5db840
> 62    0x1c00 0xce51c000  106 de5dbcc0
> 63    0x3c00 0xce51c800  106 de5db180
> "

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
