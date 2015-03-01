From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 28 Feb 2015 21:10:34 -0500
Subject: [PATCH v4 0/15] Those patches is used for dw_hdmi audio support
Message-ID: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


We found Designware hdmi driver only support audio clock config, we can not play sound through it.
To add Designware HDMI Audio support, we make those patch set:
1): fixed dw_hdmi irq bug, add irq control to suspend/resume interfaces.
2): add suspend/resume callback for dw_hdmi rockchip driver.
3): Warp irq control in functions.
4): Combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
5): Adjust n/cts config order.
6): Set ncts_atomic_write & cts_manual, according to dw_hdmi document.
7): Add audio support for more display resolutions(eg. 800x600).
8): Add audio support for No-CEA display resolutions.
9): Add Audio Sample Channel Status config interfaces to dw_hdmi driver.
10): add audio clock control interfaces to dw_hdmi driver.
11): creat "dw_hdmi-audio" platform device in dw_hdmi driver.
12): add codec driver for hdmi audio, callback dw_hdmi audio config functions.
13): add sound driver for hdmi audio, creat hdmi audio sound card.
14): add dt-bings file and add hdmi_audio node to corresponding dt file.

Changes in v4:
-Correct phy_type assignment bug
- Combine CTS3 registers setting, reduce register operate times
- Combine N3 registers setting
- Add hdmi audio support when monitor support audio
- Give HDMI_FC_AUD_SCHNL8 an readable value
- Rename "hdmi_audio_*" to "dw_hdmi_audio_*"
- Replace delaywork with irq thread, and add suspend/resume interfaces,
  Replace "dw-hdmi-audio" with consecutive strings.
- Add ".pm = &snd_soc_pm_ops,"

Changes in v3:
- Clear Hotplug interrupts before dw_hdmi_fb_register
- Wrap irq control in fucntions
- Setting the .pm member instead of suspend/resume
- Add ID registers parse and record
- Combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
- Only adjust the n/cts setting order
- Set ncts_atomic_write & cts_manual
- Determine whether sample channel should set by desig_id.
- Delete hdmi_audio_config interface and modify audio clock control functions
- Remove audio_config & get_connect_status callback functions
  and add write/read/mod register callback functions
- Keep audio format config function in dw-hdmi-audio driver
  and remove audio_config & get_connect_status functions,
  move jack control to dw-hdmi-audio completely.
- Delete the operation of jack in rockchip-hdmi-audio driver,
  get ready to switch to simple-audio-card driver.
- modify cpu-of-node to i2s-controller

Changes in v2:
- Add irq control to suspend/resume interfaces
- Add suspend/resume support for dw_hdmi_rockchip driver
- add more n/cts combinations for more display resolutions
- Enable audio support for No-CEA display mode
- Add audio sample channel status setting
- Add audio config interfaces to dw_hdmi driver
- Update the audio control interfaces
- Update dw_hdmi audio control interfaces, and adjust jack report process
- give "codec-name" & "codec-dai-name" an const name
- remove codec-name and codec-dai-name
- rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt

Daniel Kurtz (3):
  drm: bridge/dw_hdmi: adjust n/cts setting order
  drm: bridge/dw_hdmi: set ncts_atomic_write & cts_manual
  drm: bridge/dw_hdmi: add audio sample channel status setting

Yakir Yang (12):
  drm: bridge/dw_hdmi: add irq control to suspend/resume
  drm: bridge/dw_hdmi: wrap irq control in fucntions
  drm: rockchip/dw_hdmi_rockchip: add resume/suspend support
  drm: bridge/dw_hdmi: add identification registers parse and record
  drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n() and
    hdmi_regenerate_cts()
  drm: bridge/dw_hdmi: add audio support for more display resolutions
  drm: bridge/dw_hdmi: enable audio support for No-CEA display
    resolutions
  drm: bridge/dw_hdmi: add enable/disable to dw_hdmi_audio callbacks
  drm: bridge/dw_hdmi: creat dw-hdmi-audio platform device
  ASoC: codec/dw-hdmi-audio: add codec driver for dw hdmi audio
  ASoC: rockchip/rockchip-hdmi-audio: add sound driver for hdmi audio
  dt-bindings: Add documentation for Rockchip dw-hdmi-audio

 .../sound/rockchip,rockchip-dw-hdmi-audio.txt      |  12 +
 drivers/gpu/drm/bridge/dw_hdmi.c                   | 385 ++++++++++++++++++---
 drivers/gpu/drm/bridge/dw_hdmi.h                   |  53 ++-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  16 +
 include/drm/bridge/dw_hdmi.h                       |  17 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/dw-hdmi-audio.c                   | 379 ++++++++++++++++++++
 sound/soc/codecs/dw-hdmi-audio.h                   |  74 ++++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_hdmi_audio.c           | 169 +++++++++
 12 files changed, 1076 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.c
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.h
 create mode 100644 sound/soc/rockchip/rockchip_hdmi_audio.c

-- 
2.1.2
