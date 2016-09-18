From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Sep 2016 20:09:38 +0200
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <1bc1a3db-8120-a2ae-0f55-a5c1bb154dc6@soulik.info>
References: <1474207751-9804-1-git-send-email-ayaka@soulik.info>
 <1474207751-9804-2-git-send-email-ayaka@soulik.info>
 <20160918144247.GA11009@kozik-book>
 <1bc1a3db-8120-a2ae-0f55-a5c1bb154dc6@soulik.info>
Message-ID: <20160918180938.GA19279@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 11:12:34PM +0800, ayaka wrote:
> 
> 
> On 09/18/2016 10:42 PM, Krzysztof Kozlowski wrote:
> >On Sun, Sep 18, 2016 at 10:09:11PM +0800, Randy Li wrote:
> >>It is simple sound card time, we could assign different codec
> >>to a interface without making a specific driver for it.
> >The description does not convince me and I do not see an example using
> >this. Could you provide one?
> Sorry, the board TOPEET iTop 4412 for exynos 4412 I posted supported codec
> with I2S interface using the simple sound card. Anyway, it is no harm to
> make them explicitly right? 

kbuild gave you the answer...

> Or I have to enabled those codec support for
> SMDK, which is not needed for the other board.

If I understand correctly, the i2s/pcm etc are still needed but not
built in config choosing only simple-audio-card? I tried now such
configuration on Odroid XU and indeed the audio is missing.

The patch looks like needed but:
1. You need to describe the rationale in commit message, why it is
needed.
2. You need to fix it... kbuild pointed build issues.

Other solution would be to add a user-selectable option for generic
sound on Samsung using simple audio card. The option would then select
appropriate SND_SAMSUNG* options, just like specific drivers do. I see
that sh does like this. Personally this approach seems simpler to me -
the defconfig could just choose this generic sound instead of many
SND_SAMSUNG_* sub-options.

Best regards,
Krzysztof

> >
> >Best regards,
> >Krzysztof
> >
> >
> >>Signed-off-by: Randy Li <ayaka@soulik.info>
> >>---
> >>  sound/soc/samsung/Kconfig | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> >>index 7b722b0..b7b3a38 100644
> >>--- a/sound/soc/samsung/Kconfig
> >>+++ b/sound/soc/samsung/Kconfig
> >>@@ -18,18 +18,18 @@ config SND_S3C2412_SOC_I2S
> >>  	select SND_S3C_I2SV2_SOC
> >>  config SND_SAMSUNG_PCM
> >>-	tristate
> >>+	tristate "Samsung PCM interface support"
> >>  config SND_SAMSUNG_AC97
> >>-	tristate
> >>+	tristate "Samsung AC97 controller support"
> >>  	select SND_SOC_AC97_BUS
> >>  config SND_SAMSUNG_SPDIF
> >>-	tristate
> >>+	tristate "Samsung SPDIF transmitter support"
> >>  	select SND_SOC_SPDIF
> >>  config SND_SAMSUNG_I2S
> >>-	tristate
> >>+	tristate "Samsung I2S interface support"
> >>  config SND_SOC_SAMSUNG_NEO1973_WM8753
> >>  	tristate "Audio support for Openmoko Neo1973 Smartphones (GTA02)"
> >>-- 
> >>2.7.4
> >>
> 
