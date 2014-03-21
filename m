From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Mar 2014 01:18:43 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <532B86A7.5010200@boundarydevices.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de> <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
 <20140320230559.GF7528@n2100.arm.linux.org.uk>
 <532B86A7.5010200@boundarydevices.com>
Message-ID: <20140321011843.GG7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 05:24:07PM -0700, Troy Kisky wrote:
> My question is, on a non-cacheable, bufferable write, can an entire 64
> byte line be written ?  Since our descriptors are only 32 bytes is there
> contention between the cpu queuing  the next packet and the ENET completing
> the one before ?

Well, 64-byte lines would be covering descriptors 0,1 2,3 4,5 ... 12,13
14,15 etc.

However, it wouldn't really make sense because the store buffers in the
L310 are 32-bytes in size, and there's three of them.  Given that with
my patch the descriptor updates go through two draining of that buffer
per update - once after the address, length and other parameters are
written, then again after the status bits have been written, I think
it's unlikely that what you're suggesting could be a possibility,
unless there's some bug we don't know about.

Remember, DMA memory is "normal, non-cacheable" so there shouldn't be
any cache effects going on here - only store buffer effects which may
delay, merge and/or reorder writes, and that's why we have barriers.

> 13 SH 0x1c00 0x00000000   66   (null)
> 14    0x9c00 0xce504000   66 de5b90c0
> 
> Note that the problematic descriptor(14) is even. That would fit with
> the above. In your testing, is it always even?

Since running with my patch on aan iMX6Q, I haven't seen any timeouts,
and I've run many iperf sessions in both directions (even multiple
machines hammering the poor iMX6Q, running iperf and/or flood pings
with various packet sizes.)

What may be useful to know is which iMX device these are still happening
on, with my patch applied.  I have both iMX6Q and iMX6S, the 6Q has been
the focus of my hammering so far...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
