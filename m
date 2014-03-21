From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 20 Mar 2014 17:24:07 -0700
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140320230559.GF7528@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de> <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
 <20140320230559.GF7528@n2100.arm.linux.org.uk>
Message-ID: <532B86A7.5010200@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/20/2014 4:06 PM, Russell King - ARM Linux wrote:
> On Thu, Mar 20, 2014 at 07:27:43PM -0300, Fabio Estevam wrote:
>> "I tried the patch and it seems a little better but still has problems.
>> When I first started the test I saw dropped packets.  After about 2 minutes
>> I got the pause again with the accompanying kernel backtrace.  It looks
>> like I got some more debug information from the backtrace however (I think
>> that was part of the patch.)
> 
> Thanks.  Now that we can see the ring, we can see what's going on.
> Every entry with a non-NULL skb is a packet which has been queued up
> for transmission, but which hasn't been reaped.  Any entry with a "SC"
> value of 0x1c00 has been transmitted.
> 
> S marks the ring entry where the next packet to be transmitted would
> be placed into the ring.  H points at the previous entry which was
> reaped - in other words, the next packet which would be reaped if it
> were transmitted would be ring entry 14.
> 
> However, this hasn't happened, because that packet is still marked for
> the FEC to transmit it.  The really odd thing is, it has transmitted
> the subsequent packets from 15 to 63, and 0 to 12.
> 
> The obvious question is: was the packet at 14 actually transmitted,
> and has the update to the descriptor been lost somehow - that would
> require a log of the last 64-ish transmitted packets, and knowledge
> of what those packets should contain to really confirm - just wondering
> whether we could transmit an additional byte containing the ring index
> on these small packets which we could then capture.  We would have to
> be certain that the capture itself hasn't dropped any packets.

My question is, on a non-cacheable, bufferable write, can an entire 64
byte line be written ?  Since our descriptors are only 32 bytes is there
contention between the cpu queuing  the next packet and the ENET completing
the one before ?

13 SH 0x1c00 0x00000000   66   (null)
14    0x9c00 0xce504000   66 de5b90c0

Note that the problematic descriptor(14) is even. That would fit with
the above. In your testing, is it always even?


Troy
