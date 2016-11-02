From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  2 Nov 2016 15:35:57 +0800
Subject: [PATCH v2 0/4] ASoC: DAPM: Support stereo controls shared between
 widgets
Message-ID: <20161102073601.8659-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This was part of my Allwinner A31 audio codec support series. As I split
up some patches, the series was getting somewhat large. Hence I'm sending
out the ASoC DAPM core changes separately. The remaining Allwinner
specific patches will be sent later. The complete series can be found
here [1], if people need a real use case as reference.

While DAPM is mono or single channel, its controls can be shared between
widgets, such as sharing one stereo mixer control between the left and
right channel widgets. An example such as the following routes

    [Line In Left]----------<Line In Playback Switch>-------[Left Mixer]
                                          ^
          ^           ^                   |                      ^
       (inputs)    (paths)   <shared stereo mixer control>   (outputs)
          v           v                   |                      v
                                          v
    [Line In Right]---------<Line In Playback Switch>-------[Right Mixer]

where we have separate widgets and paths for the left and right channels
from "Line In" to "Mixer", but a shared stereo mixer control for the
2 paths. By having a stereo mixer control, we expose to userspace a sane
mixer interface. Otherwise we would have a bunch of "X Left Playback Switch"
and "X Right Playback Switch" controls.

This series introduces support for such shared mixer controls, allowing
more than 1 path to be attached to a single stereo control, and allowing
control of left/right channels independently. The DAPM control types
DAPM_DOUBLE and DAPM_DOUBLE_R are added.


Changes since v1:

  - Expaned commit message for "ASoC: dapm: Implement stereo mixer
    control support"

  - Expanded comments in dapm_set_mixer_path_status and
    soc_dapm_mixer_update_power

  - Check assumption of field width < (bits in unsigned int / 2) in
    snd_soc_dapm_put_volsw

  - Print warning when adding stereo "autodisable" controls which is not
    supported

  - Use NULL for struct snd_soc_dapm_update initializer, as the first
    field is a pointer, to avoid compiler warnings.


Regards
ChenYu

[1] https://github.com/wens/linux/commits/a31-audio-v2

Chen-Yu Tsai (4):
  ASoC: dapm: Support second register for DAPM control updates
  ASoC: dapm: Implement stereo mixer control support
  ASoC: dapm: Introduce DAPM_DOUBLE dual channel control type
  ASoC: dapm: Introduce DAPM_DOUBLE_R dual channel dual register control
    type

 include/sound/soc-dapm.h       |  14 ++++
 sound/soc/codecs/adau17x1.c    |   2 +-
 sound/soc/codecs/tlv320aic3x.c |   2 +-
 sound/soc/codecs/wm9712.c      |   2 +-
 sound/soc/codecs/wm9713.c      |   2 +-
 sound/soc/soc-dapm.c           | 154 ++++++++++++++++++++++++++++++++---------
 6 files changed, 141 insertions(+), 35 deletions(-)

-- 
2.10.2
