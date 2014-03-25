From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Mar 2014 23:10:47 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <201403250202.42268.marex@denx.de>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <201403250202.42268.marex@denx.de>
Message-ID: <20140325231047.GU7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 02:02:42AM +0100, Marek Vasut wrote:
> I think we might be seeing something similar on i.MX28 in U-Boot too,
> but I dare not to correlate this and the in-kernel FEC issue. We also
> sporadically see the FEC not transmitting a packet.

That could be the ERR006358 problem.

This occurs when you've transmitted a packet previously, and the
indicator in FEC_X_DES_ACTIVE remains set at the point in time when
you load the next packet.  The subsequent write to FEC_X_DES_ACTIVE
has no effect on the TX side, which has already shut down.

The work-around for that which is in the kernel is to look at the
previous packet status: if that indicates it has been sent immediately
after setting everything up for the next packet (remembering to take
care of the store buffers between the CPU and memory), then you need to
re-ping the transmitter after a short delay.

(I've cocked that work-around up today... it can happen quite frequently
depending on your workload.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
