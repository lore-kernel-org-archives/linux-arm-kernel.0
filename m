From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 18 Jun 2010 07:48:54 +0200
Subject: [PATCH 3/4] pxa2xx/cpufreq: Fix PCMCIA frequency scaling
In-Reply-To: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1276840135-5982-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MCxx values must be based off memory clock, not CPU core clock.

This also fixes the bug where on some machines the LCD went crazy while using
PCMCIA.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_base.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index df4532e..f370476 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -178,7 +178,6 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 			       unsigned long val,
 			       struct cpufreq_freqs *freqs)
 {
-#warning "it's not clear if this is right since the core CPU (N) clock has no effect on the memory (L) clock"
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
 		if (freqs->new > freqs->old) {
@@ -186,7 +185,7 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 			       "pre-updating\n",
 			       freqs->new / 1000, (freqs->new / 100) % 10,
 			       freqs->old / 1000, (freqs->old / 100) % 10);
-			pxa2xx_pcmcia_set_mcxx(skt, freqs->new);
+			pxa2xx_pcmcia_set_timing(skt);
 		}
 		break;
 
@@ -196,7 +195,7 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 			       "post-updating\n",
 			       freqs->new / 1000, (freqs->new / 100) % 10,
 			       freqs->old / 1000, (freqs->old / 100) % 10);
-			pxa2xx_pcmcia_set_mcxx(skt, freqs->new);
+			pxa2xx_pcmcia_set_timing(skt);
 		}
 		break;
 	}
-- 
1.7.1
