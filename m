From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 23 Feb 2017 15:45:56 +0100
Subject: [PATCH v2 4/8] sound: soc: pxa: Suppress SND_MMP_SOC for arm64
In-Reply-To: <s5hefyp6l4i.wl-tiwai@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
 <20170222022929.10540-5-afaerber@suse.de>
 <20170222184734.wmkbzfsz4yklofcg@sirena.org.uk>
 <473e4976-77eb-4b67-e874-ae6bd717ddaa@suse.de> <s5hefyp6l4i.wl-tiwai@suse.de>
Message-ID: <48c91f5d-6ff3-af67-c4eb-4e958a7de465@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.02.2017 um 15:24 schrieb Takashi Iwai:
> On Thu, 23 Feb 2017 15:11:46 +0100,
> Andreas F?rber wrote:
>> Am 22.02.2017 um 19:47 schrieb Mark Brown:
>>> Please use subject lines matching the style for the subsystem.  This
>>> makes it easier for people to identify relevant patches.
>>
>> Should I make it "ASoC: pxa: ..." then? SND_MMP_SOC selects SND_ARM,
>> which in sound/arm/Kconfig says 'Drivers that are implemented on ASoC
>> can be found in "ALSA for SoC audio support" section.', which confused
>> me about whether or not this is an ASoC compliant driver if it selects a
>> non-ASoC symbol.
> 
> It's a bug that selects SND_ARM there.  I guess this was wrongly taken
> from the old example of AC97 ARM SoC code, which was fixed later.
> ASoC stuff is basically irrelevant from the legacy sound/arm/*.

Thanks, Takashi-san. I'll update as follows then.

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f8e1c06..aba7213 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -9,10 +9,9 @@ config SND_PXA2XX_SOC

 config SND_MMP_SOC
        bool "SoC Audio for Marvell MMP chips"
-       depends on ARCH_MMP && ARM
-       select MMP_SRAM
+       depends on ARCH_MMP || COMPILE_TEST
+       select MMP_SRAM if ARM
        select SND_SOC_GENERIC_DMAENGINE_PCM
-       select SND_ARM
        help
          Say Y if you want to add support for codecs attached to
          the MMP SSPA interface.

Okay to do that in one patch or break up into three?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
