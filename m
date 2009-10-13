From: pjohn@in.mvista.com (Philby John)
Date: Tue, 13 Oct 2009 19:28:24 +0530
Subject: [PATCH] aaci: ARM1176 aaci-pl041 AC97 register read timeout
Message-ID: <1255442304.25065.60.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philby John <pjohn@in.mvista.com>
Date: Tue, 13 Oct 2009 16:30:22 +0530
Subject: [PATCH] aaci: ARM1176 aaci-pl041 AC97 register read timeout

After a reboot on an ARM1176 which amounts to a softreset, it has been
noted that the ALSA driver does not get registered and the probe fails
with the error "aaci-pl041 fpga:04: ac97 read back fail". In the process
of reading from a register the SL1TxBusy bit is set indicating that the
transceiver is busy and remains so until the default timeout occurs.
Set the Power down register 0x26 to an arbitrary value as specified in
the PL041 manual (page: 3-18) so that AACISL1TX/AACISL2TX registers take
their default state.

Signed-off-by: Philby John <pjohn@in.mvista.com>
---
 sound/arm/aaci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 89096e8..98b6ffe 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -937,6 +937,7 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
 	struct snd_ac97 *ac97;
 	int ret;
 
+	writel(0, aaci->base + AC97_POWERDOWN);
 	/*
 	 * Assert AACIRESET for 2us
 	 */
-- 
1.6.3.3.MVISTA
