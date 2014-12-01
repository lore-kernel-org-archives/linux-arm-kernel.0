From: w@1wt.eu (Willy Tarreau)
Date: Mon, 1 Dec 2014 08:28:02 +0100
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <CAB8gEUtgo-8nets3tRtqiZ8qRx+SyCq2d8v05scavWNwE5TNXg@mail.gmail.com>
References: <20140717081527.GJ14723@1wt.eu>
 <CAB8gEUsLmuDkTzGsq8fVs9dZ90d82Brw2cAPBOnobUTcSgQabA@mail.gmail.com>
 <CAB8gEUvwPJUhDN-=tugTyKe93SdNwqNaGtKMF1DRCb8ZNncmmg@mail.gmail.com>
 <20140721054405.GK21834@1wt.eu>
 <CAB8gEUsK9c3YMpAABifNAWU7zec2ePztSqS4KAYtiT7Sbhadvg@mail.gmail.com>
 <20140721070303.GM21834@1wt.eu>
 <CAB8gEUtmgwfWcuoYZ-wDwHVmzHN0WyOQD9oEOGAZ_gJfbPUm-g@mail.gmail.com>
 <20140723061659.GE30488@1wt.eu>
 <CAB8gEUtO=K-mjie6czsf-9ao1cxiMAV2ScbgUnf+XxqjEfOUvg@mail.gmail.com>
 <CAB8gEUtgo-8nets3tRtqiZ8qRx+SyCq2d8v05scavWNwE5TNXg@mail.gmail.com>
Message-ID: <20141201072802.GB21731@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maggie,

On Mon, Dec 01, 2014 at 02:26:49PM +0800, Maggie Mae Roxas wrote:
> Hi Willy, Thomas.
> Good day.
> 
> I am reopening this discussion because we found an unusual behavior
> after using this combination that we thought was OK as discussed in
> the previous messages of this thread:
> 
> > - use 3.13.9 mvneta.c
> > - apply cd71e246c16b30e3f396a85943d5f596202737ba
> > - revert 4f3a4f701b59a3e4b5c8503ac3d905c0a326f922
> 
> Specifically, if we apply above, the "No buffer space available" error
> during continuous ping does NOT occur anymore.
> # Attached: with_patch_3_13_9_no_buffer_space_solved.txt
> 
> However, after continuous and further testing, we encounter the ff. issues:
> 1. Low throughput during iperf when Armada 370 device is set as iperf
> client. For example, in 1000Mbits/s, we only get below 140Mbits/s.

Yes that was the intent of the original fix.

We recently diagnosed the issue related to "no buffer space available".
What happens is that the "ping" utility uses a very small socket buffer.
It sends a few packets, and the NIC doesn't send interrupts until the
TX interrupt count is reached, so the Tx skbs are not freed and the
socket buffers remain full.

The only solution at the moment is to make the NIC emit an IRQ for each
Tx packet. I'm still trying to find a better way to do this (either find
a way to make the NIC emit an IRQ once the Tx queue is empty or adjust
the IRQ delay when adding more packets, though it creates a race condition).

In the mean time you can apply the attached patch. I haven't submitted it
yet only by lack of time :-(

Best regards,
Willy

-------------- next part --------------
>From 01b23da3607dbce1d1abfe5b7f092de11ae327cf Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sat, 25 Oct 2014 19:12:49 +0200
Subject: net: mvneta: fix TX coalesce interrupt mode

The mvneta driver sets the amount of Tx coalesce packets to 16 by
default. Normally that does not cause any trouble since the driver
uses a much larger Tx ring size (532 packets). But some sockets
might run with very small buffers, much smaller than the equivalent
of 16 packets. This is what ping is doing for example, by setting
SNDBUF to 324 bytes rounded up to 2kB by the kernel.

The problem is that there is no documented method to force a specific
packet to emit an interrupt (eg: the last of the ring) nor is it
possible to make the NIC emit an interrupt after a given delay.

In this case, it causes trouble, because when ping sends packets over
its raw socket, the few first packets leave the system, and the first
15 packets will be emitted without an IRQ being generated, so without
the skbs being freed. And since the socket's buffer is small, there's
no way to reach that amount of packets, and the ping ends up with
"send: no buffer available" after sending 6 packets. Running with 3
instances of ping in parallel is enough to hide the problem, because
with 6 packets per instance, that's 18 packets total, which is enough
to grant a Tx interrupt before all are sent.

The original driver in the LSP kernel worked around this design flaw
by using a software timer to clean up the Tx descriptors. This timer
was slow and caused terrible network performance on some Tx-bound
workloads (such as routing) but was enough to make tools like ping
work correctly.

Instead here, we simply set the packet counts before interrupt to 1.
This ensures that each packet sent will produce an interrupt. NAPI
takes care of coalescing interrupts since the interrupt is disabled
once generated.

No measurable performance impact nor CPU usage were observed on small
nor large packets, including when saturating the link on Tx, and this
fixes tools like ping which rely on too small a send buffer.

This fix needs to be backported to stable kernels starting with 3.10.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 4762994..35bfba7 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -214,7 +214,7 @@
 /* Various constants */
 
 /* Coalescing */
-#define MVNETA_TXDONE_COAL_PKTS		16
+#define MVNETA_TXDONE_COAL_PKTS		1
 #define MVNETA_RX_COAL_PKTS		32
 #define MVNETA_RX_COAL_USEC		100
 
-- 
1.7.12.2.21.g234cd45.dirty
