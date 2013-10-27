From: sre@debian.org (Sebastian Reichel)
Date: Sun, 27 Oct 2013 22:24:42 +0100
Subject: [RFC 0/4] DT support for rx51-audio
Message-ID: <1382909086-10493-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds DT support in rx51-audio. I tested it on the Nokia N900
and was able to play sound with aplay using earphones and earspeaker. The
Loudspeakers did not work. I don't know the reason.

The patchset consists of 4 patches:

1. convert rx51-audio to snd_soc_register_card()
2. init audio in rx51 platform file
3. add some DT helpers to ASoC core
4. add DT support to rx51-audio

Please note, that the patch is RFC level for now. For example non DT boot
does not work, because I did not yet add pdata in boardcode.

Proposed DTS node would look like this:

sound: rx51-audio {
       compatible = "nokia,rx51-audio";

       ti,mcbsp = <&mcbsp2>;
       ti,codec = <&tlv320aic3x>;
       ti,codec_aux = <&tlv320aic3x_aux>;
       ti,headset_amp = <&tpa6130a2>;

       tvout-selection-gpio = <&gpio2 8 GPIO_ACTIVE_HIGH>; /* 40 */
       jack-detection-gpio = <&gpio6 17 GPIO_ACTIVE_HIGH>; /* 177 */
       eci-sw-gpio = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* 182 */
       speaker-amp-gpio = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
};

-- Sebastian

Pali Roh?r (2):
  ASoC: omap: rx51: Use snd_soc_register_card
  ARM: OMAP: rx51: Register audio device

Sebastian Reichel (2):
  ASoC: Allow Aux Codecs to be specified using DT
  ASoC: RX-51: Add DT support to sound driver

 .../devicetree/bindings/sound/nokia,rx51.txt       |  28 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c       |  11 ++
 include/sound/rx51.h                               |  18 ++
 include/sound/soc.h                                |  13 +-
 sound/soc/omap/omap-mcbsp.c                        |   5 +-
 sound/soc/omap/omap-mcbsp.h                        |   2 +-
 sound/soc/omap/rx51.c                              | 212 +++++++++++++++------
 sound/soc/soc-core.c                               |  68 +++++--
 9 files changed, 277 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nokia,rx51.txt
 create mode 100644 include/sound/rx51.h

-- 
1.8.4.rc3
