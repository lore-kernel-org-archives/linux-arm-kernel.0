From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 Nov 2015 09:33:53 +0800
Subject: [PATCH v1 0/5] Support more sample rates, let the rates normal work
Message-ID: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That's seem the moment rockchip-codec driver other than 44100 and 48000 do not work.
Says the (max98090, rt5640).

----
As the chromeos reported issue:(https://chromium.googlesource.com/chromiumos/third_party/kernel/+/v3.14)

For detail:
In that bug we want to add 32000 to sound/soc/rockchip/rockchip_max98090.c rk_aif1_hw_params. However that does not work.

Previously, in https://chromium-review.googlesource.com/#/c/268398/ , rate 8000, 1600, 96000 were added.
However, those rates do not work. I got the same audio as 48000 when I run

aplay -D hw:0,0 /usr/local/autotest/cros/audio/fix_440_16_half.raw --rate 8000 -f S16_LE -c2
aplay -D hw:0,0 /usr/local/autotest/cros/audio/fix_440_16_half.raw --rate 16000 -f S16_LE -c2
aplay -D hw:0,0 /usr/local/autotest/cros/audio/fix_440_16_half.raw --rate 96000 -f S16_LE -c2

They all sound identical to
aplay -D hw:0,0 /usr/local/autotest/cros/audio/fix_440_16_half.raw --rate 48000 -f S16_LE -c2

Also, recording using
aplay -D hw:0,0 /usr/local/test.raw --rate 96000 -f S16_LE -c2  and examine the output we see it was recording using 48000.

Okay, let's add this series patchs to fix this issue.

arecord -D hw:0 -f S16_LE -c 2 --rate 96000 -d 5 foobar.wav
and
    aplay -D hw:0 foobar.wav
Tested on veyron devices.


Changes in v1:
- change the subject and commit.
- remove the print message dev_dbg().
- Fix a subject missspell.

Caesar Wang (5):
  ASoC: rockchip: i2s: Support to set the divider clock API
  ASoC: rockchip-max98090: Allow more sample rates
  ASoC: rockchip-rt5645: Allow more sample rates
  ASoC: rockchip-max98090: Add the divider clock for cpu
  ASoC: rockchip-rt5645: Add the divider clock for cpu

 sound/soc/rockchip/rockchip_i2s.c      | 27 +++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_max98090.c | 37 ++++++++++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_rt5645.c   | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

-- 
1.9.1
