From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 11:03:02 +0200
Subject: [PATCH 8/8] eukrea-tlv320: add support for our i.MX25 board
In-Reply-To: <1275987782-16094-7-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
	<1275987782-16094-2-git-send-email-eric@eukrea.com>
	<1275987782-16094-3-git-send-email-eric@eukrea.com>
	<1275987782-16094-4-git-send-email-eric@eukrea.com>
	<1275987782-16094-5-git-send-email-eric@eukrea.com>
	<1275987782-16094-6-git-send-email-eric@eukrea.com>
	<1275987782-16094-7-git-send-email-eric@eukrea.com>
Message-ID: <1275987782-16094-8-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* tdm slot has to be configured to get sound working on i.MX25

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 sound/soc/imx/Kconfig         |    2 +-
 sound/soc/imx/eukrea-tlv320.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index fd292f1..fd616ae 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -31,7 +31,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	bool "Eukrea TLV320"
-	depends on MACH_EUKREA_MBIMX27_BASEBOARD
+	depends on MACH_EUKREA_MBIMX27_BASEBOARD || MACH_EUKREA_MBIMXSD_BASEBOARD
 	select SND_MXC_SOC_SSI
 	select SND_SOC_TLV320AIC23
 	help
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index 968380a..45f5e4b 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -60,6 +60,7 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 		pr_err("%s: failed setting codec sysclk\n", __func__);
 		return ret;
 	}
+	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
 				SND_SOC_CLOCK_IN);
@@ -100,7 +101,7 @@ static int __init eukrea_tlv320_init(void)
 {
 	int ret;
 
-	if (!machine_is_eukrea_cpuimx27())
+	if (!machine_is_eukrea_cpuimx27() && !machine_is_eukrea_cpuimx25sd())
 		/* return happy. We might run on a totally different machine */
 		return 0;
 
-- 
1.6.3.3
