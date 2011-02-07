From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Feb 2011 15:22:19 +0000
Subject: [PATCH -next] ALSA: AACI: fix crash in aaci_size_fifo
In-Reply-To: <20110207151313.GA5853@n2100.arm.linux.org.uk>
References: <1297091227-27142-1-git-send-email-marc.zyngier@arm.com>
	<20110207151313.GA5853@n2100.arm.linux.org.uk>
Message-ID: <1297092139.11987.29.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-07 at 15:13 +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 07, 2011 at 03:07:07PM +0000, Marc Zyngier wrote:
> > As this is probably only a debug leftover, get rid of the statement altogether.
> 
> No.  Reading back from the register makes sure that the write hits the device
> before we delay.
> 

Right. Something like that?

8<-------------
>From 1c5cb983e3b88baa56121cf16c741373d5ba2ca8 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 7 Feb 2011 14:45:03 +0000
Subject: [PATCH -next] ALSA: AACI: fix crash in aaci_size_fifo

Commit ad58498 (ALSA: AACI: allow writes to MAINCR to take effect)
that appeared in next-20110207 added a statement treating the maincr
value as an address.  This leads to a crash while probing the device:

Unable to handle kernel NULL pointer dereference at virtual address 00000079
pgd = c0004000
[00000079] *pgd=00000000
Internal error: Oops: 1 [#1] PREEMPT SMP
last sysfs file:
Modules linked in:
CPU: 2    Not tainted  (2.6.38-rc3-next-20110207-00031-g7ed0487 #12)
PC is at aaci_probe+0x438/0x5bc
LR is at 0x79
pc : [<c0385b98>]    lr : [<00000079>]    psr: 60000013
sp : df83beb0  ip : e08be000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : c048e1c0  r6 : df9a65f8  r5 : c0492840  r4 : 00000200
r3 : 00000000  r2 : e08be000  r1 : 00000079  r0 : 00000078
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 8000406a  DAC: 00000015

Instead, read the register back to force the write to the hardware.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 sound/arm/aaci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index b4cda4b..af5a152 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -970,7 +970,7 @@ static unsigned int __devinit aaci_size_fifo(struct aaci *aaci)
 	 * disabling the channel doesn't clear the FIFO.
 	 */
 	writel(aaci->maincr & ~MAINCR_IE, aaci->base + AACI_MAINCR);
-	readl(aaci->maincr);
+	readl(aaci->base + AACI_MAINCR);
 	udelay(1);
 	writel(aaci->maincr, aaci->base + AACI_MAINCR);
 
-- 
1.7.0.4


-- 
Reality is an implementation detail.
