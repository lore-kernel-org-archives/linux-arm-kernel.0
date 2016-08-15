From: wens213@gmail.com (wens Tsai)
Date: Mon, 15 Aug 2016 17:43:55 +0800
Subject: ASoC: sun4i-codec: playback stall and I/O error with DAPM paths all
 disabled
Message-ID: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

In the sun4i-codec driver, we control the DAC digital enable bits with a
supply widget, which in turn supplies the DAC source widgets. DAPM will
disable the supply if there are no usable playback paths. And it just so
happens that the default value for various playback switches is the off
setting.

Any user getting codec support for the first time has to enable a proper
playback path before getting sound out of the hardware. This is expected.

What is unexpected is any attempt to play anything under this state makes
the playback software (in my case mpg321) stall, and later report an I/O
error. My guess is that the DAC is still disabled by DAPM, so it doesn't
send any DRQs, and thus the DMA engine is not consuming any data from
userspace.

I think we should just enable the digital bits of the DAC/ADC all the
time. Or maybe transfer and then discard data if the DAC is off. Not
sure if this is doable though. I expect playback software to work, and
not block, regardless of the hardware status.

Any thoughts on this? sun4i-codec seems to be one of the rarer kinds of
hardware where the DAC is directly tied to the system bus, without an I2S
interface in between. And I don't see any DAI drivers using DAPM.


Regards
ChenYu
