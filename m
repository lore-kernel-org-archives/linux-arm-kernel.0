From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 06 Apr 2010 20:07:24 +0200
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <20100406174157.GB12831@n2100.arm.linux.org.uk>
References: <1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
	<4BACB256.3020404@mvista.com>
	<1269611685.807.55.camel@e102109-lin.cambridge.arm.com>
	<20100326140833.GK27692@sirena.org.uk>
	<1269612734.807.73.camel@e102109-lin.cambridge.arm.com>
	<1269619671.30296.1.camel@localhost.localdomain>
	<s5heij66b5o.wl%tiwai@suse.de> <4BB05A92.7010607@mvista.com>
	<s5h4ojz4l16.wl%tiwai@suse.de> <s5hfx39dmp2.wl%tiwai@suse.de>
	<20100406174157.GB12831@n2100.arm.linux.org.uk>
Message-ID: <s5hbpdwe9pf.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 6 Apr 2010 18:41:57 +0100,
Russell King - ARM Linux wrote:
> 
> On Tue, Apr 06, 2010 at 10:12:09AM +0200, Takashi Iwai wrote:
> > This issue is still pending.
> > Can anyone give a proper patch with a rational explanation?
> > 
> > Philby's last patch looks OK to apply wrt coding (at least better than
> > the original one), but it doesn't clarify exactly why.
> 
> It is technically *incorrect*, which is why I NAK'd it - several times.

Well, what I meant is his patch below.  It now has nothing to do with
ac97 register or such.

> I don't know how we can proceed on this; we certainly can not go adding
> this positively incorrect change to the kernel.
> 
> Maybe Philby would like to take the time to understand the technical
> objection to his patch(es), and try to work out a more reasonable
> solution.  Short of that, there doesn't appear to be any other way to
> proceed - and given that I suggest that we put the issue on the back
> burner until someone who is willing to investigate _can_ and is willing
> to do so.

Yeah, thus I've been asking now.  I'm fine to revert the patch first.
But, obviously, without some extra accesslike the above, the ac97
reset failed on Philby's system.  IIRC, Catalin confirmed it, too.

The above is a bloody workaround that cures something magically,
indeed.  So I'd like to know what is the real cause there...


thanks,

Takashi

===
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
