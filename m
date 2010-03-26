From: pjohn@mvista.com (Philby John)
Date: Fri, 26 Mar 2010 21:37:51 +0530
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <1269612734.807.73.camel@e102109-lin.cambridge.arm.com>
References: <s5h39zou023.wl%tiwai@suse.de>
	<20100325113019.GA6590@n2100.arm.linux.org.uk>
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>
	<1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>
	<20100325121614.GC6590@n2100.arm.linux.org.uk>
	<1269602911.15413.6.camel@localhost.localdomain>
	<1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
	<4BACB256.3020404@mvista.com>
	<1269611685.807.55.camel@e102109-lin.cambridge.arm.com>
	<20100326140833.GK27692@sirena.org.uk>
	<1269612734.807.73.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1269619671.30296.1.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-26 at 14:12 +0000, Catalin Marinas wrote:
> On Fri, 2010-03-26 at 14:08 +0000, Mark Brown wrote:
> > On Fri, Mar 26, 2010 at 01:54:45PM +0000, Catalin Marinas wrote:
> > 
> > > But the above says "the power down control and status register (0x26) of
> > > the CODEC". So this refers to the AC97 registers rather than the AACI
> > > registers. Your patch reads from the AACI registers. The AC97 registers
> > > I think are access with aaci_ac97_(read|write) functions.
> > 
> > Yes, they are - but note that some CODECs will power up in low power
> > mode and therefore attempts to read immediately after the controller
> > probe function starts executing may fail until the controller has issued
> > a warm reset.
> 
> Yes, possibly. But my point is that accessing offset 0x26 in the AACI
> register space has nothing to do with the AC97 power register. At offset
> 0x26 in the AACI register space you find the top part of the AACIIE2
> register (if you can even read this as a half-word).
> 
>From b411099000bbbb9b076168ee98742a36018a67ac Mon Sep 17 00:00:00 2001
From: Philby John <pjohn@in.mvista.com>
Date: Fri, 26 Mar 2010 16:41:06 +0530
Subject: [PATCH] Fix alignment faults on ARM Cortex introduced by commit 29a4f2d3

The commit 29a4f2d3 used writel() at offset 0x26 which is
half-word aligned causing unaligned exceptions on a
Cortex-A8. The original patch solved the "aaci-pl041 fpga:04:
ac97 read back fail" issue on a soft reset. Reading from any
arbitrary aaci register seems to solve this issue.

Signed-off-by: Philby John <pjohn@mvista.com>
---
 sound/arm/aaci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 656e474..91acc9a 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -863,7 +863,6 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
 	struct snd_ac97 *ac97;
 	int ret;
 
-	writel(0, aaci->base + AC97_POWERDOWN);
 	/*
 	 * Assert AACIRESET for 2us
 	 */
@@ -1047,7 +1046,11 @@ static int __devinit aaci_probe(struct amba_device *dev, struct amba_id *id)
 
 	writel(0x1fff, aaci->base + AACI_INTCLR);
 	writel(aaci->maincr, aaci->base + AACI_MAINCR);
-
+	/*
+	 * Fix: ac97 read back fail errors by reading
+	 * from any arbitrary aaci register.
+	 */
+	readl(aaci->base + AACI_CSCH1);
 	ret = aaci_probe_ac97(aaci);
 	if (ret)
 		goto out;
-- 
1.7.0.1
