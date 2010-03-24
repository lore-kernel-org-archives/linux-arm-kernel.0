From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Mar 2010 15:10:18 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-24 at 13:51 +0000, Catalin Marinas wrote:
> The commit mentioned above adds a writel() to the AC97_POWERDOWN
> register which is half-word aligned and causing unaligned exceptions on
> a Cortex-A8. Is this register 16-bit only and we should use a writew()
> instead?

Something like below:


aaci: Use writew() to the AC97_POWERDOWN 16-bit register

From: Catalin Marinas <catalin.marinas@arm.com>

The writel() introduced by commit 29a4f2d3 generates an alignment fault
on ARM.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Philby John <pjohn@in.mvista.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/arm/aaci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 656e474..d66d4ff 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -863,7 +863,7 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
 	struct snd_ac97 *ac97;
 	int ret;
 
-	writel(0, aaci->base + AC97_POWERDOWN);
+	writew(0, aaci->base + AC97_POWERDOWN);
 	/*
 	 * Assert AACIRESET for 2us
 	 */


-- 
Catalin
